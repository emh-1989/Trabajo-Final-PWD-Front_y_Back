<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { Icon } from '@iconify/vue'
import { useRouter } from 'vue-router'
import { usePublicacionesStore } from '@/stores/usePublicacionesStore'
import EstadoCarga from '@/components/EstadoCarga.vue'

const router = useRouter()
const publicacionesStore = usePublicacionesStore()

type EstadoPublicacion = 'pendiente' | 'publicado' | 'rechazado' | 'borrador'

const filtroEstado = ref<EstadoPublicacion | ''>('')

onMounted(() => {
  publicacionesStore.fetchPublicaciones()
})

const filtradas = computed(() => {
  if (!filtroEstado.value) return publicacionesStore.publicaciones
  return publicacionesStore.publicaciones.filter((p) => p.estado === filtroEstado.value)
})

// Tipado correcto para eliminar el error
const estadoConfig: Record<EstadoPublicacion, { label: string; color: string; icon: string }> = {
  pendiente: { label: 'Pendiente', color: '#ef9f27', icon: 'mdi:clock-outline' },
  publicado: { label: 'Publicado', color: '#1d9e75', icon: 'mdi:check-circle' },
  rechazado: { label: 'Rechazado', color: '#df243c', icon: 'mdi:close-circle' },
  borrador: { label: 'Borrador', color: '#888780', icon: 'mdi:file-outline' },
}

const verDetalle = (id: number) => router.push(`/hotel/${id}`)
const editar = (id: number) => router.push(`/publicar/${id}`)
const eliminar = (id: number) => publicacionesStore.eliminar(id)

const motivoAbierto = ref<number | null>(null)
const toggleMotivo = (id: number) => {
  motivoAbierto.value = motivoAbierto.value === id ? null : id
}
</script>

<template>
  <div class="mis-publicaciones">
    <!-- HERO -->
    <section class="hero">
      <h1>Mis publicaciones</h1>
      <p>Gestioná tus propiedades publicadas en Adventure.</p>
      <button class="btn-nueva" @click="router.push('/publicar')">
        <Icon icon="mdi:plus" width="18" /> Nueva publicación
      </button>
    </section>

    <!-- Estado de carga / error -->
    <EstadoCarga
      v-if="publicacionesStore.estado !== 'exito'"
      :estado="publicacionesStore.estado"
      :mensaje="publicacionesStore.mensajeError"
      recurso="publicación"
      @reintentar="publicacionesStore.fetchPublicaciones()"
    />

    <template v-else>
      <!-- FILTROS -->
      <div class="barra-filtros">
        <button
          v-for="(cfg, key) in estadoConfig"
          :key="key"
          class="filtro-btn"
          :class="{ activo: filtroEstado === key }"
          @click="filtroEstado = filtroEstado === key ? '' : key"
        >
          <Icon :icon="cfg.icon" width="14" />
          {{ cfg.label }}
        </button>
        <button
          class="filtro-btn"
          :class="{ activo: filtroEstado === '' }"
          @click="filtroEstado = ''"
        >
          Todos
        </button>
      </div>

      <!-- LISTA -->
      <div class="contenido">
        <p v-if="filtradas.length === 0" class="empty">No tenés publicaciones en este estado.</p>

        <div v-for="pub in filtradas" :key="pub.id" class="card">
          <!-- IMAGEN -->
          <div class="card-img">
            <img :src="pub.imagenes?.[0] || '/imagenes/placeholder.jpg'" :alt="pub.nombre" />
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

            <!-- MOTIVO RECHAZO -->
            <div v-if="pub.estado === 'rechazado'" class="rechazo">
              <button class="btn-motivo" @click="toggleMotivo(pub.id)">
                <Icon icon="mdi:information-outline" width="15" />
                Ver motivo de rechazo
                <Icon
                  :icon="motivoAbierto === pub.id ? 'mdi:chevron-up' : 'mdi:chevron-down'"
                  width="14"
                />
              </button>
              <p v-if="motivoAbierto === pub.id" class="motivo-texto">
                {{ pub.motivo_rechazo }}
              </p>
            </div>

            <p class="fecha">Publicado el {{ pub.created_at }}</p>

            <!-- ACCIONES -->
            <div class="card-acciones">
              <button class="btn-accion" @click="verDetalle(pub.id)" title="Ver publicación">
                <Icon icon="mdi:eye-outline" width="16" /> Ver
              </button>
              <button class="btn-accion" @click="editar(pub.id)" title="Editar">
                <Icon icon="mdi:pencil-outline" width="16" /> Editar
              </button>
              <button class="btn-accion danger" @click="eliminar(pub.id)" title="Eliminar">
                <Icon icon="mdi:trash-can-outline" width="16" /> Eliminar
              </button>
            </div>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<style scoped>
.mis-publicaciones {
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
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.75rem;
}

.hero p {
  opacity: 0.7;
}

.btn-nueva {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  background: #df243c;
  border: none;
  color: white;
  padding: 0.6rem 1.4rem;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
  transition: 0.2s;
  margin-top: 0.5rem;
}

.btn-nueva:hover {
  background: #b81d30;
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
  max-width: 900px;
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

/* IMAGEN */
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

/* INFO */
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

.fecha {
  font-size: 0.78rem;
  opacity: 0.4;
}

/* RECHAZO */
.rechazo {
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
}

.btn-motivo {
  display: flex;
  align-items: center;
  gap: 0.3rem;
  background: transparent;
  border: none;
  color: #df243c;
  font-size: 0.82rem;
  cursor: pointer;
  padding: 0;
  transition: 0.2s;
}

.btn-motivo:hover {
  opacity: 0.8;
}

.motivo-texto {
  background: rgba(223, 36, 60, 0.08);
  border: 1px solid rgba(223, 36, 60, 0.2);
  border-radius: 6px;
  padding: 0.6rem 0.9rem;
  font-size: 0.83rem;
  opacity: 0.85;
  line-height: 1.5;
}

/* ACCIONES */
.card-acciones {
  display: flex;
  gap: 0.5rem;
  margin-top: auto;
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

.btn-accion.danger:hover {
  border-color: #df243c;
  color: #df243c;
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

  .barra-filtros {
    padding: 1rem;
  }
}
</style>
