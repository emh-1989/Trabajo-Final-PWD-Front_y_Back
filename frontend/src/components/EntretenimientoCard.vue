<script setup lang="ts">
import { Icon } from '@iconify/vue'

defineProps<{
  id: number
  titulo: string
  ubicacion: string
  fecha: string
  tipo: string
  imagen: string
  descripcion: string
  esFavorito?: boolean
}>()

const emit = defineEmits<{
  (e: 'verDetalle', id: number): void
  (e: 'toggleFavorito'): void
}>()

const tipoLabel = (tipo: string) => {
  const map: Record<string, string> = {
    concierto: '🎵 Concierto',
    teatro: '🎭 Teatro',
    deporte: '⚽ Deporte',
    festival: '🎪 Festival',
  }
  return map[tipo] || tipo
}
</script>

<template>
  <div class="card" @click="emit('verDetalle', id)">
    <div class="img">
      <img :src="imagen" :alt="titulo" />
      <div class="overlay"></div>

      <!-- BADGE TIPO -->
      <div class="badge">{{ tipoLabel(tipo) }}</div>

      <!-- BOTÓN FAVORITO -->
      <button
        class="btn-favorito"
        :class="{ activo: esFavorito }"
        @click.stop="emit('toggleFavorito')"
        :title="esFavorito ? 'Quitar de favoritos' : 'Agregar a favoritos'"
      >
        <Icon :icon="esFavorito ? 'mdi:heart' : 'mdi:heart-outline'" width="16" />
      </button>

      <!-- HOVER CONTENT -->
      <div class="hover-content">
        <h3>{{ titulo }}</h3>
        <p class="meta"><Icon icon="mdi:map-marker" /> {{ ubicacion }}</p>
        <p class="meta"><Icon icon="mdi:calendar" /> {{ fecha }}</p>
        <p class="desc">{{ descripcion }}</p>
        <button class="btn">Ver detalle</button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.card {
  border-radius: 14px;
  overflow: hidden;
  cursor: pointer;
  position: relative;
  transition: 0.3s;
}

.img {
  position: relative;
  height: 240px;
}

.img img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: 0.4s;
}

.overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(to top, rgba(0, 0, 0, 0.85), rgba(0, 0, 0, 0.2), transparent);
  opacity: 0.7;
  transition: 0.3s;
}

.badge {
  position: absolute;
  top: 10px;
  left: 10px;
  background: rgba(223, 36, 60, 0.9);
  color: white;
  padding: 0.3rem 0.6rem;
  border-radius: 8px;
  font-size: 0.75rem;
  font-weight: 600;
  z-index: 2;
}

/* FAVORITO */
.btn-favorito {
  position: absolute;
  top: 10px;
  right: 10px;
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
  z-index: 2;
}

.btn-favorito:hover {
  background: rgba(0, 0, 0, 0.85);
  color: #df243c;
}
.btn-favorito.activo {
  color: #df243c;
}

.hover-content {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 1rem;
  color: white;
  transform: translateY(40%);
  opacity: 0;
  transition: 0.35s ease;
}

h3 {
  margin: 0;
  font-size: 1.1rem;
}

.meta {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  font-size: 0.8rem;
  opacity: 0.9;
}

.desc {
  font-size: 0.8rem;
  opacity: 0.75;
  margin-top: 0.3rem;
}

.btn {
  margin-top: 0.7rem;
  padding: 0.5rem;
  width: 100%;
  border: none;
  border-radius: 8px;
  background: #df243c;
  cursor: pointer;
  font-weight: 600;
  color: white;
  transition: 0.2s;
}

.btn:hover {
  background: #b81d30;
}

.card:hover .hover-content {
  transform: translateY(0%);
  opacity: 1;
}
.card:hover img {
  transform: scale(1.08);
}
.card:hover .overlay {
  opacity: 1;
}
</style>
