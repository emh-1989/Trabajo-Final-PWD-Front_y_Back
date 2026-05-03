<script setup lang="ts">
import { useRouter } from 'vue-router'

const router = useRouter()
const irA = (ruta: string) => router.push(ruta)
</script>

<template>
  <!-- FIX: clase corregida de "contacto" a "condiciones" -->
  <div class="condiciones">
    <h1>Condiciones de uso</h1>
    <p>
      Bienvenido a Adventure, tu plataforma de reservas de alojamientos para viajeros. Al utilizar
      nuestro sitio web, aceptas cumplir con las siguientes condiciones de uso:
    </p>
    <h2>1. Uso del sitio web</h2>
    <p>
      Adventure es una plataforma que conecta a viajeros con alojamientos. Al utilizar nuestro
      sitio, aceptas proporcionar información precisa y actualizada sobre ti mismo y tus reservas.
      No debes utilizar el sitio para actividades ilegales o fraudulentas.
    </p>
    <h2>2. Propiedad intelectual</h2>
    <p>
      Todo el contenido de Adventure, incluyendo textos, imágenes, logotipos y software, es
      propiedad de Adventure o de sus licenciantes. No puedes reproducir, distribuir o utilizar
      nuestro contenido sin permiso.
    </p>
    <h2>3. Responsabilidad</h2>
    <p>
      Adventure no se hace responsable de los daños o pérdidas que puedan surgir del uso de nuestro
      sitio web o de las reservas realizadas a través de él. Es tu responsabilidad verificar la
      información de los alojamientos y las políticas de cancelación antes de realizar una reserva.
    </p>
  </div>
</template>

<style scoped>
/* FIX: selector corregido de .contacto a .condiciones */
.condiciones {
  background: #111111;
  color: white;
  min-height: 100vh;
  padding: 3rem 2rem;
  max-width: 800px;
  margin: 0 auto;
}

.condiciones h1 {
  color: #7cd3e3;
  margin-bottom: 1rem;
  border-bottom: 2px solid #7cd3e3;
  padding-bottom: 0.5rem;
}

.condiciones h2 {
  color: #df243c;
  margin-top: 2rem;
  margin-bottom: 0.75rem;
}

.condiciones p {
  opacity: 0.85;
  line-height: 1.6;
}
</style>
