<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { Icon } from '@iconify/vue'
import { useRouter } from 'vue-router'
import HotelCard from '@/components/HotelCard.vue'
import EstadoCarga from '@/components/EstadoCarga.vue'
import { useHotelesStore } from '@/stores/useHotelesStore'
import { useFavoritosStore } from '@/stores/useFavoritosStore'

const router = useRouter()
const hotelesStore = useHotelesStore()
const favs = useFavoritosStore()

// BUSCADOR
const destino = ref('')
const pasajeros = ref(2)
const checkin = ref('')
const checkout = ref('')

// FILTROS — se pasan al store para que hotelesFiltrados los aplique
const precioMax = ref(150)
const ratingMin = ref(0)
const tipoSeleccionado = ref<'' | 'hotel' | 'hostel' | 'departamento' | 'resort'>('')

// FIX: ya no hay computed local duplicando la lógica del store.
// Usamos hotelesFiltrados del store directamente y actualizamos
// los filtros del store cuando el usuario los cambia.
const aplicarFiltros = () => {
  hotelesStore.filtros = {
    ...hotelesStore.filtros,
    precioMax: precioMax.value,
    ratingMin: ratingMin.value || undefined,
    tipo: tipoSeleccionado.value || undefined,
  }
}

const buscar = () => {
  hotelesStore.buscarHoteles({
    destino: destino.value,
    checkin: checkin.value,
    checkout: checkout.value,
    pasajeros: pasajeros.value,
    precioMax: precioMax.value,
    ratingMin: ratingMin.value || undefined,
    tipo: tipoSeleccionado.value || undefined,
  })
}

const irADetalle = (id: number) => router.push(`/hotel/${id}`)

const toggleFavorito = (hotel: (typeof hotelesStore.hoteles)[0]) => {
  favs.toggle({
    tipo: 'hotel',
    referencia_id: hotel.id,
    nombre: hotel.nombre,
    ubicacion: hotel.ubicacion,
    imagen: hotel.imagen,
    precio: hotel.precio,
    rating: hotel.rating,
  })
}

onMounted(() => {
  favs.fetchFavoritos()
})
</script>

<template>
  <div class="hospedaje">
    <section class="hero">
      <h1>Encontrá tu próximo alojamiento</h1>

      <div class="buscador">
        <div class="campo">
          <Icon icon="mdi:map-marker-outline" />
          <input v-model="destino" placeholder="Destino" />
        </div>
        <div class="campo">
          <Icon icon="mdi:account-outline" />
          <input type="number" v-model="pasajeros" min="1" />
        </div>
        <div class="campo fechas">
          <div>
            <label>Check in</label>
            <input type="date" v-model="checkin" />
          </div>
          <div>
            <label>Check out</label>
            <input type="date" v-model="checkout" />
          </div>
        </div>
      </div>

      <button class="btn-buscar" @click="buscar" :disabled="hotelesStore.estado === 'cargando'">
        <span v-if="hotelesStore.estado === 'cargando'" class="spinner" />
        <span v-else>Buscar</span>
      </button>
    </section>

    <div class="contenido">
      <!-- SIDEBAR DE FILTROS -->
      <aside class="filtros">
        <h3>Filtros</h3>

        <div class="filtro">
          <label>Precio máx: ${{ precioMax }}</label>
          <input type="range" min="50" max="300" v-model="precioMax" @input="aplicarFiltros" />
        </div>

        <div class="filtro">
          <label>Rating mínimo</label>
          <select v-model="ratingMin" @change="aplicarFiltros">
            <option :value="0">Todos</option>
            <option :value="3">3+</option>
            <option :value="4">4+</option>
            <option :value="4.5">4.5+</option>
          </select>
        </div>

        <div class="filtro">
          <label>Tipo</label>
          <select v-model="tipoSeleccionado" @change="aplicarFiltros">
            <option value="">Todos</option>
            <option value="hotel">Hotel</option>
            <option value="hostel">Hostel</option>
            <option value="departamento">Departamento</option>
            <option value="resort">Resort</option>
          </select>
        </div>
      </aside>

      <!-- RESULTADOS — usa hotelesFiltrados del store (una sola fuente de verdad) -->
      <section class="resultados">
        <EstadoCarga
          v-if="hotelesStore.estado !== 'exito' && hotelesStore.estado !== 'idle'"
          :estado="hotelesStore.estado"
          :mensaje="hotelesStore.mensajeError"
          recurso="hotel"
          @reintentar="buscar"
        />

        <template v-else>
          <h2>
            Resultados
            <span class="count">{{ hotelesStore.hotelesFiltrados.length }}</span>
          </h2>

          <div class="grid">
            <HotelCard
              v-for="(h, i) in hotelesStore.hotelesFiltrados"
              :key="h.id"
              v-bind="h"
              :destacado="i === 0"
              :esFavorito="favs.esFavorito('hotel', h.id)"
              @verDetalle="irADetalle(h.id)"
              @toggleFavorito="toggleFavorito(h)"
            />
          </div>

          <p v-if="hotelesStore.hotelesFiltrados.length === 0" class="empty">
            No se encontraron alojamientos 😢
          </p>
        </template>
      </section>
    </div>
  </div>
</template>

<style scoped>
.hospedaje {
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

.buscador {
  display: flex;
  background: #1a1a1a;
  border: 1px solid rgba(124, 211, 227, 0.2);
  border-radius: 10px;
  overflow: hidden;
  width: min(900px, 95%);
  margin: auto;
  color: white;
}

.campo {
  flex: 1;
  padding: 1rem;
  display: flex;
  gap: 0.5rem;
  align-items: center;
  border-right: 1px solid rgba(255, 255, 255, 0.08);
}
.campo input {
  border: none;
  background: transparent;
  outline: none;
  width: 100%;
  color: white;
}
.fechas {
  display: flex;
  gap: 1rem;
}

.btn-buscar {
  margin-top: 1rem;
  padding: 0.7rem 2rem;
  border: none;
  border-radius: 8px;
  background: #df243c;
  color: white;
  font-weight: 600;
  cursor: pointer;
  transition: 0.2s;
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
}
.btn-buscar:hover:not(:disabled) {
  background: #b81d30;
}
.btn-buscar:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.contenido {
  display: flex;
  gap: 2rem;
  padding: 2rem;
}

.filtros {
  width: 250px;
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(124, 211, 227, 0.15);
  padding: 1rem;
  border-radius: 12px;
  align-self: flex-start;
  position: sticky;
  top: 100px;
}
.filtros h3 {
  color: #7cd3e3;
  margin-bottom: 1rem;
}
.filtro {
  margin-bottom: 1rem;
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
}
.filtro select,
.filtro input[type='range'] {
  background: #1a1a1a;
  border: 1px solid rgba(255, 255, 255, 0.1);
  color: white;
  border-radius: 6px;
  padding: 0.3rem 0.5rem;
}

.resultados {
  flex: 1;
}
.resultados h2 {
  color: #7cd3e3;
  margin-bottom: 1rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.count {
  background: rgba(124, 211, 227, 0.1);
  color: #7cd3e3;
  font-size: 0.8rem;
  padding: 0.1rem 0.5rem;
  border-radius: 10px;
  font-weight: normal;
}

.grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(260px, 320px));
  gap: 1.5rem;
  justify-content: center;
}

.empty {
  text-align: center;
  margin-top: 2rem;
  opacity: 0.7;
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
@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

@media (max-width: 768px) {
  .contenido {
    flex-direction: column;
  }
  .filtros {
    width: 100%;
    position: static;
  }
  .buscador {
    flex-direction: column;
  }
  .fechas {
    flex-direction: column;
  }
}
</style>
