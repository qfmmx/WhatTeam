<template>
  <div class="page">
    <div class="hero">
      <img src="../assets/supervisor-cover-banner-fit.png" alt="背景图">
    </div>

    <div class="title-box">
      <h1>东软环保公众监督平台</h1>
      <p>公众监督员端</p>
    </div>

    <div class="card">
      <div class="field">
        <i class="fa fa-user-o"></i>
        <input v-model="form.telId" maxlength="11" placeholder="输入手机号">
      </div>
      <div class="field">
        <i class="fa fa-lock"></i>
        <input v-model="form.password" type="password" placeholder="输入登录密码">
      </div>

      <div class="actions">
        <span class="register-link" @click="goRegister">注册</span>
      </div>

      <button class="primary-btn" @click="handleLogin">登录</button>
    </div>

    <MessageDialog :visible="dialogVisible" :message="dialogMessage" @close="dialogVisible = false" />
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import { useRouter } from 'vue-router';
import { setSessionStorage } from '../common';
import { supervisorApi } from '../api';
import MessageDialog from '../components/MessageDialog.vue';
import { validateLoginForm } from '../utils/supervisorValidation';

const router = useRouter();

const form = reactive({
  telId: '',
  password: ''
});
const dialogVisible = ref(false);
const dialogMessage = ref('');

const showDialog = (message) => {
  dialogMessage.value = message;
  dialogVisible.value = true;
};

const goRegister = () => {
  router.push('/register');
};

const handleLogin = async () => {
  const validationMessage = validateLoginForm(form);
  if (validationMessage) {
    showDialog(validationMessage);
    return;
  }

  try {
    const response = await supervisorApi.login(form.telId, form.password);
    if (response.data.code === 200) {
      setSessionStorage('supervisor', response.data.data);
      router.replace('/grid');
      return;
    }
    showDialog(response.data.message || '登录失败');
  } catch (error) {
    console.error('公众监督员登录失败:', error);
    showDialog(error.response?.data?.message || '登录失败，请稍后重试');
  }
};
</script>

<style scoped>
.page {
  height: 100%;
  background: #d7ecef;
  display: flex;
  flex-direction: column;
}

.hero {
  height: 230px;
  padding: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.hero img {
  width: 100%;
  height: 100%;
  display: block;
  object-fit: cover;
}

.title-box {
  text-align: center;
  margin: 10px 0 18px;
  color: #2d7c63;
}

.title-box h1 {
  font-size: 28px;
  margin-bottom: 6px;
}

.title-box p {
  font-size: 16px;
  color: #74a695;
}

.card {
  margin: 0 28px;
  background: #fff;
  border-radius: 14px;
  padding: 22px 18px 24px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
}

.field {
  height: 48px;
  border: 1px solid #e6e6e6;
  border-radius: 8px;
  display: flex;
  align-items: center;
  padding: 0 14px;
  margin-bottom: 16px;
  background: #fafafa;
}

.field i {
  width: 18px;
  color: #c1c1c1;
  margin-right: 10px;
}

.field input {
  flex: 1;
  border: none;
  background: transparent;
  outline: none;
  font-size: 15px;
}

.actions {
  display: flex;
  justify-content: space-between;
  font-size: 14px;
  color: #5f9db0;
  margin: 6px 0 18px;
}

.register-link {
  cursor: pointer;
}

.primary-btn {
  width: 100%;
  height: 50px;
  border: none;
  border-radius: 8px;
  background: #79b7c6;
  color: #fff;
  font-size: 24px;
  letter-spacing: 4px;
  cursor: pointer;
}
</style>
