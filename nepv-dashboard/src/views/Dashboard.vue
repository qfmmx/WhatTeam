<template>
  <div class="dashboard-page">
    <header class="top-header">
      <div class="header-left"></div>
      <div class="title-container">
        <div class="title-text">东软空气质量环保公众监督平台</div>
      </div>
      <div class="header-actions">
        <div class="time-text">{{ currentTime }}</div>
      </div>
    </header>

    <!-- 主体内容区 -->
    <main class="main-content">
      <!-- 左侧数据区 -->
      <aside class="side-panel left-panel">
        <div class="material-card chart-container gauge-container">
          <dv-border-box-13 backgroundColor="#0a1631">
            <div class="inner-flex-container">
              <div class="chart-title-text text-center">网格覆盖率监控</div>
              <div class="coverage-content">
                <div class="coverage-item">
                  <CoverageChart title="省会城市" :percentageStr="provinceCoverage" />
                </div>
                <div class="coverage-item">
                  <CoverageChart title="大城市" :percentageStr="cityCoverage" />
                </div>
              </div>
            </div>
          </dv-border-box-13>
        </div>
        
        <div class="material-card chart-container pie-container">
          <dv-border-box-13 backgroundColor="#0a1631">
            <div class="inner-flex-container">
              <div class="chart-title-text text-center">空气质量指数级别分布</div>
              <div class="chart-wrapper">
                 <AqiDistributeChart :data="aqiDistributeData" />
              </div>
            </div>
          </dv-border-box-13>
        </div>
        
        <div class="material-card chart-container trend-container">
          <dv-border-box-13 backgroundColor="#0a1631">
            <div class="inner-flex-container">
              <div class="chart-title-text text-center">12个月内全国空气质量超标趋势</div>
              <div class="chart-wrapper">
                 <TrendChart :data="aqiTrendData" />
              </div>
            </div>
          </dv-border-box-13>
        </div>
      </aside>

      <!-- 中间地图与核心数据区 -->
      <section class="center-panel">
        <div class="material-card map-container">
          <dv-border-box-10 backgroundColor="#0a1631">
            <div class="inner-flex-container">
              <div class="map-wrapper">
                  <ChinaMap :data="provinceTotalData" :pm25Data="pm25Data" :so2Data="so2Data" :coData="coData" />
              </div>
              <!-- 核心数据汇总 -->
              <div class="summary-data">
                <div class="summary-title">空气质量检测实时统计</div>
                <div class="data-items-row">
                  <div class="data-item">
                    <div class="icon-wrap" style="background: rgba(138, 180, 248, 0.15);">
                      <svg viewBox="0 0 24 24" fill="none" stroke="#8ab4f8" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="2"></circle><path d="M16.24 7.76a6 6 0 0 1 0 8.49m-8.48-.01a6 6 0 0 1 0-8.49m11.31-2.82a10 10 0 0 1 0 14.14m-14.14 0a10 10 0 0 1 0-14.14"></path></svg>
                    </div>
                    <div class="data-info">
                      <span class="data-value primary">{{ totalAqiCount }}</span>
                      <span class="data-label">检测总数量</span>
                    </div>
                  </div>
                  <div class="data-item">
                    <div class="icon-wrap" style="background: rgba(129, 201, 149, 0.15);">
                      <svg viewBox="0 0 24 24" fill="none" stroke="#81c995" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9.59 4.59A2 2 0 1 1 11 8H2m10.59 11.41A2 2 0 1 0 14 16H2m15.73-8.27A2.5 2.5 0 1 1 19.5 12H2"></path></svg>
                    </div>
                    <div class="data-info">
                      <span class="data-value success">{{ goodAqiCount }}</span>
                      <span class="data-label">良好数量</span>
                    </div>
                  </div>
                  <div class="data-item">
                    <div class="icon-wrap" style="background: rgba(242, 139, 130, 0.15);">
                      <svg viewBox="0 0 24 24" fill="none" stroke="#f28b82" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path><line x1="12" y1="9" x2="12" y2="13"></line><line x1="12" y1="17" x2="12.01" y2="17"></line></svg>
                    </div>
                    <div class="data-info">
                      <span class="data-value danger">{{ totalAqiCount - goodAqiCount }}</span>
                      <span class="data-label">污染数量</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </dv-border-box-10>
        </div>
      </section>

      <!-- 右侧数据区 -->
      <aside class="side-panel right-panel">
        <div class="material-card chart-container">
          <dv-border-box-13 backgroundColor="#0a1631">
            <div class="inner-flex-container">
              <div class="chart-title-text text-center">悬浮颗粒物 (PM2.5) 浓度超标累计</div>
              <div class="chart-wrapper">
                 <VerticalBarChart :data="pm25Data" color="#8ab4f8" />
              </div>
            </div>
          </dv-border-box-13>
        </div>
        <div class="material-card chart-container">
          <dv-border-box-13 backgroundColor="#0a1631">
            <div class="inner-flex-container">
              <div class="chart-title-text text-center">二氧化硫 (SO2) 浓度超标累计</div>
              <div class="chart-wrapper">
                 <VerticalBarChart :data="so2Data" color="#81c995" />
              </div>
            </div>
          </dv-border-box-13>
        </div>
        <div class="material-card chart-container">
          <dv-border-box-13 backgroundColor="#0a1631">
            <div class="inner-flex-container">
              <div class="chart-title-text text-center">一氧化碳 (CO) 浓度超标累计</div>
              <div class="chart-wrapper">
                 <VerticalBarChart :data="coData" color="#f28b82" />
              </div>
            </div>
          </dv-border-box-13>
        </div>
      </aside>
    </main>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

import { getDashboardData } from '../api/statistics'

import CoverageChart from '../components/CoverageChart.vue'
import ChinaMap from '../components/ChinaMap.vue'
import AqiDistributeChart from '../components/AqiDistributeChart.vue'
import TrendChart from '../components/TrendChart.vue'
import VerticalBarChart from '../components/VerticalBarChart.vue'

const currentTime = ref('')
let timer = null
let dataTimer = null
const provinceCoverage = ref('0')
const cityCoverage = ref('0')
const totalAqiCount = ref(0)
const goodAqiCount = ref(0)
const aqiDistributeData = ref([])
const aqiTrendData = ref([])
const provinceTotalData = ref([])

const pm25Data = ref([])
const so2Data = ref([])
const coData = ref([])

const fetchDashboardData = async () => {
  try {
    const res = await getDashboardData();
    const data = res.data.data;

    provinceCoverage.value = parseFloat(data.provinceCoverage || '47') + ''
    cityCoverage.value = parseFloat(data.cityCoverage || '16') + ''
    
    totalAqiCount.value = data.totalAqiCount ?? 38
    goodAqiCount.value = data.goodAqiCount ?? 2

    aqiDistributeData.value = data.aqiDistributeData || []
    aqiTrendData.value = data.aqiTrendData || []
    provinceTotalData.value = data.provinceTotalData || []

    pm25Data.value = data.pm25Data || []
    so2Data.value = data.so2Data || []
    coData.value = data.coData || []
  } catch (error) {
    console.error('获取大屏数据失败:', error)
  }
}

onMounted(() => {
  fetchDashboardData();
  dataTimer = setInterval(fetchDashboardData, 5000); // 每5秒轮询一次大屏聚合数据
    
    const updateTime = () => {
      const now = new Date()
      const year = now.getFullYear()
      const month = String(now.getMonth() + 1).padStart(2, '0')
      const date = String(now.getDate()).padStart(2, '0')
      const hours = String(now.getHours()).padStart(2, '0')
      const minutes = String(now.getMinutes()).padStart(2, '0')
      const seconds = String(now.getSeconds()).padStart(2, '0')
      currentTime.value = `${year}-${month}-${date} ${hours}:${minutes}:${seconds}`
    }
    updateTime()
    timer = setInterval(updateTime, 1000)
})

onUnmounted(() => {
  if (timer) clearInterval(timer);
  if (dataTimer) clearInterval(dataTimer);
})
</script>

<style scoped>
.dashboard-page {
  width: 100vw;
  height: 100vh;
  background-color: #040b1c;
  color: #e8eaed; 
  font-family: 'Roboto', 'Helvetica Neue', Arial, sans-serif;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

/* 顶部标题栏 */
.top-header {
  height: 64px;
  background: #040b1c; /* 与页面背景一致 */
  border-bottom: 1px solid #14254b;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 24px;
  z-index: 10;
  flex-shrink: 0;
}

.header-left {
  flex: 1;
}

.title-container {
  flex: 2;
  display: flex;
  align-items: center;
  justify-content: center;
}

.title-text {
  font-size: 24px;
  font-weight: 500;
  color: #e8eaed;
  letter-spacing: 0.5px;
}

.header-actions {
  flex: 1;
  display: flex;
  justify-content: flex-end;
}

.time-text {
  color: #9aa0a6;
  font-size: 16px;
  font-weight: 500;
}

/* 主体布局 */
.main-content {
  display: flex;
  flex: 1;
  padding: 24px;
  gap: 24px;
  box-sizing: border-box;
  overflow: hidden; /* 防止页面出现滚动条 */
}

.side-panel {
  width: 25%;
  display: flex;
  flex-direction: column;
  gap: 24px;
  height: 100%;
}

.center-panel {
  width: 50%;
  display: flex;
  flex-direction: column;
  height: 100%;
}

.material-card {
  background: transparent; 
  border-radius: 8px;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.inner-flex-container {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100%;
}

/* 图表容器 */
.chart-container {
  flex: 1; /* 平分高度 */
  display: flex;
  flex-direction: column;
  position: relative;
  min-height: 0; 
}

.gauge-container {
  flex: 0.8; 
}

.pie-container {
  flex: 1.3; 
}

.trend-container {
  flex: 0.9;
}

.map-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  min-height: 0;
}

.chart-title-text {
  font-size: 14px;
  color: #9aa0a6;
  font-weight: 500;
  padding: 15px 15px 5px;
  z-index: 10;
}

.text-center {
  text-align: center;
}

/* 覆盖率模块特殊布局 */
.coverage-content {
  display: flex;
  justify-content: center;
  gap: 10px;
  align-items: center;
  flex: 1;
  min-height: 0;
}

.coverage-item {
  width: 45%;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/* 图表占位容器 */
.chart-wrapper {
  flex: 1;
  width: 100%;
  position: relative;
  min-height: 0;
}

.map-wrapper {
  flex: 1;
  width: 100%;
  position: relative;
  min-height: 0;
  border-bottom: 1px solid #14254b;
}

/* 中间面板数据 */
.summary-data {
  height: 140px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 0 20px;
  flex-shrink: 0;
  background: transparent; 
}

.summary-title {
  font-size: 16px;
  font-weight: 500;
  color: #e8eaed;
  margin-bottom: 15px;
}

.data-items-row {
  display: flex;
  justify-content: space-around;
  width: 100%;
}

.data-item {
  display: flex;
  align-items: center;
  gap: 15px;
}

.icon-wrap {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.icon-wrap svg {
  width: 24px;
  height: 24px;
}

.data-info {
  display: flex;
  flex-direction: column;
}

.data-value {
  font-size: 28px;
  font-weight: 400;
  line-height: 1.2;
  margin-bottom: 2px;
}

.data-value.primary { color: #8ab4f8; }
.data-value.success { color: #81c995; }
.data-value.danger { color: #f28b82; }

.data-label {
  font-size: 12px;
  color: #9aa0a6;
}
</style>
