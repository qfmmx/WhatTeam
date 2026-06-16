import { USE_MOCK } from '@/config'
import { mockGridProvince } from '@/mock'
import request from '@/utils/request'

export const listAllProvinces = () =>
  USE_MOCK ? mockGridProvince.listAll() : request.get('/gridProvince/listAll')
