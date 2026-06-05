<template>
  <div class="login-container">
    <div class="header-bg">
      <img src="../assets/网格员背景图.png" alt="背景图">
    </div>
    
    <div class="login-box">
      <h1 class="title">东软环保公众监督平台-网格员端</h1>
      
      <div class="form-item">
        <label class="label">编码</label>
        <div class="input-box">
          <i class="fa fa-user"></i>
          <input type="text" v-model="loginForm.username" placeholder="请输入编码">
        </div>
      </div>
      
      <div class="form-item">
        <label class="label">密码</label>
        <div class="input-box">
          <i class="fa fa-lock"></i>
          <input :type="showPwd ? 'text' : 'password'" v-model="loginForm.password" placeholder="请输入密码">
        </div>
      </div>
      
      <button class="login-btn" @click="handleLogin">登录</button>
      
      <div class="checkbox-box">
        <input type="checkbox" id="agreement" v-model="agreed">
        <label for="agreement">我已阅读用户协议和隐私政策并理解相关条款内容</label>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, inject } from 'vue';
import { useRouter } from 'vue-router';
import { setSessionStorage } from '../common';
import { gridMemberApi } from '../api/index';

const router = useRouter();

const loginForm = reactive({
  username: '',
  password: ''
});

const agreed = ref(false);
const showPwd = ref(false);

const togglePwd = () => {
  showPwd.value = !showPwd.value;
};

const handleLogin = async () => {
  if (!loginForm.username || !loginForm.password) {
    alert('请输入账号和密码');
    return;
  }
  if (!agreed.value) {
    alert('请先阅读并同意用户协议和隐私政策');
    return;
  }
  
  try {
    const response = await gridMemberApi.login(loginForm.username, loginForm.password);
    
    if (response.data.code === 200) {
      setSessionStorage('gridMember', response.data.data);
      router.push('/feedbackList');
    } else {
      alert(response.data.message || '登录失败');
    }
  } catch (error) {
    console.error('登录失败:', error);
    alert('登录失败，请检查网络连接');
  }
};
</script>

<style scoped>
.login-container {
  width: 100%;
  height: 812px;
  background: #fff;
  padding-bottom: 50px;
  overflow-y: auto;
}

.header-bg {
  width: 100%;
  height: 190px;
  overflow: hidden;
  background: #e8f5e9;
}

.header-bg img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.login-box {
  padding: 0 22px;
}

.title {
  font-size: 22px;
  color: #227B60;
  font-weight: bold;
  text-align: center;
  margin: 30px 0;
  white-space: nowrap;
}

.form-item {
  margin-bottom: 19px;
}

.label {
  font-size: 17px;
  color: #555;
  margin-bottom: 8px;
  display: block;
}

.input-box {
  width: 100%;
  height: 45px;
  background: #f5f5f5;
  border-radius: 10px;
  display: flex;
  align-items: center;
  padding: 0 11px;
  box-sizing: border-box;
  border: 1px solid #ddd;
}

.input-box i {
  font-size: 18px;
  color: #666;
  margin-right: 11px;
  width: 20px;
  text-align: center;
  flex-shrink: 0;
  z-index: 1;
}

.input-box input {
  flex: 1;
  height: 100%;
  border: none;
  background: transparent;
  font-size: 17px;
  color: #333;
  outline: none;
  z-index: 2;
  padding-left: 5px;
}

.login-btn {
  width: 100%;
  height: 49px;
  background: linear-gradient(90deg, #2e7d32 0%, #4caf50 100%);
  color: #fff;
  font-size: 18px;
  border: none;
  border-radius: 10px;
  margin-top: 22px;
  cursor: pointer;
}

.login-btn:active {
  opacity: 0.8;
}

.checkbox-box {
  display: flex;
  align-items: center;
  margin-top: 19px;
}

.checkbox-box input[type="checkbox"] {
  width: 17px;
  height: 17px;
  margin-right: 8px;
}

.checkbox-box label {
  font-size: 13px;
  color: #666;
  cursor: pointer;
}
</style>
