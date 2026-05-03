<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Icon } from '@iconify/vue'
import { useAuthStore } from '@/stores/useAuthStore'
import EstadoCarga from '@/components/EstadoCarga.vue'

const router = useRouter()
const auth = useAuthStore()

onMounted(() => {
  if (!auth.estaLogueado) router.push('/login')
})

const usuario = computed(() => auth.usuario)
const nombreCorto = computed(() => auth.nombreCorto)
const iniciales = computed(() => auth.iniciales)

// ── Edición de perfil ──────────────────────────────────────
const editando = ref(false)
const nombreEdit = ref('')
const emailEdit = ref('')
const guardado = ref(false)

const abrirEdicion = () => {
  nombreEdit.value = usuario.value?.nombre ?? ''
  emailEdit.value = usuario.value?.email ?? ''
  editando.value = true
  guardado.value = false
}

const guardarPerfil = async () => {
  if (!nombreEdit.value.trim() || !emailEdit.value.trim()) return
  await auth.actualizarPerfil({ nombre: nombreEdit.value, email: emailEdit.value })
  if (auth.estado === 'exito') {
    guardado.value = true
    editando.value = false
  }
}

// ── Avatar ─────────────────────────────────────────────────
const avatarInput = ref<HTMLInputElement | null>(null)
const previewAvatar = ref<string | null>(null)

const onAvatar = (e: Event) => {
  const input = e.target as HTMLInputElement
  if (!input.files?.[0]) return
  previewAvatar.value = URL.createObjectURL(input.files[0])
  // TODO: subir a Cloudinary y llamar auth.actualizarAvatar(url)
}

// ── Cambio de contraseña ───────────────────────────────────
const passActual = ref('')
const passNueva = ref('')
const passConfirm = ref('')
const passError = ref('')
const passOk = ref(false)
const cambiandoPass = ref(false)

// FIX: ahora llama realmente a auth.cambiarPassword()
const cambiarPassword = async () => {
  passError.value = ''
  passOk.value = false
  if (!passActual.value || !passNueva.value || !passConfirm.value) {
    passError.value = 'Completá todos los campos.'
    return
  }
  if (passNueva.value !== passConfirm.value) {
    passError.value = 'Las contraseñas no coinciden.'
    return
  }
  if (passNueva.value.length < 8) {
    passError.value = 'La contraseña debe tener al menos 8 caracteres.'
    return
  }
  cambiandoPass.value = true
  await auth.cambiarPassword({ passActual: passActual.value, passNueva: passNueva.value })
  cambiandoPass.value = false
  if (auth.estado === 'exito') {
    passOk.value = true
    passActual.value = passNueva.value = passConfirm.value = ''
  } else {
    passError.value = auth.mensajeError
  }
}

// ── Solicitar anfitrión ────────────────────────────────────
const rolSolicitado = ref(false)
const solicitandoRol = ref(false)

// FIX: ahora llama realmente a auth.solicitarAnfitrion()
const solicitarAnfitrion = async () => {
  solicitandoRol.value = true
  await auth.solicitarAnfitrion()
  solicitandoRol.value = false
  if (auth.estado === 'exito') rolSolicitado.value = true
}

// ── Eliminar cuenta ────────────────────────────────────────
// FIX: ahora tiene confirmación en dos pasos en vez de un botón sin handler
const confirmarEliminar = ref(false)
const eliminando = ref(false)

const eliminarCuenta = async () => {
  // Pendiente de implementación en backend
  // TODO: llamar a ApiService.destroy('auth/cuenta', auth.usuario!.id) y luego cerrarSesion()
  eliminando.value = true
  await new Promise((r) => setTimeout(r, 800))
  eliminando.value = false
  confirmarEliminar.value = false
  // auth.cerrarSesion()
}

// ── Config de roles ────────────────────────────────────────
const rolConfig: Record<string, { label: string; color: string; icon: string }> = {
  viajero: { label: 'Viajero', color: '#888780', icon: 'mdi:account-outline' },
  anfitrion: { label: 'Anfitrión', color: '#7cd3e3', icon: 'mdi:home-outline' },
  admin: { label: 'Admin', color: '#df243c', icon: 'mdi:shield-account' },
}

const getRolConfig = (rol: string | undefined) =>
  rolConfig[rol ?? ''] ?? { label: 'Desconocido', color: '#ffffff', icon: 'mdi:help-circle' }
</script>

<template>
  <div class="perfil">
    <section class="hero">
      <h1>Mi perfil</h1>
      <p>Administrá tu cuenta y preferencias.</p>
    </section>

    <EstadoCarga
      v-if="auth.estado === 'cargando' && !auth.usuario"
      :estado="auth.estado"
      recurso="sesión"
    />

    <div v-else-if="!auth.usuario" class="sin-sesion">
      <p>No hay sesión activa.</p>
      <button class="btn-primary" @click="router.push('/login')">Ir al login</button>
    </div>

    <div v-else class="contenido">
      <template v-if="usuario">
        <!-- SIDEBAR -->
        <aside class="sidebar">
          <div class="avatar-wrapper">
            <div class="avatar">
              <img
                v-if="previewAvatar || usuario.avatar"
                :src="(previewAvatar || usuario.avatar)!"
                :alt="usuario.nombre"
              />
              <span v-else class="iniciales">{{ iniciales }}</span>
            </div>
            <button class="btn-avatar" @click="avatarInput?.click()">
              <Icon icon="mdi:camera" width="14" /> Cambiar foto
            </button>
            <input
              ref="avatarInput"
              type="file"
              accept="image/*"
              style="display: none"
              @change="onAvatar"
            />
          </div>

          <h2 class="nombre">{{ usuario.nombre }}</h2>
          <span
            class="badge-rol"
            :style="{
              background: getRolConfig(usuario.rol).color + '22',
              color: getRolConfig(usuario.rol).color,
              borderColor: getRolConfig(usuario.rol).color + '44',
            }"
          >
            <Icon :icon="getRolConfig(usuario.rol).icon" width="14" />
            {{ getRolConfig(usuario.rol).label }}
          </span>
          <p class="miembro">Miembro desde {{ usuario.created_at }}</p>

          <nav class="accesos">
            <button class="acceso-btn" @click="router.push('/mis-reservas')">
              <Icon icon="mdi:calendar-check-outline" width="18" /> Mis reservas
            </button>
            <button class="acceso-btn" @click="router.push('/favoritos')">
              <Icon icon="mdi:heart-outline" width="18" /> Favoritos
            </button>
            <button
              v-if="auth.esAnfitrion || auth.esAdmin"
              class="acceso-btn"
              @click="router.push('/mis-publicaciones')"
            >
              <Icon icon="mdi:home-outline" width="18" /> Mis publicaciones
            </button>
            <button v-if="auth.esAdmin" class="acceso-btn rojo" @click="router.push('/admin')">
              <Icon icon="mdi:shield-account" width="18" /> Panel admin
            </button>
            <button class="acceso-btn rojo" @click="auth.cerrarSesion()">
              <Icon icon="mdi:logout" width="18" /> Cerrar sesión
            </button>
          </nav>
        </aside>

        <!-- SECCIONES -->
        <div class="secciones">
          <!-- DATOS PERSONALES -->
          <section class="seccion">
            <div class="seccion-header">
              <h3>Datos personales</h3>
              <button v-if="!editando" class="btn-edit" @click="abrirEdicion">
                <Icon icon="mdi:pencil-outline" width="15" /> Editar
              </button>
            </div>

            <div v-if="!editando" class="datos">
              <div class="dato">
                <span class="lbl">Nombre</span>
                <span>{{ usuario.nombre }}</span>
              </div>
              <div class="dato">
                <span class="lbl">Email</span>
                <span>{{ usuario.email }}</span>
              </div>
              <p v-if="guardado" class="ok-msg">
                <Icon icon="mdi:check-circle" width="15" /> Cambios guardados.
              </p>
            </div>

            <div v-else class="form-edit">
              <div class="campo">
                <label>Nombre</label>
                <input v-model="nombreEdit" placeholder="Tu nombre" />
              </div>
              <div class="campo">
                <label>Email</label>
                <input v-model="emailEdit" type="email" placeholder="Tu email" />
              </div>
              <p v-if="auth.mensajeError && auth.estado === 'error'" class="error-msg">
                <Icon icon="mdi:alert-circle" width="15" /> {{ auth.mensajeError }}
              </p>
              <div class="form-acciones">
                <button class="btn-sec" @click="editando = false">Cancelar</button>
                <button
                  class="btn-primary"
                  :disabled="auth.estado === 'cargando'"
                  @click="guardarPerfil"
                >
                  <span v-if="auth.estado === 'cargando'" class="spinner" />
                  <span v-else>Guardar</span>
                </button>
              </div>
            </div>
          </section>

          <!-- CONTRASEÑA -->
          <section class="seccion">
            <div class="seccion-header"><h3>Contraseña</h3></div>
            <div class="form-edit">
              <div class="campo">
                <label>Contraseña actual</label>
                <input v-model="passActual" type="password" placeholder="••••••••" />
              </div>
              <div class="campo">
                <label>Nueva contraseña</label>
                <input v-model="passNueva" type="password" placeholder="••••••••" />
              </div>
              <div class="campo">
                <label>Confirmar nueva contraseña</label>
                <input v-model="passConfirm" type="password" placeholder="••••••••" />
              </div>
              <p v-if="passError" class="error-msg">
                <Icon icon="mdi:alert-circle" width="15" /> {{ passError }}
              </p>
              <p v-if="passOk" class="ok-msg">
                <Icon icon="mdi:check-circle" width="15" /> Contraseña actualizada.
              </p>
              <div class="form-acciones">
                <button class="btn-primary" :disabled="cambiandoPass" @click="cambiarPassword">
                  <span v-if="cambiandoPass" class="spinner" />
                  <span v-else>Actualizar contraseña</span>
                </button>
              </div>
            </div>
          </section>

          <!-- SOLICITAR ANFITRIÓN -->
          <section v-if="usuario.rol === 'viajero'" class="seccion seccion-anfitrion">
            <div class="seccion-header">
              <h3>¿Querés publicar tu propiedad?</h3>
            </div>
            <p class="anfitrion-desc">
              Convertite en anfitrión y publicá tu hotel, departamento o cabaña en Adventure. Tu
              solicitud será revisada por nuestro equipo.
            </p>
            <div v-if="rolSolicitado" class="ok-msg">
              <Icon icon="mdi:check-circle" width="15" /> Solicitud enviada. Te avisaremos cuando
              sea procesada.
            </div>
            <button
              v-else
              class="btn-anfitrion"
              :disabled="solicitandoRol"
              @click="solicitarAnfitrion"
            >
              <span v-if="solicitandoRol" class="spinner spinner-dark" />
              <span v-else><Icon icon="mdi:home-plus" width="18" /> Quiero ser anfitrión</span>
            </button>
          </section>

          <!-- DANGER ZONE -->
          <!-- FIX: botón "Eliminar cuenta" ahora tiene confirmación en dos pasos -->
          <section class="seccion seccion-danger">
            <div class="seccion-header"><h3>Zona peligrosa</h3></div>
            <p class="danger-desc">
              Una vez que eliminés tu cuenta, no hay vuelta atrás. Esta acción es permanente.
            </p>

            <template v-if="!confirmarEliminar">
              <button class="btn-danger" @click="confirmarEliminar = true">
                <Icon icon="mdi:trash-can-outline" width="16" /> Eliminar cuenta
              </button>
            </template>

            <template v-else>
              <p class="danger-confirmar">
                ¿Estás seguro? Esta acción <strong>no se puede deshacer</strong>.
              </p>
              <div class="form-acciones">
                <button class="btn-sec" @click="confirmarEliminar = false">Cancelar</button>
                <button class="btn-danger-confirm" :disabled="eliminando" @click="eliminarCuenta">
                  <span v-if="eliminando" class="spinner" />
                  <span v-else>Sí, eliminar mi cuenta</span>
                </button>
              </div>
            </template>
          </section>
        </div>
      </template>
    </div>
  </div>
</template>

<style scoped>
.perfil {
  background: #111111;
  color: white;
  min-height: 100vh;
}

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

.sin-sesion {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 1rem;
  padding: 5rem 2rem;
  opacity: 0.6;
}

.contenido {
  display: flex;
  gap: 2rem;
  padding: 2rem;
  max-width: 1000px;
  margin: 0 auto;
  align-items: flex-start;
}

.sidebar {
  width: 240px;
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.75rem;
  position: sticky;
  top: 100px;
}

.avatar-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
}

.avatar {
  width: 90px;
  height: 90px;
  border-radius: 50%;
  background: rgba(124, 211, 227, 0.15);
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  border: 2px solid rgba(124, 211, 227, 0.3);
}
.avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.iniciales {
  font-size: 1.4rem;
  font-weight: 700;
  color: #7cd3e3;
}

.btn-avatar {
  display: flex;
  align-items: center;
  gap: 0.3rem;
  background: transparent;
  border: 1px solid rgba(255, 255, 255, 0.12);
  color: rgba(255, 255, 255, 0.6);
  padding: 0.3rem 0.8rem;
  border-radius: 6px;
  font-size: 0.78rem;
  cursor: pointer;
  transition: 0.2s;
}
.btn-avatar:hover {
  border-color: #7cd3e3;
  color: #7cd3e3;
}

.nombre {
  margin: 0;
  font-size: 1.1rem;
  text-align: center;
}

.badge-rol {
  display: flex;
  align-items: center;
  gap: 0.3rem;
  padding: 0.25rem 0.7rem;
  border-radius: 20px;
  font-size: 0.75rem;
  font-weight: 600;
  border: 1px solid;
}

.miembro {
  font-size: 0.75rem;
  opacity: 0.4;
  margin: 0;
}

.accesos {
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
  width: 100%;
  margin-top: 0.5rem;
}

.acceso-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(255, 255, 255, 0.08);
  color: rgba(255, 255, 255, 0.75);
  padding: 0.6rem 1rem;
  border-radius: 8px;
  font-size: 0.85rem;
  cursor: pointer;
  transition: 0.2s;
  width: 100%;
  text-align: left;
}
.acceso-btn:hover {
  border-color: #7cd3e3;
  color: #7cd3e3;
}
.acceso-btn.rojo:hover {
  border-color: #df243c;
  color: #df243c;
}

.secciones {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
}

.seccion {
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 12px;
  padding: 1.5rem;
}

.seccion-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.25rem;
}
.seccion-header h3 {
  margin: 0;
  font-size: 1rem;
}

.btn-edit {
  display: flex;
  align-items: center;
  gap: 0.3rem;
  background: transparent;
  border: 1px solid rgba(255, 255, 255, 0.12);
  color: rgba(255, 255, 255, 0.65);
  padding: 0.3rem 0.7rem;
  border-radius: 6px;
  font-size: 0.8rem;
  cursor: pointer;
  transition: 0.2s;
}
.btn-edit:hover {
  border-color: #7cd3e3;
  color: #7cd3e3;
}

.datos {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}
.dato {
  display: flex;
  flex-direction: column;
  gap: 0.2rem;
}
.lbl {
  font-size: 0.75rem;
  opacity: 0.45;
}

.form-edit {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}
.campo {
  display: flex;
  flex-direction: column;
  gap: 0.35rem;
}
.campo label {
  font-size: 0.8rem;
  opacity: 0.6;
}
.campo input {
  background: #1a1a1a;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  color: white;
  padding: 0.6rem 0.9rem;
  outline: none;
  transition: 0.2s;
}
.campo input:focus {
  border-color: #7cd3e3;
}

.form-acciones {
  display: flex;
  justify-content: flex-end;
  gap: 0.75rem;
}

.btn-primary {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  padding: 0.6rem 1.4rem;
  border: none;
  border-radius: 8px;
  background: #df243c;
  color: white;
  font-weight: 600;
  cursor: pointer;
  transition: 0.2s;
}
.btn-primary:hover:not(:disabled) {
  background: #b81d30;
}
.btn-primary:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.btn-sec {
  padding: 0.6rem 1.2rem;
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

.ok-msg {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  color: #1d9e75;
  font-size: 0.85rem;
}
.error-msg {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  color: #ff4d4d;
  font-size: 0.85rem;
}

.seccion-anfitrion {
  border-color: rgba(124, 211, 227, 0.2);
}
.anfitrion-desc {
  opacity: 0.7;
  font-size: 0.88rem;
  line-height: 1.6;
  margin-bottom: 1rem;
}

.btn-anfitrion {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  background: #7cd3e3;
  border: none;
  color: #111111;
  padding: 0.65rem 1.5rem;
  border-radius: 8px;
  font-weight: 700;
  cursor: pointer;
  transition: 0.2s;
}
.btn-anfitrion:hover:not(:disabled) {
  background: #5bbdce;
}
.btn-anfitrion:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.seccion-danger {
  border-color: rgba(223, 36, 60, 0.2);
}
.danger-desc {
  opacity: 0.6;
  font-size: 0.85rem;
  margin-bottom: 1rem;
}
.danger-confirmar {
  color: #ff4d4d;
  font-size: 0.85rem;
  margin-bottom: 1rem;
}

.btn-danger {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  background: transparent;
  border: 1px solid rgba(223, 36, 60, 0.4);
  color: #df243c;
  padding: 0.55rem 1.2rem;
  border-radius: 8px;
  font-size: 0.85rem;
  cursor: pointer;
  transition: 0.2s;
}
.btn-danger:hover {
  background: rgba(223, 36, 60, 0.1);
}

.btn-danger-confirm {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  background: #df243c;
  border: none;
  color: white;
  padding: 0.55rem 1.2rem;
  border-radius: 8px;
  font-size: 0.85rem;
  font-weight: 600;
  cursor: pointer;
  transition: 0.2s;
}
.btn-danger-confirm:hover:not(:disabled) {
  background: #b81d30;
}
.btn-danger-confirm:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.spinner {
  width: 16px;
  height: 16px;
  border: 2px solid white;
  border-top-color: transparent;
  border-radius: 50%;
  animation: spin 0.6s linear infinite;
  display: inline-block;
}
.spinner-dark {
  border-color: #111;
  border-top-color: transparent;
}
@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

@media (max-width: 768px) {
  .contenido {
    flex-direction: column;
    padding: 1rem;
  }
  .sidebar {
    width: 100%;
    position: static;
  }
  .accesos {
    display: grid;
    grid-template-columns: 1fr 1fr;
  }
}
</style>
