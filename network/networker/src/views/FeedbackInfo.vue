<template>
  <div class="detail-container">
    <header>
      <img src="../assets/箭头返回.png" class="back-btn" @click="goBack" alt="返回">
      <h2>反馈任务详细信息</h2>
      <span></span>
    </header>
    <div class="header-bg">
      <img src="../assets/网格员背景图.png" alt="背景图">
    </div>
    
    <div class="detail-content">
      <div class="info-card">
        <div class="info-row">
          <span class="info-label">反馈用户</span>
          <span class="info-value">{{ feedbackInfo.userName }} {{ feedbackInfo.phone }}</span>
        </div>
        <div class="info-row">
          <span class="info-label">网格</span>
          <span class="info-value">{{ feedbackInfo.grid }}</span>
        </div>
        <div class="info-row">
          <span class="info-label">详细地址</span>
          <span class="info-value">{{ feedbackInfo.address }}</span>
        </div>
        <div class="info-row">
          <span class="info-label">预估等级</span>
          <span class="info-value">{{ feedbackInfo.estimateLevel }}</span>
        </div>
        <div class="info-row">
          <span class="info-label">信息描述</span>
          <span class="info-value">{{ feedbackInfo.description }}</span>
        </div>
      </div>
      
      <div class="input-section">
        <div class="input-row">
          <span class="input-label">SO2浓度</span>
          <div class="input-wrap">
            <input type="number" v-model="formData.so2" @change="calculateAqiLevel" placeholder="请输入SO2浓度">
            <span class="unit">ug/m3</span>
            <span class="level-badge level-green">一</span>
          </div>
        </div>
        
        <div class="input-row">
          <span class="input-label">CO浓度</span>
          <div class="input-wrap">
            <input type="number" v-model="formData.co" @change="calculateAqiLevel" placeholder="请输入CO浓度">
            <span class="unit">ug/m3</span>
            <span class="level-badge level-orange">三</span>
          </div>
        </div>
        
        <div class="input-row">
          <span class="input-label">PM2.5</span>
          <div class="input-wrap">
            <input type="number" v-model="formData.pm25" @change="calculateAqiLevel" placeholder="请输入PM2.5浓度">
            <span class="unit">ug/m3</span>
            <span class="level-badge level-red">四</span>
          </div>
        </div>
      </div>
      
      <div class="aqi-result">
        <span class="result-text">实测AQI等级：{{ aqiResult || '请输入实测数据' }}</span>
      </div>
      
      <button class="submit-btn" @click="submitData">提交实测数据</button>
    </div>
    
    <!-- 成功弹窗 -->
    <div v-if="showSuccessModal" class="modal-overlay" @click="closeModal">
      <div class="modal-content" @click.stop>
        <div class="modal-icon">✓</div>
        <div class="modal-title">提交成功</div>
        <div class="modal-desc">实测数据已成功保存</div>
        <button class="modal-btn" @click="handleSuccess">确定</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, inject, computed } from 'vue';
import { useRouter } from 'vue-router';
import { getSessionStorage } from '../common';
import { feedbackApi } from '../api/index';

const router = useRouter();

const currentTask = ref(null);
const gridMember = ref(null);

const feedbackInfo = reactive({
  userName: '',
  phone: '',
  grid: '',
  address: '',
  estimateLevel: '',
  description: ''
});

const formData = reactive({
  so2: '',
  co: '',
  pm25: ''
});

const aqiResult = ref('');
const showSuccessModal = ref(false);

const goBack = () => {
  router.push('/feedbackList');
};

const getAqiLevelText = (grade) => {
  const levelMap = {
    1: '一级 优',
    2: '二级 良',
    3: '三级 轻度污染',
    4: '四级 中度污染',
    5: '五级 重度污染',
    6: '六级 严重污染'
  };
  return levelMap[grade] || '未知';
};

const calculateAqiLevel = () => {
  const so2 = parseInt(formData.so2) || 0;
  const pm25 = parseInt(formData.pm25) || 0;
  
  let maxLevel = 1;
  
  if (pm25 > 150) maxLevel = 5;
  else if (pm25 > 115) maxLevel = 4;
  else if (pm25 > 75) maxLevel = 3;
  else if (pm25 > 35) maxLevel = 2;
  
  if (so2 > 800) maxLevel = Math.max(maxLevel, 4);
  else if (so2 > 475) maxLevel = Math.max(maxLevel, 3);
  else if (so2 > 150) maxLevel = Math.max(maxLevel, 2);
  
  aqiResult.value = getAqiLevelText(maxLevel);
};

const submitData = async () => {
  if (!formData.so2 || !formData.co || !formData.pm25) {
    alert('请填写完整的实测数据');
    return;
  }
  
  if (!gridMember.value || !currentTask.value) {
    alert('数据异常，请重新登录');
    router.push('/login');
    return;
  }
  
  try {
    const response = await feedbackApi.submit({
      gmId: gridMember.value.gmId,
      afId: currentTask.value.id,
      so2: parseInt(formData.so2),
      co: parseFloat(formData.co),
      pm25: parseInt(formData.pm25)
    });
    
    if (response.data.code === 200) {
      showSuccessModal.value = true;
    } else {
      alert(response.data.message || '提交失败');
    }
  } catch (error) {
    console.error('提交失败:', error);
    alert('提交失败，请稍后重试');
  }
};

const closeModal = () => {
  showSuccessModal.value = false;
};

const handleSuccess = () => {
  showSuccessModal.value = false;
  router.push('/feedbackList');
};

onMounted(() => {
  gridMember.value = getSessionStorage('gridMember');
  
  const task = sessionStorage.getItem('currentTask');
  if (task) {
    currentTask.value = JSON.parse(task);
    feedbackInfo.address = currentTask.value.address || '';
    feedbackInfo.grid = currentTask.value.detail || '';
    feedbackInfo.description = currentTask.value.information || '';
    feedbackInfo.phone = currentTask.value.telId || '';
    feedbackInfo.estimateLevel = getAqiLevelText(currentTask.value.estimatedGrade);
  }
  
  if (!gridMember.value) {
    router.push('/login');
  }
});
</script>

<style scoped>
.detail-container {
  width: 100%;
  height: 812px;
  background: #fff;
  display: flex;
  flex-direction: column;
}

header {
  height: 56px;
  background: #fff;
  display: flex;
  align-items: center;
  padding: 0 15px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  flex-shrink: 0;
  position: relative;
}

header h2 {
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
  margin: 0;
}

header h2 {
  font-size: 18px;
  color: #666;
  font-weight: bold;
}

.back-btn {
  width: 24px;
  height: 24px;
  cursor: pointer;
}

.header-bg {
  width: 100%;
  height: 190px;
  overflow: hidden;
  flex-shrink: 0;
}

.header-bg img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.detail-content {
  padding: 15px;
  overflow-y: auto;
  flex: 1;
}

.info-card {
  background: #fff;
  border-radius: 0;
  border: 1px solid #ddd;
  border-collapse: collapse;
  margin-bottom: 15px;
}

.info-row {
  display: flex;
  padding: 12px 15px;
  border-bottom: 1px solid #eee;
}

.info-row:last-child {
  border-bottom: none;
}

.info-label {
  width: 90px;
  font-size: 14px;
  color: #999;
  flex-shrink: 0;
  border-right: 1px solid #eee;
  padding-right: 10px;
  background: #f8f8f8;
  margin: -12px -15px;
  padding: 12px 15px;
}

.info-value {
  flex: 1;
  font-size: 14px;
  color: #333;
  padding-left: 25px;
}

.input-section {
  background: transparent;
  padding: 0;
  margin-bottom: 15px;
}

.input-row {
  margin-bottom: 15px;
}

.input-row:last-child {
  margin-bottom: 0;
}

.input-label {
  font-size: 15px;
  color: #555;
  margin-bottom: 8px;
  display: block;
}

.input-wrap {
  display: flex;
  align-items: center;
}

.input-wrap input {
  flex: 1;
  height: 38px;
  border: 1px solid #ddd;
  border-radius: 20px;
  padding: 0 15px;
  font-size: 14px;
  outline: none;
}

.unit {
  font-size: 13px;
  color: #999;
  margin: 0 8px;
}

.level-badge {
  width: 34px;
  height: 34px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 15px;
  font-weight: bold;
}

.level-green {
  background: #4caf50;
}

.level-orange {
  background: #ff7043;
}

.level-red {
  background: #e53935;
}

.aqi-result {
  background: #d32f2f;
  border-radius: 10px;
  padding: 15px;
  margin-bottom: 19px;
}

.result-text {
  font-size: 17px;
  color: #fff;
  font-weight: bold;
}

.submit-btn {
  width: 60%;
  height: 45px;
  background: linear-gradient(90deg, #2e7d32 0%, #4caf50 100%);
  color: #fff;
  font-size: 16px;
  border: none;
  border-radius: 25px;
  cursor: pointer;
  display: block;
  margin: 0 auto;
}

.submit-btn:active {
  opacity: 0.8;
}

/* 弹窗样式 */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  width: 80%;
  max-width: 300px;
  background: #fff;
  border-radius: 16px;
  padding: 30px 20px;
  text-align: center;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
}

.modal-icon {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background: #4caf50;
  color: #fff;
  font-size: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 15px;
}

.modal-title {
  font-size: 18px;
  font-weight: bold;
  color: #333;
  margin-bottom: 8px;
}

.modal-desc {
  font-size: 14px;
  color: #999;
  margin-bottom: 25px;
}

.modal-btn {
  width: 100%;
  height: 44px;
  background: linear-gradient(90deg, #2e7d32 0%, #4caf50 100%);
  color: #fff;
  font-size: 16px;
  border: none;
  border-radius: 22px;
  cursor: pointer;
}

.modal-btn:active {
  opacity: 0.8;
}
</style>
