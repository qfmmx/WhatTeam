<template>
  <div class="page">
    <header class="header">
      <i class="fa fa-angle-left back" @click="goBack"></i>
      <span>历史反馈信息列表</span>
      <div class="header-actions">
        <span class="action-link" @click="goGrid">反馈</span>
        <span class="action-link logout" @click="handleLogout">退出</span>
      </div>
    </header>

    <div class="hero">
      <img src="../assets/supervisor-cover-banner-slogan-fit.png" alt="背景图">
    </div>

    <div class="list">
      <div v-if="records.length === 0" class="empty">暂无历史反馈信息</div>
      <div v-for="item in records" :key="item.id" class="item" @click="openDetail(item.id)">
        <div class="badge" :style="{ backgroundColor: gradeColor(item.estimatedGrade) }">
          {{ gradeText(item.estimatedGrade) }}
        </div>
        <div class="info">
          <div class="row-line">
            <span class="time">{{ item.feedbackDateTime }}</span>
            <span class="region">{{ item.provinceName }}</span>
            <span class="city">{{ item.cityName }}</span>
          </div>
          <div class="info-text">{{ item.information }}</div>
        </div>
      </div>
    </div>

    <button class="primary-btn" @click="goGrid">继续反馈</button>
    <MessageDialog :visible="dialogVisible" :message="dialogMessage" @close="dialogVisible = false" />
    <div v-if="detailVisible" class="dialog-mask" @click.self="closeDetail">
      <div class="dialog-card detail-card">
        <div class="dialog-title">反馈详情</div>
        <div v-if="detail" class="detail-body">
          <div class="detail-row"><span>反馈编号</span><strong>{{ detail.id }}</strong></div>
          <div class="detail-row"><span>手机号</span><strong>{{ detail.telId }}</strong></div>
          <div class="detail-row"><span>省市</span><strong>{{ detail.provinceName }} {{ detail.cityName }}</strong></div>
          <div class="detail-row"><span>地址</span><strong>{{ detail.address }}</strong></div>
          <div class="detail-row"><span>AQI等级</span><strong>{{ gradeText(detail.estimatedGrade) }}</strong></div>
          <div class="detail-row"><span>反馈时间</span><strong>{{ detail.feedbackDateTime }}</strong></div>
          <div v-if="detail.state !== 0" class="detail-row"><span>状态</span><strong>{{ detail.stateLabel }}</strong></div>
          <div class="detail-row multiline"><span>反馈内容</span><strong>{{ detail.information }}</strong></div>
        </div>
        <button class="dialog-btn" @click="closeDetail">我知道了</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { getSessionStorage, removeSessionStorage } from '../common';
import { aqiFeedbackApi } from '../api';
import MessageDialog from '../components/MessageDialog.vue';

const router = useRouter();
const route = useRoute();
const records = ref([]);
const supervisor = ref(null);
const detail = ref(null);
const detailVisible = ref(false);
const dialogVisible = ref(false);
const dialogMessage = ref('');

const gradeText = (grade) => ['一', '二', '三', '四', '五', '六'][(grade || 1) - 1] || '未';
const gradeColor = (grade) => ({
  1: '#30b34f',
  2: '#f6c11d',
  3: '#ff8c2b',
  4: '#d6443c',
  5: '#8a2be2',
  6: '#7E0023'
}[grade] || '#9e9e9e');

const showDialog = (message) => {
  dialogMessage.value = message;
  dialogVisible.value = true;
};

const goBack = () => {
  router.push('/grid');
};

const goGrid = () => {
  router.push('/grid');
};

const handleLogout = () => {
  removeSessionStorage('supervisor');
  removeSessionStorage('supervisorFeedbackDraft');
  router.replace('/login');
};

const openDetail = async (id) => {
  try {
    const response = await aqiFeedbackApi.detail(id);
    if (response.data.code === 200) {
      detail.value = response.data.data;
      detailVisible.value = true;
      return;
    }
    showDialog(response.data.message || '获取反馈详情失败');
  } catch (error) {
    console.error('获取反馈详情失败:', error);
    showDialog(error.response?.data?.message || '获取反馈详情失败，请稍后重试');
  }
};

const closeDetail = () => {
  detailVisible.value = false;
  detail.value = null;
};

const loadHistory = async () => {
  try {
    const response = await aqiFeedbackApi.listByTel(supervisor.value.telId || supervisor.value.phone);
    if (response.data.code === 200) {
      records.value = response.data.data || [];
      if (route.query.submitted) {
        showDialog('反馈提交成功');
        history.replaceState(null, '', '#/history');
      }
      return;
    }
    showDialog(response.data.message || '获取历史反馈失败');
  } catch (error) {
    console.error('获取历史反馈失败:', error);
    showDialog(error.response?.data?.message || '获取历史反馈失败，请稍后重试');
  }
};

onMounted(async () => {
  supervisor.value = getSessionStorage('supervisor');
  if (!supervisor.value) {
    router.push('/login');
    return;
  }
  await loadHistory();
});
</script>

<style scoped>
.page {
  height: 100%;
  background: #d7ecef;
  display: flex;
  flex-direction: column;
}

.header {
  height: 52px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 16px;
  background: #fff;
  font-size: 20px;
  color: #333;
}

.back {
  width: 24px;
  font-size: 28px;
  cursor: pointer;
}

.hero {
  height: 230px;
  padding: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.hero img {
  width: 100%;
  height: 100%;
  display: block;
  object-fit: cover;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}

.action-link {
  color: #5d7a84;
  font-size: 14px;
  cursor: pointer;
}

.logout {
  color: #d36f57;
}

.list {
  flex: 1;
  overflow-y: auto;
  padding: 12px;
}

.empty {
  text-align: center;
  color: #888;
  margin-top: 30px;
}

.item {
  background: rgba(255, 255, 255, 0.92);
  border: 1px solid #e5e8eb;
  border-radius: 4px;
  padding: 8px 10px;
  display: flex;
  align-items: center;
  margin-bottom: 10px;
  cursor: pointer;
}

.badge {
  width: 26px;
  height: 26px;
  border-radius: 6px;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 13px;
  font-weight: bold;
  margin-right: 10px;
  flex-shrink: 0;
}

.info {
  flex: 1;
  min-width: 0;
}

.info-text {
  margin-top: 4px;
  color: #666;
  font-size: 13px;
  line-height: 1.5;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.row-line {
  display: flex;
  align-items: center;
  gap: 18px;
  color: #666;
  font-size: 13px;
  line-height: 1.5;
  white-space: nowrap;
  overflow: hidden;
}

.time,
.region,
.city {
  overflow: hidden;
  overflow: hidden;
  text-overflow: ellipsis;
}

.time {
  min-width: 132px;
}

.region,
.city {
  flex: 1;
}

.primary-btn {
  width: calc(100% - 24px);
  margin: 0 12px 12px;
  height: 46px;
  border: none;
  border-radius: 8px;
  background: #79b7c6;
  color: #fff;
  font-size: 22px;
  cursor: pointer;
}

.dialog-mask {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.35);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 999;
}

.dialog-card {
  width: calc(100% - 56px);
  max-width: 360px;
  background: #fff;
  border-radius: 14px;
  padding: 20px 18px 18px;
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.18);
}

.dialog-title {
  text-align: center;
  font-size: 18px;
  font-weight: bold;
  color: #2f5d6a;
}

.detail-body {
  margin: 16px 0 18px;
}

.detail-row {
  display: flex;
  gap: 12px;
  margin-bottom: 12px;
  font-size: 14px;
  color: #4f4f4f;
}

.detail-row span {
  width: 70px;
  color: #6d7a81;
  flex-shrink: 0;
}

.detail-row strong {
  flex: 1;
  font-weight: normal;
  word-break: break-all;
}

.multiline strong {
  white-space: pre-wrap;
}

.dialog-btn {
  width: 100%;
  height: 42px;
  border: none;
  border-radius: 8px;
  background: #79b7c6;
  color: #fff;
  font-size: 16px;
  cursor: pointer;
}
</style>
