<script setup lang="ts">
import Header from '@/components/Header.vue'
import Footer from '@/components/Footer.vue'
</script>

<template>
  <div class="app">
    <Header />

    <main class="contenido">
      <router-view />
    </main>

    <Footer />
  </div>
</template>

<style>
.app {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.contenido {
  flex: 1;
}
</style>
