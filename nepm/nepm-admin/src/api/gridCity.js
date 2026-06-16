import { USE_MOCK } from '@/config'
import { mockGridCity } from '@/mock'
import request from '@/utils/request'

export const listCitiesByProvince = (provinceId) =>
  USE_MOCK
    ? mockGridCity.listByProvince(provinceId)
    : request.get('/gridCity/listByProvince', { params: { provinceId } })
