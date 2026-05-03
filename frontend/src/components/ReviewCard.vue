<script setup lang="ts">
defineProps<{
  texto: string
  autor: string
  estrellas: number
}>()
</script>

<template>
  <div class="review">
    <p class="texto">"{{ texto }}"</p>

    <div class="bottom">
      <span class="autor">{{ autor }}</span>

      <span class="stars">
        {{ '⭐'.repeat(estrellas) }}
      </span>
    </div>
  </div>
</template>

<style scoped>
.review {
  padding: 1.2rem;
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(124, 211, 227, 0.12);
  color: white;
  transition: 0.3s;
}

/* TEXTO */
.texto {
  font-size: 0.9rem;
  line-height: 1.4;
}

/* FOOTER */
.bottom {
  display: flex;
  justify-content: space-between;
  margin-top: 1rem;
  font-size: 0.85rem;
}

.autor {
  opacity: 0.7;
}

.stars {
  color: #7cd3e3;
}

/* HOVER */
.review:hover {
  transform: translateY(-4px);
  box-shadow: 0 0 12px rgba(124, 211, 227, 0.3);
}
</style>
