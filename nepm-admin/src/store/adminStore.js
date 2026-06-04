import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useAdminStore = defineStore('admin', () => {
  const adminInfo = ref(JSON.parse(sessionStorage.getItem('adminInfo') || 'null'))

  function setAdmin(info) {
    adminInfo.value = info
    sessionStorage.setItem('adminInfo', JSON.stringify(info))
  }

  function clearAdmin() {
    adminInfo.value = null
    sessionStorage.removeItem('adminInfo')
  }

  return { adminInfo, setAdmin, clearAdmin }
})
