<template>
  <div class="page">
    <header class="header">
      <i class="fa fa-angle-left back" @click="goBack"></i>
      <span>选择AQI</span>
      <div class="header-actions">
        <span class="action-link" @click="goHistory">历史</span>
        <span class="action-link logout" @click="handleLogout">退出</span>
      </div>
    </header>

    <div class="aqi-panel">
      <div class="aqi-item" v-for="item in aqiList" :key="item.aqiId">
        <div class="aqi-index" :style="{ backgroundColor: item.color || '#ccc' }">
          {{ indexText(item.aqiId) }}
        </div>
        <div class="aqi-content">
          <div class="aqi-name">{{ item.chineseExplain }}</div>
          <div class="aqi-desc">{{ item.aqiExplain || item.healthImpact || '' }}</div>
        </div>
      </div>
    </div>

    <div class="section-title">请预估当前空气质量指数等级：</div>
    <div class="grade-row">
      <button
        v-for="item in aqiList"
        :key="`grade-${item.aqiId}`"
        class="grade-btn"
        :class="{ active: form.estimatedGrade === item.aqiId }"
        :style="{ backgroundColor: form.estimatedGrade === item.aqiId ? item.color : '#f3f3f3', color: form.estimatedGrade === item.aqiId ? '#fff' : '#333' }"
        @click="form.estimatedGrade = item.aqiId"
      >
        {{ indexText(item.aqiId) }}
      </button>
    </div>

    <div class="section-title">请填写反馈信息</div>
    <textarea v-model="form.information" class="textarea" placeholder="请填写反馈信息"></textarea>

    <button class="primary-btn" @click="handleSubmit">提交</button>
    <MessageDialog :visible="dialogVisible" :message="dialogMessage" @close="dialogVisible = false" />
  </div>
</template>

<script setup>
import { onMounted, reactive, ref } from 'vue';
import { useRouter } from 'vue-router';
import { getSessionStorage, removeSessionStorage } from '../common';
import { aqiApi, aqiFeedbackApi } from '../api';
import MessageDialog from '../components/MessageDialog.vue';
import { validateFeedbackForm } from '../utils/supervisorValidation';

const router = useRouter();
const aqiList = ref([]);
const supervisor = ref(null);
const draft = ref(null);

const form = reactive({
  estimatedGrade: null,
  information: ''
});
const dialogVisible = ref(false);
const dialogMessage = ref('');

const showDialog = (message) => {
  dialogMessage.value = message;
  dialogVisible.value = true;
};

const indexText = (value) => {
  const texts = ['一', '二', '三', '四', '五', '六'];
  return texts[(value || 1) - 1] || value;
};

const goBack = () => {
  router.push('/grid');
};

const goHistory = () => {
  router.push('/history');
};

const handleLogout = () => {
  removeSessionStorage('supervisor');
  removeSessionStorage('supervisorFeedbackDraft');
  router.replace('/login');
};

const loadAqiList = async () => {
  const response = await aqiApi.listAll();
  if (response.data.code === 200) {
    aqiList.value = response.data.data || [];
  }
};

const handleSubmit = async () => {
  if (!draft.value) {
    showDialog('请先选择网格');
    router.replace('/grid');
    return;
  }
  const validationMessage = validateFeedbackForm(form);
  if (validationMessage) {
    showDialog(validationMessage);
    return;
  }

  try {
    const response = await aqiFeedbackApi.save({
      telId: supervisor.value.telId || supervisor.value.phone,
      provinceId: draft.value.provinceId,
      cityId: draft.value.cityId,
      address: draft.value.address,
      information: form.information.trim(),
      estimatedGrade: form.estimatedGrade
    });

    if (response.data.code === 200) {
      removeSessionStorage('supervisorFeedbackDraft');
      router.replace('/history?submitted=1');
      return;
    }
    showDialog(response.data.message || '提交失败');
  } catch (error) {
    console.error('提交反馈失败:', error);
    showDialog(error.response?.data?.message || '提交失败，请稍后重试');
  }
};

onMounted(async () => {
  supervisor.value = getSessionStorage('supervisor');
  draft.value = getSessionStorage('supervisorFeedbackDraft');
  if (!supervisor.value) {
    router.push('/login');
    return;
  }
  if (!draft.value) {
    router.push('/grid');
    return;
  }
  await loadAqiList();
});
</script>

<style scoped>
.page {
  height: 100%;
  background: #f4f8fb;
  overflow-y: auto;
  padding-bottom: 20px;
}

.header {
  height: 52px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 16px;
  background: #fff;
  font-size: 22px;
  color: #333;
}

.back {
  width: 24px;
  font-size: 28px;
  cursor: pointer;
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

.aqi-panel {
  margin: 12px;
  background: #fff;
  border: 1px solid #d9d9d9;
}

.aqi-item {
  display: flex;
  border-bottom: 1px solid #ececec;
}

.aqi-item:last-child {
  border-bottom: none;
}

.aqi-index {
  width: 46px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 18px;
  font-weight: bold;
}

.aqi-content {
  flex: 1;
  padding: 10px 12px;
}

.aqi-name {
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 4px;
}

.aqi-desc {
  font-size: 13px;
  color: #666;
  line-height: 1.4;
}

.section-title {
  margin: 16px 14px 10px;
  color: #444;
  font-size: 16px;
}

.grade-row {
  display: flex;
  gap: 8px;
  padding: 0 14px;
  flex-wrap: wrap;
}

.grade-btn {
  width: 40px;
  height: 32px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
}

.textarea {
  width: calc(100% - 28px);
  margin: 0 14px;
  min-height: 110px;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  padding: 10px;
  resize: none;
  box-sizing: border-box;
  outline: none;
  font-size: 14px;
}

.primary-btn {
  width: calc(100% - 28px);
  margin: 16px 14px 0;
  height: 46px;
  border: none;
  border-radius: 8px;
  background: #79b7c6;
  color: #fff;
  font-size: 24px;
  cursor: pointer;
}
</style>
