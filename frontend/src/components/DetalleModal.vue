<script setup lang="ts">
import { Icon } from '@iconify/vue'

defineProps<{
  visible: boolean
  titulo: string
  imagen?: string
}>()

const emit = defineEmits<{
  (e: 'cerrar'): void
}>()
</script>

<template>
  <div v-if="visible" class="overlay" @click.self="emit('cerrar')">
    <div class="modal">
      <button class="cerrar" @click="emit('cerrar')" title="Cerrar">
        <Icon icon="mdi:close" width="22" />
      </button>
      <img v-if="imagen" :src="imagen" :alt="titulo" class="foto" />
      <div class="contenido">
        <h2>{{ titulo }}</h2>
        <slot />
      </div>
    </div>
  </div>
</template>

<style scoped>
.overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}
.modal {
  position: relative;
  background: #1b1b1b;
  color: white;
  width: 92%;
  max-width: 520px;
  max-height: 90vh;
  overflow-y: auto;
  border-radius: 16px;
}
.cerrar {
  position: absolute;
  top: 10px;
  right: 10px;
  width: 36px;
  height: 36px;
  border: none;
  border-radius: 50%;
  background: rgba(0, 0, 0, 0.6);
  color: white;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}
.foto {
  width: 100%;
  height: 240px;
  object-fit: cover;
  border-radius: 16px 16px 0 0;
  display: block;
}
.contenido {
  padding: 20px;
}
.contenido h2 {
  margin: 0 0 12px;
}
.contenido :slotted(p) {
  margin: 6px 0;
  color: #ccc;
  line-height: 1.5;
}
</style>