import { USE_MOCK } from '@/config'
import { mockAdmins } from '@/mock'
import request from '@/utils/request'

export const login = (data) =>
  USE_MOCK ? mockAdmins.login(data) : request.post('/admins/login', data)
