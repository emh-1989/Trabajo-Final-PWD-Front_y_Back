<script setup lang="ts">
import { ref, computed, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { Icon } from '@iconify/vue'
import EstadoCarga from '@/components/EstadoCarga.vue'
import { useHotelesStore } from '@/stores/useHotelesStore'
import { useReservasStore } from '@/stores/useReservasStore'
import { useAuthStore } from '@/stores/useAuthStore'

const route = useRoute()
const router = useRouter()
const hotelesStore = useHotelesStore()
const reservasStore = useReservasStore()
const auth = useAuthStore()

const hotelId = Number(route.params.id)
const imagenActiva = ref('')
const checkin = ref('')
const checkout = ref('')
const huespedes = ref(2)
const reservaExitosa = ref(false)

watch(
  () => hotelesStore.hotelActual,
  (nuevo) => {
    if (nuevo) {
      imagenActiva.value = nuevo.imagenes?.[0] || nuevo.imagen || ''
    }
  },
  { immediate: true },
)

onMounted(async () => {
  await hotelesStore.fetchHotelPorId(hotelId)
})

const hotel = computed(() => hotelesStore.hotelActual)

// FIX: reservar() ahora llama realmente al store de reservas
const reservar = async () => {
  if (!auth.estaLogueado) {
    router.push({ name: 'login', query: { redirect: route.fullPath } })
    return
  }
  if (!checkin.value || !checkout.value) return

  await reservasStore.crear({
    hotel_id: hotelId,
    fecha_entrada: checkin.value,
    fecha_salida: checkout.value,
  })

  if (reservasStore.estado === 'exito') {
    reservaExitosa.value = true
  }
}
</script>

<template>
  <div class="detalle">
    <!-- Estado de carga / error / no encontrado -->
    <EstadoCarga
      v-if="hotelesStore.estadoDetalle !== 'exito'"
      :estado="hotelesStore.estadoDetalle"
      :mensaje="hotelesStore.mensajeErrorDetalle"
      recurso="hotel"
      @reintentar="hotelesStore.fetchHotelPorId(hotelId)"
    />

    <template v-else-if="hotel">
      <!-- GALERÍA -->
      <section class="galeria">
        <div class="principal">
          <img :src="imagenActiva" :alt="hotel.nombre" />
        </div>
        <div v-if="hotel.imagenes && hotel.imagenes.length > 1" class="thumbs">
          <img v-for="img in hotel.imagenes" :key="img" :src="img" @click="imagenActiva = img" />
        </div>
      </section>

      <!-- CONTENIDO -->
      <div class="contenido">
        <div class="info">
          <h1>{{ hotel.nombre }}</h1>
          <p class="ubicacion"><Icon icon="mdi:map-marker" width="18" /> {{ hotel.ubicacion }}</p>
          <p class="rating">⭐ {{ hotel.rating }}</p>
          <p class="descripcion">{{ hotel.descripcion }}</p>

          <div v-if="hotel.servicios?.length" class="servicios">
            <h3>Servicios</h3>
            <ul>
              <li v-for="s in hotel.servicios" :key="s">
                <Icon icon="mdi:check" width="16" /> {{ s }}
              </li>
            </ul>
          </div>
        </div>

        <!-- SIDEBAR RESERVA -->
        <div class="reserva">
          <div class="card-reserva">
            <h2>${{ hotel.precio }} USD / noche</h2>

            <!-- Éxito -->
            <div v-if="reservaExitosa" class="reserva-ok">
              <Icon icon="mdi:check-circle" width="24" />
              <p>
                ¡Reserva confirmada! Podés verla en
                <router-link to="/mis-reservas">Mis reservas</router-link>.
              </p>
            </div>

            <template v-else>
              <div class="campo">
                <label>Check in</label>
                <input
                  type="date"
                  v-model="checkin"
                  :min="new Date().toISOString().split('T')[0]"
                />
              </div>
              <div class="campo">
                <label>Check out</label>
                <input
                  type="date"
                  v-model="checkout"
                  :min="checkin || new Date().toISOString().split('T')[0]"
                />
              </div>
              <div class="campo">
                <label>Huéspedes</label>
                <input type="number" v-model="huespedes" min="1" />
              </div>

              <!-- Error de reserva -->
              <p v-if="reservasStore.mensajeError" class="error-reserva">
                {{ reservasStore.mensajeError }}
              </p>

              <button
                class="btn-reservar"
                @click="reservar"
                :disabled="!checkin || !checkout || reservasStore.estado === 'cargando'"
              >
                <span v-if="reservasStore.estado === 'cargando'" class="spinner" />
                <span v-else>Reservar ahora</span>
              </button>

              <p v-if="!auth.estaLogueado" class="aviso-login">
                Necesitás <router-link to="/login">iniciar sesión</router-link> para reservar.
              </p>
            </template>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<style scoped>
.detalle {
  background: #111111;
  color: white;
  padding-bottom: 2rem;
}

.galeria {
  width: 100%;
}

.principal img {
  width: 100%;
  height: 400px;
  object-fit: cover;
}

.thumbs {
  display: flex;
  gap: 0.5rem;
  padding: 0.5rem;
  overflow-x: auto;
  background: #0d0d0d;
}

.thumbs img {
  width: 120px;
  height: 80px;
  object-fit: cover;
  cursor: pointer;
  border-radius: 6px;
  opacity: 0.6;
  border: 2px solid transparent;
  transition: 0.3s;
}

.thumbs img:hover {
  opacity: 1;
  border-color: #7cd3e3;
}

.contenido {
  display: flex;
  gap: 2rem;
  padding: 2rem;
}

.info {
  flex: 2;
}
.info h1 {
  margin-bottom: 0.5rem;
}
.ubicacion {
  opacity: 0.7;
}
.rating {
  margin: 0.5rem 0;
  color: #7cd3e3;
}
.descripcion {
  margin-top: 1rem;
  line-height: 1.6;
  opacity: 0.85;
}

.servicios {
  margin-top: 1.5rem;
}
.servicios h3 {
  color: #7cd3e3;
  margin-bottom: 0.75rem;
}
.servicios ul {
  list-style: none;
  padding: 0;
}
.servicios li {
  margin-bottom: 0.4rem;
  opacity: 0.85;
}

.reserva {
  flex: 1;
}

.card-reserva {
  position: sticky;
  top: 100px;
  background: rgba(255, 255, 255, 0.04);
  padding: 1.5rem;
  border-radius: 14px;
  border: 1px solid rgba(124, 211, 227, 0.2);
}

.card-reserva h2 {
  color: #7cd3e3;
  margin-bottom: 1rem;
}

.campo {
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
  margin-bottom: 1rem;
}

.campo input {
  padding: 0.5rem;
  border-radius: 6px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  background: #1a1a1a;
  color: white;
  outline: none;
}

.campo input:focus {
  border-color: #7cd3e3;
}

.btn-reservar {
  width: 100%;
  padding: 0.8rem;
  border: none;
  border-radius: 8px;
  background: #df243c;
  color: white;
  font-weight: bold;
  cursor: pointer;
  transition: 0.2s;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
}

.btn-reservar:hover:not(:disabled) {
  background: #b81d30;
}
.btn-reservar:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.spinner {
  width: 16px;
  height: 16px;
  border: 2px solid white;
  border-top-color: transparent;
  border-radius: 50%;
  animation: spin 0.6s linear infinite;
  display: inline-block;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.reserva-ok {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  color: #1d9e75;
  padding: 1rem;
  background: rgba(29, 158, 117, 0.08);
  border: 1px solid rgba(29, 158, 117, 0.2);
  border-radius: 8px;
}

.reserva-ok a {
  color: #7cd3e3;
}

.error-reserva {
  color: #ff4d4d;
  font-size: 0.85rem;
  margin-bottom: 0.75rem;
}

.aviso-login {
  font-size: 0.8rem;
  opacity: 0.6;
  margin-top: 0.75rem;
  text-align: center;
}

.aviso-login a {
  color: #7cd3e3;
}

@media (max-width: 900px) {
  .contenido {
    flex-direction: column;
  }
  .card-reserva {
    position: static;
  }
}
</style>
