import axios from 'axios';

// 模拟的聚合数据字典
const MOCK_DASHBOARD_DATA = {
  provinceCoverage: '45.3%',
  cityCoverage: '22.5%',
  totalAqiCount: 1789,
  goodAqiCount: 1500,
  aqiDistributeData: [
    { level: 1, levelName: '优', count: 800, percentage: '44.7%' },
    { level: 2, levelName: '良', count: 700, percentage: '39.1%' },
    { level: 3, levelName: '轻度污染', count: 150, percentage: '8.4%' },
    { level: 4, levelName: '中度污染', count: 80, percentage: '4.5%' },
    { level: 5, levelName: '重度污染', count: 40, percentage: '2.2%' },
    { level: 6, levelName: '严重污染', count: 19, percentage: '1.1%' }
  ],
  aqiTrendData: [
    { month: '2025-07', exceedCount: 15 },
    { month: '2025-08', exceedCount: 20 },
    { month: '2025-09', exceedCount: 18 },
    { month: '2025-10', exceedCount: 30 },
    { month: '2025-11', exceedCount: 40 },
    { month: '2025-12', exceedCount: 50 },
    { month: '2026-01', exceedCount: 45 },
    { month: '2026-02', exceedCount: 30 },
    { month: '2026-03', exceedCount: 20 },
    { month: '2026-04', exceedCount: 10 },
    { month: '2026-05', exceedCount: 6 },
    { month: '2026-06', exceedCount: 5 }
  ],
  provinceTotalData: [
    { provinceName: '北京', exceedCount: 15, totalCount: 365, exceedRate: '4.1%' },
    { provinceName: '天津', exceedCount: 6, totalCount: 365, exceedRate: '1.6%' },
    { provinceName: '河北', exceedCount: 30, totalCount: 365, exceedRate: '8.2%' },
    { provinceName: '山西', exceedCount: 38, totalCount: 365, exceedRate: '10.4%' },
    { provinceName: '内蒙古', exceedCount: 17, totalCount: 365, exceedRate: '4.7%' },
    { provinceName: '辽宁', exceedCount: 24, totalCount: 365, exceedRate: '6.6%' },
    { provinceName: '吉林', exceedCount: 11, totalCount: 365, exceedRate: '3.0%' },
    { provinceName: '黑龙江', exceedCount: 17, totalCount: 365, exceedRate: '4.7%' },
    { provinceName: '上海', exceedCount: 3, totalCount: 365, exceedRate: '0.8%' },
    { provinceName: '江苏', exceedCount: 8, totalCount: 365, exceedRate: '2.2%' },
    { provinceName: '浙江', exceedCount: 4, totalCount: 365, exceedRate: '1.1%' },
    { provinceName: '安徽', exceedCount: 12, totalCount: 365, exceedRate: '3.3%' },
    { provinceName: '福建', exceedCount: 3, totalCount: 365, exceedRate: '0.8%' },
    { provinceName: '江西', exceedCount: 7, totalCount: 365, exceedRate: '1.9%' },
    { provinceName: '山东', exceedCount: 25, totalCount: 365, exceedRate: '6.8%' },
    { provinceName: '河南', exceedCount: 18, totalCount: 365, exceedRate: '4.9%' },
    { provinceName: '湖北', exceedCount: 5, totalCount: 365, exceedRate: '1.4%' },
    { provinceName: '湖南', exceedCount: 2, totalCount: 365, exceedRate: '0.5%' },
    { provinceName: '广东', exceedCount: 0, totalCount: 365, exceedRate: '0.0%' },
    { provinceName: '广西', exceedCount: 0, totalCount: 365, exceedRate: '0.0%' },
    { provinceName: '海南', exceedCount: 0, totalCount: 365, exceedRate: '0.0%' },
    { provinceName: '重庆', exceedCount: 5, totalCount: 365, exceedRate: '1.4%' },
    { provinceName: '四川', exceedCount: 9, totalCount: 365, exceedRate: '2.5%' },
    { provinceName: '贵州', exceedCount: 2, totalCount: 365, exceedRate: '0.5%' },
    { provinceName: '云南', exceedCount: 0, totalCount: 365, exceedRate: '0.0%' },
    { provinceName: '西藏', exceedCount: 0, totalCount: 365, exceedRate: '0.0%' },
    { provinceName: '陕西', exceedCount: 12, totalCount: 365, exceedRate: '3.3%' },
    { provinceName: '甘肃', exceedCount: 5, totalCount: 365, exceedRate: '1.4%' },
    { provinceName: '青海', exceedCount: 0, totalCount: 365, exceedRate: '0.0%' },
    { provinceName: '宁夏', exceedCount: 2, totalCount: 365, exceedRate: '0.5%' },
    { provinceName: '新疆', exceedCount: 9, totalCount: 365, exceedRate: '2.5%' },
    { provinceName: '台湾', exceedCount: 0, totalCount: 365, exceedRate: '0.0%' },
    { provinceName: '香港', exceedCount: 0, totalCount: 365, exceedRate: '0.0%' },
    { provinceName: '澳门', exceedCount: 0, totalCount: 365, exceedRate: '0.0%' }
  ],
  pm25Data: [
    { name: '京', value: 5 }, { name: '津', value: 3 }, { name: '冀', value: 12 },
    { name: '晋', value: 15 }, { name: '蒙', value: 8 }, { name: '辽', value: 10 },
    { name: '吉', value: 6 }, { name: '黑', value: 9 }, { name: '沪', value: 2 },
    { name: '苏', value: 4 }, { name: '浙', value: 2 }, { name: '皖', value: 5 },
    { name: '闽', value: 1 }, { name: '赣', value: 3 }, { name: '鲁', value: 11 },
    { name: '豫', value: 8 }, { name: '鄂', value: 2 }, { name: '湘', value: 1 },
    { name: '粤', value: 0 }, { name: '桂', value: 0 }, { name: '琼', value: 0 },
    { name: '渝', value: 2 }, { name: '川', value: 4 }, { name: '贵', value: 1 },
    { name: '云', value: 0 }, { name: '藏', value: 0 }, { name: '陕', value: 5 },
    { name: '甘', value: 2 }, { name: '青', value: 0 }, { name: '宁', value: 1 },
    { name: '新', value: 3 }, { name: '台', value: 0 }, { name: '港', value: 0 }, { name: '澳', value: 0 }
  ],
  so2Data: [
    { name: '京', value: 4 }, { name: '津', value: 1 }, { name: '冀', value: 8 },
    { name: '晋', value: 10 }, { name: '蒙', value: 4 }, { name: '辽', value: 6 },
    { name: '吉', value: 2 }, { name: '黑', value: 3 }, { name: '沪', value: 1 },
    { name: '苏', value: 2 }, { name: '浙', value: 1 }, { name: '皖', value: 3 },
    { name: '闽', value: 1 }, { name: '赣', value: 2 }, { name: '鲁', value: 6 },
    { name: '豫', value: 4 }, { name: '鄂', value: 1 }, { name: '湘', value: 0 },
    { name: '粤', value: 0 }, { name: '桂', value: 0 }, { name: '琼', value: 0 },
    { name: '渝', value: 1 }, { name: '川', value: 2 }, { name: '贵', value: 0 },
    { name: '云', value: 0 }, { name: '藏', value: 0 }, { name: '陕', value: 3 },
    { name: '甘', value: 1 }, { name: '青', value: 0 }, { name: '宁', value: 0 },
    { name: '新', value: 2 }, { name: '台', value: 0 }, { name: '港', value: 0 }, { name: '澳', value: 0 }
  ],
  coData: [
    { name: '京', value: 6 }, { name: '津', value: 2 }, { name: '冀', value: 10 },
    { name: '晋', value: 13 }, { name: '蒙', value: 5 }, { name: '辽', value: 8 },
    { name: '吉', value: 3 }, { name: '黑', value: 5 }, { name: '沪', value: 0 },
    { name: '苏', value: 2 }, { name: '浙', value: 1 }, { name: '皖', value: 4 },
    { name: '闽', value: 1 }, { name: '赣', value: 2 }, { name: '鲁', value: 8 },
    { name: '豫', value: 6 }, { name: '鄂', value: 2 }, { name: '湘', value: 1 },
    { name: '粤', value: 0 }, { name: '桂', value: 0 }, { name: '琼', value: 0 },
    { name: '渝', value: 2 }, { name: '川', value: 3 }, { name: '贵', value: 1 },
    { name: '云', value: 0 }, { name: '藏', value: 0 }, { name: '陕', value: 4 },
    { name: '甘', value: 2 }, { name: '青', value: 0 }, { name: '宁', value: 1 },
    { name: '新', value: 4 }, { name: '台', value: 0 }, { name: '港', value: 0 }, { name: '澳', value: 0 }
  ]
};

/**
 * 统一获取大屏聚合数据接口
 * 在前端基于 Axios 封装
 */
export const getDashboardData = () => {
  // 本地开发模拟 Axios 响应，体验 5 秒轮询效果
  return new Promise((resolve) => {
    setTimeout(() => {
      const randomOffset = Math.floor(Math.random() * 5);
      const clonedData = JSON.parse(JSON.stringify(MOCK_DASHBOARD_DATA));
      clonedData.totalAqiCount += randomOffset;
      clonedData.goodAqiCount += randomOffset;

      resolve({
        status: 200,
        statusText: 'OK',
        data: {
          code: 200,
          message: 'success',
          data: clonedData
        }
      });
    }, 300); // 模拟网络延迟
  });
};
