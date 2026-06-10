<script setup lang="ts">
defineProps<{
  text: string
}>()
</script>

<template>
  <div class="motto-container">
    <div class="motto-decoration">
      <span class="quote-mark">"</span>
    </div>
    <p class="motto-text">{{ text }}</p>
    <div class="motto-divider"></div>
  </div>
</template>

<style scoped>
.motto-container {
  position: relative;
  padding: 24px 20px;
  background: var(--color-card);
  border-radius: var(--radius-md);
  border: 1px solid var(--color-border);
  transition: all var(--transition-normal);
}

.motto-container:hover {
  border-color: var(--color-accent-light);
  box-shadow: var(--shadow-sm);
}

.motto-decoration {
  position: absolute;
  top: -8px;
  left: 20px;
  width: 36px;
  height: 36px;
  background: var(--color-accent-light);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.quote-mark {
  font-family: var(--font-display);
  font-size: 24px;
  font-weight: 700;
  color: var(--color-accent);
  line-height: 1;
}

.motto-text {
  font-family: var(--font-display);
  font-size: 0.95rem;
  line-height: 1.8;
  color: var(--color-text);
  margin: 0 0 16px 0;
  padding-top: 8px;
}

.motto-divider {
  height: 2px;
  background: linear-gradient(90deg, var(--color-accent-light), transparent);
  border-radius: 2px;
}
</style>
