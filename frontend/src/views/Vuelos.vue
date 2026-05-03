<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { Icon } from '@iconify/vue'
import VueloCard from '@/components/VueloCard.vue'
import EstadoCarga from '@/components/EstadoCarga.vue'
import { useVuelosStore } from '@/stores/useVuelosStore'
import { useFavoritosStore } from '@/stores/useFavoritosStore'

const vuelosStore = useVuelosStore()
const favs = useFavoritosStore()

// BUSCADOR
const origen = ref('')
const destino = ref('')
const fechaIda = ref('')
const fechaVuelta = ref('')
const pasajeros = ref(1)

// FILTROS LOCALES
const precioMax = ref(1500)
const soloDirectos = ref(false)

// BUSCAR
const buscar = () => {
  vuelosStore.buscarVuelos({
    origen: origen.value,
    destino: destino.value,
    fechaIda: fechaIda.value,
    fechaVuelta: fechaVuelta.value,
    pasajeros: pasajeros.value,
    precioMax: precioMax.value,
    soloDirectos: soloDirectos.value,
  })
}

// SELECCIONAR VUELO
const seleccionarVuelo = (id: number) => {
  console.log('Vuelo seleccionado:', id)
}

// TOGGLE FAVORITO
const toggleFavorito = (vuelo: any) => {
  favs.toggle({
    tipo: 'vuelo',
    referencia_id: vuelo.id,
    nombre: `${vuelo.aerolinea} — ${vuelo.origen} → ${vuelo.destino}`,
    precio: vuelo.precio,
  })
}

onMounted(() => {
  favs.fetchFavoritos()
})
</script>

<template>
  <div class="vuelos">
    <!-- HERO -->
    <section class="hero">
      <h1>Buscá tu vuelo ideal</h1>

      <div class="buscador">
        <div class="campo">
          <Icon icon="mdi:airplane-takeoff" />
          <input v-model="origen" placeholder="Origen" />
        </div>
        <div class="campo">
          <Icon icon="mdi:airplane-landing" />
          <input v-model="destino" placeholder="Destino" />
        </div>
        <div class="campo">
          <label>Ida</label>
          <input type="date" v-model="fechaIda" />
        </div>
        <div class="campo">
          <label>Vuelta</label>
          <input type="date" v-model="fechaVuelta" />
        </div>
        <div class="campo">
          <Icon icon="mdi:account-outline" />
          <input type="number" v-model="pasajeros" min="1" />
        </div>
      </div>

      <button class="btn-buscar" @click="buscar" :disabled="vuelosStore.estado === 'cargando'">
        <span v-if="vuelosStore.estado === 'cargando'" class="spinner" />
        <span v-else>Buscar</span>
      </button>
    </section>

    <!-- CONTENIDO -->
    <div class="contenido">
      <!-- FILTROS -->
      <aside class="filtros">
        <h3>Filtros</h3>
        <div class="filtro">
          <label>Precio máx: ${{ precioMax }}</label>
          <input type="range" min="00" max="2000000" v-model="precioMax" />
        </div>
        <div class="filtro">
          <label>
            <input type="checkbox" v-model="soloDirectos" />
            Solo vuelos directos
          </label>
        </div>

        <div
          v-if="vuelosStore.busquedaRealizada && vuelosStore.estado === 'exito'"
          class="info-busqueda"
        >
          <p>Vuelos directos: {{ vuelosStore.vuelosDirectos.length }}</p>
          <p>Precio promedio: ${{ vuelosStore.precioPromedio }}</p>
        </div>
      </aside>

      <!-- RESULTADOS -->
      <section class="resultados">
        <!-- Estado inicial sin búsqueda -->
        <div
          v-if="!vuelosStore.busquedaRealizada && vuelosStore.estado === 'idle'"
          class="estado-inicial"
        >
          <Icon icon="mdi:airplane-search" width="64" />
          <h2>Buscar vuelos</h2>
          <p>Completá los datos y hacé clic en buscar ✈️</p>
        </div>

        <!-- Estado de carga / error -->
        <EstadoCarga
          v-else-if="vuelosStore.estado !== 'exito'"
          :estado="vuelosStore.estado"
          :mensaje="vuelosStore.mensajeError"
          recurso="vuelo"
          @reintentar="buscar"
        />

        <!-- Resultados -->
        <template v-else>
          <h2>
            Vuelos disponibles
            <span class="count">{{ vuelosStore.vuelosFiltrados.length }}</span>
          </h2>

          <div class="lista">
            <VueloCard
              v-for="v in vuelosStore.vuelosFiltrados"
              :key="v.id"
              v-bind="v"
              :esFavorito="favs.esFavorito('vuelo', v.id)"
              @seleccionar="seleccionarVuelo"
              @toggleFavorito="toggleFavorito(v)"
            />
          </div>

          <p v-if="vuelosStore.vuelosFiltrados.length === 0" class="empty">
            No se encontraron vuelos 😢
          </p>
        </template>
      </section>
    </div>
  </div>
</template>

<style scoped>
.vuelos {
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
  flex-wrap: wrap;
  gap: 1rem;
  justify-content: center;
  margin-top: 1.5rem;
}

.campo {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  background: #1a1a1a;
  border: 1px solid rgba(124, 211, 227, 0.2);
  color: white;
  padding: 0.7rem 1rem;
  border-radius: 8px;
}

.campo input {
  border: none;
  outline: none;
  background: transparent;
  color: white;
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
}

.filtros h3 {
  color: #7cd3e3;
  margin-bottom: 1rem;
}

.filtro {
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
  margin-bottom: 1rem;
}

.filtro input[type='range'] {
  accent-color: #7cd3e3;
}

.filtro label {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  cursor: pointer;
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

.lista {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.empty {
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

@media (max-width: 900px) {
  .contenido {
    flex-direction: column;
  }
  .filtros {
    width: 100%;
  }
}
</style>
