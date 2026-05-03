<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { useRouter } from 'vue-router'

const router = useRouter()

const irA = (ruta: string) => router.push(ruta)
</script>

<template>
  <footer class="footer">
    <div class="footer-links">
      <span @click="irA('/condiciones_de_uso')">Condiciones de uso</span>
      <span @click="irA('/privacidad')">Declaración de privacidad y de cookies</span>
      <span @click="irA('/contacto')">Contáctanos</span>
    </div>
    <div class="footer-redes">
      <div class="iconos-redes">
        <Icon icon="mdi:facebook" />
        <Icon icon="ri:twitter-x-fill" />
        <Icon icon="mdi:instagram" />
        <Icon icon="ic:baseline-tiktok" />
        <Icon icon="mdi:youtube" />
      </div>
    </div>
    <p class="footer-copy">
      © 2026 Trabajo Final PWD — Emmanuel Hidalgo. Todos los derechos reservados.
    </p>
  </footer>
</template>

<style scoped>
.footer {
  background: #111111;
  border-top: 3px solid transparent;
  border-image: linear-gradient(to right, #df243c, #7cd3e3) 1;
  color: white;
  padding: 0.75rem 2rem;
  text-align: center;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.footer-links {
  display: flex;
  justify-content: center;
  gap: 2rem;
  flex-wrap: wrap;
  font-size: 0.85rem;
}

.footer-links span {
  cursor: pointer;
  opacity: 0.7;
  transition: 0.2s;
}

.footer-links span:hover {
  opacity: 1;
  color: #7cd3e3;
}

.footer-redes {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.4rem;
}

.iconos-redes {
  display: flex;
  gap: 1rem;
  font-size: 1.5rem;
}

.iconos-redes svg {
  cursor: pointer;
  opacity: 0.7;
  transition: 0.2s;
}

.iconos-redes svg:hover {
  opacity: 1;
  transform: scale(1.2);
  color: #7cd3e3;
}

.footer-copy {
  font-size: 0.75rem;
  opacity: 0.4;
}
</style>
