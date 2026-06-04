import request from '@/utils/request'

export const listMembersByCity = (provinceId, cityId) =>
  request.get('/gridMember/listByCity', { params: { provinceId, cityId } })
