<script setup lang="ts">
defineProps<{
  titulo: string
  descripcion: string
  imagen: string
}>()
</script>

<template>
  <div class="card">
    <div class="img-container">
      <img :src="imagen" />
      <div class="overlay"></div>
    </div>

    <div class="info">
      <h3>{{ titulo }}</h3>
      <p class="descripcion">{{ descripcion }}</p>
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

.img-container {
  position: relative;
  width: 100%;
  height: 180px;
  overflow: hidden;
  transition: height 0.4s ease;
}

.img-container img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center;
  transition: 0.4s;
}

.card:hover .img-container {
  height: 320px;
}

.overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(to top, rgba(0, 0, 0, 0.6), transparent);
}

.info {
  padding: 0.9rem;
  background: #1a1a1a;
}

.info h3 {
  color: #7cd3e3;
  margin-bottom: 0.2rem;
}

.descripcion {
  font-size: 0.8rem;
  opacity: 0.7;
  margin-top: 0.3rem;
}

.card:hover {
  transform: translateY(-6px) scale(1.02);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.6);
}

.card:hover img {
  transform: scale(1.1);
}
</style>
