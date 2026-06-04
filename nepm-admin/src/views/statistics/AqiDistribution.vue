<script setup>
import { ref, onMounted } from 'vue'
import { getAqiDistribute } from '@/api/statistics'

const tableData = ref([])
const loading = ref(false)

onMounted(loadData)

async function loadData() {
  loading.value = true
  try {
    const res = await getAqiDistribute()
    tableData.value = res.data
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
        <el-breadcrumb-item>AQI空气质量指数级别分布</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="table-card">
      <div class="section-title">AQI空气质量指数级别分布</div>
      <el-table :data="tableData" v-loading="loading" stripe border style="width:100%">
        <el-table-column prop="level" label="AQI指数等级" width="130" align="center" />
        <el-table-column prop="levelName" label="AQI指数等级描述" min-width="150" align="center">
          <template #default="{ row }">
            <el-tag :type="row.level <= 2 ? 'success' : row.level <= 3 ? 'warning' : 'danger'" size="small">
              {{ row.levelName }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="count" label="AQI指数等级分布统计" min-width="160" align="center" />
        <el-table-column prop="percentage" label="占比" width="100" align="center" />
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
