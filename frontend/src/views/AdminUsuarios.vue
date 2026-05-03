<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { Icon } from '@iconify/vue'
import { useRouter } from 'vue-router'
import { useAdminStore } from '@/stores/useAdminStore'
import EstadoCarga from '@/components/EstadoCarga.vue'

const router = useRouter()
const admin = useAdminStore()

type Rol = 'viajero' | 'anfitrion' | 'admin'

const busqueda = ref('')
const filtroRol = ref<Rol | ''>('')
const confirmandoId = ref<number | null>(null)
const nuevoRol = ref<Rol>('viajero')

onMounted(() => {
  admin.fetchUsuarios()
})

const filtrados = computed(() => {
  return admin.usuarios.filter((u) => {
    const matchBusqueda =
      !busqueda.value ||
      u.nombre.toLowerCase().includes(busqueda.value.toLowerCase()) ||
      u.email.toLowerCase().includes(busqueda.value.toLowerCase())
    const matchRol = !filtroRol.value || u.rol === filtroRol.value
    return matchBusqueda && matchRol
  })
})

const conteo = computed(() => admin.conteoUsuarios)

// Ahora está tipado con las claves exactas
const rolConfig: Record<Rol, { label: string; color: string; icon: string }> = {
  viajero: { label: 'Viajero', color: '#888780', icon: 'mdi:account-outline' },
  anfitrion: { label: 'Anfitrión', color: '#7cd3e3', icon: 'mdi:home-outline' },
  admin: { label: 'Admin', color: '#df243c', icon: 'mdi:shield-account' },
}

const abrirCambioRol = (usuario: any) => {
  confirmandoId.value = usuario.id
  nuevoRol.value = usuario.rol
}

const confirmarCambioRol = () => {
  if (confirmandoId.value !== null) {
    admin.cambiarRol(confirmandoId.value, nuevoRol.value)
    confirmandoId.value = null
  }
}

const cancelarCambio = () => {
  confirmandoId.value = null
}

const eliminarUsuario = (id: number) => {
  if (confirm('¿Estás seguro? Esta acción no se puede deshacer.')) {
    admin.eliminarUsuario(id)
  }
}

const iniciales = (nombre: string) =>
  nombre
    .split(' ')
    .map((n) => n[0])
    .join('')
    .toUpperCase()
    .slice(0, 2)
</script>

<template>
  <div class="admin-usuarios">
    <!-- HERO -->
    <section class="hero">
      <h1>Gestión de usuarios</h1>
      <p>Administrá roles y permisos de los usuarios de Adventure.</p>
      <button class="btn-volver" @click="router.push('/admin')">
        <Icon icon="mdi:arrow-left" width="16" /> Volver al panel
      </button>
    </section>

    <!-- Estado de carga / error -->
    <EstadoCarga
      v-if="admin.estado !== 'exito'"
      :estado="admin.estado"
      :mensaje="admin.mensajeError"
      recurso="usuario"
      @reintentar="admin.fetchUsuarios()"
    />

    <template v-else>
      <!-- STATS -->
      <div class="stats">
        <div class="stat">
          <Icon icon="mdi:account-group" width="22" />
          <div>
            <span class="num">{{ conteo.total }}</span>
            <span class="lbl">Total</span>
          </div>
        </div>
        <div class="stat celeste">
          <Icon icon="mdi:home-outline" width="22" />
          <div>
            <span class="num">{{ conteo.anfitrion }}</span>
            <span class="lbl">Anfitriones</span>
          </div>
        </div>
        <div class="stat gris">
          <Icon icon="mdi:account-outline" width="22" />
          <div>
            <span class="num">{{ conteo.viajero }}</span>
            <span class="lbl">Viajeros</span>
          </div>
        </div>
        <div class="stat rojo">
          <Icon icon="mdi:shield-account" width="22" />
          <div>
            <span class="num">{{ conteo.admin }}</span>
            <span class="lbl">Admins</span>
          </div>
        </div>
      </div>

      <!-- BARRA DE BÚSQUEDA Y FILTROS -->
      <div class="barra">
        <div class="buscador">
          <Icon icon="mdi:magnify" width="18" />
          <input v-model="busqueda" placeholder="Buscar por nombre o email..." />
        </div>

        <div class="filtros-rol">
          <button class="filtro-btn" :class="{ activo: filtroRol === '' }" @click="filtroRol = ''">
            Todos
          </button>
          <button
            v-for="(cfg, key) in rolConfig"
            :key="key"
            class="filtro-btn"
            :class="{ activo: filtroRol === key }"
            @click="filtroRol = filtroRol === key ? '' : key"
          >
            <Icon :icon="cfg.icon" width="14" />
            {{ cfg.label }}
          </button>
        </div>
      </div>

      <!-- TABLA -->
      <div class="contenido">
        <p v-if="filtrados.length === 0" class="empty">No se encontraron usuarios.</p>

        <div v-for="u in filtrados" :key="u.id" class="fila">
          <!-- AVATAR -->
          <div class="avatar" :style="{ background: rolConfig[u.rol].color + '33' }">
            <img v-if="u.avatar" :src="u.avatar" :alt="u.nombre" />
            <span v-else class="iniciales">{{ iniciales(u.nombre) }}</span>
          </div>

          <!-- INFO -->
          <div class="info">
            <span class="nombre">{{ u.nombre }}</span>
            <span class="email">{{ u.email }}</span>
          </div>

          <!-- ROL BADGE -->
          <span
            class="badge-rol"
            :style="{
              background: rolConfig[u.rol].color + '22',
              color: rolConfig[u.rol].color,
              borderColor: rolConfig[u.rol].color + '55',
            }"
          >
            <Icon :icon="rolConfig[u.rol].icon" width="13" />
            {{ rolConfig[u.rol].label }}
          </span>

          <!-- STATS USUARIO -->
          <div class="user-stats">
            <span title="Publicaciones">
              <Icon icon="mdi:home-outline" width="14" /> {{ u.publicaciones }}
            </span>
            <span title="Reservas">
              <Icon icon="mdi:calendar-check-outline" width="14" /> {{ u.reservas }}
            </span>
          </div>

          <span class="fecha">{{ u.created_at }}</span>

          <!-- ACCIONES -->
          <div class="acciones">
            <button class="btn-accion" @click="abrirCambioRol(u)" title="Cambiar rol">
              <Icon icon="mdi:account-edit-outline" width="15" /> Rol
            </button>
            <button
              class="btn-accion danger"
              @click="eliminarUsuario(u.id)"
              title="Eliminar usuario"
              :disabled="u.rol === 'admin'"
            >
              <Icon icon="mdi:trash-can-outline" width="15" />
            </button>
          </div>
        </div>
      </div>

      <!-- MODAL CAMBIO ROL -->
      <div v-if="confirmandoId !== null" class="modal-overlay" @click.self="cancelarCambio">
        <div class="modal">
          <h3>Cambiar rol</h3>
          <p>Seleccioná el nuevo rol para este usuario.</p>

          <div class="opciones-rol">
            <label
              v-for="(cfg, key) in rolConfig"
              :key="key"
              class="opcion-rol"
              :class="{ seleccionado: nuevoRol === key }"
              :style="
                nuevoRol === key ? { borderColor: cfg.color, background: cfg.color + '15' } : {}
              "
            >
              <input type="radio" :value="key" v-model="nuevoRol" style="display: none" />
              <Icon :icon="cfg.icon" width="20" :style="{ color: cfg.color }" />
              <span>{{ cfg.label }}</span>
            </label>
          </div>

          <div class="modal-acciones">
            <button class="btn-accion" @click="cancelarCambio">Cancelar</button>
            <button class="btn-accion confirmar" @click="confirmarCambioRol">Confirmar</button>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<style scoped>
.admin-usuarios {
  background: #111111;
  color: white;
  min-height: 100vh;
}

/* HERO */
.hero {
  padding: 3rem 1rem;
  text-align: center;
  background: #111111;
  border-bottom: 3px solid #df243c;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.75rem;
}

.hero p {
  opacity: 0.7;
}

.btn-volver {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  background: transparent;
  border: 1px solid rgba(255, 255, 255, 0.15);
  color: rgba(255, 255, 255, 0.7);
  padding: 0.4rem 1rem;
  border-radius: 8px;
  cursor: pointer;
  font-size: 0.85rem;
  transition: 0.2s;
}

.btn-volver:hover {
  border-color: #7cd3e3;
  color: #7cd3e3;
}

/* STATS */
.stats {
  display: flex;
  gap: 1rem;
  padding: 1.5rem 2rem;
  flex-wrap: wrap;
}

.stat {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 10px;
  padding: 1rem 1.5rem;
  flex: 1;
  min-width: 120px;
  border-left: 3px solid rgba(255, 255, 255, 0.15);
}

.stat div {
  display: flex;
  flex-direction: column;
}
.num {
  font-size: 1.5rem;
  font-weight: 700;
  line-height: 1;
}
.lbl {
  font-size: 0.78rem;
  opacity: 0.6;
  margin-top: 0.2rem;
}

.celeste {
  border-left-color: #7cd3e3;
}
.celeste .num {
  color: #7cd3e3;
}
.gris {
  border-left-color: #888780;
}
.gris .num {
  color: #888780;
}
.rojo {
  border-left-color: #df243c;
}
.rojo .num {
  color: #df243c;
}

/* BARRA */
.barra {
  display: flex;
  gap: 1rem;
  padding: 1rem 2rem;
  align-items: center;
  flex-wrap: wrap;
  border-bottom: 1px solid rgba(255, 255, 255, 0.07);
}

.buscador {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  background: #1a1a1a;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  padding: 0.5rem 0.9rem;
  flex: 1;
  min-width: 200px;
}

.buscador input {
  background: transparent;
  border: none;
  outline: none;
  color: white;
  width: 100%;
  font-size: 0.9rem;
}

.buscador:focus-within {
  border-color: #7cd3e3;
}

.filtros-rol {
  display: flex;
  gap: 0.4rem;
  flex-wrap: wrap;
}

.filtro-btn {
  display: flex;
  align-items: center;
  gap: 0.3rem;
  background: transparent;
  border: 1px solid rgba(255, 255, 255, 0.12);
  color: rgba(255, 255, 255, 0.7);
  padding: 0.35rem 0.9rem;
  border-radius: 20px;
  font-size: 0.82rem;
  cursor: pointer;
  transition: 0.2s;
}

.filtro-btn:hover,
.filtro-btn.activo {
  border-color: #7cd3e3;
  color: #7cd3e3;
}

/* CONTENIDO */
.contenido {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  padding: 1.5rem 2rem;
  max-width: 1000px;
  margin: 0 auto;
}

.empty {
  text-align: center;
  opacity: 0.5;
  margin-top: 3rem;
}

/* FILA */
.fila {
  display: flex;
  align-items: center;
  gap: 1rem;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.07);
  border-radius: 10px;
  padding: 0.75rem 1rem;
  transition: 0.2s;
}

.fila:hover {
  border-color: rgba(124, 211, 227, 0.15);
}

/* AVATAR */
.avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.iniciales {
  font-size: 0.8rem;
  font-weight: 700;
  letter-spacing: 0.05em;
}

/* INFO */
.info {
  display: flex;
  flex-direction: column;
  flex: 1;
  min-width: 0;
}

.nombre {
  font-size: 0.9rem;
  font-weight: 600;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.email {
  font-size: 0.78rem;
  opacity: 0.5;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* BADGE ROL */
.badge-rol {
  display: flex;
  align-items: center;
  gap: 0.3rem;
  padding: 0.25rem 0.7rem;
  border-radius: 20px;
  font-size: 0.75rem;
  font-weight: 600;
  border: 1px solid;
  white-space: nowrap;
  flex-shrink: 0;
}

/* USER STATS */
.user-stats {
  display: flex;
  gap: 0.75rem;
  font-size: 0.78rem;
  opacity: 0.5;
  flex-shrink: 0;
}

.user-stats span {
  display: flex;
  align-items: center;
  gap: 0.2rem;
}

.fecha {
  font-size: 0.75rem;
  opacity: 0.35;
  flex-shrink: 0;
  white-space: nowrap;
}

/* ACCIONES */
.acciones {
  display: flex;
  gap: 0.4rem;
  flex-shrink: 0;
}

.btn-accion {
  display: flex;
  align-items: center;
  gap: 0.3rem;
  background: transparent;
  border: 1px solid rgba(255, 255, 255, 0.12);
  color: rgba(255, 255, 255, 0.7);
  padding: 0.3rem 0.7rem;
  border-radius: 6px;
  font-size: 0.8rem;
  cursor: pointer;
  transition: 0.2s;
}

.btn-accion:hover {
  border-color: #7cd3e3;
  color: #7cd3e3;
}
.btn-accion.danger:hover {
  border-color: #df243c;
  color: #df243c;
}
.btn-accion.confirmar {
  border-color: rgba(29, 158, 117, 0.4);
  color: #1d9e75;
}
.btn-accion.confirmar:hover {
  background: rgba(29, 158, 117, 0.1);
}
.btn-accion:disabled {
  opacity: 0.2;
  cursor: not-allowed;
  pointer-events: none;
}

/* MODAL */
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 200;
  padding: 1rem;
}

.modal {
  background: #1a1a1a;
  border: 1px solid rgba(124, 211, 227, 0.2);
  border-radius: 14px;
  padding: 2rem;
  width: 100%;
  max-width: 400px;
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
}

.modal h3 {
  color: #7cd3e3;
  margin: 0;
}
.modal p {
  opacity: 0.7;
  font-size: 0.9rem;
  margin: 0;
}

.opciones-rol {
  display: flex;
  gap: 0.75rem;
}

.opcion-rol {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.4rem;
  padding: 0.9rem 0.5rem;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 10px;
  cursor: pointer;
  transition: 0.2s;
  font-size: 0.82rem;
  text-align: center;
}

.opcion-rol:hover {
  border-color: rgba(255, 255, 255, 0.25);
}

.modal-acciones {
  display: flex;
  justify-content: flex-end;
  gap: 0.75rem;
}

/* RESPONSIVE */
@media (max-width: 768px) {
  .user-stats,
  .fecha {
    display: none;
  }

  .fila {
    flex-wrap: wrap;
  }

  .barra {
    flex-direction: column;
    align-items: stretch;
  }

  .stats {
    padding: 1rem;
  }
  .contenido {
    padding: 1rem;
  }

  .opciones-rol {
    flex-direction: column;
  }
}
</style>
