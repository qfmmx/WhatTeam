<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getStatisticsById } from '@/api/statistics'

const route = useRoute()
const router = useRouter()
const detail = ref(null)
const loading = ref(false)

onMounted(async () => {
  loading.value = true
  try {
    const res = await getStatisticsById(route.params.id)
    detail.value = res.data
  } catch {
  } finally {
    loading.value = false
  }
})

function getLevelInfo(aqiValue) {
  if (!aqiValue && aqiValue !== 0) return { level: '-', name: '-' }
  if (aqiValue <= 50) return { level: 1, name: '优' }
  if (aqiValue <= 100) return { level: 2, name: '良' }
  if (aqiValue <= 150) return { level: 3, name: '轻度污染' }
  if (aqiValue <= 200) return { level: 4, name: '中度污染' }
  if (aqiValue <= 300) return { level: 5, name: '重度污染' }
  return { level: 6, name: '严重污染' }
}
</script>

<template>
  <div class="page-container" v-loading="loading">
    <div class="breadcrumb">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item>公众监督数据管理</el-breadcrumb-item>
        <el-breadcrumb-item>确认AQI数据详情</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="detail-card" v-if="detail">
      <div class="card-header">
        <h3>公众监督数据详情</h3>
        <el-button type="primary" @click="router.back()">返回</el-button>
      </div>

      <div class="detail-body">
        <div class="detail-row">
          <label>确认AQI数据编号</label>
          <span>{{ detail.id }}</span>
        </div>
        <div class="detail-row">
          <label>确认信息所在地址</label>
          <el-tag type="info" size="small">{{ detail.cityCode }}</el-tag>
        </div>
        <div class="detail-row">
          <label>确认AQI等级</label>
          <el-tag size="small">{{ getLevelInfo(detail.aqiValue).level }}级</el-tag>
          <el-tag size="small" type="danger" style="margin-left:6px">{{ getLevelInfo(detail.aqiValue).name }}</el-tag>
        </div>
        <div class="detail-row">
          <label>AQI值</label>
          <span>{{ detail.aqiValue }}</span>
        </div>
        <div class="detail-row">
          <label>确认日期时间</label>
          <el-tag type="info" size="small">{{ detail.confirmTime?.split(' ')[0] }}</el-tag>
          <el-tag type="info" size="small" style="margin-left:6px">{{ detail.confirmTime?.split(' ')[1] }}</el-tag>
        </div>
        <div class="detail-row">
          <label>网格员信息</label>
          <el-tag type="success" size="small">{{ detail.gmId }}</el-tag>
        </div>
        <div class="detail-row">
          <label>是否超标</label>
          <el-tag :type="detail.isExceed ? 'danger' : 'success'" size="small">
            {{ detail.isExceed ? '是（AQI > 100）' : '否' }}
          </el-tag>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.page-container { padding: 0; }
.breadcrumb { margin-bottom: 12px; }

.detail-card {
  background: #fff;
  border-radius: 6px;
  padding: 20px 24px;
  box-shadow: 0 1px 4px rgba(0,0,0,0.06);
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.card-header h3 {
  font-size: 16px;
  font-weight: 600;
  color: #333;
  margin: 0;
}

.detail-body { max-width: 700px; }

.detail-row {
  display: flex;
  align-items: center;
  padding: 12px 0;
  border-bottom: 1px solid #f0f0f0;
  font-size: 14px;
}

.detail-row label {
  width: 160px;
  color: #666;
  flex-shrink: 0;
}
</style>
