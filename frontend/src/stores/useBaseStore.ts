import { defineStore } from 'pinia'
import { ref } from 'vue'

export type EstadoCarga = 'idle' | 'cargando' | 'exito' | 'error' | 'noEncontrado'

export const useBaseStore = defineStore('base', () => {
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

  const setError = (mensaje: string) => {
    estado.value = 'error'
    mensajeError.value = mensaje
  }

  const limpiarEstado = () => {
    estado.value = 'idle'
    mensajeError.value = ''
  }

  return {
    estado,
    mensajeError,
    iniciarCarga,
    cargaExitosa,
    manejarError,
    setError,
    limpiarEstado,
  }
})
