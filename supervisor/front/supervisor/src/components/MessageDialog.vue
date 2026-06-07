<template>
  <div v-if="visible" class="dialog-mask" @click.self="$emit('close')">
    <div class="dialog-card">
      <div class="dialog-title">{{ title }}</div>
      <div class="dialog-message">{{ message }}</div>
      <button class="dialog-btn" @click="$emit('close')">我知道了</button>
    </div>
  </div>
</template>

<script setup>
defineProps({
  visible: {
    type: Boolean,
    default: false
  },
  title: {
    type: String,
    default: '提示'
  },
  message: {
    type: String,
    default: ''
  }
});

defineEmits(['close']);
</script>

<style scoped>
.dialog-mask {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.35);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 999;
}

.dialog-card {
  width: calc(100% - 56px);
  max-width: 360px;
  background: #fff;
  border-radius: 14px;
  padding: 20px 18px 18px;
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.18);
  text-align: center;
}

.dialog-title {
  font-size: 18px;
  font-weight: bold;
  color: #2f5d6a;
}

.dialog-message {
  margin: 14px 0 20px;
  color: #4f4f4f;
  font-size: 15px;
  line-height: 1.6;
  white-space: pre-wrap;
}

.dialog-btn {
  width: 100%;
  height: 42px;
  border: none;
  border-radius: 8px;
  background: #79b7c6;
  color: #fff;
  font-size: 16px;
  cursor: pointer;
}
</style>
