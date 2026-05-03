import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { useAuthStore } from './useAuthStore'
import ApiService from '@/services/ApiService'

type EstadoCarga = 'idle' | 'cargando' | 'exito' | 'error' | 'noEncontrado'
type EstadoReserva = 'pendiente' | 'confirmada' | 'cancelada'

interface Hotel {
  id: number
  nombre: string
  ubicacion: string
  imagen: string
}

interface Vuelo {
  id: number
  aerolinea: string
  origen: string
  destino: string
  hora_salida: string
  hora_llegada: string
}

interface Reserva {
  id: number
  hotel?: Hotel
  vuelo?: Vuelo
  fecha_entrada?: string
  fecha_salida?: string
  estado: EstadoReserva
  created_at: string
}

export const useReservasStore = defineStore('reservas', () => {
  const auth = useAuthStore()
  const reservas = ref<Reserva[]>([])
  const estado = ref<EstadoCarga>('idle')
  const mensajeError = ref('')

  const iniciarCarga = () => {
    estado.value = 'cargando'
    mensajeError.value = ''
  }
  const cargaExitosa = () => {
    estado.value = 'exito'
    mensajeError.value = ''
  }
  const manejarError = (e: any) => {
    estado.value = 'error'
    mensajeError.value = e?.response?.data?.message || e?.message || 'Error desconocido.'
  }

  const porEstado = computed(() => {
    return (est: EstadoReserva) => reservas.value.filter((r) => r.estado === est)
  })

  const activas = computed(() => reservas.value.filter((r) => r.estado !== 'cancelada'))
  const totalActivas = computed(() => activas.value.length)

  const calcularNoches = computed(() => {
    return (entrada?: string, salida?: string) => {
      if (!entrada || !salida) return null
      const diff = new Date(salida).getTime() - new Date(entrada).getTime()
      return Math.round(diff / (1000 * 60 * 60 * 24))
    }
  })

  const fetchReservas = async () => {
    if (!auth.estaLogueado) return
    iniciarCarga()
    try {
      const { data } = await ApiService.getAll('reservas')
      reservas.value = data
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  const crear = async (datos: {
    hotel_id?: number
    vuelo_id?: number
    fecha_entrada?: string
    fecha_salida?: string
  }) => {
    if (!auth.estaLogueado) return
    if (!datos.hotel_id && !datos.vuelo_id) {
      estado.value = 'error'
      mensajeError.value = 'La reserva debe incluir al menos un hotel o un vuelo.'
      return
    }
    iniciarCarga()
    try {
      const { data } = await ApiService.create('reservas', datos)
      reservas.value.push(data)
      cargaExitosa()
      return data
    } catch (e: any) {
      manejarError(e)
    }
  }

  const cancelar = async (id: number) => {
    if (!auth.estaLogueado) return
    const reserva = reservas.value.find((r) => r.id === id)
    if (!reserva) return
    const estadoAnterior = reserva.estado
    reserva.estado = 'cancelada'
    try {
      await ApiService.update('reservas', id, { estado: 'cancelada' })
      cargaExitosa()
    } catch (e: any) {
      reserva.estado = estadoAnterior
      manejarError(e)
    }
  }

  const limpiar = () => {
    reservas.value = []
    estado.value = 'idle'
    mensajeError.value = ''
  }

  return {
    reservas,
    estado,
    mensajeError,
    porEstado,
    activas,
    totalActivas,
    calcularNoches,
    fetchReservas,
    crear,
    cancelar,
    limpiar,
  }
})
