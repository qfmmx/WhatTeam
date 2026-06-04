import request from '@/utils/request'

export const pageAqiFeedback = (data) => request.post('/aqiFeedback/page', data)
export const getAqiFeedbackById = (id) => request.get(`/aqiFeedback/${id}`)
export const assignAqiFeedback = (data) => request.put('/aqiFeedback/assign', data)
export const updateAqiFeedbackState = (data) => request.put('/aqiFeedback/state', data)
