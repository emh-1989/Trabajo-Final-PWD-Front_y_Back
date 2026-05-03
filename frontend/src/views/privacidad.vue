<script setup lang="ts">
import { useRouter } from 'vue-router'

const router = useRouter()
const irA = (ruta: string) => router.push(ruta)
</script>

<template>
  <!-- FIX: clase corregida de "contacto" a "privacidad" -->
  <div class="privacidad">
    <h1>Declaración de privacidad y de cookies</h1>
    <p>
      En Adventure, valoramos tu privacidad y nos comprometemos a proteger tus datos personales.
      Esta declaración de privacidad explica cómo recopilamos, usamos y protegemos tu información
      cuando utilizas nuestra plataforma.
    </p>

    <h2>Recopilación de información</h2>
    <p>
      Recopilamos información personal que nos proporcionas al registrarte, como tu nombre, correo
      electrónico y preferencias de viaje. También podemos recopilar información sobre tu uso de la
      plataforma, como las búsquedas realizadas y las reservas efectuadas.
    </p>

    <h2>Uso de la información</h2>
    <p>
      Utilizamos tu información para mejorar nuestros servicios, personalizar tu experiencia y
      enviarte ofertas relevantes. No compartimos tu información con terceros sin tu consentimiento,
      excepto cuando sea necesario para cumplir con la ley o proteger nuestros derechos.
    </p>

    <h2>Cookies</h2>
    <p>
      Utilizamos cookies para mejorar la funcionalidad de nuestro sitio web y analizar el tráfico.
      Puedes configurar tu navegador para rechazar las cookies, pero ten en cuenta que esto puede
      afectar tu experiencia en nuestra plataforma.
    </p>

    <h2>Seguridad</h2>
    <p>
      Implementamos medidas de seguridad para proteger tu información contra accesos no autorizados,
      alteraciones o destrucción. Sin embargo, ningún método de transmisión por Internet es
      completamente seguro.
    </p>

    <h2>Contacto</h2>
    <p>
      Si tenés alguna pregunta sobre esta declaración de privacidad, podés contactarnos a través de
      nuestro formulario de contacto.
    </p>
  </div>
</template>

<style scoped>
/* FIX: selector corregido de .contacto a .privacidad */
.privacidad {
  background: #111111;
  color: white;
  min-height: 100vh;
  padding: 3rem 2rem;
  max-width: 800px;
  margin: 0 auto;
}

.privacidad h1 {
  color: #7cd3e3;
  margin-bottom: 1rem;
  border-bottom: 2px solid #7cd3e3;
  padding-bottom: 0.5rem;
}

.privacidad h2 {
  color: #df243c;
  margin-top: 2rem;
  margin-bottom: 0.75rem;
}

.privacidad p {
  opacity: 0.85;
  line-height: 1.6;
}
</style>
