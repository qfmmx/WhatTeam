<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Document } from '@element-plus/icons-vue'
import { getFeedbackPage } from '@/api/admin'

const router = useRouter()

const tableData = ref([])
const loading = ref(false)
const total = ref(0)

const query = reactive({
  pageNum: 1,
  pageSize: 10,
  state: 0
})

onMounted(loadData)

async function loadData() {
  loading.value = true
  try {
    const res = await getFeedbackPage({
      pageNum: query.pageNum,
      pageSize: query.pageSize,
      state: query.state
    })
    tableData.value = res.data.records
    total.value = res.data.total
  } catch {
  } finally {
    loading.value = false
  }
}

function onStateChange(val) {
  query.state = val
  query.pageNum = 1
  loadData()
}

function onPageChange(page) {
  query.pageNum = page
  loadData()
}

function onSizeChange(size) {
  query.pageSize = size
  query.pageNum = 1
  loadData()
}

function getLevel(aqiValue) {
  if (aqiValue <= 50) return { name: '优', style: { background: '#f6ffed', color: '#52c41a', border: '1px solid #b7eb8f' } }
  if (aqiValue <= 100) return { name: '良', style: { background: '#fff9e6', color: '#d4a017', border: '1px solid #ffe58f' } }
  if (aqiValue <= 150) return { name: '轻度污染', style: { background: '#fff7e6', color: '#fa8c16', border: '1px solid #ffd591' } }
  if (aqiValue <= 200) return { name: '中度污染', style: { background: '#fff2e8', color: '#fa541c', border: '1px solid #ffbb96' } }
  if (aqiValue <= 300) return { name: '重度污染', style: { background: '#fff1f0', color: '#f5222d', border: '1px solid #ffa39e' } }
  return { name: '严重污染', style: { background: '#4a1942', color: '#fff', border: 'none' } }
}

function formatDate(dt) {
  return dt ? dt.split(' ')[0] : '-'
}

function viewDetail(row) {
  router.push(`/feedback/${row.id}`)
}
</script>

<template>
  <div class="page-container">
    <div class="breadcrumb">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item>公众监督数据管理</el-breadcrumb-item>
        <el-breadcrumb-item>公众监督反馈列表</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="table-card">
      <div class="toolbar">
        <el-radio-group :model-value="query.state" @change="onStateChange">
          <el-radio-button :value="0">未指派</el-radio-button>
          <el-radio-button :value="1">已指派</el-radio-button>
        </el-radio-group>
      </div>

      <el-table :data="tableData" v-loading="loading" stripe border style="width:100%">
        <el-table-column prop="id" label="编号" width="80" align="center" />
        <el-table-column prop="telId" label="监督员" min-width="130" align="center" />
        <el-table-column prop="cityName" label="城市" width="120" align="center" />
        <el-table-column prop="remark" label="地址" min-width="180" show-overflow-tooltip />
        <el-table-column label="预估等级" width="130" align="center">
          <template #default="{ row }">
            <span class="level-tag" :style="getLevel(row.aqiValue).style">
              {{ getLevel(row.aqiValue).name }}
            </span>
          </template>
        </el-table-column>
        <el-table-column label="反馈日期" width="120" align="center">
          <template #default="{ row }">{{ formatDate(row.feedbackTime) }}</template>
        </el-table-column>
        <el-table-column label="操作" width="100" align="center" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" size="small" :icon="Document" @click="viewDetail(row)">详情</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination-bar">
        <el-pagination
          v-model:current-page="query.pageNum"
          v-model:page-size="query.pageSize"
          :total="total"
          :page-sizes="[10, 20, 50]"
          layout="total, sizes, prev, pager, next"
          @current-change="onPageChange"
          @size-change="onSizeChange"
        />
      </div>
    </div>
  </div>
</template>

<style scoped>
.page-container { padding: 0; }
.breadcrumb { margin-bottom: 12px; font-size: 13px; }
.table-card {
  background: #fff;
  border-radius: 6px;
  padding: 16px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.06);
}
.toolbar { margin-bottom: 14px; }
.level-tag {
  display: inline-block;
  padding: 2px 8px;
  border-radius: 3px;
  font-size: 12px;
  font-weight: 500;
}
.pagination-bar {
  display: flex;
  justify-content: flex-end;
  margin-top: 16px;
}
</style>
