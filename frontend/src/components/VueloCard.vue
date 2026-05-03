<!-- components/VueloCard.vue -->
<script setup lang="ts">
import { Icon } from '@iconify/vue'

const props = defineProps<{
  id: number
  aerolinea: string
  logo?: string // ahora opcional
  origen: string
  destino: string
  horaSalida: string
  horaLlegada: string
  duracion: string
  precio: number
  escalas?: number
  esFavorito?: boolean
}>()

const emit = defineEmits<{
  (e: 'seleccionar', id: number): void
  (e: 'toggleFavorito'): void
}>()

const seleccionar = () => emit('seleccionar', props.id)
</script>

<template>
  <div class="vuelo-card">
    <!-- AEROLÍNEA -->
    <div class="aerolinea">
      <!-- Si hay logo, lo mostramos; si no, icono de avión genérico -->
      <img v-if="logo" :src="logo" alt="logo" class="logo" />
      <Icon v-else icon="simple-line-icons:plane" width="32" class="logo-placeholder" />
      <span>{{ aerolinea }}</span>
    </div>

    <!-- HORARIOS (sin cambios) -->
    <div class="horarios">
      <div class="bloque">
        <strong>{{ horaSalida }}</strong>
        <p>{{ origen }}</p>
      </div>
      <div class="centro">
        <span class="duracion">{{ duracion }}</span>
        <div class="linea"></div>
        <small>{{ escalas === 0 ? 'Directo' : (escalas || 0) + ' escala' }}</small>
      </div>
      <div class="bloque">
        <strong>{{ horaLlegada }}</strong>
        <p>{{ destino }}</p>
      </div>
    </div>

    <!-- PRECIO + ACCIONES -->
    <div class="precio">
      <span>${{ precio }}</span>
      <div class="acciones">
        <button
          class="btn-favorito"
          :class="{ activo: esFavorito }"
          @click.stop="emit('toggleFavorito')"
          :title="esFavorito ? 'Quitar de favoritos' : 'Agregar a favoritos'"
        >
          <Icon :icon="esFavorito ? 'mdi:heart' : 'mdi:heart-outline'" width="18" />
        </button>
        <button class="btn" @click.stop="seleccionar">Seleccionar</button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.vuelo-card {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 1rem;
  background: rgba(255, 255, 255, 0.05);
  padding: 1.2rem;
  border-radius: 12px;
  transition: 0.3s;
}

.vuelo-card:hover {
  transform: scale(1.01);
  box-shadow: 0 0 10px rgba(124, 211, 227, 0.2);
}

/* AEROLÍNEA */
.aerolinea {
  width: 180px;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 0.6rem;
}

.logo {
  width: 32px;
  height: 32px;
  object-fit: contain;
  background: white;
  border-radius: 6px;
  padding: 2px;
}

/* HORARIOS */
.horarios {
  display: flex;
  align-items: center;
  gap: 2rem;
  flex: 1;
  justify-content: center;
}

.bloque {
  text-align: center;
}
.bloque p {
  font-size: 0.85rem;
  opacity: 0.7;
}

.centro {
  text-align: center;
  min-width: 120px;
}
.duracion {
  font-size: 0.85rem;
  opacity: 0.8;
}

.linea {
  height: 2px;
  width: 80px;
  background: rgba(124, 211, 227, 0.4);
  margin: 4px auto;
}

/* PRECIO */
.precio {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 0.5rem;
}

.precio span {
  font-size: 1.4rem;
  font-weight: bold;
  color: #7cd3e3;
}

.acciones {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

/* FAVORITO */
.btn-favorito {
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.12);
  border-radius: 8px;
  color: rgba(255, 255, 255, 0.6);
  width: 34px;
  height: 34px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: 0.2s;
}

.btn-favorito:hover {
  border-color: #df243c;
  color: #df243c;
}
.btn-favorito.activo {
  color: #df243c;
  border-color: rgba(223, 36, 60, 0.4);
}

/* BOTÓN SELECCIONAR */
.btn {
  padding: 0.4rem 1rem;
  border: none;
  border-radius: 8px;
  background: #7cd3e3;
  color: black;
  font-weight: 600;
  cursor: pointer;
  transition: 0.3s;
  height: 34px;
}

.btn:hover {
  background: #5fc2d4;
  box-shadow: 0 0 8px rgba(124, 211, 227, 0.6);
}

/* RESPONSIVE */
@media (max-width: 900px) {
  .vuelo-card {
    flex-direction: column;
    align-items: flex-start;
  }
  .horarios {
    width: 100%;
    justify-content: space-between;
  }
  .precio {
    width: 100%;
    align-items: flex-start;
  }
  .aerolinea {
    width: 200px;
  }
}
</style>
