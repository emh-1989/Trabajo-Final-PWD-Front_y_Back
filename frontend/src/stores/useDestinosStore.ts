import { defineStore } from 'pinia'
import { ref } from 'vue'
import ApiService from '@/services/ApiService'

type EstadoCarga = 'idle' | 'cargando' | 'exito' | 'error' | 'noEncontrado'

interface Destino {
  id: number
  titulo: string
  emoji: string
  imagen: string
  descripcion: string
  paisajes: string
  comida: string
  tips: string[]
  orden: number
}

export const useDestinosStore = defineStore('destinos', () => {
  const destinos = ref<Destino[]>([])
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

  const fetchDestinos = async () => {
    iniciarCarga()
    try {
      const { data } = await ApiService.getAll('destinos')
      destinos.value = data
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  const crear = async (datos: Omit<Destino, 'id'>) => {
    iniciarCarga()
    try {
      const { data } = await ApiService.create('destinos', datos)
      destinos.value.push(data)
      cargaExitosa()
      return data
    } catch (e: any) {
      manejarError(e)
    }
  }

  const actualizar = async (id: number, datos: Partial<Destino>) => {
    iniciarCarga()
    try {
      const { data } = await ApiService.update('destinos', id, datos)
      const idx = destinos.value.findIndex((d) => d.id === id)
      if (idx !== -1) destinos.value[idx] = data
      cargaExitosa()
      return data
    } catch (e: any) {
      manejarError(e)
    }
  }

  const eliminar = async (id: number) => {
    iniciarCarga()
    try {
      await ApiService.destroy('destinos', id)
      destinos.value = destinos.value.filter((d) => d.id !== id)
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  return { destinos, estado, mensajeError, fetchDestinos, crear, actualizar, eliminar }
})
