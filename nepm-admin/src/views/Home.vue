<script setup>
import { useAdminStore } from '@/store/adminStore'

const adminStore = useAdminStore()
const adminName = adminStore.adminInfo?.adminName || 'administrator'
</script>

<template>
  <div class="home">
    <div class="welcome-card">
      <div class="welcome-illustration">
        <svg width="400" height="200" viewBox="0 0 400 200" xmlns="http://www.w3.org/2000/svg">
          <rect width="400" height="200" fill="#e8f4fd" rx="8"/>
          <!-- Ground -->
          <ellipse cx="200" cy="175" rx="180" ry="20" fill="#c8e6c9" opacity="0.6"/>
          <!-- Trees -->
          <g fill="#66bb6a">
            <ellipse cx="60" cy="150" rx="28" ry="35" />
            <ellipse cx="95" cy="145" rx="22" ry="28" />
            <ellipse cx="130" cy="150" rx="25" ry="32" />
            <ellipse cx="165" cy="145" rx="20" ry="26" />
            <ellipse cx="240" cy="148" rx="24" ry="30" />
            <ellipse cx="275" cy="145" rx="20" ry="25" />
            <ellipse cx="310" cy="150" rx="26" ry="33" />
            <ellipse cx="345" cy="145" rx="22" ry="28" />
          </g>
          <!-- Building -->
          <rect x="185" y="70" width="60" height="105" fill="#b0bec5" rx="2"/>
          <rect x="190" y="40" width="50" height="35" fill="#90a4ae" rx="2"/>
          <!-- Windows -->
          <g fill="#e3f2fd">
            <rect x="193" y="80" width="10" height="12" rx="1"/>
            <rect x="210" y="80" width="10" height="12" rx="1"/>
            <rect x="227" y="80" width="10" height="12" rx="1"/>
            <rect x="193" y="100" width="10" height="12" rx="1"/>
            <rect x="210" y="100" width="10" height="12" rx="1"/>
            <rect x="227" y="100" width="10" height="12" rx="1"/>
            <rect x="193" y="120" width="10" height="12" rx="1"/>
            <rect x="227" y="120" width="10" height="12" rx="1"/>
            <rect x="197" y="48" width="12" height="10" rx="1"/>
            <rect x="215" y="48" width="12" height="10" rx="1"/>
            <rect x="233" y="48" width="10" height="10" rx="1"/>
          </g>
          <!-- Door -->
          <rect x="205" y="145" width="20" height="30" fill="#78909c" rx="1"/>
          <!-- Clouds -->
          <g fill="white" opacity="0.8">
            <ellipse cx="80" cy="50" rx="30" ry="15"/>
            <ellipse cx="100" cy="45" rx="25" ry="12"/>
            <ellipse cx="300" cy="40" rx="35" ry="16"/>
            <ellipse cx="325" cy="35" rx="28" ry="13"/>
          </g>
        </svg>
      </div>
      <div class="welcome-text">
        <p>欢迎回来，<strong>{{ adminName }}</strong></p>
        <p class="sub-text">东软环保公众监督平台 - 守护蓝天绿水</p>
      </div>
    </div>
  </div>
</template>

<style scoped>
.home {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  min-height: 400px;
}

.welcome-card {
  background: #fff;
  border-radius: 8px;
  padding: 40px;
  text-align: center;
  box-shadow: 0 2px 12px rgba(0,0,0,0.08);
  max-width: 600px;
  width: 100%;
}

.welcome-illustration {
  margin-bottom: 24px;
}

.welcome-illustration svg {
  border-radius: 8px;
}

.welcome-text p {
  font-size: 18px;
  color: #555;
  margin-bottom: 8px;
}

.welcome-text strong {
  color: #4a90d9;
}

.sub-text {
  font-size: 14px !important;
  color: #999 !important;
}
</style>
