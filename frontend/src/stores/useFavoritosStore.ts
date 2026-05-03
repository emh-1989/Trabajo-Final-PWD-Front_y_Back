import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { useAuthStore } from './useAuthStore'
import ApiService from '@/services/ApiService'

type EstadoCarga = 'idle' | 'cargando' | 'exito' | 'error' | 'noEncontrado'
type TipoFavorito = 'hotel' | 'vuelo' | 'restaurante' | 'entretenimiento' | 'destino'

interface Favorito {
  id: number
  tipo: TipoFavorito
  referencia_id: number
  nombre: string
  ubicacion?: string
  imagen?: string
  precio?: number | string
  rating?: number
  created_at: string
}

export const useFavoritosStore = defineStore('favoritos', () => {
  const auth = useAuthStore()
  const favoritos = ref<Favorito[]>([])
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

  const esFavorito = computed(() => {
    return (tipo: TipoFavorito, referencia_id: number) =>
      favoritos.value.some((f) => f.tipo === tipo && f.referencia_id === referencia_id)
  })

  const porTipo = computed(() => {
    return (tipo: TipoFavorito) => favoritos.value.filter((f) => f.tipo === tipo)
  })

  const total = computed(() => favoritos.value.length)

  const fetchFavoritos = async () => {
    if (!auth.estaLogueado) return
    iniciarCarga()
    try {
      const { data } = await ApiService.getAll('favoritos')
      favoritos.value = data
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  const agregar = async (item: Omit<Favorito, 'id' | 'created_at'>) => {
    if (!auth.estaLogueado) return
    if (esFavorito.value(item.tipo, item.referencia_id)) return
    iniciarCarga()
    try {
      const { data } = await ApiService.create('favoritos', {
        tipo: item.tipo,
        referencia_id: item.referencia_id,
      })
      favoritos.value.push(data)
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  const quitar = async (tipo: TipoFavorito, referencia_id: number) => {
    if (!auth.estaLogueado) return
    // FIX: buscar una sola vez para evitar doble find con posible mutación intermedia
    const favorito = favoritos.value.find(
      (f) => f.tipo === tipo && f.referencia_id === referencia_id,
    )
    if (!favorito) return
    favoritos.value = favoritos.value.filter((f) => f.id !== favorito.id)
    iniciarCarga()
    try {
      await ApiService.destroy('favoritos', favorito.id)
      cargaExitosa()
    } catch (e: any) {
      favoritos.value.push(favorito)
      manejarError(e)
    }
  }

  const toggle = async (item: Omit<Favorito, 'id' | 'created_at'>) => {
    if (esFavorito.value(item.tipo, item.referencia_id)) {
      await quitar(item.tipo, item.referencia_id)
    } else {
      await agregar(item)
    }
  }

  const limpiar = () => {
    favoritos.value = []
    estado.value = 'idle'
    mensajeError.value = ''
  }

  return {
    favoritos,
    estado,
    mensajeError,
    esFavorito,
    porTipo,
    total,
    fetchFavoritos,
    agregar,
    quitar,
    toggle,
    limpiar,
  }
})
