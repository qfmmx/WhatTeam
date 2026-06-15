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
  },
  color: {
    type: String,
    default: '#1a73e8' 
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

  let currentStart = 0
  let currentEnd = 40
  
  try {
    const currentOption = chartInstance.getOption()
    if (currentOption && currentOption.dataZoom && currentOption.dataZoom.length > 0) {
      currentStart = currentOption.dataZoom[0].start
      currentEnd = currentOption.dataZoom[0].end
    }
  } catch (e) {
    // ignore
  }

  const xData = props.data.map(item => item.name || '')
  const yData = props.data.map(item => item.value || 0)

  const option = {
    tooltip: {
      trigger: 'axis',
      axisPointer: { type: 'shadow' }
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '22%', // 留出滚动条空间
      top: '15%',
      containLabel: true
    },
    dataZoom: [
      {
        type: 'inside',
        xAxisIndex: [0],
        start: currentStart,
        end: currentEnd
      },
      {
        type: 'slider',
        xAxisIndex: [0],
        start: currentStart,
        end: currentEnd,
        bottom: 5,
        height: 10,
        borderColor: 'transparent',
        backgroundColor: '#0a1631',
        fillerColor: 'rgba(138, 180, 248, 0.4)',
        handleStyle: {
          color: props.color
        },
        textStyle: {
          color: 'transparent'
        }
      }
    ],
    xAxis: {
      type: 'category',
      data: xData,
      axisLabel: { color: '#9aa0a6', interval: 0 },
      axisLine: { lineStyle: { color: '#3c4043' } }
    },
    yAxis: {
      type: 'value',
      axisLabel: { color: '#9aa0a6' },
      splitLine: { lineStyle: { color: '#3c4043', type: 'dashed' } }
    },
    series: [
      {
        type: 'bar',
        barWidth: '50%',
        data: yData,
        itemStyle: {
          color: props.color
        }
      }
    ]
  }
  chartInstance.setOption(option)
}

watch([() => props.data, () => props.color], () => {
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
