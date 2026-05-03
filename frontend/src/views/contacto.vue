<script setup lang="ts">
import { useRouter } from 'vue-router'

const router = useRouter()
const irA = (ruta: string) => router.push(ruta)
</script>

<template>
  <div class="contacto">
    <h1>Contáctanos</h1>
    <p>
      Si tienes alguna pregunta, sugerencia o necesitas asistencia, no dudes en contactarnos.
      Estamos aquí para ayudarte a planificar tu próxima aventura.
    </p>

    <h2>Información de Contacto</h2>
    <ul>
      <li><strong>Email:</strong> contacto@adventure.com</li>
      <li><strong>Teléfono:</strong> +54 02920 15123456</li>
      <li><strong>Dirección:</strong> J B Cabral 185, Viedma, Rio Negro, Argentina</li>
    </ul>
  </div>
</template>

<style scoped>
.contacto {
  background: #111111;
  color: white;
  min-height: 100vh;
  padding: 3rem 2rem;
  max-width: 800px;
  margin: 0 auto;
}

.contacto h1 {
  color: #7cd3e3;
  margin-bottom: 1rem;
  border-bottom: 2px solid #7cd3e3;
  padding-bottom: 0.5rem;
}

.contacto h2 {
  color: #df243c;
  margin-top: 2rem;
  margin-bottom: 0.75rem;
}

.contacto p {
  opacity: 0.85;
  line-height: 1.6;
}

.contacto ul {
  list-style: none;
  padding: 0;
  margin-top: 0.5rem;
}

.contacto li {
  padding: 0.5rem 0;
  border-bottom: 1px solid rgba(255, 255, 255, 0.07);
  opacity: 0.85;
}
</style>
