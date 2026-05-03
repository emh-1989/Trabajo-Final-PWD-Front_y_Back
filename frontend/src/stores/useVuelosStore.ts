import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import ApiService from '@/services/ApiService'

type EstadoCarga = 'idle' | 'cargando' | 'exito' | 'error' | 'noEncontrado'

interface Vuelo {
  id: number
  aerolinea: string
  logo?: string
  origen: string
  destino: string
  horaSalida: string
  horaLlegada: string
  duracion: string
  precio: number
  escalas: number
}

interface FiltrosVuelo {
  origen?: string
  destino?: string
  fechaIda?: string
  fechaVuelta?: string
  pasajeros?: number
  precioMax?: number
  soloDirectos?: boolean
}

export const useVuelosStore = defineStore('vuelos', () => {
  const vuelos = ref<Vuelo[]>([])
  const filtros = ref<FiltrosVuelo>({})
  const busquedaRealizada = ref(false)
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

  const vuelosFiltrados = computed(() => {
    return vuelos.value.filter((v) => {
      if (filtros.value.precioMax && v.precio > filtros.value.precioMax) return false
      if (filtros.value.soloDirectos && v.escalas > 0) return false
      if (
        filtros.value.origen &&
        !v.origen.toLowerCase().includes(filtros.value.origen.toLowerCase())
      )
        return false
      if (
        filtros.value.destino &&
        !v.destino.toLowerCase().includes(filtros.value.destino.toLowerCase())
      )
        return false
      return true
    })
  })

  const vuelosDirectos = computed(() => vuelos.value.filter((v) => v.escalas === 0))
  const precioPromedio = computed(() => {
    if (vuelos.value.length === 0) return 0
    return Math.round(vuelos.value.reduce((sum, v) => sum + v.precio, 0) / vuelos.value.length)
  })

  const buscarVuelos = async (filtrosBusqueda: FiltrosVuelo) => {
    iniciarCarga()
    filtros.value = filtrosBusqueda
    busquedaRealizada.value = true
    try {
      const params = new URLSearchParams()
      if (filtrosBusqueda.origen) params.append('origen', filtrosBusqueda.origen)
      if (filtrosBusqueda.destino) params.append('destino', filtrosBusqueda.destino)
      if (filtrosBusqueda.fechaIda) params.append('fecha_ida', filtrosBusqueda.fechaIda)
      if (filtrosBusqueda.pasajeros) params.append('pasajeros', String(filtrosBusqueda.pasajeros))
      const { data } = await ApiService.getAll(`vuelos/buscar?${params.toString()}`)
      vuelos.value = data
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  return {
    vuelos,
    filtros,
    busquedaRealizada,
    estado,
    mensajeError,
    vuelosFiltrados,
    vuelosDirectos,
    precioPromedio,
    buscarVuelos,
  }
})
