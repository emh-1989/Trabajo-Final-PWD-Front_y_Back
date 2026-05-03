<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { Icon } from '@iconify/vue'
import { useAuthStore } from '@/stores/useAuthStore'
import EstadoCarga from '@/components/EstadoCarga.vue'

const router = useRouter()
const auth = useAuthStore()

const email = ref('')
const password = ref('')
const showPass = ref(false)

const login = async () => {
  await auth.login(email.value, password.value)
  // si salió bien, auth redirige automáticamente a '/'
  // si hubo error, se muestra en auth.mensajeError y se puede mostrar en el template
}

const loginGoogle = () => console.log('Login con Google')
const loginGithub = () => console.log('Login con GitHub')
</script>

<template>
  <div class="login">
    <!-- Estado de carga global o error inesperado (opcional, pero se puede usar EstadoCarga si el login demora mucho) -->
    <EstadoCarga
      v-if="auth.estado === 'cargando' && !email && !password"
      :estado="auth.estado"
      recurso="sesión"
    />

    <!-- FORM principal -->
    <div class="form-container" v-else>
      <div class="form-box">
        <h2>Iniciar sesión</h2>

        <!-- ERROR desde el store -->
        <p v-if="auth.error" class="error">{{ auth.mensajeError }}</p>

        <!-- EMAIL -->
        <div class="campo">
          <label>Email</label>
          <input v-model="email" type="email" placeholder="correo@ejemplo.com" />
        </div>

        <!-- PASSWORD -->
        <div class="campo">
          <label>Password</label>
          <div class="password-box">
            <input
              :type="showPass ? 'text' : 'password'"
              v-model="password"
              class="input-password"
              placeholder="••••••••"
            />
            <button type="button" class="eye" @click="showPass = !showPass">
              <Icon :icon="showPass ? 'mdi:eye-off-outline' : 'mdi:eye-outline'" />
            </button>
          </div>
        </div>

        <!-- BOTÓN -->
        <button class="btn" @click="login" :disabled="auth.estado === 'cargando'">
          <span v-if="auth.estado === 'cargando'" class="spinner"></span>
          <span v-else>Ingresar</span>
        </button>

        <!-- DIVIDER -->
        <div class="divider"><span>o continuar con</span></div>

        <!-- OAUTH -->
        <div class="socials">
          <button class="btn-social google" @click="loginGoogle">
            <Icon icon="mdi:google" /> Google
          </button>
          <button class="btn-social github" @click="loginGithub">
            <Icon icon="mdi:github" /> GitHub
          </button>
        </div>

        <!-- REGISTER -->
        <p class="switch">
          ¿No tenés cuenta?
          <span @click="router.push('/register')">Registrate</span>
        </p>
      </div>
    </div>

    <!-- IMAGEN -->
    <div class="image-container">
      <img src="/imagenes/login.jpg" alt="Login" />
      <div class="overlay"></div>
    </div>
  </div>
</template>

<style scoped>
.login {
  display: flex;
  min-height: 100vh;
  background: #111111;
  color: white;
}

.form-container {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
}

.form-box {
  width: 320px;
  animation: fade 0.5s ease;
}

@keyframes fade {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.campo {
  margin-bottom: 1rem;
}

input {
  width: 100%;
  padding: 0.6rem;
  border-radius: 6px;
  border: 1px solid rgba(124, 211, 227, 0.2);
  background: #1a1a1a;
  color: white;
  outline: none;
}

input:focus {
  border-color: #7cd3e3;
}

.password-box {
  position: relative;
  display: flex;
  align-items: center;
}

.input-password {
  padding-right: 2.5rem;
}

.eye {
  position: absolute;
  right: 8px;
  top: 50%;
  transform: translateY(-50%);
  background: transparent;
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  color: white;
  opacity: 0.7;
  transition: 0.2s;
}

.eye:hover {
  opacity: 1;
  transform: translateY(-50%) scale(1.1);
}

.btn {
  width: 100%;
  padding: 0.7rem;
  border: none;
  border-radius: 8px;
  background: #df243c;
  color: white;
  font-weight: 600;
  cursor: pointer;
  margin-top: 0.5rem;
  transition: 0.2s;
}

.btn:hover {
  background: #b81d30;
}
.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.spinner {
  width: 18px;
  height: 18px;
  border: 2px solid white;
  border-top: 2px solid transparent;
  border-radius: 50%;
  display: inline-block;
  animation: spin 0.6s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.divider {
  text-align: center;
  margin: 1rem 0;
  opacity: 0.5;
  font-size: 0.85rem;
}

.socials {
  display: flex;
  gap: 0.5rem;
}

.btn-social {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.4rem;
  padding: 0.6rem;
  border-radius: 8px;
  cursor: pointer;
  border: none;
  font-size: 0.9rem;
  transition: 0.2s;
}

.google {
  background: white;
  color: black;
}

.github {
  background: #222;
  color: white;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.switch {
  margin-top: 1rem;
  font-size: 0.85rem;
  opacity: 0.8;
}

.switch span {
  color: #7cd3e3;
  cursor: pointer;
  font-weight: 600;
}

.error {
  color: #ff4d4d;
  margin-bottom: 0.5rem;
  font-size: 0.85rem;
}

.image-container {
  flex: 1;
  position: relative;
}

.image-container img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.3);
}

@media (max-width: 900px) {
  .image-container {
    display: none;
  }
}
</style>
