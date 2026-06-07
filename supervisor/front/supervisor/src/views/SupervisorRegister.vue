<template>
  <div class="page">
    <header class="header">
      <i class="fa fa-angle-left back" @click="goBack"></i>
      <span>注册</span>
      <span class="placeholder"></span>
    </header>

    <div class="hero">
      <img src="../assets/supervisor-cover-banner-fit.png" alt="背景图">
    </div>

    <div class="slogan">保护环境人人有责</div>

    <div class="form-box">
      <div class="row">
        <label>手机号码</label>
        <input v-model="form.telId" maxlength="11" placeholder="请输入手机号码">
      </div>
      <div class="row">
        <label>真实姓名</label>
        <input v-model="form.realName" placeholder="真实姓名便于我们联系您">
      </div>
      <div class="row">
        <label>年龄</label>
        <input v-model="form.age" placeholder="年龄">
      </div>
      <div class="row">
        <label>性别</label>
        <div class="radio-group">
          <label><input v-model="form.sex" :value="1" type="radio">男</label>
          <label><input v-model="form.sex" :value="0" type="radio">女</label>
        </div>
      </div>
      <div class="row">
        <label>密码</label>
        <input v-model="form.password" type="password" placeholder="请输入密码">
      </div>
      <div class="row">
        <label>确认密码</label>
        <input v-model="form.confirmPassword" type="password" placeholder="请再次输入密码">
      </div>
    </div>

    <button class="primary-btn" @click="handleRegister">注册</button>
    <MessageDialog :visible="dialogVisible" :message="dialogMessage" @close="dialogVisible = false" />
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import { useRouter } from 'vue-router';
import { supervisorApi } from '../api';
import MessageDialog from '../components/MessageDialog.vue';
import { validateRegisterForm } from '../utils/supervisorValidation';

const router = useRouter();

const form = reactive({
  telId: '',
  realName: '',
  age: '',
  sex: 1,
  password: '',
  confirmPassword: ''
});
const dialogVisible = ref(false);
const dialogMessage = ref('');

const showDialog = (message) => {
  dialogMessage.value = message;
  dialogVisible.value = true;
};

const goBack = () => {
  router.replace('/login');
};

const handleRegister = async () => {
  const validationMessage = validateRegisterForm(form);
  if (validationMessage) {
    showDialog(validationMessage);
    return;
  }

  try {
    const checkResponse = await supervisorApi.checkPhone(form.telId);
    if (checkResponse.data.code !== 200) {
      showDialog(checkResponse.data.message || '手机号已存在');
      return;
    }

    const response = await supervisorApi.register({
      phone: form.telId,
      password: form.password,
      realName: form.realName,
      age: Number(form.age),
      sex: form.sex
    });

    if (response.data.code === 200) {
      showDialog('注册成功，请登录');
      setTimeout(() => {
        dialogVisible.value = false;
        router.replace('/login');
      }, 600);
      return;
    }
    showDialog(response.data.message || '注册失败');
  } catch (error) {
    if (error.response?.data?.code === 409) {
      showDialog('手机号已注册');
      return;
    }
    console.error('注册失败:', error);
    showDialog(error.response?.data?.message || '注册失败，请稍后重试');
  }
};
</script>

<style scoped>
.page {
  height: 100%;
  background: #d7ecef;
  overflow-y: auto;
}

.header {
  height: 52px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 16px;
  background: #fff;
  font-size: 22px;
  color: #333;
}

.back,
.placeholder {
  width: 24px;
}

.back {
  font-size: 28px;
  cursor: pointer;
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

.slogan {
  text-align: center;
  color: #dc6a4f;
  font-size: 24px;
  font-weight: bold;
  margin: 10px 0 20px;
}

.form-box {
  padding: 0 22px;
}

.row {
  display: flex;
  align-items: center;
  margin-bottom: 18px;
}

.row label {
  width: 88px;
  color: #4b4b4b;
  font-size: 15px;
  font-weight: bold;
}

.row input {
  flex: 1;
  border: none;
  background: transparent;
  border-bottom: 1px solid rgba(0, 0, 0, 0.08);
  padding: 8px 0;
  outline: none;
  font-size: 15px;
}

.radio-group {
  flex: 1;
  display: flex;
  gap: 18px;
  color: #333;
}

.primary-btn {
  width: calc(100% - 44px);
  margin: 26px 22px 30px;
  height: 48px;
  border: none;
  border-radius: 8px;
  background: #79b7c6;
  color: #fff;
  font-size: 24px;
  cursor: pointer;
}
</style>
