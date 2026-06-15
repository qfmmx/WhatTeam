<template>
  <div class="chart-container" ref="chartRef"></div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, watch } from 'vue'
import * as echarts from 'echarts'

const props = defineProps({
  data: {
    type: Array,
    default: () => []
  }
})

const chartRef = ref(null)
let chartInstance = null

const initChart = () => {
  if (!chartRef.value) return
  chartInstance = echarts.init(chartRef.value)
  updateChart()
}

const updateChart = () => {
  if (!chartInstance) return

  // 提取后两个字符作为 x 轴标签，比如 "2025-07" -> "07"
  const xData = props.data.map(item => item.month ? item.month.substring(5) : '')
  const yData = props.data.map(item => item.exceedCount || 0)


  const option = {
    tooltip: {
      trigger: 'axis',
      axisPointer: { type: 'line' },
      formatter: function (params) {
        let result = '<div style="font-size: 14px; color: #333; margin-bottom: 5px;">' + params[0].name + '月</div>';
        params.forEach(item => {
          result += '<div style="display: flex; align-items: center; justify-content: space-between; font-size: 14px; color: #666;">' + 
                    '<div style="display: flex; align-items: center;">' + item.marker + '<span style="margin-left: 5px;">' + item.seriesName + '</span></div>' + 
                    '<span style="margin-left: 15px; font-weight: bold; color: #333;">' + item.value + '</span></div>';
        });
        return result;
      }
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '10%',
      top: '15%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      boundaryGap: false,
      data: xData,
      axisLabel: { color: '#9aa0a6' },
      axisLine: { lineStyle: { color: '#3c4043' } }
    },
    yAxis: {
      type: 'value',
      axisLabel: { color: '#9aa0a6' },
      splitLine: { lineStyle: { color: '#3c4043', type: 'dashed' } }
    },
    series: [
      {
        name: '超标次数',
        type: 'line',
        smooth: true,
        data: yData,
        symbol: 'circle',
        symbolSize: 6,
        itemStyle: {
          color: '#4a90e2'
        },
        lineStyle: {
          width: 2,
          color: '#4a90e2'
        }
      }
    ]
  }
  chartInstance.setOption(option)
}

watch(() => props.data, () => {
  updateChart()
}, { deep: true })

const resizeHandler = () => {
  chartInstance?.resize()
}

onMounted(() => {
  initChart()
  window.addEventListener('resize', resizeHandler)
})

onUnmounted(() => {
  window.removeEventListener('resize', resizeHandler)
  chartInstance?.dispose()
})
</script>

<style scoped>
.chart-container {
  width: 100%;
  height: 100%;
}
</style>
