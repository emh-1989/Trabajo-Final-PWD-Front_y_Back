<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Icon } from '@iconify/vue'
import { useFavoritosStore } from '@/stores/useFavoritosStore'
import EstadoCarga from '@/components/EstadoCarga.vue'

const router = useRouter()
const favs = useFavoritosStore()

type TipoFavorito = 'hotel' | 'vuelo' | 'restaurante' | 'entretenimiento' | 'destino'

const filtroTipo = ref<TipoFavorito | ''>('')

onMounted(() => {
  favs.fetchFavoritos()
})

const favoritosFiltrados = computed(() => {
  if (!filtroTipo.value) return favs.favoritos
  return favs.favoritos.filter((f) => f.tipo === filtroTipo.value)
})

const tipoConfig: Record<TipoFavorito, { label: string; icon: string; color: string }> = {
  hotel: { label: 'Hoteles', icon: 'fontisto:hotel', color: '#7cd3e3' },
  vuelo: { label: 'Vuelos', icon: 'simple-line-icons:plane', color: '#7cd3e3' },
  restaurante: { label: 'Restaurantes', icon: 'fluent:food-16-regular', color: '#df243c' },
  entretenimiento: {
    label: 'Entretenimiento',
    icon: 'streamline-ultimate:show-theater-mask-happy',
    color: '#df243c',
  },
  destino: { label: 'Destinos', icon: 'mdi:map-marker-outline', color: '#7cd3e3' },
}

const irA = (f: (typeof favs.favoritos)[0]) => {
  const rutas: Record<TipoFavorito, string> = {
    hotel: `/hotel/${f.referencia_id}`,
    vuelo: '/vuelos',
    restaurante: '/restaurant',
    entretenimiento: '/entretenimiento',
    destino: '/hospedaje',
  }
  router.push(rutas[f.tipo])
}

// FIX: buscar el favorito una sola vez para evitar que el optimistic update
// del store mute el array entre el primer y segundo .find()
const eliminar = (id: number) => {
  const f = favs.favoritos.find((f) => f.id === id)
  if (f) favs.quitar(f.tipo, f.referencia_id)
}
</script>

<template>
  <div class="favoritos">
    <section class="hero">
      <h1>Mis favoritos</h1>
      <p>Todo lo que guardaste en un solo lugar.</p>
    </section>

    <div class="barra-filtros">
      <button class="filtro-btn" :class="{ activo: filtroTipo === '' }" @click="filtroTipo = ''">
        Todos
        <span class="count">{{ favs.favoritos.length }}</span>
      </button>
      <button
        v-for="(cfg, key) in tipoConfig"
        :key="key"
        class="filtro-btn"
        :class="{ activo: filtroTipo === key }"
        @click="filtroTipo = filtroTipo === key ? '' : (key as TipoFavorito)"
      >
        <Icon :icon="cfg.icon" width="14" />
        {{ cfg.label }}
        <span class="count">{{ favs.porTipo(key).length }}</span>
      </button>
    </div>

    <EstadoCarga
      v-if="favs.estado !== 'exito' && favs.estado !== 'idle'"
      :estado="favs.estado"
      :mensaje="favs.mensajeError"
      recurso="favorito"
      @reintentar="favs.fetchFavoritos()"
    />

    <div v-else class="contenido">
      <p v-if="favoritosFiltrados.length === 0" class="empty">
        No tenés favoritos en esta categoría.
      </p>

      <div class="grid">
        <div v-for="f in favoritosFiltrados" :key="f.id" class="card" @click="irA(f)">
          <div class="card-img">
            <img v-if="f.imagen" :src="f.imagen" :alt="f.nombre" />
            <div v-else class="card-img-placeholder">
              <Icon
                :icon="tipoConfig[f.tipo].icon"
                width="32"
                :style="{ color: tipoConfig[f.tipo].color }"
              />
            </div>

            <span
              class="badge-tipo"
              :style="{
                background: tipoConfig[f.tipo].color + '22',
                color: tipoConfig[f.tipo].color,
                borderColor: tipoConfig[f.tipo].color + '44',
              }"
            >
              <Icon :icon="tipoConfig[f.tipo].icon" width="12" />
              {{ tipoConfig[f.tipo].label }}
            </span>

            <button class="btn-quitar" @click.stop="eliminar(f.id)" title="Quitar de favoritos">
              <Icon icon="mdi:heart" width="16" />
            </button>
          </div>

          <div class="card-info">
            <h3>{{ f.nombre }}</h3>
            <p v-if="f.ubicacion" class="ubicacion">
              <Icon icon="mdi:map-marker-outline" width="13" />
              {{ f.ubicacion }}
            </p>
            <div class="card-footer">
              <span v-if="f.precio" class="precio">
                {{ typeof f.precio === 'number' ? `$${f.precio} USD` : f.precio }}
              </span>
              <span v-if="f.rating" class="rating"> ⭐ {{ f.rating }} </span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.favoritos {
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

.barra-filtros {
  display: flex;
  gap: 0.5rem;
  padding: 1rem 2rem;
  flex-wrap: wrap;
  border-bottom: 1px solid rgba(255, 255, 255, 0.07);
  overflow-x: auto;
}

.filtro-btn {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  background: transparent;
  border: 1px solid rgba(255, 255, 255, 0.12);
  color: rgba(255, 255, 255, 0.7);
  padding: 0.35rem 0.9rem;
  border-radius: 20px;
  font-size: 0.82rem;
  cursor: pointer;
  transition: 0.2s;
  white-space: nowrap;
  flex-shrink: 0;
}
.filtro-btn:hover,
.filtro-btn.activo {
  border-color: #7cd3e3;
  color: #7cd3e3;
}

.count {
  background: rgba(255, 255, 255, 0.1);
  padding: 0.05rem 0.4rem;
  border-radius: 10px;
  font-size: 0.72rem;
}

.contenido {
  padding: 2rem;
  max-width: 1100px;
  margin: 0 auto;
}
.empty {
  text-align: center;
  opacity: 0.5;
  margin-top: 4rem;
}

.grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
  gap: 1.25rem;
}

.card {
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 12px;
  overflow: hidden;
  cursor: pointer;
  transition: 0.25s;
}
.card:hover {
  transform: translateY(-4px);
  border-color: rgba(124, 211, 227, 0.25);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
}

.card-img {
  position: relative;
  height: 160px;
  overflow: hidden;
}
.card-img img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: 0.4s;
}
.card:hover .card-img img {
  transform: scale(1.05);
}
.card-img-placeholder {
  width: 100%;
  height: 100%;
  background: #1a1a1a;
  display: flex;
  align-items: center;
  justify-content: center;
}

.badge-tipo {
  position: absolute;
  top: 8px;
  left: 8px;
  display: flex;
  align-items: center;
  gap: 0.25rem;
  padding: 0.2rem 0.55rem;
  border-radius: 20px;
  font-size: 0.7rem;
  font-weight: 600;
  border: 1px solid;
}

.btn-quitar {
  position: absolute;
  top: 8px;
  right: 8px;
  background: rgba(0, 0, 0, 0.6);
  border: none;
  border-radius: 50%;
  color: #df243c;
  width: 28px;
  height: 28px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: 0.2s;
}
.btn-quitar:hover {
  background: #df243c;
  color: white;
}

.card-info {
  padding: 0.9rem;
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
}
.card-info h3 {
  margin: 0;
  font-size: 0.95rem;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.ubicacion {
  display: flex;
  align-items: center;
  gap: 0.3rem;
  font-size: 0.8rem;
  opacity: 0.6;
}
.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 0.2rem;
}
.precio {
  color: #7cd3e3;
  font-weight: 700;
  font-size: 0.88rem;
}
.rating {
  font-size: 0.8rem;
  opacity: 0.75;
}

@media (max-width: 640px) {
  .contenido {
    padding: 1rem;
  }
  .barra-filtros {
    padding: 0.75rem 1rem;
  }
  .grid {
    grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
  }
}
</style>
