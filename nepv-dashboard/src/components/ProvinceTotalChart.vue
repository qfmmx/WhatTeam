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

  // 对数据进行排序或者取前几名展示
  const chartData = [...props.data].sort((a, b) => a.exceedCount - b.exceedCount)
  
  const yData = chartData.map(item => item.provinceName || '未知')
  const xData = chartData.map(item => item.exceedCount || 0)

  const option = {
    tooltip: {
      trigger: 'axis',
      axisPointer: { type: 'shadow' }
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      top: '5%',
      containLabel: true
    },
    xAxis: {
      type: 'value',
      axisLabel: { color: '#5f6368' },
      splitLine: { lineStyle: { color: '#f1f3f4', type: 'dashed' } }
    },
    yAxis: {
      type: 'category',
      data: yData,
      axisLabel: { color: '#5f6368' },
      axisLine: { lineStyle: { color: '#e8eaed' } }
    },
    series: [
      {
        name: '累计超标次数',
        type: 'bar',
        barWidth: '60%',
        data: xData,
        itemStyle: {
          color: new echarts.graphic.LinearGradient(1, 0, 0, 0, [
            { offset: 0, color: '#34a853' },
            { offset: 1, color: '#4285f4' }
          ]),
          borderRadius: [0, 5, 5, 0]
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
