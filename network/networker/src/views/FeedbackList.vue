<template>
  <div class="list-container">
    <header>
      <img src="../assets/箭头返回.png" class="back-btn" @click="goBack" alt="返回">
      <h2>反馈任务列表</h2>
      <span></span>
    </header>
    <div class="header-bg">
      <img src="../assets/网格员背景图.png" alt="背景图">
    </div>
    
    <div class="list-content">
      <div class="task-item" v-for="item in taskList" :key="item.id">
        <div class="task-left">
          <div class="badge" :style="{backgroundColor: item.badgeColor}">{{ item.badgeText }}</div>
          <div class="task-info">
            <div class="task-title">{{ item.provinceName }}{{ item.cityName }} {{ item.date }}</div>
            <div class="task-detail">{{ item.address }}</div>
          </div>
        </div>
        <button class="check-btn" @click="goToDetail(item)">去检测 <img src="../assets/箭头.png" class="arrow-icon" alt="箭头"></button>
      </div>
    </div>
    
    <div class="pagination">
      <button class="page-btn" :disabled="currentPage <= 1" @click="prevPage">
        <i class="fa fa-angle-double-left"></i>
      </button>
      <button 
        v-for="page in visiblePages" 
        :key="page"
        class="page-num"
        :class="{ active: page === currentPage }"
        @click="goToPage(page)"
      >{{ page }}</button>
      <button class="page-btn" :disabled="currentPage >= totalPages" @click="nextPage">
        <i class="fa fa-angle-double-right"></i>
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, inject, computed } from 'vue';
import { useRouter } from 'vue-router';
import { getSessionStorage } from '../common';
import { feedbackApi } from '../api/index';

const router = useRouter();

const taskList = ref([]);
const currentPage = ref(1);
const totalPages = ref(1);
const pageSize = ref(5);
const gridMember = ref(null);

const visiblePages = computed(() => {
  const pages = [];
  const maxVisible = 7;
  let start = Math.max(1, currentPage.value - 3);
  let end = Math.min(totalPages.value, start + maxVisible - 1);
  
  for (let i = start; i <= end; i++) {
    pages.push(i);
    if (pages.length >= maxVisible) break;
  }
  return pages;
});

const goBack = () => {
  router.push('/login');
};

const goToDetail = (item) => {
  sessionStorage.setItem('currentTask', JSON.stringify(item));
  router.push('/feedbackInfo');
};

const prevPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--;
    fetchTasks();
  }
};

const nextPage = () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++;
    fetchTasks();
  }
};

const goToPage = (page) => {
  currentPage.value = page;
  fetchTasks();
};

const getBadgeInfo = (estimatedGrade) => {
  const gradeMap = {
    1: { text: '一', color: '#4caf50' },
    2: { text: '二', color: '#ffc107' },
    3: { text: '三', color: '#ff7043' },
    4: { text: '四', color: '#e53935' },
    5: { text: '五', color: '#7e57c2' },
    6: { text: '六', color: '#7E0023' }
  };
  return gradeMap[estimatedGrade] || { text: '未', color: '#999' };
};

const fetchTasks = async () => {
  if (!gridMember.value || !gridMember.value.gmId) {
    router.push('/login');
    return;
  }
  
  try {
    const response = await feedbackApi.list(gridMember.value.gmId, currentPage.value, pageSize.value);
    
    if (response.data.code === 200) {
      const result = response.data.data;
      totalPages.value = Math.ceil(result.total / pageSize.value);
      
      taskList.value = result.records.map(item => {
        const badge = getBadgeInfo(item.estimatedGrade);
        return {
          id: item.afId,
          badgeText: badge.text,
          badgeColor: badge.color,
          estimatedGrade: item.estimatedGrade || 0,
          provinceName: item.provinceName || '',
          cityName: item.cityName || '',
          address: item.address || '',
          date: item.afDate || '',
          detail: `${item.provinceName || ''}${item.cityName || ''}`,
          information: item.information || '',
          telId: item.telId || ''
        };
      });
    }
  } catch (error) {
    console.error('获取任务列表失败:', error);
  }
};

onMounted(() => {
  gridMember.value = getSessionStorage('gridMember');
  if (!gridMember.value) {
    router.push('/login');
    return;
  }
  fetchTasks();
});
</script>

<style scoped>
.list-container {
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

.header-bg {
  width: 100%;
  height: 190px;
  overflow: hidden;
  flex-shrink: 0;
}

.list-content {
  padding: 15px;
  overflow-y: auto;
  flex: 1;
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

.header-bg img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.list-content {
  padding: 15px;
}

.task-item {
  background: #fff;
  border-radius: 10px;
  padding: 12px;
  margin-bottom: 10px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.task-left {
  display: flex;
  align-items: flex-start;
  flex: 1;
}

.badge {
  width: 34px;
  height: 34px;
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 15px;
  font-weight: bold;
  margin-right: 10px;
}

.task-info {
  flex: 1;
}

.task-title {
  font-size: 15px;
  color: #333;
  font-weight: bold;
  margin-bottom: 3px;
}

.task-detail {
  font-size: 13px;
  color: #666;
  margin-bottom: 3px;
}

.task-info-text {
  font-size: 12px;
  color: #999;
}

.check-btn {
  background: linear-gradient(90deg, #2E8B57 0%, #3CB371 100%);
  color: #fff;
  border: none;
  border-radius: 20px;
  padding: 7px 15px;
  font-size: 13px;
  display: flex;
  align-items: center;
  gap: 5px;
  cursor: pointer;
}

.arrow-icon {
  width: 16px;
  height: 16px;
}

.pagination {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 22px 15px;
  gap: 8px;
}

.page-btn {
  width: 30px;
  height: 30px;
  border: 1px solid #ddd;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #fff;
  color: #666;
  font-size: 14px;
}

.page-btn:disabled {
  opacity: 0.5;
}

.page-num {
  width: 30px;
  height: 30px;
  border: none;
  border-radius: 50%;
  background: #fff;
  color: #666;
  font-size: 15px;
}

.page-num.active {
  background: #4caf50;
  color: #fff;
}
</style>
