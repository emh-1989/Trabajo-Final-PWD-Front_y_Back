<script setup lang="ts">
import { useRouter } from 'vue-router'
import PromoCard from '@/components/PromoCard.vue'
import ReviewCard from '@/components/ReviewCard.vue'
import EspectaculosCard from '@/components/EspectaculosCard.vue'
import DestinosCard from '@/components/DestinosCard.vue'
import hero from '@/assets/hero.jpg'
import { Icon } from '@iconify/vue'
import explora from '@/assets/explora.jpg'

const router = useRouter()
const irA = (ruta: string) => router.push(ruta)

const categorias = [
  { icon: 'mdi:mountain', nombre: 'Montaña' },
  { icon: 'mdi:beach', nombre: 'Playa' },
  { icon: 'mdi:city', nombre: 'Ciudad' },
  { icon: 'mdi:ticket-outline', nombre: 'Eventos' },
]

const promos = [
  {
    id: 1,
    titulo: 'San Carlos de Bariloche',
    fecha: '20 al 25 de jun.',
    precio: '$380 USD noche',
    imagen: '/imagenes/bariloche.jpg',
  },
  {
    id: 2,
    titulo: 'Mendoza',
    fecha: '21 al 28 de jun.',
    precio: '$330 USD noche',
    imagen: '/imagenes/mendoza.jpg',
  },
  {
    id: 3,
    titulo: 'Buenos Aires',
    fecha: '23 al 30 de jun.',
    precio: '$350 USD noche',
    imagen: '/imagenes/buenos_aires.jpg',
  },
]

const reviews = [
  {
    id: 1,
    texto: 'Excelente experiencia! Todo muy bien organizado.',
    autor: 'Andycor621',
    estrellas: 5,
  },
  {
    id: 2,
    texto: 'Muy buen servicio, superó expectativas.',
    autor: 'MaríaG',
    estrellas: 4,
  },
]

const espectaculos = [
  {
    id: 1,
    titulo: 'AC/DC Power up tour',
    fecha: '20 al 25 de jun.',
    precio: '$300 USD-1000 USD',
    imagen: '/imagenes/acdc.jpg',
  },
  {
    id: 2,
    titulo: 'Esperando la carroza- teatro',
    fecha: '20 al 30 de junio',
    precio: '$40 USD-100 USD ',
    imagen: '/imagenes/esperando_la_carroza.jpg',
  },
  {
    id: 3,
    titulo: 'Proyecto Fin del Mundo',
    fecha: '23 al 30 de jun.',
    precio: '$15.000 $',
    imagen: '/imagenes/proyecto_fin_del_mundo.jpg',
  },
]

const destinos = [
  {
    id: 1,
    titulo: 'Aruba, Caribe',
    descripcion:
      'Aruba es una pequeña isla autónoma del Reino de los Países Bajos, situada al sur del Caribe, cerca de Venezuela. Conocida como "La Isla Feliz", destaca por sus playas de arena blanca, aguas cristalinas y un clima seco y soleado todo el año, al estar fuera de la zona de huracanes.',
    imagen: '/imagenes/aruba.jpg',
  },
  {
    id: 2,
    titulo: 'Cappadocia, Turquía',
    descripcion:
      'Cappadocia es una región histórica en el centro de Turquía, famosa por sus formaciones rocosas únicas, conocidas como "chimeneas de hadas". Estas formaciones se crearon a lo largo de millones de años debido a la erosión de la roca volcánica blanda. La región también es conocida por sus ciudades subterráneas, iglesias rupestres y paisajes surrealistas, lo que la convierte en un destino turístico popular.',
    imagen: '/imagenes/cappadocia.jpg',
  },
  {
    id: 3,
    titulo: 'Bali, Indonesia',
    descripcion:
      'Bali es una isla indonesia conocida por sus paisajes tropicales, templos hindues y una vibrante cultura. Es un destino popular para el turismo de playa, con playas de arena blanca, aguas cristalinas y una escena artística y creativa floreciente.',
    imagen: '/imagenes/bali.jpg',
  },
]
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
      :style="{
        backgroundImage: `linear-gradient(rgba(0,0,0,.5), rgba(0,0,0,.5)), url(${hero})`,
      }"
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
        <input placeholder="¿Adónde?" />
        <button>
          <Icon icon="gis:map-search" width="18" />
        </button>
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
      <div class="grid">
        <PromoCard v-for="p in promos" :key="p.id" v-bind="p" />
      </div>
    </section>

    <!-- DESTINOS -->
    <section
      class="seccion_destinos"
      v-motion
      :initial="{ opacity: 0, y: 60 }"
      :visible="{ opacity: 1, y: 0 }"
      :transition="{ duration: 500 }"
    >
      <h2 class="titulo">DESTINOS POPULARES</h2>
      <div class="grid">
        <DestinosCard v-for="d in destinos" :key="d.id" v-bind="d" />
      </div>
    </section>

    <!-- EVENTOS DESTACADOS -->
    <section
      class="seccion_destacados"
      v-motion
      :initial="{ opacity: 0, y: 60 }"
      :visible="{ opacity: 1, y: 0 }"
      :transition="{ duration: 500 }"
    >
      <h2 class="titulo">Espectaculos destacados</h2>
      <div class="grid">
        <EspectaculosCard v-for="p in espectaculos" :key="p.id" v-bind="p" />
      </div>
    </section>

    <!-- RESEÑAS -->
    <section
      class="seccion_resenas"
      v-motion
      :initial="{ opacity: 0, y: 60 }"
      :visible="{ opacity: 1, y: 0 }"
      :transition="{ duration: 500 }"
    >
      <h2 class="titulo">RESEÑAS</h2>
      <div class="grid">
        <ReviewCard v-for="r in reviews" :key="r.id" v-bind="r" />
      </div>
    </section>
  </div>
</template>

<style scoped>
/* HERO */
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

/* BARRA */
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

/* SECCIONES — base compartida */
.seccion_destinos,
.seccion_promos,
.seccion_destacados,
.seccion_resenas {
  padding: 3.5rem 1.5rem;
  width: 100vw;
  margin-left: calc(-50vw + 50%);
}

.titulo {
  text-align: center;
  margin-bottom: 1.5rem;
  color: #ffffff;
}

/* PROMOCIONES — acento rojo */
.seccion_promos {
  background: #111111;
  border-top: 3px solid #df243c;
}

/* DESTINOS — acento celeste */
.seccion_destinos {
  background: #111111;
  border-top: 3px solid #7cd3e3;
}

/* ESPECTÁCULOS — acento rojo */
.seccion_destacados {
  background: #111111;
  border-top: 3px solid #df243c;
  padding: 2.5rem 1.5rem;
}

/* RESEÑAS — acento celeste */
.seccion_resenas {
  background: #111111;
  border-top: 3px solid #7cd3e3;
  padding: 2.5rem 1.5rem;
}

/* GRID */
.grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
  gap: 1rem;
}

/* CATEGORÍAS */
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

/* DESTINOS */
.destino {
  padding: 2rem;
  text-align: center;
}

/* NEON */
.neon-text {
  text-shadow: 0 0 10px rgba(124, 211, 227, 0.6);
}
</style>
