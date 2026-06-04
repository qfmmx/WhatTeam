<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { pageStatistics } from '@/api/statistics'
import { listAllProvinces } from '@/api/gridProvince'
import { listCitiesByProvince } from '@/api/gridCity'

const router = useRouter()
const tableData = ref([])
const loading = ref(false)
const total = ref(0)
const provinces = ref([])
const cities = ref([])
const dateRange = ref([])

const query = reactive({
  pageNum: 1,
  pageSize: 10,
  provinceId: '',
  cityId: '',
  cityName: ''
})

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
  query.cityName = ''
  cities.value = []
  if (val) {
    try {
      const res = await listCitiesByProvince(val)
      cities.value = res.data
    } catch {}
  }
}

function onCityChange(val) {
  const city = cities.value.find(c => c.id === val)
  query.cityName = city ? city.cityName : ''
}

async function loadData() {
  loading.value = true
  try {
    const params = {
      pageNum: query.pageNum,
      pageSize: query.pageSize
    }
    if (query.cityName) params.cityName = query.cityName
    if (dateRange.value && dateRange.value.length === 2) {
      params.startTime = dateRange.value[0] + ' 00:00:00'
      params.endTime = dateRange.value[1] + ' 23:59:59'
    }
    const res = await pageStatistics(params)
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
  query.cityName = ''
  cities.value = []
  dateRange.value = []
  query.pageNum = 1
  loadData()
}

function onPageChange(page) {
  query.pageNum = page
  loadData()
}

function getLevelStyle(aqiValue) {
  if (!aqiValue) return {}
  if (aqiValue <= 50) return { background: '#f6ffed', color: '#52c41a', border: '1px solid #b7eb8f' }
  if (aqiValue <= 100) return { background: '#fff9e6', color: '#d4a017', border: '1px solid #ffe58f' }
  if (aqiValue <= 150) return { background: '#fff7e6', color: '#fa8c16', border: '1px solid #ffd591' }
  if (aqiValue <= 200) return { background: '#fff2e8', color: '#fa541c', border: '1px solid #ffbb96' }
  if (aqiValue <= 300) return { background: '#fff1f0', color: '#f5222d', border: '1px solid #ffa39e' }
  return { background: '#4a1942', color: '#fff', border: 'none' }
}

function getLevelName(aqiValue) {
  if (!aqiValue) return '-'
  if (aqiValue <= 50) return '优（一）'
  if (aqiValue <= 100) return '良（二）'
  if (aqiValue <= 150) return '轻度污染（三）'
  if (aqiValue <= 200) return '中度污染（四）'
  if (aqiValue <= 300) return '重度污染（五）'
  return '严重污染（六）'
}

function formatDate(dt) {
  if (!dt) return '-'
  return dt.split(' ')[0]
}

function formatTime(dt) {
  if (!dt) return '-'
  const p = dt.split(' ')
  return p[1] || '-'
}

function viewDetail(row) {
  router.push(`/aqi/detail/${row.id}`)
}
</script>

<template>
  <div class="page-container">
    <div class="breadcrumb">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item>公众监督数据管理</el-breadcrumb-item>
        <el-breadcrumb-item>确认AQI数据列表</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="filter-bar">
      <el-select v-model="query.provinceId" placeholder="省区域 -全部-" clearable style="width:140px" @change="onProvinceChange">
        <el-option label="-全部-" value="" />
        <el-option v-for="p in provinces" :key="p.id" :label="p.provinceName" :value="p.id" />
      </el-select>
      <el-select v-model="query.cityId" placeholder="市区域 -全部-" clearable style="width:140px" :disabled="!query.provinceId" @change="onCityChange">
        <el-option label="-全部-" value="" />
        <el-option v-for="c in cities" :key="c.id" :label="c.cityName" :value="c.id" />
      </el-select>
      <el-date-picker
        v-model="dateRange"
        type="daterange"
        range-separator="至"
        start-placeholder="确认开始日期"
        end-placeholder="确认结束日期"
        value-format="YYYY-MM-DD"
        style="width:260px"
      />
      <el-button type="danger" @click="handleSearch">查询</el-button>
      <el-button @click="handleReset">清空</el-button>
    </div>

    <div class="table-card">
      <el-table :data="tableData" v-loading="loading" stripe border style="width:100%">
        <el-table-column prop="id" label="编号" width="70" align="center" />
        <el-table-column prop="cityCode" label="城市编码" width="100" align="center" />
        <el-table-column label="AQI等级" width="160" align="center">
          <template #default="{ row }">
            <span class="level-tag" :style="getLevelStyle(row.aqiValue)">
              {{ getLevelName(row.aqiValue) }}
            </span>
          </template>
        </el-table-column>
        <el-table-column prop="aqiValue" label="AQI值" width="80" align="center" />
        <el-table-column label="确认日期" width="100" align="center">
          <template #default="{ row }">{{ formatDate(row.confirmTime) }}</template>
        </el-table-column>
        <el-table-column label="确认时间" width="90" align="center">
          <template #default="{ row }">{{ formatTime(row.confirmTime) }}</template>
        </el-table-column>
        <el-table-column prop="gmId" label="网格员ID" width="90" align="center" />
        <el-table-column label="是否超标" width="90" align="center">
          <template #default="{ row }">
            <el-tag :type="row.isExceed ? 'danger' : 'success'" size="small">
              {{ row.isExceed ? '超标' : '正常' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="80" align="center" fixed="right">
          <template #default="{ row }">
            <el-tooltip content="查看详情">
              <el-button type="primary" :icon="Document" circle size="small" @click="viewDetail(row)" />
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
.page-container { padding: 0; }
.breadcrumb { margin-bottom: 12px; }

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
