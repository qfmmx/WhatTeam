import request from '@/utils/request'

export const listAllProvinces = () => request.get('/gridProvince/listAll')
