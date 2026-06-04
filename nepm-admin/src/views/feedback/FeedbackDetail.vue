<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getAqiFeedbackById, assignAqiFeedback } from '@/api/aqiFeedback'
import { listAllProvinces } from '@/api/gridProvince'
import { listCitiesByProvince } from '@/api/gridCity'
import { listMembersByCity } from '@/api/gridMember'
import { ElMessage } from 'element-plus'

const route = useRoute()
const router = useRouter()
const detail = ref(null)
const loading = ref(false)
const assigning = ref(false)

const provinces = ref([])
const cities = ref([])
const members = ref([])
const isRemote = ref(false)

const assignForm = reactive({
  provinceId: '',
  cityId: '',
  gmId: ''
})

onMounted(async () => {
  await loadDetail()
  await loadProvinces()
})

async function loadDetail() {
  loading.value = true
  try {
    const res = await getAqiFeedbackById(route.params.id)
    detail.value = res.data
  } catch {
  } finally {
    loading.value = false
  }
}

async function loadProvinces() {
  try {
    const res = await listAllProvinces()
    provinces.value = res.data
  } catch {}
}

async function onProvinceChange(val) {
  assignForm.cityId = ''
  assignForm.gmId = ''
  cities.value = []
  members.value = []
  if (val) {
    try {
      const res = await listCitiesByProvince(val)
      cities.value = res.data
    } catch {}
  }
}

async function onCityChange(val) {
  assignForm.gmId = ''
  members.value = []
  if (val && assignForm.provinceId) {
    try {
      const res = await listMembersByCity(assignForm.provinceId, val)
      members.value = res.data
    } catch {}
  }
}

async function handleAssign() {
  if (!assignForm.gmId) {
    ElMessage.warning('请选择网格员')
    return
  }
  assigning.value = true
  try {
    await assignAqiFeedback({ id: detail.value.id, gmId: assignForm.gmId })
    ElMessage.success('指派成功')
    await loadDetail()
  } catch {
  } finally {
    assigning.value = false
  }
}

function getLevelInfo(aqiValue) {
  if (!aqiValue && aqiValue !== 0) return { name: '-', level: 0 }
  if (aqiValue <= 50) return { level: 1, name: '优' }
  if (aqiValue <= 100) return { level: 2, name: '良' }
  if (aqiValue <= 150) return { level: 3, name: '轻度污染' }
  if (aqiValue <= 200) return { level: 4, name: '中度污染' }
  if (aqiValue <= 300) return { level: 5, name: '重度污染' }
  return { level: 6, name: '严重污染' }
}

const stateMap = { 0: '待指派', 1: '已指派', 2: '已处理' }
</script>

<template>
  <div class="page-container" v-loading="loading">
    <div class="breadcrumb">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item>公众监督数据管理</el-breadcrumb-item>
        <el-breadcrumb-item>公众监督数据详情</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="detail-card" v-if="detail">
      <div class="card-header">
        <h3>公众监督数据详情</h3>
        <el-button type="primary" @click="router.back()">返回</el-button>
      </div>

      <div class="detail-body">
        <div class="detail-row">
          <label>公众监督反馈信息编号</label>
          <span>{{ detail.id }}</span>
        </div>
        <div class="detail-row">
          <label>反馈者联系电话</label>
          <span>{{ detail.telId }}</span>
        </div>
        <div class="detail-row">
          <label>反馈信息城市编码</label>
          <el-tag type="info" size="small">{{ detail.cityCode }}</el-tag>
        </div>
        <div class="detail-row">
          <label>观测AQI值</label>
          <span>{{ detail.aqiValue }}</span>
        </div>
        <div class="detail-row">
          <label>预估等级</label>
          <el-tag size="small">{{ getLevelInfo(detail.aqiValue).level }}级</el-tag>
          <el-tag size="small" type="danger" style="margin-left:6px">{{ getLevelInfo(detail.aqiValue).name }}</el-tag>
        </div>
        <div class="detail-row">
          <label>反馈信息描述</label>
          <span>{{ detail.remark || '暂无描述' }}</span>
        </div>
        <div class="detail-row">
          <label>反馈日期时间</label>
          <el-tag type="info" size="small">{{ detail.feedbackTime?.split(' ')[0] }}</el-tag>
          <el-tag type="info" size="small" style="margin-left:6px">{{ detail.feedbackTime?.split(' ')[1] }}</el-tag>
        </div>
        <div class="detail-row">
          <label>当前状态</label>
          <el-tag :type="detail.state === 0 ? 'warning' : detail.state === 1 ? 'primary' : 'success'" size="small">
            {{ stateMap[detail.state] }}
          </el-tag>
        </div>
        <div v-if="detail.gmId" class="detail-row">
          <label>已指派网格员</label>
          <el-tag type="success" size="small">{{ detail.gmName || `网格员ID: ${detail.gmId}` }}</el-tag>
          <span v-if="detail.assignTime" style="margin-left:10px;font-size:12px;color:#999">{{ detail.assignTime }}</span>
        </div>

        <el-divider v-if="detail.state === 0" content-position="left">
          <span class="divider-title">指派网格员</span>
        </el-divider>

        <template v-if="detail.state === 0">
          <div class="assign-bar">
            <el-switch v-model="isRemote" active-text="是否异地指派" />
            <template v-if="isRemote">
              <el-select v-model="assignForm.provinceId" placeholder="选择省份" style="width:140px" @change="onProvinceChange">
                <el-option v-for="p in provinces" :key="p.id" :label="p.provinceName" :value="p.id" />
              </el-select>
              <el-select v-model="assignForm.cityId" placeholder="选择城市" style="width:140px" :disabled="!assignForm.provinceId" @change="onCityChange">
                <el-option v-for="c in cities" :key="c.id" :label="c.cityName" :value="c.id" />
              </el-select>
            </template>
            <el-select v-model="assignForm.gmId" placeholder="选择网格员" style="width:160px" :disabled="isRemote && !assignForm.cityId">
              <el-option v-for="m in members" :key="m.id" :label="m.memberName" :value="m.id" />
            </el-select>
            <el-button type="primary" :loading="assigning" @click="handleAssign">确认指派</el-button>
          </div>
        </template>
      </div>
    </div>
  </div>
</template>

<style scoped>
.page-container {
  padding: 0;
}

.breadcrumb {
  margin-bottom: 12px;
}

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

.detail-body {
  max-width: 700px;
}

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

.detail-row span {
  color: #333;
}

.divider-title {
  font-size: 14px;
  color: #4a90d9;
  font-weight: 500;
}

.assign-bar {
  display: flex;
  align-items: center;
  gap: 12px;
  flex-wrap: wrap;
  padding: 16px 0;
}
</style>
