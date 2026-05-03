import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { useAuthStore } from './useAuthStore'
import ApiService from '@/services/ApiService'

type EstadoCarga = 'idle' | 'cargando' | 'exito' | 'error' | 'noEncontrado'
type EstadoPublicacion = 'borrador' | 'pendiente' | 'publicado' | 'rechazado'
type TipoPropiedad = 'hotel' | 'hostel' | 'departamento' | 'resort'

interface Publicacion {
  id: number
  nombre: string
  tipo: TipoPropiedad
  ubicacion: string
  destino: string
  precio_noche: number
  descripcion: string
  imagenes: string[]
  estado: EstadoPublicacion
  motivo_rechazo?: string
  created_at: string
}

interface NuevaPublicacion {
  nombre: string
  tipo: TipoPropiedad
  ubicacion: string
  destino: string
  precio_noche: number
  descripcion: string
  imagenes: File[]
}

export const usePublicacionesStore = defineStore('publicaciones', () => {
  const auth = useAuthStore()
  const publicaciones = ref<Publicacion[]>([])
  const subiendo = ref(false)
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

  const porEstado = computed(() => {
    return (est: EstadoPublicacion) => publicaciones.value.filter((p) => p.estado === est)
  })

  const conteo = computed(() => ({
    borrador: publicaciones.value.filter((p) => p.estado === 'borrador').length,
    pendiente: publicaciones.value.filter((p) => p.estado === 'pendiente').length,
    publicado: publicaciones.value.filter((p) => p.estado === 'publicado').length,
    rechazado: publicaciones.value.filter((p) => p.estado === 'rechazado').length,
  }))

  const totalPublicadas = computed(
    () => publicaciones.value.filter((p) => p.estado === 'publicado').length,
  )

  const fetchPublicaciones = async () => {
    if (!auth.estaLogueado || !auth.esAnfitrion) return
    iniciarCarga()
    try {
      const { data } = await ApiService.getAll('publicaciones/mias')
      publicaciones.value = data
      cargaExitosa()
    } catch (e: any) {
      manejarError(e)
    }
  }

  // TODO: reemplazar con subida real a Cloudinary u otro servicio de imágenes
  const subirImagenes = async (archivos: File[]): Promise<string[]> => {
    subiendo.value = true
    const urls: string[] = []
    try {
      for (const archivo of archivos) {
        await new Promise((r) => setTimeout(r, 300))
        urls.push(`https://res.cloudinary.com/demo/image/upload/${archivo.name}`)
      }
      return urls
    } catch (e: any) {
      mensajeError.value = 'Error al subir las imágenes.'
      return []
    } finally {
      subiendo.value = false
    }
  }

  const crear = async (datos: NuevaPublicacion) => {
    if (!auth.estaLogueado) return
    iniciarCarga()
    try {
      const urlsImagenes = await subirImagenes(datos.imagenes)
      if (urlsImagenes.length === 0) throw new Error('No se pudieron subir las imágenes.')
      const { data } = await ApiService.create('publicaciones', {
        ...datos,
        imagenes: urlsImagenes,
      })
      publicaciones.value.push(data)
      cargaExitosa()
      return data
    } catch (e: any) {
      manejarError(e)
    }
  }

  const editar = async (id: number, datos: Partial<NuevaPublicacion>) => {
    if (!auth.estaLogueado) return
    iniciarCarga()
    try {
      let urlsImagenes: string[] = []
      if (datos.imagenes && datos.imagenes.length > 0) {
        urlsImagenes = await subirImagenes(datos.imagenes)
      }
      const payload = { ...datos, ...(urlsImagenes.length > 0 && { imagenes: urlsImagenes }) }
      const { data } = await ApiService.update('publicaciones', id, payload)
      const idx = publicaciones.value.findIndex((p) => p.id === id)
      if (idx !== -1) publicaciones.value[idx] = { ...publicaciones.value[idx], ...data }
      cargaExitosa()
      return data
    } catch (e: any) {
      manejarError(e)
    }
  }

  const eliminar = async (id: number) => {
    if (!auth.estaLogueado) return
    const publicacion = publicaciones.value.find((p) => p.id === id)
    if (!publicacion) return
    publicaciones.value = publicaciones.value.filter((p) => p.id !== id)
    try {
      await ApiService.destroy('publicaciones', id)
      cargaExitosa()
    } catch (e: any) {
      publicaciones.value.push(publicacion)
      manejarError(e)
    }
  }

  const limpiar = () => {
    publicaciones.value = []
    estado.value = 'idle'
    mensajeError.value = ''
  }

  return {
    publicaciones,
    subiendo,
    estado,
    mensajeError,
    porEstado,
    conteo,
    totalPublicadas,
    fetchPublicaciones,
    subirImagenes,
    crear,
    editar,
    eliminar,
    limpiar,
  }
})
