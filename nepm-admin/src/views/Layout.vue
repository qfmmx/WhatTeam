<script setup>
import { ref, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useAdminStore } from '@/store/adminStore'
import { ElMessageBox } from 'element-plus'

const router = useRouter()
const route = useRoute()
const adminStore = useAdminStore()

const adminName = computed(() => adminStore.adminInfo?.adminName || 'administrator')
const activeMenu = computed(() => route.path)

async function handleLogout() {
  await ElMessageBox.confirm('确定要退出登录吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  })
  adminStore.clearAdmin()
  router.push('/login')
}
</script>

<template>
  <div class="layout">
    <header class="header">
      <div class="header-left">
        <el-icon class="logo-icon" :size="22"><DataAnalysis /></el-icon>
        <span class="system-title">东软环保公众监督平台管理系统</span>
      </div>
      <div class="header-right">
        <span class="admin-text">系统管理员：{{ adminName }}</span>
        <el-button type="danger" size="small" @click="handleLogout">OUT »</el-button>
      </div>
    </header>

    <div class="main-container">
      <aside class="sidebar">
        <el-menu
          :default-active="activeMenu"
          router
          background-color="#4a90d9"
          text-color="rgba(255,255,255,0.85)"
          active-text-color="#ffffff"
        >
          <el-sub-menu index="feedback">
            <template #title>
              <el-icon><Grid /></el-icon>
              <span>公众监督数据管理</span>
            </template>
            <el-menu-item index="/feedback">公众监督数据列表</el-menu-item>
            <el-menu-item index="/aqi/list">确认AQI数据列表</el-menu-item>
          </el-sub-menu>

          <el-sub-menu index="statistics">
            <template #title>
              <el-icon><DataAnalysis /></el-icon>
              <span>统计数据管理</span>
            </template>
            <el-menu-item index="/statistics/province">省分组检查统计</el-menu-item>
            <el-menu-item index="/statistics/distribution">AQI指数分布统计</el-menu-item>
            <el-menu-item index="/statistics/trend">AQI指数趋势统计</el-menu-item>
            <el-menu-item index="/statistics/other">其它数据统计</el-menu-item>
          </el-sub-menu>

          <el-sub-menu index="grid">
            <template #title>
              <el-icon><Location /></el-icon>
              <span>网格数据管理</span>
            </template>
          </el-sub-menu>
        </el-menu>
      </aside>

      <div class="content-wrapper">
        <main class="content">
          <router-view />
        </main>
        <footer class="footer">© 版权所有 东软睿道 www.neusoft.com</footer>
      </div>
    </div>
  </div>
</template>

<style scoped>
.layout {
  display: flex;
  flex-direction: column;
  height: 100vh;
}

.header {
  height: 52px;
  background: #4a90d9;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
  flex-shrink: 0;
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
}

.header-left {
  display: flex;
  align-items: center;
  gap: 10px;
  color: #fff;
}

.logo-icon {
  color: #fff;
}

.system-title {
  font-size: 18px;
  font-weight: 600;
  color: #fff;
  letter-spacing: 0.5px;
}

.header-right {
  display: flex;
  align-items: center;
  gap: 16px;
  color: #fff;
  font-size: 14px;
}

.admin-text {
  color: rgba(255,255,255,0.9);
}

.main-container {
  display: flex;
  flex: 1;
  overflow: hidden;
}

.sidebar {
  width: 190px;
  flex-shrink: 0;
  background: #4a90d9;
  overflow-y: auto;
}

.sidebar :deep(.el-menu) {
  border-right: none;
}

.sidebar :deep(.el-menu-item) {
  font-size: 13px;
  height: 40px;
  line-height: 40px;
  padding-left: 40px !important;
}

.sidebar :deep(.el-menu-item.is-active) {
  background-color: rgba(255,255,255,0.2) !important;
  font-weight: 600;
  color: #ffeb3b !important;
}

.sidebar :deep(.el-menu-item:hover) {
  background-color: rgba(255,255,255,0.15) !important;
}

.sidebar :deep(.el-sub-menu__title) {
  font-size: 14px;
  color: rgba(255,255,255,0.9) !important;
}

.sidebar :deep(.el-sub-menu__title:hover) {
  background-color: rgba(255,255,255,0.1) !important;
}

.content-wrapper {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.content {
  flex: 1;
  overflow-y: auto;
  padding: 16px;
  background: #f0f2f5;
}

.footer {
  height: 36px;
  background: #4a90d9;
  display: flex;
  align-items: center;
  justify-content: center;
  color: rgba(255,255,255,0.85);
  font-size: 12px;
  flex-shrink: 0;
}
</style>
