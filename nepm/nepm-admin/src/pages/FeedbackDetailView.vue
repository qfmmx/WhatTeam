<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import {
  getFeedbackDetail,
  getLocalGridMembers,
  getCrossProvinceMembers,
  assignFeedback
} from '@/api/admin'

const route = useRoute()
const router = useRouter()
const afId = route.params.afId

const detail = ref(null)
const loading = ref(false)
const assigning = ref(false)

// 智能指派状态
const localInfo = reactive({ hasLocal: false, cityName: '', provinceName: '', members: [] })
const crossMembers = ref([])
const crossUnlocked = ref(false)   // 外省调派是否已解锁
const mode = ref('local')          // 'local' | 'cross'
const selectedGmId = ref('')

const stateMap = { 0: '待指派', 1: '已指派', 2: '已处理' }

// 当前可选网格员列表
const candidates = computed(() => (mode.value === 'cross' ? crossMembers.value : localInfo.members))
// 外省调派按钮：本市有人时禁用
const crossDisabled = computed(() => localInfo.hasLocal)

onMounted(async () => {
  await loadDetail()
  if (detail.value && detail.value.state === 0) {
    await loadLocalMembers()
  }
})

async function loadDetail() {
  loading.value = true
  try {
    const res = await getFeedbackDetail(afId)
    detail.value = res.data
  } catch {
  } finally {
    loading.value = false
  }
}

// 本市指派：拉取本市在岗网格员
async function loadLocalMembers() {
  try {
    const res = await getLocalGridMembers(afId)
    Object.assign(localInfo, res.data)
    if (!res.data.hasLocal) {
      ElMessage.warning('本市暂无可用网格员，请使用「外省调派」')
    }
  } catch {}
}

// 解锁并加载外省网格员
async function unlockCross() {
  try {
    const res = await getCrossProvinceMembers(afId)
    crossMembers.value = res.data
    crossUnlocked.value = true
    mode.value = 'cross'
    selectedGmId.value = ''
    ElMessage.success('已解锁外省调派，可选择外省网格员')
  } catch (e) {
    ElMessage.error(e?.message || '无法进行外省调派')
  }
}

async function handleAssign() {
  if (!selectedGmId.value) {
    ElMessage.warning('请选择网格员')
    return
  }
  assigning.value = true
  try {
    const res = await assignFeedback({ afId, gmId: selectedGmId.value })
    ElMessage.success(res.message || '指派成功')
    // 重新加载详情，状态同步更新
    selectedGmId.value = ''
    await loadDetail()
  } catch (e) {
    ElMessage.error(e?.message || '指派失败')
  } finally {
    assigning.value = false
  }
}

function getLevel(aqiValue) {
  if (!aqiValue && aqiValue !== 0) return { level: 0, name: '-' }
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
        <el-breadcrumb-item>公众监督反馈详情</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div class="detail-card" v-if="detail">
      <div class="card-header">
        <h3>公众监督反馈详情</h3>
        <el-button @click="router.back()">返回</el-button>
      </div>

      <div class="detail-body">
        <div class="detail-row">
          <label>反馈编号</label><span>{{ detail.id }}</span>
        </div>
        <div class="detail-row">
          <label>反馈者 / 监督员</label><span>{{ detail.telId }}</span>
        </div>
        <div class="detail-row">
          <label>联系电话</label><span>{{ detail.telId }}</span>
        </div>
        <div class="detail-row">
          <label>所属城市</label>
          <span>{{ detail.cityName }}</span>
          <el-tag type="info" size="small" style="margin-left:8px">{{ detail.cityCode }}</el-tag>
        </div>
        <div class="detail-row">
          <label>反馈地址 / 描述</label><span>{{ detail.remark || '暂无描述' }}</span>
        </div>
        <div class="detail-row">
          <label>观测 AQI 值</label><span>{{ detail.aqiValue }}</span>
        </div>
        <div class="detail-row">
          <label>预估等级</label>
          <el-tag size="small">{{ getLevel(detail.aqiValue).level }}级</el-tag>
          <el-tag size="small" type="danger" style="margin-left:6px">{{ getLevel(detail.aqiValue).name }}</el-tag>
        </div>
        <div class="detail-row">
          <label>反馈时间</label><span>{{ detail.feedbackTime }}</span>
        </div>
        <div class="detail-row">
          <label>当前状态</label>
          <el-tag :type="detail.state === 0 ? 'warning' : detail.state === 1 ? 'primary' : 'success'" size="small">
            {{ stateMap[detail.state] }}
          </el-tag>
        </div>
        <div v-if="detail.gmId" class="detail-row">
          <label>已指派网格员</label>
          <el-tag type="success" size="small">{{ detail.gmName || `网格员ID:${detail.gmId}` }}</el-tag>
          <el-tag v-if="detail.isRemote" type="danger" size="small" style="margin-left:6px">外省调派</el-tag>
          <span v-if="detail.assignTime" style="margin-left:10px;font-size:12px;color:#999">{{ detail.assignTime }}</span>
        </div>

        <!-- 智能指派区 -->
        <template v-if="detail.state === 0">
          <el-divider content-position="left">
            <span class="divider-title">指派网格员</span>
          </el-divider>

          <el-alert
            v-if="!localInfo.hasLocal && !crossUnlocked"
            type="warning"
            :closable="false"
            show-icon
            title="本市暂无可用网格员"
            description="本市无在岗网格员，请点击「外省调派」从其它省份调派人员。"
            style="margin-bottom:14px"
          />
          <el-alert
            v-else-if="localInfo.hasLocal"
            type="success"
            :closable="false"
            show-icon
            :title="`本市（${localInfo.cityName}）有 ${localInfo.members.length} 名在岗网格员`"
            description="按「本市优先」规则，仅可指派本市网格员，外省调派已禁用。"
            style="margin-bottom:14px"
          />

          <div class="assign-bar">
            <span class="assign-label">{{ mode === 'cross' ? '外省网格员' : '本市网格员' }}</span>
            <el-select v-model="selectedGmId" placeholder="请选择网格员" style="width:240px">
              <el-option
                v-for="m in candidates"
                :key="m.id"
                :label="mode === 'cross' ? `${m.provinceName}/${m.cityName} - ${m.memberName}` : m.memberName"
                :value="m.id"
              />
            </el-select>

            <el-button
              type="warning"
              plain
              :disabled="crossDisabled"
              @click="unlockCross"
            >外省调派</el-button>

            <el-button type="primary" :loading="assigning" @click="handleAssign">确认指派</el-button>
          </div>
          <p class="tip">
            指派规则：本市有在岗网格员时仅可本地指派；本市无人时方可跨省调派，提交后由后端二次校验城市权限。
          </p>
        </template>

        <!-- 指派网格员（占位，暂不实现完整流程） -->
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
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.06);
}
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}
.card-header h3 { font-size: 16px; font-weight: 600; color: #333; margin: 0; }
.detail-body { max-width: 760px; }
.detail-row {
  display: flex;
  align-items: center;
  padding: 12px 0;
  border-bottom: 1px solid #f0f0f0;
  font-size: 14px;
}
.detail-row label { width: 160px; color: #666; flex-shrink: 0; }
.detail-row span { color: #333; }
.divider-title { font-size: 14px; color: #4a90d9; font-weight: 500; }
.assign-bar {
  display: flex;
  align-items: center;
  gap: 12px;
  flex-wrap: wrap;
  padding: 4px 0;
}
.assign-label { color: #666; font-size: 14px; }
.tip { margin-top: 12px; font-size: 12px; color: #999; }
</style>
