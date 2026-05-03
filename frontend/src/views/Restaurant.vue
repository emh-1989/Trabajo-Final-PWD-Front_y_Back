<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { Icon } from '@iconify/vue'
import RestaurantCard from '@/components/RestaurantCard.vue'
import EstadoCarga from '@/components/EstadoCarga.vue'
import { useRestaurantesStore } from '@/stores/useRestaurantesStore'
import { useFavoritosStore } from '@/stores/useFavoritosStore'

const restaurantesStore = useRestaurantesStore()
const favs = useFavoritosStore()

// BUSCADOR
const destino = ref('')

// FILTROS
const precioMax = ref(100)
const ratingMin = ref(0)
const tipoSeleccionado = ref('')

// BUSCAR
const buscar = () => {
  restaurantesStore.buscarRestaurantes({
    destino: destino.value,
    tipo: tipoSeleccionado.value,
    precioMax: precioMax.value,
    ratingMin: ratingMin.value,
  })
}

// TOGGLE FAVORITO
const toggleFavorito = (rest: any) => {
  favs.toggle({
    tipo: 'restaurante',
    referencia_id: rest.id,
    nombre: rest.nombre,
    ubicacion: rest.ubicacion,
    imagen: rest.imagen,
    precio: rest.precio,
    rating: rest.rating,
  })
}

onMounted(() => {
  favs.fetchFavoritos()
})
</script>

<template>
  <div class="restaurant">
    <!-- HERO -->
    <section class="hero">
      <h1>Descubrí dónde comer</h1>
      <div class="buscador">
        <div class="campo">
          <Icon icon="mdi:map-marker-outline" />
          <input v-model="destino" placeholder="Buscar ciudad o zona" />
        </div>
      </div>
      <button
        class="btn-buscar"
        @click="buscar"
        :disabled="restaurantesStore.estado === 'cargando'"
      >
        <span v-if="restaurantesStore.estado === 'cargando'" class="spinner" />
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
          <input type="range" min="10" max="1500000" v-model="precioMax" />
        </div>

        <div class="filtro">
          <label>Rating mínimo</label>
          <select v-model="ratingMin">
            <option :value="0">Todos</option>
            <option :value="3">3+</option>
            <option :value="4">4+</option>
            <option :value="4.5">4.5+</option>
          </select>
        </div>

        <div class="filtro">
          <label>Tipo</label>
          <select v-model="tipoSeleccionado">
            <option value="">Todos</option>
            <option value="parrilla">Parrilla</option>
            <option value="japonesa">Japonesa</option>
            <option value="tradicional">Tradicional</option>
            <option value="italiana">Italiana</option>
            <option value="mariscos">Mariscos</option>
          </select>
        </div>
      </aside>

      <!-- RESULTADOS -->
      <section class="resultados">
        <!-- Estado de carga / error -->
        <EstadoCarga
          v-if="restaurantesStore.estado !== 'exito' && restaurantesStore.estado !== 'idle'"
          :estado="restaurantesStore.estado"
          :mensaje="restaurantesStore.mensajeError"
          recurso="restaurante"
          @reintentar="buscar"
        />

        <!-- Contenido cuando hay datos -->
        <template v-else>
          <h2>
            Restaurantes
            <span class="count">{{ restaurantesStore.restaurantesFiltrados.length }}</span>
          </h2>

          <div class="grid">
            <RestaurantCard
              v-for="(r, i) in restaurantesStore.restaurantesFiltrados"
              :key="r.id"
              v-bind="r"
              :destacado="i === 0"
              :esFavorito="favs.esFavorito('restaurante', r.id)"
              @toggleFavorito="toggleFavorito(r)"
            />
          </div>

          <p v-if="restaurantesStore.restaurantesFiltrados.length === 0" class="empty">
            No se encontraron restaurantes 😢
          </p>
        </template>
      </section>
    </div>
  </div>
</template>

<style scoped>
.restaurant {
  background: #111111;
  color: white;
  min-height: 100vh;
}

.hero {
  padding: 3rem 1rem;
  text-align: center;
  background: #111111;
  border-bottom: 3px solid #df243c;
}

.buscador {
  display: flex;
  justify-content: center;
  margin-top: 1.5rem;
}

.campo {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  background: #1a1a1a;
  border: 1px solid rgba(223, 36, 60, 0.25);
  color: white;
  padding: 0.7rem 1rem;
  border-radius: 8px;
  width: 300px;
}

.campo input {
  border: none;
  outline: none;
  background: transparent;
  color: white;
}

.contenido {
  display: flex;
  gap: 2rem;
  padding: 2rem;
}

.filtros {
  width: 250px;
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(223, 36, 60, 0.2);
  padding: 1rem;
  border-radius: 12px;
}

.filtros h3 {
  color: #df243c;
  margin-bottom: 1rem;
}

.filtro {
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
  margin-bottom: 1rem;
}

.filtro select,
.filtro input[type='range'] {
  background: #1a1a1a;
  border: 1px solid rgba(255, 255, 255, 0.1);
  color: white;
  border-radius: 6px;
  padding: 0.3rem 0.5rem;
}

.filtro input[type='range'] {
  accent-color: #df243c;
}

.resultados {
  flex: 1;
}

.resultados h2 {
  color: #df243c;
  margin-bottom: 1rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.count {
  background: rgba(223, 36, 60, 0.1);
  color: #df243c;
  font-size: 0.8rem;
  padding: 0.1rem 0.5rem;
  border-radius: 10px;
  font-weight: normal;
}

.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 320px));
  gap: 1.5rem;
  justify-content: center;
}

.empty {
  margin-top: 2rem;
  opacity: 0.7;
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
