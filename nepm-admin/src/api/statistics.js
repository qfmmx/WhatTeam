import request from '@/utils/request'

export const pageStatistics = (data) => request.post('/statistics/page', data)
export const getStatisticsById = (id) => request.get(`/statistics/${id}`)
export const getProvinceTotal = () => request.get('/statistics/provinceTotal')
export const getAqiDistribute = () => request.get('/statistics/aqiDistribute')
export const getAqiTrend = () => request.get('/statistics/trend')
export const getAqiTotalCount = () => request.get('/statistics/totalCount')
export const getAqiGoodCount = () => request.get('/statistics/goodCount')
export const getProvinceCoverage = () => request.get('/statistics/provinceCoverage')
export const getCityCoverage = () => request.get('/statistics/cityCoverage')
