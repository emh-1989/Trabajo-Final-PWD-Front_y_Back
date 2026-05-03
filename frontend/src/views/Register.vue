<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { Icon } from '@iconify/vue'
import { useAuthStore } from '@/stores/useAuthStore'

const router = useRouter()
const auth = useAuthStore()

const nombre = ref('')
const email = ref('')
const password = ref('')
const confirmPassword = ref('')
const showPass = ref(false)
const showConfirm = ref(false)
const errorLocal = ref('')

const register = async () => {
  errorLocal.value = ''

  // Validación local antes de llamar al store
  if (password.value !== confirmPassword.value) {
    errorLocal.value = 'Las contraseñas no coinciden.'
    return
  }

  await auth.register(nombre.value, email.value, password.value)
  // si salió bien, auth redirige automáticamente a '/'
  // si hubo error del servidor, está en auth.mensajeError
}
</script>

<template>
  <div class="login">
    <!-- FORM -->
    <div class="form-container">
      <div class="form-box">
        <h2>Crear cuenta</h2>

        <!-- Error local (contraseñas no coinciden) -->
        <p v-if="errorLocal" class="error">{{ errorLocal }}</p>

        <!-- Error del store (email ya existe, etc.) -->
        <p v-else-if="auth.error" class="error">{{ auth.mensajeError }}</p>

        <!-- NOMBRE -->
        <div class="campo">
          <label>Nombre</label>
          <input v-model="nombre" placeholder="Tu nombre completo" />
        </div>

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
              placeholder="••••••••"
            />
            <span class="eye" @click="showPass = !showPass">
              <Icon :icon="showPass ? 'mdi:eye-off-outline' : 'mdi:eye-outline'" />
            </span>
          </div>
        </div>

        <!-- CONFIRMAR PASSWORD -->
        <div class="campo">
          <label>Confirmar Password</label>
          <div class="password-box">
            <input
              :type="showConfirm ? 'text' : 'password'"
              v-model="confirmPassword"
              placeholder="••••••••"
            />
            <span class="eye" @click="showConfirm = !showConfirm">
              <Icon :icon="showConfirm ? 'mdi:eye-off-outline' : 'mdi:eye-outline'" />
            </span>
          </div>
        </div>

        <!-- BOTÓN -->
        <button class="btn" @click="register" :disabled="auth.estado === 'cargando'">
          <span v-if="auth.estado === 'cargando'" class="spinner"></span>
          <span v-else>Registrarse</span>
        </button>

        <!-- SWITCH A LOGIN -->
        <p class="switch">
          ¿Ya tenés cuenta?
          <span @click="router.push('/login')">Iniciar sesión</span>
        </p>
      </div>
    </div>

    <!-- IMAGEN -->
    <div class="image-container">
      <img src="/imagenes/login.jpg" alt="Register" />
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
}

.eye {
  position: absolute;
  right: 10px;
  top: 50%;
  transform: translateY(-50%);
  cursor: pointer;
  color: white;
  opacity: 0.7;
}

.eye:hover {
  opacity: 1;
}

.btn {
  width: 100%;
  padding: 0.7rem;
  border-radius: 8px;
  background: #7cd3e3;
  color: #111111;
  font-weight: 600;
  border: none;
  cursor: pointer;
  margin-top: 0.5rem;
  transition: 0.2s;
}

.btn:hover {
  background: #5bbdce;
}
.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.spinner {
  width: 18px;
  height: 18px;
  border: 2px solid #111;
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
