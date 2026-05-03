<script setup lang="ts">
import { ref } from 'vue'
import { Icon } from '@iconify/vue'
import { useRouter } from 'vue-router'
import { usePublicacionesStore } from '@/stores/usePublicacionesStore'

const router = useRouter()
const publicacionesStore = usePublicacionesStore()

// Campos del formulario
const nombre = ref('')
const tipo = ref<'hotel' | 'hostel' | 'departamento' | 'resort'>('hotel')
const ubicacion = ref('')
const destino = ref('')
const precio_noche = ref<number | null>(null)
const descripcion = ref('')
const imagenes = ref<File[]>([])
const previews = ref<string[]>([])

const enviando = ref(false)
const enviado = ref(false)
const error = ref('')

// Manejo de imágenes
const onImagenes = (e: Event) => {
  const input = e.target as HTMLInputElement
  if (!input.files) return
  const nuevas = Array.from(input.files).slice(0, 8 - imagenes.value.length)
  nuevas.forEach((file) => {
    imagenes.value.push(file)
    previews.value.push(URL.createObjectURL(file))
  })
}

const eliminarImagen = (i: number) => {
  URL.revokeObjectURL(previews.value[i])
  imagenes.value.splice(i, 1)
  previews.value.splice(i, 1)
}

// Validación
const valido = () => {
  if (!nombre.value.trim()) {
    error.value = 'El nombre es obligatorio.'
    return false
  }
  if (!ubicacion.value.trim()) {
    error.value = 'La ubicación es obligatoria.'
    return false
  }
  if (!destino.value.trim()) {
    error.value = 'El destino es obligatorio.'
    return false
  }
  if (!precio_noche.value || precio_noche.value <= 0) {
    error.value = 'El precio debe ser mayor a 0.'
    return false
  }
  if (!descripcion.value.trim()) {
    error.value = 'La descripción es obligatoria.'
    return false
  }
  if (imagenes.value.length === 0) {
    error.value = 'Agregá al menos una imagen.'
    return false
  }
  error.value = ''
  return true
}

// Envío
const publicar = async () => {
  if (!valido()) return
  enviando.value = true
  try {
    // Crear publicación a través del store
    await publicacionesStore.crear({
      nombre: nombre.value,
      tipo: tipo.value,
      ubicacion: ubicacion.value,
      destino: destino.value,
      precio_noche: precio_noche.value!,
      descripcion: descripcion.value,
      imagenes: imagenes.value,
    })
    enviado.value = true
  } catch (e) {
    error.value = 'Error al publicar la propiedad.'
  } finally {
    enviando.value = false
  }
}
</script>

<template>
  <div class="publicar">
    <section class="hero">
      <h1>Publicá tu propiedad</h1>
      <p>Completá el formulario y tu publicación será revisada antes de aparecer en la app.</p>
    </section>

    <!-- Éxito -->
    <div v-if="enviado" class="estado-ok">
      <Icon icon="mdi:check-circle" width="40" />
      <h2>¡Publicación enviada!</h2>
      <p>Tu propiedad está en revisión. Te notificaremos cuando sea aprobada.</p>
      <button class="btn-sec" @click="router.push('/mis-publicaciones')">
        Ver mis publicaciones
      </button>
    </div>

    <!-- Formulario -->
    <form v-else class="form" @submit.prevent="publicar">
      <!-- Secciones del formulario sin cambios -->
      <!-- ... (copia exactamente el mismo formulario que ya tenías, 
           solo cambiá el @submit.prevent por el método 'publicar' 
           y usá las variables reactivas locales) ... -->
      <fieldset class="seccion">
        <legend>Datos de la propiedad</legend>
        <div class="fila-2">
          <div class="campo">
            <label>Nombre *</label><input v-model="nombre" placeholder="Ej: Cabaña Los Arrayanes" />
          </div>
          <div class="campo">
            <label>Tipo *</label
            ><select v-model="tipo">
              <option value="hotel">Hotel</option>
              <option value="hostel">Hostel</option>
              <option value="departamento">Departamento</option>
              <option value="resort">Resort</option>
            </select>
          </div>
        </div>
        <div class="fila-2">
          <div class="campo">
            <label>Ubicación *</label>
            <div class="input-icon">
              <Icon icon="mdi:map-marker-outline" /><input
                v-model="ubicacion"
                placeholder="Dirección o barrio"
              />
            </div>
          </div>
          <div class="campo">
            <label>Destino *</label>
            <div class="input-icon">
              <Icon icon="mdi:city" /><input v-model="destino" placeholder="Ej: Bariloche" />
            </div>
          </div>
        </div>
        <div class="campo campo-sm">
          <label>Precio por noche (USD) *</label>
          <div class="input-icon">
            <Icon icon="mdi:currency-usd" /><input
              type="number"
              v-model="precio_noche"
              min="1"
              placeholder="0"
            />
          </div>
        </div>
      </fieldset>
      <!-- resto igual... -->
      <p v-if="error" class="error"><Icon icon="mdi:alert-circle" /> {{ error }}</p>
      <div class="acciones">
        <button type="button" class="btn-sec" @click="router.back()">Cancelar</button>
        <button type="submit" class="btn-primary" :disabled="enviando">
          <span v-if="enviando" class="spinner" />
          <span v-else>Enviar para revisión</span>
        </button>
      </div>
    </form>
  </div>
</template>

<style scoped>
.publicar {
  background: #111111;
  color: white;
  min-height: 100vh;
}

/* HERO */
.hero {
  padding: 3rem 1rem;
  text-align: center;
  background: #111111;
  border-bottom: 3px solid #7cd3e3;
}

.hero p {
  opacity: 0.7;
  margin-top: 0.5rem;
}

/* ESTADO OK */
.estado-ok {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  padding: 5rem 2rem;
  text-align: center;
  color: #7cd3e3;
}

.estado-ok p {
  color: white;
  opacity: 0.7;
}

/* FORM */
.form {
  max-width: 820px;
  margin: 2rem auto;
  padding: 0 1.5rem 3rem;
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

/* FIELDSET */
.seccion {
  border: 1px solid rgba(124, 211, 227, 0.15);
  border-radius: 12px;
  padding: 1.5rem;
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.seccion legend {
  color: #7cd3e3;
  font-size: 0.9rem;
  font-weight: 600;
  padding: 0 0.5rem;
  letter-spacing: 0.04em;
  text-transform: uppercase;
}

/* FILAS */
.fila-2 {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
}

/* CAMPO */
.campo {
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
}

.campo-sm {
  max-width: 240px;
}

.campo label {
  font-size: 0.85rem;
  opacity: 0.75;
}

.campo input,
.campo select,
.campo textarea {
  background: #1a1a1a;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  color: white;
  padding: 0.6rem 0.9rem;
  font-size: 0.95rem;
  outline: none;
  transition: border-color 0.2s;
  width: 100%;
  box-sizing: border-box;
}

.campo input:focus,
.campo select:focus,
.campo textarea:focus {
  border-color: #7cd3e3;
}

.campo textarea {
  resize: vertical;
  min-height: 120px;
}

.campo select option {
  background: #1a1a1a;
}

.contador {
  font-size: 0.75rem;
  opacity: 0.4;
  text-align: right;
}

/* INPUT CON ÍCONO */
.input-icon {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  background: #1a1a1a;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  padding: 0 0.9rem;
  transition: border-color 0.2s;
}

.input-icon:focus-within {
  border-color: #7cd3e3;
}

.input-icon input {
  border: none;
  background: transparent;
  padding: 0.6rem 0;
  flex: 1;
}

.input-icon input:focus {
  border: none;
}

/* DROPZONE */
.dropzone {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 0.4rem;
  border: 2px dashed rgba(124, 211, 227, 0.3);
  border-radius: 10px;
  padding: 2rem;
  cursor: pointer;
  transition: 0.2s;
  text-align: center;
  color: rgba(255, 255, 255, 0.6);
}

.dropzone:hover:not(.lleno) {
  border-color: #7cd3e3;
  color: #7cd3e3;
}

.dropzone.lleno {
  opacity: 0.4;
  cursor: not-allowed;
}

.dropzone small {
  font-size: 0.75rem;
  opacity: 0.6;
}

/* PREVIEWS */
.previews {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
  gap: 0.75rem;
}

.preview-item {
  position: relative;
  border-radius: 8px;
  overflow: hidden;
  aspect-ratio: 1;
}

.preview-item img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.btn-eliminar {
  position: absolute;
  top: 4px;
  right: 4px;
  background: rgba(0, 0, 0, 0.7);
  border: none;
  border-radius: 50%;
  color: white;
  width: 22px;
  height: 22px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: 0.2s;
}

.btn-eliminar:hover {
  background: #df243c;
}

.badge-principal {
  position: absolute;
  bottom: 4px;
  left: 4px;
  background: #7cd3e3;
  color: #111;
  font-size: 0.65rem;
  font-weight: 700;
  padding: 0.15rem 0.4rem;
  border-radius: 4px;
}

/* ERROR */
.error {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  color: #ff4d4d;
  font-size: 0.9rem;
}

/* ACCIONES */
.acciones {
  display: flex;
  justify-content: flex-end;
  gap: 1rem;
}

.btn-primary {
  padding: 0.7rem 2rem;
  border: none;
  border-radius: 8px;
  background: #df243c;
  color: white;
  font-weight: 600;
  cursor: pointer;
  transition: 0.2s;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.btn-primary:hover:not(:disabled) {
  background: #b81d30;
}

.btn-primary:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.btn-sec {
  padding: 0.7rem 1.5rem;
  border: 1px solid rgba(255, 255, 255, 0.15);
  border-radius: 8px;
  background: transparent;
  color: white;
  cursor: pointer;
  transition: 0.2s;
}

.btn-sec:hover {
  border-color: #7cd3e3;
  color: #7cd3e3;
}

/* SPINNER */
.spinner {
  width: 18px;
  height: 18px;
  border: 2px solid white;
  border-top-color: transparent;
  border-radius: 50%;
  animation: spin 0.6s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

/* RESPONSIVE */
@media (max-width: 640px) {
  .fila-2 {
    grid-template-columns: 1fr;
  }

  .campo-sm {
    max-width: 100%;
  }

  .acciones {
    flex-direction: column;
  }

  .btn-primary,
  .btn-sec {
    width: 100%;
    justify-content: center;
  }
}
</style>
