<!-- views/NotFound.vue -->
<script setup lang="ts">
import { useRouter } from 'vue-router'
import { Icon } from '@iconify/vue'

const router = useRouter()
</script>

<template>
  <div class="not-found">
    <Icon icon="mdi:map-marker-off" width="64" />
    <h1>404</h1>
    <h2>Página no encontrada</h2>
    <p>La página que buscas no existe o fue movida.</p>
    <button @click="router.push('/')">Volver al inicio</button>
  </div>
</template>

<style scoped>
.not-found {
  background: #111111;
  color: white;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  text-align: center;
  padding: 2rem;
}

.not-found h1 {
  font-size: 6rem;
  color: #df243c;
  margin: 0;
  line-height: 1;
}

.not-found h2 {
  color: #7cd3e3;
  margin: 0;
}

.not-found p {
  opacity: 0.7;
}

.not-found button {
  margin-top: 1rem;
  padding: 0.7rem 2rem;
  border: none;
  border-radius: 8px;
  background: #df243c;
  color: white;
  font-weight: 600;
  cursor: pointer;
  transition: 0.2s;
}

.not-found button:hover {
  background: #b81d30;
}

.not-found svg {
  color: #7cd3e3;
}
</style>
