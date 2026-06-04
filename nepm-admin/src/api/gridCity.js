import request from '@/utils/request'

export const listCitiesByProvince = (provinceId) =>
  request.get('/gridCity/listByProvince', { params: { provinceId } })
