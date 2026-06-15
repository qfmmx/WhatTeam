<template>
  <div class="chart-container" ref="chartRef">
    <div v-if="loading" class="loading-text">地图数据加载中...</div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, watch } from 'vue'
import * as echarts from 'echarts'
import axios from 'axios'

const props = defineProps({
  data: {
    type: Array,
    default: () => []
  },
  pm25Data: { type: Array, default: () => [] },
  so2Data: { type: Array, default: () => [] },
  coData: { type: Array, default: () => [] }
})

const chartRef = ref(null)
const loading = ref(true)
let chartInstance = null
let mapFeatures = []

const initChart = async () => {
  if (!chartRef.value) return
  
  chartInstance = echarts.init(chartRef.value)
  
  try {
    const mapRes = await axios.get('https://geo.datav.aliyun.com/areas_v3/bound/100000_full.json')
    mapFeatures = mapRes.data.features || []
    echarts.registerMap('china', mapRes.data)
    loading.value = false
    
    updateChart()
  } catch (error) {
    console.error('加载中国地图 GeoJSON 失败:', error)
    loading.value = false
  }
}

const updateChart = () => {
  if (!chartInstance) return

  const mapData = props.data.map(item => {
    let rawName = item.provinceName || ''
    let matchName = rawName
    if (mapFeatures.length > 0) {
      // 模糊匹配省份名称以兼容后端数据与GeoJSON命名差异
      const feature = mapFeatures.find(f => f.properties.name.includes(rawName) || rawName.includes(f.properties.name))
      if (feature) {
        matchName = feature.properties.name
      }
    }
    return {
      name: matchName,
      rawName: rawName,
      value: item.exceedCount || 0
    }
  })

  let maxVal = 500
  if (mapData.length > 0) {
    const dataMax = Math.max(...mapData.map(d => d.value))
    if (dataMax > 0) {
      maxVal = dataMax
    }
  }

  const option = {
    tooltip: {
      trigger: 'item',
      formatter: function(params) {
        const matchName = params.name
        const dataItem = mapData.find(d => d.name === matchName)
        let pm25 = 0, so2 = 0, co = 0
        let total = params.value || 0
        
        if (dataItem) {
          const rawName = dataItem.rawName || matchName
          
          const abbrMap = {
            '京': '北京', '津': '天津', '冀': '河北', '晋': '山西', '蒙': '内蒙古',
            '辽': '辽宁', '吉': '吉林', '黑': '黑龙江', '沪': '上海', '苏': '江苏',
            '浙': '浙江', '皖': '安徽', '闽': '福建', '赣': '江西', '鲁': '山东',
            '豫': '河南', '鄂': '湖北', '湘': '湖南', '粤': '广东', '桂': '广西',
            '琼': '海南', '渝': '重庆', '川': '四川', '贵': '贵州', '云': '云南',
            '藏': '西藏', '陕': '陕西', '甘': '甘肃', '青': '青海', '宁': '宁夏',
            '新': '新疆', '台': '台湾', '港': '香港', '澳': '澳门'
          };

          const findValue = (arr, rn, mn) => {
            const found = arr.find(a => {
              if (!a.name) return false;
              if (a.name.includes(rn) || rn.includes(a.name) || a.name.includes(mn) || mn.includes(a.name)) return true;
              
              const mappedName = abbrMap[a.name];
              if (mappedName && (mappedName.includes(rn) || rn.includes(mappedName) || mappedName.includes(mn) || mn.includes(mappedName))) {
                return true;
              }
              return false;
            })
            return found ? (found.value || 0) : 0
          }
          pm25 = findValue(props.pm25Data, rawName, matchName)
          so2 = findValue(props.so2Data, rawName, matchName)
          co = findValue(props.coData, rawName, matchName)
        }

        return `
          <div style="font-weight:bold;margin-bottom:5px;">${matchName}</div>
          总超标次数：${total}<br/>
          PM2.5超标次数：${pm25}<br/>
          SO2超标次数：${so2}<br/>
          CO超标次数：${co}
        `
      }
    },
    visualMap: {
      min: 0,
      max: maxVal,
      left: 10,
      bottom: '10%',
      text: ['高', '低'],
      calculable: false, 
      hoverLink: false, 
      inRange: {
        color: ['#ffffff', '#f5d142', '#f54254'] 
      },
      textStyle: {
        color: '#9aa0a6'
      }
    },
    graphic: [
      {
        type: 'text',
        left: 55, // 放置在标尺右侧
        bottom: '15%',
        style: {
          text: '超\n标\n程\n度',
          fill: '#9aa0a6',
          fontSize: 12
        }
      }
    ],
    series: [
      {
        name: '省份数据',
        type: 'map',
        map: 'china',
        roam: false, 
        zoom: 1.2,
        selectedMode: false, 
        select: { disabled: true },
        label: {
          show: true,
          color: '#333',
          fontSize: 10
        },
        itemStyle: {
          areaColor: '#ffffff',
          borderColor: '#a0aab8',
          borderWidth: 1
        },
        emphasis: {
          focus: 'self',
          label: {
            show: true,
            color: '#000'
          },
          itemStyle: {
            areaColor: '#f5d142' // 悬浮时的颜色
          }
        },
        blur: {
          itemStyle: {
            opacity: 0.3
          },
          label: {
            show: false
          }
        },
        data: mapData
      }
    ]
  }
  chartInstance.setOption(option)
}

watch(() => props.data, () => {
  if (!loading.value) {
    updateChart()
  }
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
  position: relative;
}
.loading-text {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  color: #4a90e2;
  font-size: 16px;
}
</style>
