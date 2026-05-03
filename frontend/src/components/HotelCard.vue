<script setup lang="ts">
import { useRouter } from 'vue-router'
import { Icon } from '@iconify/vue'

const router = useRouter()

const props = defineProps<{
  id: number
  nombre: string
  ubicacion: string
  precio: number
  rating: number
  imagen: string
  tipo: 'hotel' | 'hostel' | 'departamento' | 'resort'
  destacado?: boolean
  esFavorito?: boolean
}>()

const emit = defineEmits<{
  (e: 'verDetalle', id: number): void
  (e: 'toggleFavorito'): void
}>()

const irDetalle = () => {
  router.push(`/hotel/${props.id}`)
}
</script>

<template>
  <div class="card" :class="{ destacado }">
    <!-- IMAGEN -->
    <div class="img-container" @click="irDetalle">
      <img :src="imagen" />

      <span v-if="destacado" class="badge top">🔥 Top</span>
      <span class="badge tipo">{{ tipo }}</span>

      <div class="rating">⭐ {{ rating }}</div>

      <!-- BOTÓN FAVORITO -->
      <button
        class="btn-favorito"
        :class="{ activo: esFavorito }"
        @click.stop="emit('toggleFavorito')"
        :title="esFavorito ? 'Quitar de favoritos' : 'Agregar a favoritos'"
      >
        <Icon :icon="esFavorito ? 'mdi:heart' : 'mdi:heart-outline'" width="18" />
      </button>
    </div>

    <!-- INFO -->
    <div class="info">
      <h3>{{ nombre }}</h3>
      <p class="ubicacion">{{ ubicacion }}</p>

      <div class="bottom">
        <span class="precio">${{ precio }} USD / noche</span>
        <button class="btn-ver" @click.stop="irDetalle">Ver más</button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.card {
  background: rgba(255, 255, 255, 0.04);
  border-radius: 14px;
  overflow: hidden;
  position: relative;
  transition: 0.3s;
  backdrop-filter: blur(8px);
}

.card:hover {
  transform: translateY(-6px) scale(1.02);
}

.destacado {
  border: 1px solid #7cd3e3;
  box-shadow: 0 0 12px rgba(124, 211, 227, 0.3);
}

.img-container {
  position: relative;
  cursor: pointer;
}

.img-container img {
  width: 100%;
  height: 170px;
  object-fit: cover;
}

.badge {
  position: absolute;
  padding: 0.3rem 0.6rem;
  border-radius: 6px;
  font-size: 0.7rem;
}

.top {
  top: 10px;
  left: 10px;
  background: #df243c;
}

.tipo {
  top: 10px;
  right: 10px;
  background: rgba(0, 0, 0, 0.6);
  text-transform: capitalize;
}

.rating {
  position: absolute;
  bottom: 10px;
  right: 10px;
  background: black;
  padding: 0.3rem 0.5rem;
  border-radius: 6px;
  font-size: 0.8rem;
}

/* FAVORITO */
.btn-favorito {
  position: absolute;
  bottom: 10px;
  left: 10px;
  background: rgba(0, 0, 0, 0.6);
  border: none;
  border-radius: 50%;
  width: 30px;
  height: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  color: rgba(255, 255, 255, 0.7);
  transition: 0.2s;
}

.btn-favorito:hover {
  background: rgba(0, 0, 0, 0.85);
  color: #df243c;
}

.btn-favorito.activo {
  color: #df243c;
}

.info {
  padding: 1rem;
}

.ubicacion {
  opacity: 0.7;
  font-size: 0.9rem;
}

.bottom {
  margin-top: 0.8rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.precio {
  color: #7cd3e3;
  font-weight: bold;
}

.btn-ver {
  background: rgba(124, 211, 227, 0.15);
  border: 1px solid rgba(124, 211, 227, 0.4);
  color: white;
  padding: 0.3rem 0.7rem;
  border-radius: 6px;
  cursor: pointer;
  transition: 0.3s;
}

.btn-ver:hover {
  background: rgba(124, 211, 227, 0.3);
  box-shadow: 0 0 8px rgba(124, 211, 227, 0.6);
}
</style>
