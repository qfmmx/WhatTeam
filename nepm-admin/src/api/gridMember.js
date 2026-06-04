import { USE_MOCK } from '@/config'
import { mockGridMember } from '@/mock'
import request from '@/utils/request'

export const listMembersByCity = (provinceId, cityId) =>
  USE_MOCK
    ? mockGridMember.listByCity(provinceId, cityId)
    : request.get('/gridMember/listByCity', { params: { provinceId, cityId } })
