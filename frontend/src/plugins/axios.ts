// plugins/axios.ts
import axios from 'axios'

export const instance = axios.create({
  baseURL: 'http://localhost:5000/api/',
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json',
  },
})

// Agrega el token automáticamente en cada request
instance.interceptors.request.use((config) => {
  const token = localStorage.getItem('token')
  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }
  return config
})

// FIX: el interceptor ya NO redirige al login en 401.
// El manejo del 401 lo hacen los stores a través de manejarError().
// Si se redirigía aquí Y en el store, había un triple manejo (interceptor + manejarError + cerrarSesion).
// Ahora solo se rechaza el error para que el store lo procese.
instance.interceptors.response.use(
  (response) => response,
  (error) => {
    // Limpiar el token si el servidor dice que expiró o es inválido,
    // pero dejar que el store maneje la redirección y el mensaje de error.
    if (error.response?.status === 401) {
      localStorage.removeItem('token')
    }
    return Promise.reject(error)
  },
)
