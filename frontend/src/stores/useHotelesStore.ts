import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import ApiService from '@/services/ApiService'

type EstadoCarga = 'idle' | 'cargando' | 'exito' | 'error' | 'noEncontrado'
type TipoHotel = 'hotel' | 'hostel' | 'departamento' | 'resort'

interface Hotel {
  id: number
  nombre: string
  ubicacion: string
  precio: number
  rating: number
  tipo: TipoHotel
  imagen: string
  imagenes?: string[]
  descripcion?: string
  servicios?: string[]
}

interface FiltrosHotel {
  destino?: string
  checkin?: string
  checkout?: string
  pasajeros?: number
  precioMax?: number
  ratingMin?: number
  tipo?: string
}

export const useHotelesStore = defineStore('hoteles', () => {
  const hoteles = ref<Hotel[]>([])
  const hotelActual = ref<Hotel | null>(null)
  const filtros = ref<FiltrosHotel>({})

  // Estado de lista
  const estado = ref<EstadoCarga>('idle')
  const mensajeError = ref('')

  // Estado separado para el detalle
  const estadoDetalle = ref<EstadoCarga>('idle')
  const mensajeErrorDetalle = ref('')

  // ── Helpers ────────────────────────────────────────────────
  const iniciarCarga = () => {
    estado.value = 'cargando'
    mensajeError.value = ''
  }
  const cargaExitosa = () => {
    estado.value = 'exito'
    mensajeError.value = ''
  }
  const manejarError = (e: any) => {
    if (e?.response?.status === 404) {
      estado.value = 'noEncontrado'
      mensajeError.value = e.response?.data?.message || 'El recurso no fue encontrado.'
    } else if (e?.response?.status === 401) {
      estado.value = 'error'
      mensajeError.value = 'No tenés permisos para acceder a este recurso.'
    } else if (e?.response?.status === 500) {
      estado.value = 'error'
      mensajeError.value = 'Error interno del servidor. Intenta más tarde.'
    } else if (e?.code === 'ERR_NETWORK') {
      estado.value = 'error'
      mensajeError.value = 'Error de conexión. Verificá tu internet.'
    } else {
      estado.value = 'error'
      mensajeError.value = e?.response?.data?.message || e?.message || 'Error desconocido.'
    }
  }

  // ── Computed ───────────────────────────────────────────────
  const hotelesFiltrados = computed(() => {
    return hoteles.value.filter((h) => {
      if (filtros.value.precioMax && h.precio > filtros.value.precioMax) return false
      if (filtros.value.ratingMin && h.rating < filtros.value.ratingMin) return false
      if (filtros.value.tipo && h.tipo !== filtros.value.tipo) return false
      if (
        filtros.value.destino &&
        !h.ubicacion.toLowerCase().includes(filtros.value.destino.toLowerCase())
      )
        return false
      return true
    })
  })

  // ── Acciones ───────────────────────────────────────────────
  const fetchHoteles = async () => {
    iniciarCarga()
    try {
      const { data } = await ApiService.getAll('hoteles')
      hoteles.value = data
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  const buscarHoteles = async (filtrosBusqueda: FiltrosHotel) => {
    iniciarCarga()
    filtros.value = filtrosBusqueda
    try {
      const params = new URLSearchParams()
      if (filtrosBusqueda.destino) params.append('destino', filtrosBusqueda.destino)
      if (filtrosBusqueda.checkin) params.append('checkin', filtrosBusqueda.checkin)
      if (filtrosBusqueda.checkout) params.append('checkout', filtrosBusqueda.checkout)
      if (filtrosBusqueda.pasajeros) params.append('pasajeros', String(filtrosBusqueda.pasajeros))
      const { data } = await ApiService.getAll(`hoteles/buscar?${params.toString()}`)
      hoteles.value = data
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  const fetchHotelPorId = async (id: number) => {
    estadoDetalle.value = 'cargando'
    mensajeErrorDetalle.value = ''
    hotelActual.value = null
    try {
      const { data } = await ApiService.getOne('hoteles', id)
      hotelActual.value = data
      estadoDetalle.value = 'exito'
    } catch (e: any) {
      hotelActual.value = null
      if (e?.response?.status === 404) {
        estadoDetalle.value = 'noEncontrado'
        mensajeErrorDetalle.value = 'El alojamiento no existe.'
      } else {
        estadoDetalle.value = 'error'
        // FIX: usar variable local en lugar de base.mensajeError.value directo
        mensajeErrorDetalle.value = e?.response?.data?.message || 'Error al cargar el hotel.'
      }
    }
  }

  return {
    hoteles,
    hotelActual,
    filtros,
    estado,
    mensajeError,
    estadoDetalle,
    mensajeErrorDetalle,
    hotelesFiltrados,
    fetchHoteles,
    buscarHoteles,
    fetchHotelPorId,
  }
})
