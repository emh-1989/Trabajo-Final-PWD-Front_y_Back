<script setup lang="ts">
defineProps<{
  titulo: string
  fecha: string
  precio: string
  imagen: string
}>()
</script>

<template>
  <div class="card">
    <div class="img-container">
      <img :src="imagen" />

      <!-- overlay -->
      <div class="overlay"></div>

      <!-- precio flotante -->
      <span class="precio">{{ precio }}</span>
    </div>

    <div class="info">
      <h3>{{ titulo }}</h3>
      <p>{{ fecha }}</p>
    </div>
  </div>
</template>

<style scoped>
.card {
  border-radius: 14px;
  overflow: hidden;
  cursor: pointer;
  transition: 0.3s;
}

/* IMAGEN */
.img-container {
  position: relative;
  height: 180px;
}

.img-container img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: 0.4s;
}

/* OVERLAY OSCURO */
.overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(to top, rgba(0, 0, 0, 0.6), transparent);
}

/* PRECIO */
.precio {
  position: absolute;
  bottom: 10px;
  right: 10px;
  background: rgba(0, 0, 0, 0.6);
  padding: 0.3rem 0.6rem;
  border-radius: 6px;
  font-size: 0.8rem;
  color: #7cd3e3;
}

/* INFO */
.info {
  padding: 0.9rem;
  background: #1a1a1a;
}

.info h3 {
  color: white;
  margin-bottom: 0.2rem;
}

.info p {
  font-size: 0.8rem;
  opacity: 0.7;
}

/* HOVER PRO */
.card:hover {
  transform: translateY(-6px) scale(1.02);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.6);
}

.card:hover img {
  transform: scale(1.1);
}
</style>
