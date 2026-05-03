import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { useAuthStore } from './useAuthStore'
import ApiService from '@/services/ApiService'

type EstadoCarga = 'idle' | 'cargando' | 'exito' | 'error' | 'noEncontrado'
type TipoNotificacion =
  | 'publicacion_aprobada'
  | 'publicacion_rechazada'
  | 'nueva_reserva'
  | 'nueva_resena'

interface Notificacion {
  id: number
  tipo: TipoNotificacion
  mensaje: string
  leida: boolean
  created_at: string
}

export const useNotificacionesStore = defineStore('notificaciones', () => {
  const auth = useAuthStore()
  const notificaciones = ref<Notificacion[]>([])
  const estado = ref<EstadoCarga>('idle')
  const mensajeError = ref('')

  const noLeidas = computed(() => notificaciones.value.filter((n) => !n.leida))
  const cantidadNoLeidas = computed(() => noLeidas.value.length)
  const hayNoLeidas = computed(() => cantidadNoLeidas.value > 0)

  const configPorTipo = computed(() => {
    return (tipo: TipoNotificacion) => {
      const config = {
        publicacion_aprobada: { icon: 'mdi:check-circle', color: '#1d9e75' },
        publicacion_rechazada: { icon: 'mdi:close-circle', color: '#df243c' },
        nueva_reserva: { icon: 'mdi:calendar-check', color: '#7cd3e3' },
        nueva_resena: { icon: 'mdi:star', color: '#ef9f27' },
      }
      return config[tipo]
    }
  })

  const fetchNotificaciones = async () => {
    if (!auth.estaLogueado) return
    estado.value = 'cargando'
    mensajeError.value = ''
    try {
      const { data } = await ApiService.getAll('notificaciones')
      notificaciones.value = data
      estado.value = 'exito'
    } catch (e: any) {
      estado.value = 'error'
      mensajeError.value = e?.response?.data?.message || 'Error al cargar notificaciones.'
    }
  }

  const marcarLeida = async (id: number) => {
    const notif = notificaciones.value.find((n) => n.id === id)
    if (!notif || notif.leida) return
    notif.leida = true
    try {
      await ApiService.update('notificaciones', id, { leida: true })
    } catch {
      notif.leida = false
      mensajeError.value = 'Error al marcar la notificación.'
    }
  }

  const marcarTodasLeidas = async () => {
    const estadosAnteriores = notificaciones.value.map((n) => ({ id: n.id, leida: n.leida }))
    notificaciones.value.forEach((n) => (n.leida = true))
    try {
      await ApiService.update('notificaciones', 'leer-todas', {})
    } catch {
      estadosAnteriores.forEach((anterior) => {
        const notif = notificaciones.value.find((n) => n.id === anterior.id)
        if (notif) notif.leida = anterior.leida
      })
      mensajeError.value = 'Error al marcar las notificaciones.'
    }
  }

  const eliminar = async (id: number) => {
    const notif = notificaciones.value.find((n) => n.id === id)
    if (!notif) return
    notificaciones.value = notificaciones.value.filter((n) => n.id !== id)
    try {
      await ApiService.destroy('notificaciones', id)
    } catch {
      notificaciones.value.push(notif)
      mensajeError.value = 'Error al eliminar la notificación.'
    }
  }

  const limpiar = () => {
    notificaciones.value = []
    estado.value = 'idle'
    mensajeError.value = ''
  }

  return {
    notificaciones,
    estado,
    mensajeError,
    noLeidas,
    cantidadNoLeidas,
    hayNoLeidas,
    configPorTipo,
    fetchNotificaciones,
    marcarLeida,
    marcarTodasLeidas,
    eliminar,
    limpiar,
  }
})
