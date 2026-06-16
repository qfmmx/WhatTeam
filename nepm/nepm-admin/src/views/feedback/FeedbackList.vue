<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { pageAqiFeedback } from '@/api/aqiFeedback'
import { listAllProvinces } from '@/api/gridProvince'
import { listCitiesByProvince } from '@/api/gridCity'

const router = useRouter()

const tableData = ref([])
const loading = ref(false)
const total = ref(0)

const query = reactive({
  pageNum: 1,
  pageSize: 10,
  state: 0,
  provinceId: '',
  cityId: '',
  startTime: '',
  endTime: ''
})

const dateRange = ref([])
const provinces = ref([])
const cities = ref([])
const activeTab = ref('0')

onMounted(() => {
  loadProvinces()
  loadData()
})

async function loadProvinces() {
  try {
    const res = await listAllProvinces()
    provinces.value = res.data
  } catch {}
}

async function onProvinceChange(val) {
  query.cityId = ''
  cities.value = []
  if (val) {
    try {
      const res = await listCitiesByProvince(val)
      cities.value = res.data
    } catch {}
  }
}

async function loadData() {
  loading.value = true
  try {
    const params = {
      pageNum: query.pageNum,
      pageSize: query.pageSize,
      state: parseInt(activeTab.value)
    }
    if (query.cityId) {
      const city = cities.value.find(c => c.id === query.cityId)
      if (city) params.cityCode = city.cityCode
    }
    if (dateRange.value && dateRange.value.length === 2) {
      params.startTime = dateRange.value[0] + ' 00:00:00'
      params.endTime = dateRange.value[1] + ' 23:59:59'
    }
    const res = await pageAqiFeedback(params)
    tableData.value = res.data.records
    total.value = res.data.total
  } catch {
  } finally {
    loading.value = false
  }
}

function handleSearch() {
  query.pageNum = 1
  loadData()
}

function handleReset() {
  query.provinceId = ''
  query.cityId = ''
  cities.value = []
  dateRange.value = []
  activeTab.value = '0'
  query.pageNum = 1
  loadData()
}

function onTabChange(tab) {
  activeTab.value = tab
  query.pageNum = 1
  loadData()
}

function onPageChange(page) {
  query.pageNum = page
  loadData()
}

function getLevelInfo(aqiValue) {
  if (aqiValue <= 50) return { level: 1, name: '优', tag: 'success' }
  if (aqiValue <= 100) return { level: 2, name: '良', tag: '' }
  if (aqiValue <= 150) return { level: 3, name: '轻度污染（三）', tag: 'warning' }
  if (aqiValue <= 200) return { level: 4, name: '中度污染（四）', tag: 'danger' }
  if (aqiValue <= 300) return { level: 5, name: '重度污染（五）', tag: 'danger' }
  return { level: 6, name: '严重污染（六）', tag: 'danger' }
}

function getLevelStyle(aqiValue) {
  if (aqiValue <= 50) return { background: '#f6ffed', color: '#52c41a', border: '1px solid #b7eb8f' }
  if (aqiValue <= 100) return { background: '#fff9e6', color: '#d4a017', border: '1px solid #ffe58f' }
  if (aqiValue <= 150) return { background: '#fff7e6', color: '#fa8c16', border: '1px solid #ffd591' }
  if (aqiValue <= 200) return { background: '#fff2e8', color: '#fa541c', border: '1px solid #ffbb96' }
  if (aqiValue <= 300) return { background: '#fff1f0', color: '#f5222d', border: '1px solid #ffa39e' }
  return { background: '#4a1942', color: '#fff', border: 'none' }
}

function formatDate(dt) {
  if (!dt) return '-'
  return dt.split(' ')[0]
}

function formatTime(dt) {
  if (!dt) return '-'
  const parts = dt.split(' ')
  return parts[1] || '-'
}

function viewDetail(row) {
  router.push(`/feedback/detail/${row.id}`)
}
</script>

<template>
  <div class="page-container">
    <div class="breadcrumb">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item>公众监督数据管理</el-breadcrumb-item>
        <el-breadcrumb-item>公众监督数据列表</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="filter-bar">
      <el-select v-model="query.provinceId" placeholder="省区域 -全部-" clearable style="width:140px" @change="onProvinceChange">
        <el-option label="-全部-" value="" />
        <el-option v-for="p in provinces" :key="p.id" :label="p.provinceName" :value="p.id" />
      </el-select>
      <el-select v-model="query.cityId" placeholder="市区域 -全部-" clearable style="width:140px" :disabled="!query.provinceId">
        <el-option label="-全部-" value="" />
        <el-option v-for="c in cities" :key="c.id" :label="c.cityName" :value="c.id" />
      </el-select>
      <el-date-picker
        v-model="dateRange"
        type="daterange"
        range-separator="至"
        start-placeholder="反馈开始日期"
        end-placeholder="反馈结束日期"
        value-format="YYYY-MM-DD"
        style="width:260px"
      />
      <el-button type="danger" @click="handleSearch">查询</el-button>
      <el-button @click="handleReset">清空</el-button>
      <div class="tab-group">
        <el-radio-group :model-value="activeTab" @change="onTabChange">
          <el-radio-button label="0">未指派</el-radio-button>
          <el-radio-button label="1">已指派</el-radio-button>
        </el-radio-group>
      </div>
    </div>

    <div class="table-card">
      <el-table :data="tableData" v-loading="loading" stripe border style="width:100%">
        <el-table-column prop="id" label="编号" width="70" align="center" />
        <el-table-column prop="telId" label="反馈者联系电话" min-width="130" align="center" />
        <el-table-column prop="cityCode" label="城市编码" width="100" align="center" />
        <el-table-column label="预估污染等级" width="160" align="center">
          <template #default="{ row }">
            <span class="level-tag" :style="getLevelStyle(row.aqiValue)">
              {{ getLevelInfo(row.aqiValue).name }}
            </span>
          </template>
        </el-table-column>
        <el-table-column label="反馈日期" width="100" align="center">
          <template #default="{ row }">{{ formatDate(row.feedbackTime) }}</template>
        </el-table-column>
        <el-table-column label="反馈时间" width="90" align="center">
          <template #default="{ row }">{{ formatTime(row.feedbackTime) }}</template>
        </el-table-column>
        <el-table-column prop="remark" label="备注" min-width="120" show-overflow-tooltip />
        <el-table-column label="操作" width="100" align="center" fixed="right">
          <template #default="{ row }">
            <el-tooltip content="查看详情">
              <el-button type="primary" :icon="Document" circle size="small" @click="viewDetail(row)" />
            </el-tooltip>
            <el-tooltip v-if="parseInt(activeTab) === 0" content="指派网格员">
              <el-button type="warning" :icon="User" circle size="small" @click="viewDetail(row)" />
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination-bar">
        <el-pagination
          v-model:current-page="query.pageNum"
          :page-size="query.pageSize"
          :total="total"
          layout="prev, pager, next, total"
          @current-change="onPageChange"
        />
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
  font-size: 13px;
}

.filter-bar {
  display: flex;
  align-items: center;
  gap: 10px;
  flex-wrap: wrap;
  padding: 14px 16px;
  background: #fff;
  border-radius: 6px;
  margin-bottom: 12px;
  box-shadow: 0 1px 4px rgba(0,0,0,0.06);
}

.tab-group {
  margin-left: auto;
}

.table-card {
  background: #fff;
  border-radius: 6px;
  padding: 16px;
  box-shadow: 0 1px 4px rgba(0,0,0,0.06);
}

.level-tag {
  display: inline-block;
  padding: 2px 8px;
  border-radius: 3px;
  font-size: 12px;
  font-weight: 500;
}

.pagination-bar {
  display: flex;
  justify-content: center;
  margin-top: 16px;
}
</style>
