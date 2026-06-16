import { USE_MOCK } from '@/config'
import { mockAqiFeedback } from '@/mock'
import request from '@/utils/request'

export const pageAqiFeedback = (data) =>
  USE_MOCK ? mockAqiFeedback.page(data) : request.post('/aqiFeedback/page', data)

export const getAqiFeedbackById = (id) =>
  USE_MOCK ? mockAqiFeedback.getById(id) : request.get(`/aqiFeedback/${id}`)

export const assignAqiFeedback = (data) =>
  USE_MOCK ? mockAqiFeedback.assign(data) : request.put('/aqiFeedback/assign', data)

export const updateAqiFeedbackState = (data) =>
  USE_MOCK ? mockAqiFeedback.updateState(data) : request.put('/aqiFeedback/state', data)
