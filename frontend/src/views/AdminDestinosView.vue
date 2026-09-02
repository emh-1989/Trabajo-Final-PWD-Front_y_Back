<script setup lang="ts">
import { ref, onMounted, reactive } from 'vue'
import { Icon } from '@iconify/vue'
import { useDestinosStore } from '@/stores/useDestinosStore'

const store = useDestinosStore()

const editando = ref<number | null>(null)
const mostrarForm = ref(false)

const formVacio = () => ({
  titulo: '',
  emoji: '',
  imagen: '',
  descripcion: '',
  paisajes: '',
  comida: '',
  tipsTexto: '',
  orden: 0,
})

const form = reactive(formVacio())

const nuevoDestino = () => {
  Object.assign(form, formVacio())
  editando.value = null
  mostrarForm.value = true
}

const editarDestino = (d: any) => {
  Object.assign(form, {
    titulo: d.titulo,
    emoji: d.emoji,
    imagen: d.imagen,
    descripcion: d.descripcion,
    paisajes: d.paisajes,
    comida: d.comida,
    tipsTexto: (d.tips || []).join('\n'),
    orden: d.orden,
  })
  editando.value = d.id
  mostrarForm.value = true
}

const cancelarForm = () => {
  mostrarForm.value = false
  editando.value = null
}

const guardar = async () => {
  const payload = {
    titulo: form.titulo,
    emoji: form.emoji,
    imagen: form.imagen,
    descripcion: form.descripcion,
    paisajes: form.paisajes,
    comida: form.comida,
    tips: form.tipsTexto
      .split('\n')
      .map((t) => t.trim())
      .filter(Boolean),
    orden: Number(form.orden) || 0,
  }

  if (editando.value) {
    await store.actualizar(editando.value, payload)
  } else {
    await store.crear(payload)
  }

  mostrarForm.value = false
  editando.value = null
}

const eliminarDestino = async (id: number) => {
  if (confirm('¿Eliminar este destino? Esta acción no se puede deshacer.')) {
    await store.eliminar(id)
  }
}

onMounted(() => {
  store.fetchDestinos()
})
</script>

<template>
  <div class="admin-destinos">
    <div class="header">
      <h2>Destinos populares (slider del Home)</h2>
      <button class="btn-primario" @click="nuevoDestino">
        <Icon icon="mdi:plus" width="18" /> Nuevo destino
      </button>
    </div>

    <div v-if="store.estado === 'cargando' && !store.destinos.length" class="cargando">
      <Icon icon="mdi:loading" width="28" class="spin" />
    </div>

    <div v-if="store.mensajeError" class="error-box">{{ store.mensajeError }}</div>

    <!-- FORMULARIO -->
    <div v-if="mostrarForm" class="form-card">
      <h3>{{ editando ? 'Editar destino' : 'Nuevo destino' }}</h3>
      <div class="campo">
        <label>Título (ej: "Bariloche, Argentina")</label>
        <input v-model="form.titulo" />
      </div>
      <div class="campo">
        <label>Emoji</label>
        <input v-model="form.emoji" placeholder="🏔️" />
      </div>
      <div class="campo">
        <label>URL de imagen</label>
        <input v-model="form.imagen" placeholder="https://..." />
      </div>
      <div class="campo">
        <label>Descripción</label>
        <textarea v-model="form.descripcion" rows="3"></textarea>
      </div>
      <div class="campo">
        <label>Paisajes</label>
        <textarea v-model="form.paisajes" rows="2"></textarea>
      </div>
      <div class="campo">
        <label>Gastronomía</label>
        <textarea v-model="form.comida" rows="2"></textarea>
      </div>
      <div class="campo">
        <label>Tips (uno por línea)</label>
        <textarea v-model="form.tipsTexto" rows="4"></textarea>
      </div>
      <div class="campo">
        <label>Orden en el slider</label>
        <input v-model="form.orden" type="number" />
      </div>
      <div class="acciones-form">
        <button class="btn-primario" @click="guardar">Guardar</button>
        <button class="btn-secundario" @click="cancelarForm">Cancelar</button>
      </div>
    </div>

    <!-- LISTADO -->
    <div class="tabla">
      <div v-for="d in store.destinos" :key="d.id" class="fila">
        <span class="emoji">{{ d.emoji }}</span>
        <span class="titulo">{{ d.titulo }}</span>
        <span class="orden">orden: {{ d.orden }}</span>
        <div class="acciones">
          <button class="btn-icono" @click="editarDestino(d)">
            <Icon icon="mdi:pencil" width="16" />
          </button>
          <button class="btn-icono btn-eliminar" @click="eliminarDestino(d.id)">
            <Icon icon="mdi:delete" width="16" />
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.admin-destinos {
  padding: 1.5rem;
}
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
}
.btn-primario {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  background: rgba(124, 211, 227, 0.15);
  border: 1px solid rgba(124, 211, 227, 0.4);
  color: #7cd3e3;
  padding: 0.5rem 1rem;
  border-radius: 8px;
  cursor: pointer;
}
.btn-secundario {
  background: transparent;
  border: 1px solid rgba(255, 255, 255, 0.2);
  color: #ccc;
  padding: 0.5rem 1rem;
  border-radius: 8px;
  cursor: pointer;
}
.error-box {
  background: rgba(223, 36, 60, 0.1);
  border: 1px solid rgba(223, 36, 60, 0.4);
  color: #df243c;
  padding: 0.75rem;
  border-radius: 8px;
  margin-bottom: 1rem;
}
.form-card {
  background: #1a1a1a;
  border-radius: 12px;
  padding: 1.5rem;
  margin-bottom: 1.5rem;
}
.campo {
  margin-bottom: 0.9rem;
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
}
.campo label {
  font-size: 0.8rem;
  opacity: 0.7;
}
.campo input,
.campo textarea {
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.15);
  border-radius: 6px;
  padding: 0.5rem;
  color: white;
  font-family: inherit;
}
.acciones-form {
  display: flex;
  gap: 0.75rem;
  margin-top: 1rem;
}
.tabla {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}
.fila {
  display: flex;
  align-items: center;
  gap: 1rem;
  background: #161616;
  border-radius: 8px;
  padding: 0.75rem 1rem;
}
.fila .titulo {
  flex: 1;
}
.fila .orden {
  font-size: 0.8rem;
  opacity: 0.6;
}
.acciones {
  display: flex;
  gap: 0.5rem;
}
.btn-icono {
  background: rgba(255, 255, 255, 0.06);
  border: none;
  color: #ccc;
  width: 30px;
  height: 30px;
  border-radius: 6px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}
.btn-eliminar:hover {
  background: rgba(223, 36, 60, 0.2);
  color: #df243c;
}
.cargando {
  display: flex;
  justify-content: center;
  padding: 2rem;
}
.spin {
  animation: spin 0.8s linear infinite;
}
@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}
</style>
