<script setup>
import { ref, onMounted } from 'vue'
import { getAqiTrend } from '@/api/statistics'

const tableData = ref([])
const loading = ref(false)

onMounted(loadData)

async function loadData() {
  loading.value = true
  try {
    const res = await getAqiTrend()
    tableData.value = res.data.map((item, index) => ({ ...item, index: index + 1 }))
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
        <el-breadcrumb-item>AQI空气质量指数超标趋势</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="table-card">
      <div class="section-title">AQI空气质量指数超标趋势</div>
      <el-table :data="tableData" v-loading="loading" stripe border style="width:100%">
        <el-table-column prop="index" label="序号" width="80" align="center" />
        <el-table-column prop="month" label="月份" min-width="200" align="center" />
        <el-table-column prop="exceedCount" label="AQI空气质量指数超标数量" min-width="200" align="center" />
      </el-table>
    </div>
  </div>
</template>

<style scoped>
.page-container { padding: 0; }
.breadcrumb { margin-bottom: 12px; }

.table-card {
  background: #fff;
  border-radius: 6px;
  padding: 16px;
  box-shadow: 0 1px 4px rgba(0,0,0,0.06);
}

.section-title {
  background: #52c41a;
  color: #fff;
  padding: 10px 16px;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
  margin-bottom: 16px;
}
</style>
