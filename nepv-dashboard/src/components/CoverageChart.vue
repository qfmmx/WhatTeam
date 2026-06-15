<template>
  <div class="chart-container" ref="chartRef"></div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, watch } from 'vue'
import * as echarts from 'echarts'

const props = defineProps({
  title: {
    type: String,
    default: ''
  },
  percentageStr: {
    type: String,
    default: '0'
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

  const val = parseFloat(props.percentageStr) || 0

  const option = {
    title: {
      text: props.title,
      left: 'center',
      top: '0%',
      textStyle: {
        color: '#9aa0a6',
        fontSize: 14,
        fontWeight: '500'
      }
    },
    series: [
      {
        type: 'gauge',
        startAngle: 210,
        endAngle: -30,
        center: ['50%', '55%'], 
        radius: '80%',
        min: 0,
        max: 100,
        splitNumber: 2,
        axisLine: {
          lineStyle: {
            width: 10,
            color: [
              [1, '#14254b'] 
            ]
          }
        },
        progress: {
          show: true,
          width: 10,
          roundCap: true,
          itemStyle: {
            color: val < 20 ? '#ea4335' : (val < 50 ? '#fbbc04' : '#34a853')
          }
        },
        pointer: {
          show: false // 隐藏多余的指针，保持圆环纯净
        },
        axisTick: {
          show: false
        },
        splitLine: {
          show: false 
        },
        axisLabel: {
          color: '#9aa0a6',
          distance: -20,
          fontSize: 10,
          formatter: function (value) {
            if (value === 0 || value === 100) return value
            return ''
          }
        },
        detail: {
          fontSize: 26,
          fontWeight: 'bold',
          offsetCenter: [0, 0], 
          valueAnimation: true,
          formatter: '{value}%',
          color: '#e8eaed'
        },
        data: [
          {
            value: val
          }
        ]
      }
    ]
  }
  chartInstance.setOption(option)
}

watch([() => props.percentageStr, () => props.title], () => {
  updateChart()
})

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
