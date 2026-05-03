<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { RouterLink, useRouter } from 'vue-router'
import { Icon } from '@iconify/vue'
import { useAuthStore } from '@/stores/useAuthStore'
import { useNotificacionesStore } from '@/stores/useNotificacionesStore'

const router = useRouter()
const auth = useAuthStore()
const notifStore = useNotificacionesStore()

// Estado local
const masAbierto = ref(false)
const perfilAbierto = ref(false)

// Computed
const nombreUsuario = computed(() => auth.nombreCorto)
const hayNotificaciones = computed(() => notifStore.hayNoLeidas)
const cantidadNotificaciones = computed(() => notifStore.cantidadNoLeidas)

// Methods
const toggleMas = () => {
  masAbierto.value = !masAbierto.value
  if (masAbierto.value) perfilAbierto.value = false
}

const cerrarMas = () => {
  masAbierto.value = false
}

const togglePerfil = () => {
  perfilAbierto.value = !perfilAbierto.value
  if (perfilAbierto.value) masAbierto.value = false
}

const cerrarPerfil = () => {
  perfilAbierto.value = false
}

const irA = (ruta: string) => {
  router.push(ruta)
  perfilAbierto.value = false
  masAbierto.value = false
}

const cerrarSesion = () => {
  auth.cerrarSesion()
  perfilAbierto.value = false
  notifStore.limpiar()
}

// Cerrar dropdowns al hacer clic fuera
const handleClickOutside = (event: MouseEvent) => {
  const target = event.target as HTMLElement
  if (!target.closest('.perfil-wrapper') && !target.closest('.mas-wrapper')) {
    perfilAbierto.value = false
    masAbierto.value = false
  }
}

onMounted(() => {
  document.addEventListener('click', handleClickOutside)
  // Cargar notificaciones si está logueado
  if (auth.estaLogueado) {
    notifStore.fetchNotificaciones()
  }
})

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside)
})
</script>

<template>
  <header class="header">
    <!-- LOGO -->
    <div class="logo" @click="router.push('/')">
      <img src="@/assets/logo.svg" alt="Adventure" />
    </div>

    <!-- NAV DESKTOP -->
    <nav class="nav-desktop">
      <RouterLink to="/hospedaje" class="nav-btn">
        <Icon icon="fontisto:hotel" width="18" /> Hospedaje
      </RouterLink>
      <RouterLink to="/entretenimiento" class="nav-btn">
        <Icon icon="streamline-ultimate:show-theater-mask-happy" width="18" /> Entretenimiento
      </RouterLink>
      <RouterLink to="/vuelos" class="nav-btn">
        <Icon icon="simple-line-icons:plane" width="18" /> Vuelos
      </RouterLink>
      <RouterLink to="/restaurant" class="nav-btn">
        <Icon icon="fluent:food-16-regular" width="18" /> Restaurant
      </RouterLink>
    </nav>

    <!-- NAV MOBILE -->
    <nav class="nav-mobile">
      <RouterLink to="/hospedaje" class="nav-btn" @click="cerrarMas">
        <Icon icon="fontisto:hotel" width="18" /> Hospedaje
      </RouterLink>

      <div class="mas-wrapper">
        <button class="nav-btn mas-btn" @click.stop="toggleMas">
          Más <Icon :icon="masAbierto ? 'mdi:chevron-up' : 'mdi:chevron-down'" width="16" />
        </button>

        <div v-if="masAbierto" class="dropdown">
          <RouterLink to="/entretenimiento" class="dropdown-item" @click="cerrarMas">
            <Icon icon="streamline-ultimate:show-theater-mask-happy" width="18" /> Entretenimiento
          </RouterLink>
          <RouterLink to="/vuelos" class="dropdown-item" @click="cerrarMas">
            <Icon icon="simple-line-icons:plane" width="18" /> Vuelos
          </RouterLink>
          <RouterLink to="/restaurant" class="dropdown-item" @click="cerrarMas">
            <Icon icon="fluent:food-16-regular" width="18" /> Restaurant
          </RouterLink>

          <!-- Opciones de usuario en móvil -->
          <template v-if="auth.estaLogueado">
            <hr class="dropdown-divider" />
            <RouterLink to="/favoritos" class="dropdown-item" @click="cerrarMas">
              <Icon icon="mdi:heart-outline" width="18" /> Favoritos
            </RouterLink>
            <RouterLink to="/mis-reservas" class="dropdown-item" @click="cerrarMas">
              <Icon icon="mdi:calendar-check-outline" width="18" /> Mis reservas
            </RouterLink>
          </template>
          <template v-else>
            <hr class="dropdown-divider" />
            <RouterLink to="/login" class="dropdown-item login-item" @click="cerrarMas">
              <Icon icon="mdi:login" width="18" /> Ingresar
            </RouterLink>
            <RouterLink to="/register" class="dropdown-item" @click="cerrarMas">
              <Icon icon="mdi:account-plus" width="18" /> Registrarse
            </RouterLink>
          </template>
        </div>
      </div>
    </nav>

    <!-- ACCIONES -->
    <div class="acciones">
      <!-- ✅ USUARIO LOGUEADO -->
      <template v-if="auth.estaLogueado">
        <!-- Notificaciones -->
        <span class="icono-badge" @click="irA('/perfil')" title="Notificaciones">
          <Icon icon="mdi:notifications" width="20" />
          <span v-if="hayNotificaciones" class="badge-notif">
            {{ cantidadNotificaciones > 9 ? '9+' : cantidadNotificaciones }}
          </span>
        </span>

        <!-- Favoritos -->
        <span class="favoritos-desktop" @click="irA('/favoritos')" title="Favoritos">
          <Icon icon="mdi:heart-outline" width="20" />
        </span>

        <!-- Perfil / Menú usuario -->
        <div class="perfil-wrapper">
          <span class="perfil-btn" @click.stop="togglePerfil" title="Menú de usuario">
            <Icon icon="mdi:account" width="20" />
            <span class="nombre-usuario">{{ nombreUsuario }}</span>
            <Icon
              :icon="perfilAbierto ? 'mdi:chevron-up' : 'mdi:chevron-down'"
              width="14"
              class="chevron"
            />
          </span>

          <!-- Dropdown del perfil -->
          <div v-if="perfilAbierto" class="perfil-dropdown">
            <div class="dropdown-header">
              <Icon icon="mdi:account-circle" width="32" />
              <div>
                <strong>{{ auth.usuario?.nombre }}</strong>
                <small>{{ auth.usuario?.email }}</small>
              </div>
            </div>

            <hr />

            <button @click="irA('/perfil')">
              <Icon icon="mdi:account-outline" width="18" /> Mi perfil
            </button>

            <button @click="irA('/mis-reservas')">
              <Icon icon="mdi:calendar-check-outline" width="18" /> Mis reservas
            </button>

            <button @click="irA('/favoritos')">
              <Icon icon="mdi:heart-outline" width="18" /> Favoritos
            </button>

            <template v-if="auth.esAnfitrion || auth.esAdmin">
              <hr />
              <button @click="irA('/mis-publicaciones')">
                <Icon icon="mdi:home-outline" width="18" /> Mis publicaciones
              </button>
              <button @click="irA('/publicar')">
                <Icon icon="mdi:plus-circle-outline" width="18" /> Nueva publicación
              </button>
            </template>

            <template v-if="auth.esAdmin">
              <hr />
              <button @click="irA('/admin')" class="admin-btn">
                <Icon icon="mdi:shield-account" width="18" /> Panel de administración
              </button>
            </template>

            <hr />

            <button @click="cerrarSesion" class="logout-btn">
              <Icon icon="mdi:logout" width="18" /> Cerrar sesión
            </button>
          </div>
        </div>
      </template>

      <!-- ❌ USUARIO NO LOGUEADO (solo visible en desktop) -->
      <template v-else>
        <span @click="router.push('/login')" title="Iniciar sesión" class="login-btn login-desktop">
          <Icon icon="mdi:login" width="20" />
          <span class="login-text">Ingresar</span>
        </span>
      </template>
    </div>
  </header>
</template>

<style scoped>
/* ── Layout principal ── */
.header {
  background: #ffffff;
  border-bottom: 3px solid transparent;
  border-image: linear-gradient(to right, #7cd3e3 0%, #df243c 100%) 1;
  color: #111111;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.75rem 1.5rem;
  gap: 1rem;
  box-shadow: 0 2px 12px rgba(124, 211, 227, 0.18);
  position: relative;
  z-index: 1000;
}

.header::before {
  content: '';
  position: absolute;
  top: 0;
  right: 0;
  width: 6px;
  height: 100%;
  background: linear-gradient(to bottom, #7cd3e3, #df243c);
  border-radius: 0 0 0 4px;
}

/* ── Logo ── */
.logo {
  cursor: pointer;
  flex-shrink: 0;
}

.logo img {
  height: 50px;
  width: auto;
  filter: drop-shadow(0 2px 6px rgba(0, 0, 0, 0.7));
}

/* ── Botones nav compartidos ── */
.nav-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.35rem;
  background: transparent;
  border: 1px solid rgba(0, 0, 0, 0.12);
  color: #111111;
  padding: 0.4rem 0.9rem;
  border-radius: 6px;
  cursor: pointer;
  font-size: 0.82rem;
  text-decoration: none;
  white-space: nowrap;
  transition: 0.2s;
}

.nav-btn:hover {
  border-color: #7cd3e3;
  color: #7cd3e3;
  box-shadow: 0 0 6px rgba(124, 211, 227, 0.35);
}

.nav-btn.router-link-active {
  border-color: #df243c;
  color: #df243c;
}

/* ── Nav desktop ── */
.nav-desktop {
  display: flex;
  gap: 0.4rem;
  align-items: center;
  flex: 1;
  justify-content: center;
}

/* ── Nav mobile ── */
.nav-mobile {
  display: none;
  gap: 0.4rem;
  align-items: center;
  flex: 1;
  justify-content: center;
}

.mas-wrapper {
  position: relative;
}

.mas-btn {
  border-color: rgba(0, 0, 0, 0.2);
}

.dropdown {
  position: absolute;
  top: calc(100% + 0.5rem);
  left: 0;
  background: #ffffff;
  border: 1px solid rgba(0, 0, 0, 0.1);
  border-radius: 12px;
  padding: 0.4rem;
  min-width: 240px;
  z-index: 100;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
  animation: fadeIn 0.2s ease;
}

.dropdown-divider {
  border: none;
  border-top: 1px solid rgba(0, 0, 0, 0.1);
  margin: 0.3rem 0;
}

.dropdown-item {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  color: #111111;
  text-decoration: none;
  padding: 0.6rem 0.9rem;
  border-radius: 8px;
  font-size: 0.9rem;
  transition: 0.2s;
}

.dropdown-item:hover {
  background: rgba(124, 211, 227, 0.12);
  color: #7cd3e3;
}

.dropdown-item.router-link-active {
  color: #df243c;
  background: rgba(223, 36, 60, 0.06);
}

.login-item {
  color: #df243c;
  font-weight: 600;
}

.login-item:hover {
  background: rgba(223, 36, 60, 0.1);
  color: #df243c;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* ── Acciones ── */
.acciones {
  display: flex;
  gap: 1.2rem;
  align-items: center;
  flex-shrink: 0;
}

.acciones > span {
  cursor: pointer;
  transition: all 0.2s;
  color: #333;
  display: flex;
  align-items: center;
  gap: 0.3rem;
}

.acciones > span:hover {
  transform: scale(1.1);
  color: #7cd3e3;
}

/* ── Badge de notificaciones ── */
.icono-badge {
  position: relative;
}

.badge-notif {
  position: absolute;
  top: -6px;
  right: -8px;
  background: #df243c;
  color: white;
  font-size: 0.65rem;
  font-weight: 700;
  width: 18px;
  height: 18px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 2px solid white;
}

/* ── Login button (desktop) ── */
.login-btn {
  background: #df243c;
  color: white !important;
  padding: 0.5rem 1rem;
  border-radius: 8px;
  font-size: 0.85rem;
  font-weight: 500;
  transition: 0.2s;
  text-decoration: none;
}

.login-btn:hover {
  background: #b81d30;
  transform: translateY(-1px) !important;
  color: white !important;
}

.login-text {
  font-size: 0.85rem;
}

/* ── Perfil wrapper ── */
.perfil-wrapper {
  position: relative;
}

.perfil-btn {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  cursor: pointer;
  padding: 0.3rem 0.5rem;
  border-radius: 8px;
  transition: 0.2s;
  color: #333;
}

.perfil-btn:hover {
  background: rgba(124, 211, 227, 0.1);
}

.nombre-usuario {
  font-size: 0.85rem;
  font-weight: 500;
  max-width: 100px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.chevron {
  opacity: 0.5;
  transition: 0.2s;
}

/* ── Perfil dropdown ── */
.perfil-dropdown {
  position: absolute;
  top: calc(100% + 0.5rem);
  right: 0;
  background: #ffffff;
  border: 1px solid rgba(0, 0, 0, 0.1);
  border-radius: 12px;
  padding: 0.5rem;
  min-width: 260px;
  z-index: 200;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
  animation: fadeIn 0.2s ease;
}

.dropdown-header {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.75rem;
}

.dropdown-header strong {
  display: block;
  font-size: 0.9rem;
  color: #111;
}

.dropdown-header small {
  display: block;
  font-size: 0.75rem;
  color: #666;
  margin-top: 0.15rem;
}

.perfil-dropdown hr {
  border: none;
  border-top: 1px solid rgba(0, 0, 0, 0.08);
  margin: 0.3rem 0;
}

.perfil-dropdown button {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  width: 100%;
  padding: 0.65rem 0.75rem;
  border: none;
  background: transparent;
  color: #333;
  font-size: 0.85rem;
  cursor: pointer;
  border-radius: 8px;
  transition: 0.2s;
  text-align: left;
}

.perfil-dropdown button:hover {
  background: rgba(124, 211, 227, 0.1);
  color: #7cd3e3;
}

.admin-btn:hover {
  background: rgba(223, 36, 60, 0.08) !important;
  color: #df243c !important;
}

.logout-btn {
  color: #df243c !important;
}

.logout-btn:hover {
  background: rgba(223, 36, 60, 0.08) !important;
}

/* ── RESPONSIVE ── */

/* Tablet y móvil: ocultar nav desktop, mostrar nav mobile */
@media (max-width: 900px) {
  .nav-desktop {
    display: none;
  }

  .nav-mobile {
    display: flex;
  }

  .login-desktop {
    display: none !important;
  }

  .favoritos-desktop {
    display: none;
  }

  .nombre-usuario {
    display: none;
  }

  .login-text {
    display: none;
  }
}

/* Móvil pequeño */
@media (max-width: 640px) {
  .header {
    padding: 0.5rem 0.75rem;
    gap: 0.5rem;
  }

  .acciones {
    gap: 0.75rem;
  }

  .perfil-dropdown {
    right: -80px;
    min-width: 240px;
  }

  .dropdown {
    right: -20px;
    left: auto;
    min-width: 220px;
  }
}

/* Móvil muy pequeño */
@media (max-width: 480px) {
  .perfil-dropdown {
    right: -100px;
    min-width: 220px;
  }

  .dropdown {
    right: -40px;
    min-width: 200px;
  }
}
</style>
