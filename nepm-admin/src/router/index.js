import { createRouter, createWebHistory } from 'vue-router'
import { useAdminStore } from '@/store/adminStore'

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/Login.vue')
  },
  {
    path: '/',
    component: () => import('@/views/Layout.vue'),
    redirect: '/home',
    meta: { requiresAuth: true },
    children: [
      {
        path: 'home',
        name: 'Home',
        component: () => import('@/views/Home.vue')
      },
      {
        path: 'feedback/list',
        name: 'FeedbackList',
        component: () => import('@/views/feedback/FeedbackList.vue')
      },
      {
        path: 'feedback/detail/:id',
        name: 'FeedbackDetail',
        component: () => import('@/views/feedback/FeedbackDetail.vue')
      },
      {
        path: 'aqi/list',
        name: 'AqiList',
        component: () => import('@/views/aqi/AqiList.vue')
      },
      {
        path: 'aqi/detail/:id',
        name: 'AqiDetail',
        component: () => import('@/views/aqi/AqiDetail.vue')
      },
      {
        path: 'statistics/province',
        name: 'ProvinceStats',
        component: () => import('@/views/statistics/ProvinceStats.vue')
      },
      {
        path: 'statistics/distribution',
        name: 'AqiDistribution',
        component: () => import('@/views/statistics/AqiDistribution.vue')
      },
      {
        path: 'statistics/trend',
        name: 'AqiTrend',
        component: () => import('@/views/statistics/AqiTrend.vue')
      },
      {
        path: 'statistics/other',
        name: 'OtherStats',
        component: () => import('@/views/statistics/OtherStats.vue')
      }
    ]
  },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  if (to.meta.requiresAuth) {
    const store = useAdminStore()
    if (!store.adminInfo) {
      next('/login')
      return
    }
  }
  next()
})

export default router
