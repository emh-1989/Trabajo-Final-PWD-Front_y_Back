<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { Icon } from '@iconify/vue'
import { useRouter } from 'vue-router'
import { useAdminStore } from '@/stores/useAdminStore'
import EstadoCarga from '@/components/EstadoCarga.vue'

const router = useRouter()
const admin = useAdminStore()

type Estado = 'pendiente' | 'publicado' | 'rechazado' | 'borrador'

const filtroEstado = ref<Estado | ''>('pendiente')

onMounted(() => {
  admin.fetchPublicaciones()
})

const filtradas = computed(() => {
  if (!filtroEstado.value) return admin.publicaciones
  return admin.publicaciones.filter((p) => p.estado === filtroEstado.value)
})

const conteo = computed(() => admin.conteoPublicaciones)

const aprobar = (id: number) => admin.aprobar(id)
const rechazar = (id: number, motivo: string) => admin.rechazar(id, motivo)

const rechazandoId = ref<number | null>(null)
const motivoRechazo = ref('')

const abrirRechazo = (id: number) => {
  rechazandoId.value = id
  motivoRechazo.value = ''
}
const confirmarRechazo = () => {
  if (!motivoRechazo.value.trim()) return
  rechazar(rechazandoId.value!, motivoRechazo.value)
  rechazandoId.value = null
  motivoRechazo.value = ''
}
const cancelarRechazo = () => {
  rechazandoId.value = null
  motivoRechazo.value = ''
}

const estadoConfig: Record<Estado, { label: string; color: string; icon: string }> = {
  pendiente: { label: 'Pendiente', color: '#ef9f27', icon: 'mdi:clock-outline' },
  publicado: { label: 'Publicado', color: '#1d9e75', icon: 'mdi:check-circle' },
  rechazado: { label: 'Rechazado', color: '#df243c', icon: 'mdi:close-circle' },
  borrador: { label: 'Borrador', color: '#888780', icon: 'mdi:file-outline' },
}
</script>

<template>
  <div class="admin-panel">
    <!-- HERO -->
    <section class="hero">
      <h1>Panel de administración</h1>
      <p>Revisá y moderá las publicaciones enviadas por los anfitriones.</p>
    </section>

    <!-- Estado de carga / error -->
    <EstadoCarga
      v-if="admin.estado !== 'exito'"
      :estado="admin.estado"
      :mensaje="admin.mensajeError"
      recurso="publicación"
      @reintentar="admin.fetchPublicaciones()"
    />

    <template v-else>
      <!-- STATS -->
      <div class="stats">
        <div class="stat amarillo">
          <Icon icon="mdi:clock-outline" width="24" />
          <div>
            <span class="num">{{ conteo.pendiente }}</span>
            <span class="lbl">Pendientes</span>
          </div>
        </div>
        <div class="stat verde">
          <Icon icon="mdi:check-circle" width="24" />
          <div>
            <span class="num">{{ conteo.publicado }}</span>
            <span class="lbl">Publicadas</span>
          </div>
        </div>
        <div class="stat rojo">
          <Icon icon="mdi:close-circle" width="24" />
          <div>
            <span class="num">{{ conteo.rechazado }}</span>
            <span class="lbl">Rechazadas</span>
          </div>
        </div>
        <div class="stat celeste" @click="router.push('/admin/usuarios')" style="cursor: pointer">
          <Icon icon="mdi:account-group" width="24" />
          <div>
            <span class="num">→</span>
            <span class="lbl">Usuarios</span>
          </div>
        </div>
      </div>

      <!-- FILTROS -->
      <div class="barra-filtros">
        <button
          class="filtro-btn"
          :class="{ activo: filtroEstado === '' }"
          @click="filtroEstado = ''"
        >
          Todos
        </button>
        <button
          v-for="(cfg, key) in estadoConfig"
          :key="key"
          class="filtro-btn"
          :class="{ activo: filtroEstado === key }"
          @click="filtroEstado = filtroEstado === key ? '' : key"
        >
          <Icon :icon="cfg.icon" width="14" /> {{ cfg.label }}
        </button>
      </div>

      <!-- LISTA -->
      <div class="contenido">
        <p v-if="filtradas.length === 0" class="empty">No hay publicaciones en este estado.</p>
        <div v-for="pub in filtradas" :key="pub.id" class="card">
          <!-- IMAGEN -->
          <div class="card-img">
            <img :src="pub.imagen" :alt="pub.nombre" />
            <span class="badge-estado" :style="{ background: estadoConfig[pub.estado].color }">
              <Icon :icon="estadoConfig[pub.estado].icon" width="13" />
              {{ estadoConfig[pub.estado].label }}
            </span>
          </div>
          <!-- INFO -->
          <div class="card-info">
            <div class="card-header">
              <div>
                <h3>{{ pub.nombre }}</h3>
                <p class="meta">
                  <Icon icon="mdi:map-marker-outline" width="14" />
                  {{ pub.ubicacion }}
                  <span class="sep">·</span>
                  <span class="tipo">{{ pub.tipo }}</span>
                </p>
              </div>
              <span class="precio">${{ pub.precio_noche }} USD/noche</span>
            </div>
            <div class="anfitrion">
              <Icon icon="mdi:account-outline" width="14" />
              <span>{{ pub.propietario }}</span>
              <a :href="`mailto:${pub.propietario_email}`" class="email">{{
                pub.propietario_email
              }}</a>
            </div>
            <p class="fecha">Enviado el {{ pub.created_at }}</p>
            <div class="card-acciones">
              <button class="btn-accion" @click="router.push(`/hotel/${pub.id}`)">
                <Icon icon="mdi:eye-outline" width="16" /> Ver
              </button>
              <template v-if="pub.estado === 'pendiente'">
                <button class="btn-accion aprobar" @click="aprobar(pub.id)">
                  <Icon icon="mdi:check" width="16" /> Aprobar
                </button>
                <button class="btn-accion rechazar" @click="abrirRechazo(pub.id)">
                  <Icon icon="mdi:close" width="16" /> Rechazar
                </button>
              </template>
              <template v-else-if="pub.estado === 'publicado'">
                <button class="btn-accion rechazar" @click="abrirRechazo(pub.id)">
                  <Icon icon="mdi:close" width="16" /> Dar de baja
                </button>
              </template>
              <template v-else-if="pub.estado === 'rechazado'">
                <button class="btn-accion aprobar" @click="aprobar(pub.id)">
                  <Icon icon="mdi:check" width="16" /> Reactivar
                </button>
              </template>
            </div>
          </div>
        </div>
      </div>

      <!-- MODAL RECHAZO -->
      <div v-if="rechazandoId !== null" class="modal-overlay" @click.self="cancelarRechazo">
        <div class="modal">
          <h3>Motivo de rechazo</h3>
          <p>
            Explicá brevemente por qué se rechaza la publicación. El anfitrión recibirá esta nota.
          </p>
          <textarea
            v-model="motivoRechazo"
            rows="4"
            placeholder="Ej: Las imágenes no cumplen los requisitos..."
          />
          <div class="modal-acciones">
            <button class="btn-accion" @click="cancelarRechazo">Cancelar</button>
            <button
              class="btn-accion rechazar"
              :disabled="!motivoRechazo.trim()"
              @click="confirmarRechazo"
            >
              Confirmar rechazo
            </button>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<style scoped>
.admin-panel {
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
}

.hero p {
  opacity: 0.7;
  margin-top: 0.5rem;
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
  min-width: 140px;
  transition: 0.2s;
}

.stat:hover {
  border-color: rgba(255, 255, 255, 0.15);
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

.amarillo {
  border-left: 3px solid #ef9f27;
}
.amarillo .num {
  color: #ef9f27;
}

.verde {
  border-left: 3px solid #1d9e75;
}
.verde .num {
  color: #1d9e75;
}

.rojo {
  border-left: 3px solid #df243c;
}
.rojo .num {
  color: #df243c;
}

.celeste {
  border-left: 3px solid #7cd3e3;
}
.celeste .num {
  color: #7cd3e3;
}

/* FILTROS */
.barra-filtros {
  display: flex;
  gap: 0.5rem;
  padding: 1rem 2rem;
  flex-wrap: wrap;
  border-bottom: 1px solid rgba(255, 255, 255, 0.07);
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
  gap: 1rem;
  padding: 2rem;
  max-width: 960px;
  margin: 0 auto;
}

.empty {
  text-align: center;
  opacity: 0.5;
  margin-top: 3rem;
}

/* CARD */
.card {
  display: flex;
  gap: 1.5rem;
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 12px;
  overflow: hidden;
  transition: 0.2s;
}

.card:hover {
  border-color: rgba(124, 211, 227, 0.2);
}

.card-img {
  position: relative;
  width: 180px;
  flex-shrink: 0;
}

.card-img img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.badge-estado {
  position: absolute;
  top: 8px;
  left: 8px;
  display: flex;
  align-items: center;
  gap: 0.3rem;
  padding: 0.25rem 0.6rem;
  border-radius: 6px;
  font-size: 0.72rem;
  font-weight: 600;
  color: white;
}

.card-info {
  flex: 1;
  padding: 1rem 1rem 1rem 0;
  display: flex;
  flex-direction: column;
  gap: 0.6rem;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 1rem;
}

.card-header h3 {
  margin: 0 0 0.2rem;
}

.meta {
  font-size: 0.85rem;
  opacity: 0.6;
  display: flex;
  align-items: center;
  gap: 0.3rem;
}

.sep {
  opacity: 0.4;
}

.tipo {
  text-transform: capitalize;
  background: rgba(255, 255, 255, 0.07);
  padding: 0.1rem 0.4rem;
  border-radius: 4px;
}

.precio {
  color: #7cd3e3;
  font-weight: 700;
  white-space: nowrap;
  font-size: 0.95rem;
}

/* ANFITRION */
.anfitrion {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  font-size: 0.83rem;
  opacity: 0.75;
}

.email {
  color: #7cd3e3;
  text-decoration: none;
  font-size: 0.8rem;
}

.email:hover {
  text-decoration: underline;
}

.fecha {
  font-size: 0.78rem;
  opacity: 0.4;
}

/* ACCIONES */
.card-acciones {
  display: flex;
  gap: 0.5rem;
  margin-top: auto;
  flex-wrap: wrap;
}

.btn-accion {
  display: flex;
  align-items: center;
  gap: 0.3rem;
  background: transparent;
  border: 1px solid rgba(255, 255, 255, 0.12);
  color: rgba(255, 255, 255, 0.75);
  padding: 0.35rem 0.8rem;
  border-radius: 6px;
  font-size: 0.82rem;
  cursor: pointer;
  transition: 0.2s;
}

.btn-accion:hover {
  border-color: #7cd3e3;
  color: #7cd3e3;
}
.btn-accion.aprobar {
  border-color: rgba(29, 158, 117, 0.4);
  color: #1d9e75;
}
.btn-accion.aprobar:hover {
  background: rgba(29, 158, 117, 0.1);
}
.btn-accion.rechazar {
  border-color: rgba(223, 36, 60, 0.4);
  color: #df243c;
}
.btn-accion.rechazar:hover {
  background: rgba(223, 36, 60, 0.1);
}
.btn-accion:disabled {
  opacity: 0.4;
  cursor: not-allowed;
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
  border: 1px solid rgba(223, 36, 60, 0.3);
  border-radius: 14px;
  padding: 2rem;
  width: 100%;
  max-width: 480px;
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.modal h3 {
  color: #df243c;
  margin: 0;
}
.modal p {
  opacity: 0.7;
  font-size: 0.9rem;
  margin: 0;
}

.modal textarea {
  background: #111;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  color: white;
  padding: 0.7rem;
  font-size: 0.9rem;
  outline: none;
  resize: vertical;
  width: 100%;
  box-sizing: border-box;
}

.modal textarea:focus {
  border-color: #df243c;
}

.modal-acciones {
  display: flex;
  justify-content: flex-end;
  gap: 0.75rem;
}

/* RESPONSIVE */
@media (max-width: 640px) {
  .card {
    flex-direction: column;
  }
  .card-img {
    width: 100%;
    height: 180px;
  }
  .card-info {
    padding: 1rem;
  }
  .card-header {
    flex-direction: column;
  }
  .stats {
    padding: 1rem;
  }
  .contenido {
    padding: 1rem;
  }
}
</style>
