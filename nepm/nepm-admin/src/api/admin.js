import { USE_MOCK } from '@/config'
import { mockAdmins, mockFeedback } from '@/mock'
import request from '@/utils/request'

// ─── 管理员登录 ───────────────────────────────────────────
export const adminLogin = (data) =>
  USE_MOCK ? mockAdmins.login(data) : request.post('/auth/admin/login', data)

// ─── 公众监督反馈 ─────────────────────────────────────────
// 分页查询反馈列表  GET /feedback
export const getFeedbackPage = (params) =>
  USE_MOCK ? mockFeedback.page(params) : request.get('/feedback', { params })

// 反馈详情  GET /feedback/{afId}
export const getFeedbackDetail = (afId) =>
  USE_MOCK ? mockFeedback.detail(afId) : request.get(`/feedback/${afId}`)

// ─── 智能指派（本市优先、外省兜底）────────────────────────
// 本市在岗网格员  GET /feedback/{afId}/localMembers
export const getLocalGridMembers = (afId) =>
  USE_MOCK ? mockFeedback.localMembers(afId) : request.get(`/feedback/${afId}/localMembers`)

// 跨省可调派网格员  GET /feedback/{afId}/crossMembers
export const getCrossProvinceMembers = (afId) =>
  USE_MOCK ? mockFeedback.crossProvinceMembers(afId) : request.get(`/feedback/${afId}/crossMembers`)

// 提交指派  PUT /feedback/assign  body: { afId, gmId }
export const assignFeedback = (data) =>
  USE_MOCK ? mockFeedback.assign(data) : request.put('/feedback/assign', data)
