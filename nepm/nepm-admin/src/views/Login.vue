<script setup>
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { useAdminStore } from '@/store/adminStore'
import { login } from '@/api/admins'
import { ElMessage } from 'element-plus'

const router = useRouter()
const adminStore = useAdminStore()
const loading = ref(false)

const form = reactive({ adminCode: '', password: '' })
const formRef = ref()

const rules = {
  adminCode: [{ required: true, message: '请输入登录编码', trigger: 'blur' }],
  password: [{ required: true, message: '请输入登录密码', trigger: 'blur' }]
}

async function handleLogin() {
  await formRef.value.validate()
  loading.value = true
  try {
    const res = await login(form)
    adminStore.setAdmin(res.data)
    router.push('/')
  } catch {
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="login-page">
    <div class="login-card">
      <div class="login-header">
        <h2>东软环保公众监督平台管理系统</h2>
      </div>
      <div class="login-body">
        <el-form ref="formRef" :model="form" :rules="rules" label-width="90px" @keyup.enter="handleLogin">
          <el-form-item label="登录编码" prop="adminCode">
            <el-input v-model="form.adminCode" placeholder="请输入管理员编码" clearable />
          </el-form-item>
          <el-form-item label="登录密码" prop="password">
            <el-input v-model="form.password" type="password" placeholder="请输入登录密码" show-password clearable />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" :loading="loading" class="login-btn" @click="handleLogin">
              登 录
            </el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>
  </div>
</template>

<style scoped>
.login-page {
  width: 100%;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #667eea 0%, #4a90d9 100%);
}

.login-card {
  width: 480px;
  background: #fff;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
}

.login-header {
  background: #4a90d9;
  padding: 20px 30px;
}

.login-header h2 {
  color: #fff;
  font-size: 18px;
  font-weight: 500;
  margin: 0;
  text-align: center;
}

.login-body {
  padding: 40px 50px 40px;
}

.login-btn {
  width: 100%;
  height: 44px;
  font-size: 16px;
  margin-top: 8px;
}
</style>
