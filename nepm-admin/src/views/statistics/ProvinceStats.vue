<script setup>
import { ref, onMounted } from 'vue'
import { getProvinceTotal } from '@/api/statistics'

const tableData = ref([])
const loading = ref(false)

onMounted(loadData)

async function loadData() {
  loading.value = true
  try {
    const res = await getProvinceTotal()
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
        <el-breadcrumb-item>省分组检查统计</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="table-card">
      <div class="section-title">省分组检查统计</div>
      <el-table :data="tableData" v-loading="loading" stripe border style="width:100%">
        <el-table-column type="index" label="序号" width="70" align="center" />
        <el-table-column prop="provinceName" label="省名称" min-width="120" align="center" />
        <el-table-column prop="exceedCount" label="AQI超标累计" width="130" align="center" />
        <el-table-column prop="totalCount" label="总确认次数" width="130" align="center" />
        <el-table-column prop="exceedRate" label="超标率" width="110" align="center">
          <template #default="{ row }">
            <el-tag :type="parseFloat(row.exceedRate) > 30 ? 'danger' : 'success'" size="small">
              {{ row.exceedRate }}
            </el-tag>
          </template>
        </el-table-column>
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
