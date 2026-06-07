import { createRouter, createWebHashHistory } from 'vue-router'
import SupervisorLogin from '../views/SupervisorLogin.vue'
import SupervisorRegister from '../views/SupervisorRegister.vue'
import SupervisorGridSelect from '../views/SupervisorGridSelect.vue'
import SupervisorAqiFeedback from '../views/SupervisorAqiFeedback.vue'
import SupervisorHistory from '../views/SupervisorHistory.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: SupervisorLogin
  }, {
    path: '/login',
    name: 'SupervisorLogin',
    component: SupervisorLogin
  }, {
    path: '/register',
    name: 'SupervisorRegister',
    component: SupervisorRegister
  }, {
    path: '/grid',
    name: 'SupervisorGridSelect',
    component: SupervisorGridSelect
  }, {
    path: '/aqi',
    name: 'SupervisorAqiFeedback',
    component: SupervisorAqiFeedback
  }, {
    path: '/history',
    name: 'SupervisorHistory',
    component: SupervisorHistory
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
