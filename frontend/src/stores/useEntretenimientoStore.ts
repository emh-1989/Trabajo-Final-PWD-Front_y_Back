import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import ApiService from '@/services/ApiService'

type EstadoCarga = 'idle' | 'cargando' | 'exito' | 'error' | 'noEncontrado'

interface Evento {
  id: number
  titulo: string
  ubicacion: string
  fecha: string
  tipo: string
  imagen: string
  descripcion: string
}

interface FiltrosEvento {
  destino?: string
  tipo?: string
  fecha?: string
}

export const useEntretenimientoStore = defineStore('entretenimiento', () => {
  const eventos = ref<Evento[]>([])
  const filtros = ref<FiltrosEvento>({})
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

  const eventosFiltrados = computed(() => {
    return eventos.value.filter((e) => {
      if (filtros.value.tipo && e.tipo !== filtros.value.tipo) return false
      if (filtros.value.fecha && e.fecha !== filtros.value.fecha) return false
      if (
        filtros.value.destino &&
        !e.ubicacion.toLowerCase().includes(filtros.value.destino.toLowerCase())
      )
        return false
      return true
    })
  })

  const buscarEventos = async (filtrosBusqueda: FiltrosEvento) => {
    iniciarCarga()
    filtros.value = filtrosBusqueda
    try {
      const params = new URLSearchParams()
      if (filtrosBusqueda.destino) params.append('destino', filtrosBusqueda.destino)
      if (filtrosBusqueda.tipo) params.append('tipo', filtrosBusqueda.tipo)
      if (filtrosBusqueda.fecha) params.append('fecha', filtrosBusqueda.fecha)
      const { data } = await ApiService.getAll(`entretenimiento/buscar?${params.toString()}`)
      eventos.value = data
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  return { eventos, filtros, estado, mensajeError, eventosFiltrados, buscarEventos }
})
