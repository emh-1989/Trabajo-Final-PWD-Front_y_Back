<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { Icon } from '@iconify/vue'
import EntretenimientoCard from '@/components/EntretenimientoCard.vue'
import EstadoCarga from '@/components/EstadoCarga.vue'
import { useEntretenimientoStore } from '@/stores/useEntretenimientoStore'
import { useFavoritosStore } from '@/stores/useFavoritosStore'

const entretenimientoStore = useEntretenimientoStore()
const favs = useFavoritosStore()

// BUSCADOR LOCAL
const destino = ref('')
const tipoEvento = ref<'' | 'concierto' | 'teatro' | 'deporte' | 'festival'>('')
const fecha = ref('')

// BUSCAR
const buscar = () => {
  entretenimientoStore.buscarEventos({
    destino: destino.value,
    tipo: tipoEvento.value,
    fecha: fecha.value,
  })
}

// TOGGLE FAVORITO
const toggleFavorito = (evento: any) => {
  favs.toggle({
    tipo: 'entretenimiento',
    referencia_id: evento.id,
    nombre: evento.titulo,
    ubicacion: evento.ubicacion,
    imagen: evento.imagen,
  })
}

onMounted(() => {
  favs.fetchFavoritos()
  // Opcional: cargar eventos automáticamente al montar
  // entretenimientoStore.buscarEventos({})
})
</script>

<template>
  <div class="entretenimiento">
    <!-- HERO -->
    <section class="hero">
      <h1>Cartelera de eventos</h1>
      <p>Descubrí todo lo que pasa en tu destino</p>

      <!-- Buscador simple (opcional, podés dejarlo o quitarlo) -->
      <div class="buscador-local" v-if="false">
        <div class="campo">
          <Icon icon="mdi:map-marker-outline" />
          <input v-model="destino" placeholder="Destino" />
        </div>
        <div class="campo">
          <select v-model="tipoEvento">
            <option value="">Todos</option>
            <option value="concierto">Conciertos</option>
            <option value="teatro">Teatro</option>
            <option value="deporte">Deportes</option>
            <option value="festival">Festivales</option>
          </select>
        </div>
        <div class="campo">
          <input type="date" v-model="fecha" />
        </div>
        <button
          class="btn-buscar"
          @click="buscar"
          :disabled="entretenimientoStore.estado === 'cargando'"
        >
          <span v-if="entretenimientoStore.estado === 'cargando'" class="spinner" />
          <span v-else>Buscar</span>
        </button>
      </div>
    </section>

    <!-- CONTENIDO -->
    <div class="contenido">
      <!-- SIDEBAR -->
      <aside class="filtros">
        <h3>Filtros</h3>

        <div class="filtro">
          <label>Destino</label>
          <input v-model="destino" placeholder="Ej: Buenos Aires" />
        </div>

        <div class="filtro">
          <label>Tipo</label>
          <select v-model="tipoEvento">
            <option value="">Todos</option>
            <option value="concierto">Conciertos</option>
            <option value="teatro">Teatro</option>
            <option value="deporte">Deportes</option>
            <option value="festival">Festivales</option>
          </select>
        </div>

        <div class="filtro">
          <label>Fecha</label>
          <input type="date" v-model="fecha" />
        </div>

        <button
          class="btn-aplicar"
          @click="buscar"
          :disabled="entretenimientoStore.estado === 'cargando'"
        >
          <span v-if="entretenimientoStore.estado === 'cargando'" class="spinner" />
          <span v-else>Aplicar filtros</span>
        </button>
      </aside>

      <!-- RESULTADOS -->
      <section class="resultados">
        <!-- Estado de carga / error -->
        <EstadoCarga
          v-if="entretenimientoStore.estado !== 'exito' && entretenimientoStore.estado !== 'idle'"
          :estado="entretenimientoStore.estado"
          :mensaje="entretenimientoStore.mensajeError"
          recurso="evento"
          @reintentar="buscar"
        />

        <!-- Contenido cuando hay datos -->
        <template v-else>
          <h2>
            Eventos disponibles
            <span class="count">{{ entretenimientoStore.eventosFiltrados.length }}</span>
          </h2>

          <div class="grid">
            <EntretenimientoCard
              v-for="e in entretenimientoStore.eventosFiltrados"
              :key="e.id"
              v-bind="e"
              :esFavorito="favs.esFavorito('entretenimiento', e.id)"
              @toggleFavorito="toggleFavorito(e)"
            />
          </div>

          <p v-if="entretenimientoStore.eventosFiltrados.length === 0" class="empty">
            No hay eventos disponibles 😢
          </p>
        </template>
      </section>
    </div>
  </div>
</template>

<style scoped>
.entretenimiento {
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

.hero p {
  opacity: 0.7;
  margin-top: 0.5rem;
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

.filtro input,
.filtro select {
  padding: 0.5rem;
  border-radius: 6px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  background: #1a1a1a;
  color: white;
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
  text-align: center;
  margin-top: 2rem;
  opacity: 0.7;
}

@media (max-width: 768px) {
  .contenido {
    flex-direction: column;
  }
  .filtros {
    width: 100%;
  }
}
</style>
