import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import AuthService from '@/services/AuthService'

type Rol = 'viajero' | 'anfitrion' | 'admin'
type EstadoCarga = 'idle' | 'cargando' | 'exito' | 'error' | 'noEncontrado'

interface Usuario {
  id: number
  nombre: string
  email: string
  avatar: string | null
  rol: Rol
  created_at: string
}

export const useAuthStore = defineStore('auth', () => {
  const router = useRouter()

  const usuario = ref<Usuario | null>(null)
  const token = ref<string | null>(localStorage.getItem('token'))

  // Estado propio (no compartido con otros stores)
  const estado = ref<EstadoCarga>('idle')
  const mensajeError = ref('')

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
    estado.value = 'error'
    if (e?.response?.status === 401) {
      mensajeError.value = 'Email o contraseña incorrectos.'
    } else if (e?.response?.status === 422) {
      mensajeError.value = e.response?.data?.message || 'Datos inválidos.'
    } else if (e?.code === 'ERR_NETWORK') {
      mensajeError.value = 'Error de conexión. Verificá tu internet.'
    } else {
      mensajeError.value = e?.response?.data?.message || e?.message || 'Error desconocido.'
    }
  }

  // ── Computed ───────────────────────────────────────────────
  const estaLogueado = computed(() => !!token.value && !!usuario.value)
  const esAnfitrion = computed(() => usuario.value?.rol === 'anfitrion')
  const esAdmin = computed(() => usuario.value?.rol === 'admin')
  const nombreCorto = computed(() => usuario.value?.nombre.split(' ')[0] ?? '')
  const iniciales = computed(() => {
    if (!usuario.value) return ''
    return usuario.value.nombre
      .split(' ')
      .map((n) => n[0])
      .join('')
      .toUpperCase()
      .slice(0, 2)
  })

  // ── Acciones ───────────────────────────────────────────────
  const inicializar = async () => {
    if (!token.value) return
    iniciarCarga()
    try {
      const { data } = await AuthService.me()
      usuario.value = data
      cargaExitosa()
    } catch {
      cerrarSesion()
    }
  }

  const login = async (email: string, password: string) => {
    iniciarCarga()
    try {
      const { data } = await AuthService.login(email, password)
      _guardarSesion(data.token, data.usuario)
      cargaExitosa()
      // Redirigir a la ruta guardada o al inicio
      const redirect = router.currentRoute.value.query.redirect as string | undefined
      router.push(redirect || '/')
    } catch (e: any) {
      manejarError(e)
    }
  }

  const register = async (nombre: string, email: string, password: string) => {
    iniciarCarga()
    try {
      const { data } = await AuthService.register(nombre, email, password)
      _guardarSesion(data.token, data.usuario)
      cargaExitosa()
      router.push('/')
    } catch (e: any) {
      manejarError(e)
    }
  }

  const actualizarPerfil = async (datos: { nombre: string; email: string }) => {
    iniciarCarga()
    try {
      const { data } = await AuthService.actualizarPerfil(datos)
      if (usuario.value) {
        usuario.value.nombre = data.nombre
        usuario.value.email = data.email
      }
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  const actualizarAvatar = async (url: string) => {
    iniciarCarga()
    try {
      await AuthService.actualizarAvatar(url)
      if (usuario.value) usuario.value.avatar = url
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  // FIX: ahora llama realmente a AuthService.cambiarPassword
  const cambiarPassword = async (datos: { passActual: string; passNueva: string }) => {
    iniciarCarga()
    try {
      await AuthService.cambiarPassword(datos)
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  // FIX: ahora llama realmente a AuthService.solicitarAnfitrion
  const solicitarAnfitrion = async () => {
    iniciarCarga()
    try {
      await AuthService.solicitarAnfitrion()
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  const cerrarSesion = () => {
    usuario.value = null
    token.value = null
    localStorage.removeItem('token')
    estado.value = 'idle'
    mensajeError.value = ''
    router.push('/login')
  }

  const _guardarSesion = (tk: string, u: Usuario) => {
    token.value = tk
    usuario.value = u
    localStorage.setItem('token', tk)
  }

  return {
    usuario,
    token,
    estado,
    mensajeError,
    estaLogueado,
    esAnfitrion,
    esAdmin,
    nombreCorto,
    iniciales,
    inicializar,
    login,
    register,
    actualizarPerfil,
    actualizarAvatar,
    cambiarPassword,
    solicitarAnfitrion,
    cerrarSesion,
  }
})
