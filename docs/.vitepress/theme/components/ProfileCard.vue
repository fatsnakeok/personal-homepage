<script setup lang="ts">
defineProps<{
  name: string
  bio: string
  avatar: string
}>()
</script>

<template>
  <div class="profile-card">
    <div class="avatar-wrapper">
      <img
        v-if="avatar"
        :src="avatar"
        :alt="name"
        class="avatar-img"
      />
      <div v-else class="avatar-placeholder">
        <span class="avatar-icon">{{ name.charAt(0) }}</span>
      </div>
    </div>
    <h2 class="profile-name">{{ name }}</h2>
    <p class="profile-bio">{{ bio }}</p>
  </div>
</template>

<style scoped>
.profile-card {
  text-align: center;
  padding: 28px 24px;
  background: var(--color-card);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-sm);
  border: 1px solid var(--color-border);
  transition: all var(--transition-normal);
}

.profile-card:hover {
  box-shadow: var(--shadow-md);
  transform: translateY(-2px);
}

.avatar-wrapper {
  position: relative;
  width: 96px;
  height: 96px;
  margin: 0 auto 16px;
}

.avatar-wrapper::before {
  content: '';
  position: absolute;
  top: -4px;
  left: -4px;
  right: -4px;
  bottom: -4px;
  border: 2px solid var(--color-primary);
  border-radius: 50%;
  opacity: 0.4;
}

.avatar-img {
  width: 96px;
  height: 96px;
  border-radius: 50%;
  object-fit: cover;
  border: 3px solid white;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.avatar-placeholder {
  width: 96px;
  height: 96px;
  border-radius: 50%;
  background: linear-gradient(135deg, var(--color-primary) 0%, #6366F1 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto;
  border: 3px solid white;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.avatar-icon {
  font-size: 36px;
  color: white;
  font-weight: 600;
  font-family: var(--font-display);
}

.profile-name {
  font-family: var(--font-display);
  font-size: 1.25rem;
  font-weight: 600;
  margin: 0 0 8px 0;
  color: var(--color-text);
}

.profile-bio {
  font-size: 0.9rem;
  color: var(--color-text-secondary);
  margin: 0;
  line-height: 1.6;
}
</style>
