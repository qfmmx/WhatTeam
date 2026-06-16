import { USE_MOCK } from '@/config'
import { mockStatistics } from '@/mock'
import request from '@/utils/request'

export const pageStatistics = (data) =>
  USE_MOCK ? mockStatistics.page(data) : request.post('/statistics/page', data)

export const getStatisticsById = (id) =>
  USE_MOCK ? mockStatistics.getById(id) : request.get(`/statistics/${id}`)

export const getProvinceTotal = () =>
  USE_MOCK ? mockStatistics.provinceTotal() : request.get('/statistics/provinceTotal')

export const getAqiDistribute = () =>
  USE_MOCK ? mockStatistics.aqiDistribute() : request.get('/statistics/aqiDistribute')

export const getAqiTrend = () =>
  USE_MOCK ? mockStatistics.trend() : request.get('/statistics/trend')

export const getAqiTotalCount = () =>
  USE_MOCK ? mockStatistics.totalCount() : request.get('/statistics/totalCount')

export const getAqiGoodCount = () =>
  USE_MOCK ? mockStatistics.goodCount() : request.get('/statistics/goodCount')

export const getProvinceCoverage = () =>
  USE_MOCK ? mockStatistics.provinceCoverage() : request.get('/statistics/provinceCoverage')

export const getCityCoverage = () =>
  USE_MOCK ? mockStatistics.cityCoverage() : request.get('/statistics/cityCoverage')
