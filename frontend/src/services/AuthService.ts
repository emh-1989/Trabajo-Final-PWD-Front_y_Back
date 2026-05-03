import { instance as axios } from '@/plugins/axios'

class AuthService {
  // POST auth/login
  // Manda email y password, el servidor devuelve token y usuario
  static async login(email: string, password: string) {
    return axios.post('auth/login', { email, password })
  }

  // POST auth/register
  // Manda nombre, email y password, el servidor devuelve token y usuario
  static async register(nombre: string, email: string, password: string) {
    return axios.post('auth/register', { nombre, email, password })
  }

  // GET auth/me
  // El servidor lee el token del header y devuelve los datos del usuario logueado
  static async me() {
    return axios.get('auth/me')
  }

  // PUT auth/perfil
  // Actualiza nombre y email del usuario logueado
  static async actualizarPerfil(datos: { nombre: string; email: string }) {
    return axios.put('auth/perfil', datos)
  }

  // PUT auth/password
  // Cambia la contraseña del usuario logueado
  static async cambiarPassword(datos: { passActual: string; passNueva: string }) {
    return axios.put('auth/password', datos)
  }

  // PUT auth/avatar
  // Actualiza la URL del avatar del usuario logueado
  static async actualizarAvatar(url: string) {
    return axios.put('auth/avatar', { url })
  }

  // POST auth/solicitar-anfitrion
  // El usuario pide ser promovido a anfitrión
  static async solicitarAnfitrion() {
    return axios.post('auth/solicitar-anfitrion')
  }
}

export default AuthService
