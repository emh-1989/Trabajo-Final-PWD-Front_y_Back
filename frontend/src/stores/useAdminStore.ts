import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { useAuthStore } from './useAuthStore'
import ApiService from '@/services/ApiService'

type EstadoPublicacion = 'borrador' | 'pendiente' | 'publicado' | 'rechazado'
type Rol = 'viajero' | 'anfitrion' | 'admin'
type EstadoCarga = 'idle' | 'cargando' | 'exito' | 'error' | 'noEncontrado'

interface Publicacion {
  id: number
  nombre: string
  tipo: string
  ubicacion: string
  precio_noche: number
  imagen: string
  estado: EstadoPublicacion
  propietario: string
  propietario_email: string
  propietario_id: number
  created_at: string
}

interface Usuario {
  id: number
  nombre: string
  email: string
  avatar: string | null
  rol: Rol
  publicaciones: number
  reservas: number
  created_at: string
}

export const useAdminStore = defineStore('admin', () => {
  const auth = useAuthStore()

  // Estado propio (no compartido con useBaseStore)
  const estado = ref<EstadoCarga>('idle')
  const mensajeError = ref('')

  const publicaciones = ref<Publicacion[]>([])
  const usuarios = ref<Usuario[]>([])

  // ── Helpers de estado ──────────────────────────────────────
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

  // ── Computed ───────────────────────────────────────────────
  const conteoPublicaciones = computed(() => ({
    pendiente: publicaciones.value.filter((p) => p.estado === 'pendiente').length,
    publicado: publicaciones.value.filter((p) => p.estado === 'publicado').length,
    rechazado: publicaciones.value.filter((p) => p.estado === 'rechazado').length,
  }))

  const conteoUsuarios = computed(() => ({
    total: usuarios.value.length,
    viajero: usuarios.value.filter((u) => u.rol === 'viajero').length,
    anfitrion: usuarios.value.filter((u) => u.rol === 'anfitrion').length,
    admin: usuarios.value.filter((u) => u.rol === 'admin').length,
  }))

  const publicacionesPorEstado = computed(() => {
    return (estado: EstadoPublicacion) => publicaciones.value.filter((p) => p.estado === estado)
  })

  const usuariosFiltrados = computed(() => {
    return (rol: Rol | '', busqueda: string) =>
      usuarios.value.filter((u) => {
        const matchRol = !rol || u.rol === rol
        const matchBusqueda =
          !busqueda ||
          u.nombre.toLowerCase().includes(busqueda.toLowerCase()) ||
          u.email.toLowerCase().includes(busqueda.toLowerCase())
        return matchRol && matchBusqueda
      })
  })

  // ── Acciones ───────────────────────────────────────────────
  const fetchPublicaciones = async () => {
    if (!auth.esAdmin) return
    iniciarCarga()
    try {
      const { data } = await ApiService.getAll('admin/publicaciones')
      publicaciones.value = data
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  const aprobar = async (id: number) => {
    if (!auth.esAdmin) return
    const pub = publicaciones.value.find((p) => p.id === id)
    if (!pub) return
    const estadoAnterior = pub.estado
    pub.estado = 'publicado'
    try {
      await ApiService.update('admin/publicaciones', id, { accion: 'aprobar' })
      cargaExitosa()
    } catch (e: any) {
      pub.estado = estadoAnterior
      manejarError(e)
    }
  }

  const rechazar = async (id: number, motivo: string) => {
    if (!auth.esAdmin) return
    const pub = publicaciones.value.find((p) => p.id === id)
    if (!pub) return
    const estadoAnterior = pub.estado
    pub.estado = 'rechazado'
    try {
      await ApiService.update('admin/publicaciones', id, { accion: 'rechazar', motivo })
      cargaExitosa()
    } catch (e: any) {
      pub.estado = estadoAnterior
      manejarError(e)
    }
  }

  const fetchUsuarios = async () => {
    if (!auth.esAdmin) return
    iniciarCarga()
    try {
      const { data } = await ApiService.getAll('admin/usuarios')
      usuarios.value = data
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  const cambiarRol = async (id: number, nuevoRol: Rol) => {
    if (!auth.esAdmin) return
    const usuario = usuarios.value.find((u) => u.id === id)
    if (!usuario) return
    const rolAnterior = usuario.rol
    usuario.rol = nuevoRol
    try {
      await ApiService.update('admin/usuarios', id, { rol: nuevoRol })
      cargaExitosa()
    } catch (e: any) {
      usuario.rol = rolAnterior
      manejarError(e)
    }
  }

  const eliminarUsuario = async (id: number) => {
    if (!auth.esAdmin) return
    const usuario = usuarios.value.find((u) => u.id === id)
    if (!usuario) return
    if (usuario.rol === 'admin') {
      // FIX: usar setError en lugar de base.error.value directo
      setError('No podés eliminar un usuario admin.')
      return
    }
    usuarios.value = usuarios.value.filter((u) => u.id !== id)
    try {
      await ApiService.destroy('admin/usuarios', id)
      cargaExitosa()
    } catch (e: any) {
      usuarios.value.push(usuario)
      manejarError(e)
    }
  }

  const limpiar = () => {
    publicaciones.value = []
    usuarios.value = []
    estado.value = 'idle'
    mensajeError.value = ''
  }

  return {
    publicaciones,
    usuarios,
    estado,
    mensajeError,
    conteoPublicaciones,
    conteoUsuarios,
    publicacionesPorEstado,
    usuariosFiltrados,
    fetchPublicaciones,
    aprobar,
    rechazar,
    fetchUsuarios,
    cambiarRol,
    eliminarUsuario,
    limpiar,
  }
})
