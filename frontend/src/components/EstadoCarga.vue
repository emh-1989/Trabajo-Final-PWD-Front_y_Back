<!-- components/EstadoCarga.vue -->
<script setup lang="ts">
import { computed } from 'vue'
import { Icon } from '@iconify/vue'
import type { EstadoCarga as TipoEstado } from '@/stores/useBaseStore'

interface Props {
  estado: TipoEstado
  mensaje?: string
  recurso?: string
}

const props = withDefaults(defineProps<Props>(), {
  mensaje: '',
  recurso: 'recurso',
})

const emit = defineEmits<{
  (e: 'reintentar'): void
}>()

const configEstado = computed(() => {
  const configs: Record<string, any> = {
    cargando: {
      icon: '',
      titulo: 'Cargando...',
      mensaje: `Obteniendo ${props.recurso}s...`,
      color: '#7cd3e3',
      mostrarSpinner: true,
      mostrarReintentar: false,
    },
    error: {
      icon: 'mdi:server-off',
      titulo: 'Error del servidor',
      mensaje: props.mensaje || 'Ocurrió un error.',
      color: '#df243c',
      mostrarSpinner: false,
      mostrarReintentar: true,
    },
    noEncontrado: {
      icon: 'mdi:file-search-outline',
      titulo: 'No encontrado',
      mensaje: `El ${props.recurso} no existe.`,
      color: '#ef9f27',
      mostrarSpinner: false,
      mostrarReintentar: false,
    },
  }
  return configs[props.estado] || configs.error
})
</script>

<template>
  <div v-if="estado !== 'idle' && estado !== 'exito'" class="estado-carga">
    <div
      v-if="configEstado.mostrarSpinner"
      class="spinner"
      :style="{ borderTopColor: configEstado.color }"
    />
    <Icon v-else :icon="configEstado.icon" width="64" :style="{ color: configEstado.color }" />
    <h2 :style="{ color: configEstado.color }">{{ configEstado.titulo }}</h2>
    <p>{{ configEstado.mensaje }}</p>
    <button
      v-if="configEstado.mostrarReintentar"
      class="btn-reintentar"
      @click="emit('reintentar')"
    >
      <Icon icon="mdi:refresh" width="18" /> Reintentar
    </button>
  </div>
</template>

<style scoped>
.estado-carga {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 40vh;
  gap: 1rem;
  text-align: center;
  padding: 2rem;
}
.spinner {
  width: 48px;
  height: 48px;
  border: 4px solid rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}
@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}
.btn-reintentar {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 2rem;
  border: none;
  border-radius: 8px;
  background: #df243c;
  color: white;
  font-weight: 600;
  cursor: pointer;
}
.btn-reintentar:hover {
  background: #b81d30;
}
</style>
