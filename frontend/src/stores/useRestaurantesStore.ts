import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import ApiService from '@/services/ApiService'

type EstadoCarga = 'idle' | 'cargando' | 'exito' | 'error' | 'noEncontrado'

interface Restaurante {
  id: number
  nombre: string
  ubicacion: string
  precio: number
  rating: number
  tipo: string
  imagen: string
}

interface FiltrosRestaurante {
  destino?: string
  precioMax?: number
  ratingMin?: number
  tipo?: string
}

export const useRestaurantesStore = defineStore('restaurantes', () => {
  const restaurantes = ref<Restaurante[]>([])
  const filtros = ref<FiltrosRestaurante>({})
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

  const restaurantesFiltrados = computed(() => {
    return restaurantes.value.filter((r) => {
      if (filtros.value.precioMax && r.precio > filtros.value.precioMax) return false
      if (filtros.value.ratingMin && r.rating < filtros.value.ratingMin) return false
      if (filtros.value.tipo && r.tipo !== filtros.value.tipo) return false
      if (
        filtros.value.destino &&
        !r.ubicacion.toLowerCase().includes(filtros.value.destino.toLowerCase())
      )
        return false
      return true
    })
  })

  const buscarRestaurantes = async (filtrosBusqueda: FiltrosRestaurante) => {
    iniciarCarga()
    filtros.value = filtrosBusqueda
    try {
      const params = new URLSearchParams()
      if (filtrosBusqueda.destino) params.append('destino', filtrosBusqueda.destino)
      if (filtrosBusqueda.tipo) params.append('tipo', filtrosBusqueda.tipo)
      const { data } = await ApiService.getAll(`restaurantes/buscar?${params.toString()}`)
      restaurantes.value = data
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  return { restaurantes, filtros, estado, mensajeError, restaurantesFiltrados, buscarRestaurantes }
})
