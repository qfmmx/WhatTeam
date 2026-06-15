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

  const pieData = props.data.map(item => ({
    name: item.levelName || '未知',
    value: item.count || 0
  }))

  const option = {
    tooltip: {
      trigger: 'item',
      formatter: '{b}: {c} ({d}%)'
    },
    legend: {
      orient: 'vertical',
      left: '15%',
      top: 'middle',
      textStyle: { color: '#9aa0a6' }
    },
    series: [
      {
        name: 'AQI分布',
        type: 'pie',
        radius: '60%',
        center: ['65%', '50%'],
        data: pieData,
        label: {
          show: false
        },
        labelLine: {
          show: false
        },
        itemStyle: {
          borderColor: '#303134',
          borderWidth: 1
        },
        color: ['#4a90e2', '#3de7c9', '#f5d142', '#f54254', '#36d1dc', '#9b59b6']
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
