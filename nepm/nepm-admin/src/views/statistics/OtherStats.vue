<script setup>
import { ref, onMounted } from 'vue'
import { getAqiTotalCount, getAqiGoodCount, getProvinceCoverage, getCityCoverage } from '@/api/statistics'

const stats = ref([
  { label: '空气质量检测总数量', value: '-', key: 'total' },
  { label: '空气质量检测良好数量', value: '-', key: 'good' },
  { label: '省会城市网格覆盖范围', value: '-', key: 'province' },
  { label: '大城市网格覆盖范围', value: '-', key: 'city' }
])
const loading = ref(false)

onMounted(loadData)

async function loadData() {
  loading.value = true
  try {
    const [total, good, province, city] = await Promise.all([
      getAqiTotalCount(),
      getAqiGoodCount(),
      getProvinceCoverage(),
      getCityCoverage()
    ])
    stats.value[0].value = total.data
    stats.value[1].value = good.data
    stats.value[2].value = province.data
    stats.value[3].value = city.data
  } catch {
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="page-container">
    <div class="breadcrumb">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item>统计数据管理</el-breadcrumb-item>
        <el-breadcrumb-item>其它数据统计</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="stats-card" v-loading="loading">
      <h3 class="card-title">其它数据统计</h3>
      <el-table :data="stats" border style="width:500px">
        <el-table-column prop="label" label="统计项" min-width="200" />
        <el-table-column prop="value" label="统计值" width="160" align="center">
          <template #default="{ row }">
            <span class="stat-value">{{ row.value }}</span>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<style scoped>
.page-container { padding: 0; }
.breadcrumb { margin-bottom: 12px; }

.stats-card {
  background: #fff;
  border-radius: 6px;
  padding: 24px;
  box-shadow: 0 1px 4px rgba(0,0,0,0.06);
}

.card-title {
  font-size: 16px;
  font-weight: 600;
  color: #333;
  margin-bottom: 20px;
}

.stat-value {
  font-size: 15px;
  font-weight: 600;
  color: #4a90d9;
}
</style>
