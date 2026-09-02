<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Icon } from '@iconify/vue'
import PromoCard from '@/components/PromoCard.vue'
import EspectaculosCard from '@/components/EspectaculosCard.vue'
import hero from '@/assets/hero.jpg'
import explora from '@/assets/explora.jpg'
import { useHotelesStore } from '@/stores/useHotelesStore'
import { useEntretenimientoStore } from '@/stores/useEntretenimientoStore'
import { useDestinosStore } from '@/stores/useDestinosStore'

const router = useRouter()
const hotelesStore = useHotelesStore()
const entretenimientoStore = useEntretenimientoStore()
const destinosStore = useDestinosStore()

const busqueda = ref('')

const buscar = () => {
  if (busqueda.value.trim()) {
    router.push({ path: '/hospedaje', query: { destino: busqueda.value } })
  } else {
    router.push('/hospedaje')
  }
}

const categorias = [
  { icon: 'mdi:mountain', nombre: 'Montaña', ruta: '/hospedaje', query: { tipo: 'resort' } },
  { icon: 'mdi:beach', nombre: 'Playa', ruta: '/hospedaje', query: { destino: 'mar' } },
  { icon: 'mdi:city', nombre: 'Ciudad', ruta: '/hospedaje', query: { tipo: 'hotel' } },
  { icon: 'mdi:ticket-outline', nombre: 'Eventos', ruta: '/entretenimiento', query: {} },
]

const irACategoria = (cat: (typeof categorias)[0]) => {
  router.push({ path: cat.ruta, query: cat.query })
}

const promos = ref<{ id: number; titulo: string; fecha: string; precio: string; imagen: string }[]>(
  [],
)
const espectaculos = ref<
  { id: number; titulo: string; fecha: string; precio: string; imagen: string }[]
>([])

// ── Slider destinos ────────────────────────────────────────
const sliderActivo = ref(0)

const siguiente = () => {
  sliderActivo.value = (sliderActivo.value + 1) % destinosStore.destinos.length
}

const anterior = () => {
  sliderActivo.value =
    (sliderActivo.value - 1 + destinosStore.destinos.length) % destinosStore.destinos.length
}

onMounted(async () => {
  hotelesStore.filtros = {}
  await hotelesStore.fetchHoteles()
  const top3 = [...hotelesStore.hoteles].sort((a, b) => b.rating - a.rating).slice(0, 3)
  promos.value = top3.map((h) => ({
    id: h.id,
    titulo: h.nombre,
    fecha: h.ubicacion,
    precio: `$${h.precio} USD / noche`,
    imagen: h.imagen || 'https://picsum.photos/seed/hotel/400/300',
  }))

  await entretenimientoStore.buscarEventos({})
  espectaculos.value = entretenimientoStore.eventos.slice(0, 3).map((e) => ({
    id: e.id,
    titulo: e.titulo,
    fecha: e.fecha,
    precio: e.ubicacion,
    imagen: e.imagen || 'https://picsum.photos/seed/evento/400/300',
  }))

  await destinosStore.fetchDestinos()
})

const irAHotel = (id: number) => router.push(`/hotel/${id}`)
const irAEvento = () => router.push('/entretenimiento')
</script>

<template>
  <div class="inicio">
    <!-- HERO -->
    <section
      class="hero"
      v-motion
      :initial="{ opacity: 0, scale: 0.95 }"
      :visible="{ opacity: 1, scale: 1 }"
      :transition="{ duration: 600 }"
      :style="{ backgroundImage: `linear-gradient(rgba(0,0,0,.5), rgba(0,0,0,.5)), url(${hero})` }"
    >
      <h2
        class="neon-text"
        v-motion
        :initial="{ opacity: 0, y: 30 }"
        :visible="{ opacity: 1, y: 0 }"
        :delay="150"
      >
        Encontrá tu próximo destino
      </h2>
      <div
        class="barra glass-strong"
        v-motion
        :initial="{ opacity: 0, y: 40 }"
        :visible="{ opacity: 1, y: 0 }"
        :delay="300"
      >
        <input v-model="busqueda" placeholder="¿Adónde?" @keyup.enter="buscar" />
        <button @click="buscar"><Icon icon="gis:map-search" width="18" /></button>
      </div>
    </section>

    <!-- CATEGORÍAS -->
    <section
      class="seccion_categorias"
      :style="{
        backgroundImage: `linear-gradient(rgba(0,0,0,.5), rgba(0,0,0,.5)), url(${explora})`,
      }"
    >
      <h2 class="titulo">Explorá por tipo</h2>
      <div class="categorias-grid">
        <div
          class="cat glass neon-hover"
          v-for="(cat, i) in categorias"
          :key="cat.nombre"
          v-motion
          :initial="{ opacity: 0, y: 50 }"
          :visible="{ opacity: 1, y: 0 }"
          :delay="i * 120"
          @click="irACategoria(cat)"
        >
          <Icon :icon="cat.icon" width="26" />
          <p>{{ cat.nombre }}</p>
        </div>
      </div>
    </section>

    <!-- PROMOCIONES -->
    <section
      class="seccion_promos"
      v-motion
      :initial="{ opacity: 0, y: 60 }"
      :visible="{ opacity: 1, y: 0 }"
      :transition="{ duration: 500 }"
    >
      <h2 class="titulo">PROMOCIONES</h2>
      <div v-if="hotelesStore.estado === 'cargando'" class="cargando">
        <Icon icon="mdi:loading" width="32" class="spin" />
      </div>
      <div v-else class="grid">
        <div v-for="p in promos" :key="p.id" @click="irAHotel(p.id)" style="cursor: pointer">
          <PromoCard v-bind="p" />
        </div>
      </div>
    </section>

    <!-- SLIDER DESTINOS POPULARES -->
    <section
      class="seccion_destinos"
      v-motion
      :initial="{ opacity: 0, y: 60 }"
      :visible="{ opacity: 1, y: 0 }"
      :transition="{ duration: 500 }"
    >
      <h2 class="titulo">DESTINOS POPULARES</h2>
      <p class="subtitulo">Paisajes, gastronomía y tips de viaje</p>

      <div v-if="destinosStore.estado === 'cargando'" class="cargando">
        <Icon icon="mdi:loading" width="32" class="spin" />
      </div>

      <div v-else-if="destinosStore.destinos.length" class="slider-wrapper">
        <div class="slide" :key="sliderActivo">
          <!-- Imagen con info encima -->
          <div
            class="slide-hero"
            :style="{
              backgroundImage: `linear-gradient(to bottom, rgba(0,0,0,0.2), rgba(0,0,0,0.85)), url(${destinosStore.destinos[sliderActivo].imagen})`,
            }"
          >
            <div class="slide-hero-contenido">
              <span class="slide-emoji">{{ destinosStore.destinos[sliderActivo].emoji }}</span>
              <h3>{{ destinosStore.destinos[sliderActivo].titulo }}</h3>
              <p class="slide-desc">{{ destinosStore.destinos[sliderActivo].descripcion }}</p>
            </div>
          </div>

          <!-- Info del destino -->
          <div class="slide-info">
            <div class="slide-secciones">
              <div class="slide-seccion">
                <h4><Icon icon="mdi:image-multiple-outline" width="15" /> Paisajes</h4>
                <p>{{ destinosStore.destinos[sliderActivo].paisajes }}</p>
              </div>
              <div class="slide-seccion">
                <h4><Icon icon="mdi:food-fork-drink" width="15" /> Gastronomía</h4>
                <p>{{ destinosStore.destinos[sliderActivo].comida }}</p>
              </div>
              <div class="slide-seccion">
                <h4><Icon icon="mdi:lightbulb-outline" width="15" /> Tips</h4>
                <ul>
                  <li v-for="tip in destinosStore.destinos[sliderActivo].tips" :key="tip">
                    <Icon icon="mdi:check-circle-outline" width="13" /> {{ tip }}
                  </li>
                </ul>
              </div>
            </div>

            <button
              class="btn-explorar"
              @click="
                router.push({
                  path: '/hospedaje',
                  query: { destino: destinosStore.destinos[sliderActivo].titulo.split(',')[0] },
                })
              "
            >
              <Icon icon="mdi:magnify" width="15" />
              Ver alojamientos en {{ destinosStore.destinos[sliderActivo].titulo.split(',')[0] }}
            </button>
          </div>
        </div>

        <!-- Controles -->
        <div class="slider-controles">
          <button class="btn-nav" @click="anterior">
            <Icon icon="mdi:chevron-left" width="22" />
          </button>
          <div class="dots">
            <button
              v-for="(_, i) in destinosStore.destinos"
              :key="i"
              class="dot"
              :class="{ activo: sliderActivo === i }"
              @click="sliderActivo = i"
            />
          </div>
          <button class="btn-nav" @click="siguiente">
            <Icon icon="mdi:chevron-right" width="22" />
          </button>
        </div>
      </div>
    </section>

    <!-- ESPECTÁCULOS -->
    <section
      class="seccion_destacados"
      v-motion
      :initial="{ opacity: 0, y: 60 }"
      :visible="{ opacity: 1, y: 0 }"
      :transition="{ duration: 500 }"
    >
      <h2 class="titulo">Espectáculos destacados</h2>
      <div v-if="entretenimientoStore.estado === 'cargando'" class="cargando">
        <Icon icon="mdi:loading" width="32" class="spin" />
      </div>
      <div v-else class="grid">
        <div v-for="e in espectaculos" :key="e.id" @click="irAEvento" style="cursor: pointer">
          <EspectaculosCard v-bind="e" />
        </div>
      </div>
      <div class="ver-mas">
        <button class="btn-ver-mas" @click="router.push('/entretenimiento')">
          Ver todos los eventos <Icon icon="mdi:arrow-right" width="16" />
        </button>
      </div>
    </section>
  </div>
</template>

<style scoped>
.hero {
  height: 350px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background-size: cover;
  width: 100vw;
  margin-left: calc(-50vw + 50%);
}

.barra {
  display: flex;
  width: min(600px, 90%);
  margin-top: 1rem;
  border-radius: 10px;
  overflow: hidden;
}

.barra input {
  flex: 1;
  padding: 0.8rem;
  background: transparent;
  border: none;
  color: white;
  outline: none;
}

.barra button {
  padding: 0.8rem;
  background: rgba(124, 211, 227, 0.15);
  border: none;
  color: white;
  cursor: pointer;
  transition: 0.3s;
}

.barra button:hover {
  background: rgba(124, 211, 227, 0.3);
  box-shadow: 0 0 8px rgba(124, 211, 227, 0.6);
}

.seccion_categorias {
  height: 350px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background-size: cover;
  width: 100vw;
  margin-left: calc(-50vw + 50%);
}

.categorias-grid {
  display: flex;
  justify-content: center;
  gap: 1.2rem;
  flex-wrap: wrap;
  margin-top: 1.5rem;
}

.cat {
  width: 120px;
  height: 100px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  border-radius: 14px;
  cursor: pointer;
  transition: 0.3s;
}

.cat svg {
  color: #7cd3e3;
}

.cat:hover {
  transform: translateY(-6px) scale(1.05);
  box-shadow: 0 0 15px rgba(124, 211, 227, 0.4);
}

.seccion_promos,
.seccion_destinos,
.seccion_destacados {
  padding: 3.5rem 1.5rem;
  width: 100vw;
  margin-left: calc(-50vw + 50%);
}

.seccion_promos {
  background: #111111;
  border-top: 3px solid #df243c;
}
.seccion_destinos {
  background: #0d0d0d;
  border-top: 3px solid #7cd3e3;
}
.seccion_destacados {
  background: #111111;
  border-top: 3px solid #df243c;
  padding: 2.5rem 1.5rem;
}

.titulo {
  text-align: center;
  margin-bottom: 0.5rem;
  color: #ffffff;
}

.subtitulo {
  text-align: center;
  opacity: 0.5;
  font-size: 0.85rem;
  margin-bottom: 2rem;
}

.grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
  gap: 1rem;
  max-width: 1100px;
  margin: 0 auto;
}

/* SLIDER */
.slider-wrapper {
  max-width: 900px;
  margin: 0 auto;
}

.slide {
  border-radius: 16px;
  overflow: hidden;
  border: 1px solid rgba(124, 211, 227, 0.2);
  animation: fadeSlide 0.4s ease;
}

@keyframes fadeSlide {
  from {
    opacity: 0;
    transform: translateX(20px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

.slide-hero {
  height: 280px;
  background-size: cover;
  background-position: center;
  display: flex;
  align-items: flex-end;
  padding: 1.5rem;
}

.slide-hero-contenido {
  color: white;
}
.slide-emoji {
  font-size: 2rem;
}

.slide-hero-contenido h3 {
  font-size: 1.6rem;
  margin: 0.3rem 0;
  color: #7cd3e3;
  text-shadow: 0 0 10px rgba(124, 211, 227, 0.5);
}

.slide-desc {
  opacity: 0.85;
  font-size: 0.88rem;
  line-height: 1.5;
  max-width: 600px;
}

.slide-info {
  background: #1a1a1a;
  padding: 1.5rem;
}

.slide-secciones {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1rem;
  margin-bottom: 1.25rem;
}

.slide-seccion {
  background: rgba(255, 255, 255, 0.04);
  border-radius: 8px;
  padding: 0.75rem;
}

.slide-seccion h4 {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  color: #7cd3e3;
  font-size: 0.82rem;
  margin-bottom: 0.5rem;
}

.slide-seccion p,
.slide-seccion li {
  font-size: 0.8rem;
  opacity: 0.75;
  line-height: 1.5;
}

.slide-seccion ul {
  list-style: none;
  padding: 0;
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.slide-seccion li {
  display: flex;
  align-items: flex-start;
  gap: 0.3rem;
}

.btn-explorar {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  background: rgba(124, 211, 227, 0.1);
  border: 1px solid rgba(124, 211, 227, 0.3);
  color: #7cd3e3;
  padding: 0.5rem 1rem;
  border-radius: 8px;
  font-size: 0.85rem;
  cursor: pointer;
  transition: 0.2s;
}

.btn-explorar:hover {
  background: rgba(124, 211, 227, 0.2);
}

.slider-controles {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  margin-top: 1.25rem;
}

.btn-nav {
  background: rgba(124, 211, 227, 0.1);
  border: 1px solid rgba(124, 211, 227, 0.3);
  color: #7cd3e3;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: 0.2s;
}

.btn-nav:hover {
  background: rgba(124, 211, 227, 0.25);
}

.dots {
  display: flex;
  gap: 0.5rem;
  align-items: center;
}

.dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.25);
  border: none;
  cursor: pointer;
  transition: 0.2s;
  padding: 0;
}

.dot.activo {
  background: #7cd3e3;
  width: 24px;
  border-radius: 4px;
}

.ver-mas {
  text-align: center;
  margin-top: 1.5rem;
}

.btn-ver-mas {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  background: transparent;
  border: 1px solid rgba(223, 36, 60, 0.4);
  color: #df243c;
  padding: 0.6rem 1.5rem;
  border-radius: 8px;
  cursor: pointer;
  transition: 0.2s;
}

.btn-ver-mas:hover {
  background: rgba(223, 36, 60, 0.1);
}

.cargando {
  display: flex;
  justify-content: center;
  padding: 2rem;
}

.spin {
  animation: spin 0.8s linear infinite;
  color: #7cd3e3;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.neon-text {
  text-shadow: 0 0 10px rgba(124, 211, 227, 0.6);
}

@media (max-width: 640px) {
  .slide-secciones {
    grid-template-columns: 1fr;
  }
  .grid {
    grid-template-columns: 1fr;
  }
  .slide-hero {
    height: 200px;
  }
  .slide-hero-contenido h3 {
    font-size: 1.2rem;
  }
}
</style>
