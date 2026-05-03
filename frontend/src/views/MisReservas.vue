<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Icon } from '@iconify/vue'
import { useReservasStore } from '@/stores/useReservasStore'
import EstadoCarga from '@/components/EstadoCarga.vue'

const router = useRouter()
const reservasStore = useReservasStore()

type EstadoReserva = 'pendiente' | 'confirmada' | 'cancelada'

// FILTRO LOCAL
const filtroEstado = ref<EstadoReserva | ''>('')

// Cargar reservas al montar
onMounted(() => {
  reservasStore.fetchReservas()
})

// Reservas filtradas según el estado seleccionado
const reservasFiltradas = computed(() => {
  if (!filtroEstado.value) return reservasStore.reservas
  return reservasStore.reservas.filter((r) => r.estado === filtroEstado.value)
})

// Configuración visual de estados
const estadoConfig: Record<EstadoReserva, { label: string; color: string; icon: string }> = {
  confirmada: { label: 'Confirmada', color: '#1d9e75', icon: 'mdi:check-circle' },
  pendiente: { label: 'Pendiente', color: '#ef9f27', icon: 'mdi:clock-outline' },
  cancelada: { label: 'Cancelada', color: '#df243c', icon: 'mdi:close-circle' },
}

// Calcular noches entre fechas
const noches = (entrada?: string, salida?: string): number | null => {
  if (!entrada || !salida) return null
  const diff = new Date(salida).getTime() - new Date(entrada).getTime()
  return Math.round(diff / (1000 * 60 * 60 * 24))
}

// Cancelar una reserva
const cancelar = (id: number) => {
  reservasStore.cancelar(id)
}

// Navegar al detalle del hotel
const verHotel = (id: number) => {
  router.push(`/hotel/${id}`)
}
</script>

<template>
  <div class="mis-reservas">
    <!-- HERO -->
    <section class="hero">
      <h1>Mis reservas</h1>
      <p>Revisá el estado de tus próximos viajes.</p>
    </section>

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
        @click="filtroEstado = filtroEstado === key ? '' : (key as EstadoReserva)"
      >
        <Icon :icon="cfg.icon" width="14" />
        {{ cfg.label }}
      </button>
    </div>

    <!-- Estado de carga / error -->
    <EstadoCarga
      v-if="reservasStore.estado !== 'exito'"
      :estado="reservasStore.estado"
      :mensaje="reservasStore.mensajeError"
      recurso="reserva"
      @reintentar="reservasStore.fetchReservas()"
    />

    <!-- Lista de reservas -->
    <div v-else class="contenido">
      <p v-if="reservasFiltradas.length === 0" class="empty">No tenés reservas en este estado.</p>

      <div v-for="r in reservasFiltradas" :key="r.id" class="card">
        <!-- HEADER CARD -->
        <div class="card-header">
          <span class="reserva-id">#{{ r.id.toString().padStart(4, '0') }}</span>
          <span
            class="badge-estado"
            :style="{
              background: estadoConfig[r.estado].color + '22',
              color: estadoConfig[r.estado].color,
              borderColor: estadoConfig[r.estado].color + '44',
            }"
          >
            <Icon :icon="estadoConfig[r.estado].icon" width="13" />
            {{ estadoConfig[r.estado].label }}
          </span>
          <span class="fecha-reserva">Reservado el {{ r.created_at }}</span>
        </div>

        <div class="card-body">
          <!-- HOTEL -->
          <div v-if="r.hotel" class="bloque hotel-bloque" @click="verHotel(r.hotel.id)">
            <img :src="r.hotel.imagen" :alt="r.hotel.nombre" />
            <div class="bloque-info">
              <div class="bloque-titulo">
                <Icon icon="fontisto:hotel" width="14" />
                <span>Alojamiento</span>
              </div>
              <h3>{{ r.hotel.nombre }}</h3>
              <p class="meta">
                <Icon icon="mdi:map-marker-outline" width="13" />
                {{ r.hotel.ubicacion }}
              </p>
              <div v-if="r.fecha_entrada" class="fechas">
                <span>
                  <Icon icon="mdi:calendar-arrow-right" width="14" />
                  {{ r.fecha_entrada }}
                </span>
                <span class="sep">→</span>
                <span>
                  <Icon icon="mdi:calendar-arrow-left" width="14" />
                  {{ r.fecha_salida }}
                </span>
                <span class="noches">{{ noches(r.fecha_entrada, r.fecha_salida) }} noches</span>
              </div>
            </div>
          </div>

          <!-- VUELO -->
          <div v-if="r.vuelo" class="bloque vuelo-bloque">
            <div class="bloque-info">
              <div class="bloque-titulo">
                <Icon icon="simple-line-icons:plane" width="14" />
                <span>Vuelo</span>
              </div>
              <h3>{{ r.vuelo.aerolinea }}</h3>
              <div class="ruta">
                <span class="iata">{{ r.vuelo.origen }}</span>
                <div class="linea-vuelo">
                  <span />
                  <Icon icon="simple-line-icons:plane" width="14" />
                  <span />
                </div>
                <span class="iata">{{ r.vuelo.destino }}</span>
              </div>
              <p class="meta">{{ r.vuelo.hora_salida }} → {{ r.vuelo.hora_llegada }}</p>
            </div>
          </div>
        </div>

        <!-- ACCIONES -->
        <div class="card-footer">
          <button v-if="r.estado !== 'cancelada'" class="btn-cancelar" @click="cancelar(r.id)">
            <Icon icon="mdi:close" width="15" /> Cancelar reserva
          </button>
          <span v-else class="cancelada-txt">Esta reserva fue cancelada.</span>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.mis-reservas {
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
  gap: 1.25rem;
  padding: 2rem;
  max-width: 860px;
  margin: 0 auto;
}

.empty {
  text-align: center;
  opacity: 0.5;
  margin-top: 3rem;
}

/* CARD */
.card {
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 14px;
  overflow: hidden;
  transition: 0.2s;
}

.card:hover {
  border-color: rgba(124, 211, 227, 0.2);
}

/* HEADER CARD */
.card-header {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.75rem 1.25rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.06);
  background: rgba(255, 255, 255, 0.02);
}

.reserva-id {
  font-size: 0.78rem;
  font-family: monospace;
  opacity: 0.45;
}

.badge-estado {
  display: flex;
  align-items: center;
  gap: 0.3rem;
  padding: 0.2rem 0.6rem;
  border-radius: 20px;
  font-size: 0.75rem;
  font-weight: 600;
  border: 1px solid;
}

.fecha-reserva {
  font-size: 0.75rem;
  opacity: 0.35;
  margin-left: auto;
}

/* BODY */
.card-body {
  display: flex;
  flex-direction: column;
  gap: 0;
}

/* BLOQUE */
.bloque {
  display: flex;
  gap: 1rem;
  padding: 1.25rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.05);
}

.hotel-bloque {
  cursor: pointer;
  transition: 0.2s;
}

.hotel-bloque:hover {
  background: rgba(255, 255, 255, 0.02);
}

.bloque img {
  width: 100px;
  height: 80px;
  object-fit: cover;
  border-radius: 8px;
  flex-shrink: 0;
}

.bloque-info {
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
}

.bloque-titulo {
  display: flex;
  align-items: center;
  gap: 0.35rem;
  font-size: 0.75rem;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  color: #7cd3e3;
  opacity: 0.8;
}

.bloque-info h3 {
  margin: 0;
  font-size: 1rem;
}

.meta {
  display: flex;
  align-items: center;
  gap: 0.3rem;
  font-size: 0.82rem;
  opacity: 0.55;
}

/* FECHAS */
.fechas {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.82rem;
  opacity: 0.75;
  flex-wrap: wrap;
}

.sep {
  opacity: 0.4;
}

.noches {
  background: rgba(124, 211, 227, 0.1);
  color: #7cd3e3;
  padding: 0.1rem 0.5rem;
  border-radius: 10px;
  font-size: 0.75rem;
}

/* RUTA VUELO */
.ruta {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin: 0.25rem 0;
}

.iata {
  font-size: 1.2rem;
  font-weight: 700;
  letter-spacing: 0.05em;
}

.linea-vuelo {
  display: flex;
  align-items: center;
  gap: 0.3rem;
  color: #7cd3e3;
  flex: 1;
}

.linea-vuelo span {
  flex: 1;
  height: 1px;
  background: rgba(124, 211, 227, 0.3);
}

/* FOOTER CARD */
.card-footer {
  padding: 0.75rem 1.25rem;
  display: flex;
  justify-content: flex-end;
}

.btn-cancelar {
  display: flex;
  align-items: center;
  gap: 0.3rem;
  background: transparent;
  border: 1px solid rgba(223, 36, 60, 0.3);
  color: #df243c;
  padding: 0.4rem 1rem;
  border-radius: 6px;
  font-size: 0.82rem;
  cursor: pointer;
  transition: 0.2s;
}

.btn-cancelar:hover {
  background: rgba(223, 36, 60, 0.1);
}

.cancelada-txt {
  font-size: 0.8rem;
  opacity: 0.4;
}

/* RESPONSIVE */
@media (max-width: 640px) {
  .contenido {
    padding: 1rem;
  }
  .barra-filtros {
    padding: 0.75rem 1rem;
  }
  .bloque img {
    width: 70px;
    height: 60px;
  }
  .fecha-reserva {
    display: none;
  }
}
</style>
