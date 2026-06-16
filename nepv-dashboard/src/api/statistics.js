import axios from 'axios';

/**
 * 统一获取大屏聚合数据接口
 * 请求后端真实聚合接口，通过 vite.config.js 中的 proxy 进行代理
 */
export const getDashboardData = () => {
  return axios.get('/api/statistics/dashboard');
};
