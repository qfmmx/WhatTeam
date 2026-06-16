import {
  PROVINCES, CITIES, GRID_MEMBERS,
  AQI_FEEDBACKS, STATISTICS_RECORDS
} from './data'

// 通用分页工具
function paginate(list, pageNum, pageSize) {
  const start = (pageNum - 1) * pageSize
  const records = list.slice(start, start + pageSize)
  return {
    total: list.length,
    pages: Math.ceil(list.length / pageSize),
    current: pageNum,
    size: pageSize,
    records
  }
}

// 模拟网络延迟（ms）
function delay(ms = 200) {
  return new Promise(resolve => setTimeout(resolve, ms))
}

function ok(data, message = '操作成功') {
  return { code: 200, message, data }
}

function fail(message, code = 400) {
  return Promise.reject({ code, message })
}

// 依据 cityCode 解析所属省 / 市
function resolveCity(cityCode) {
  const city = Object.values(CITIES).flat().find(c => c.cityCode === cityCode)
  if (!city) return null
  const province = PROVINCES.find(p => p.id === city.provinceId)
  return { city, province }
}

// 跨所有城市按 id 查找网格员
function findMemberById(gmId) {
  for (const list of Object.values(GRID_MEMBERS)) {
    const m = list.find(x => x.id === Number(gmId))
    if (m) return m
  }
  return null
}

// 本市在岗（status === 1）网格员
function localOnDutyMembers(provinceId, cityId) {
  return (GRID_MEMBERS[`${provinceId}-${cityId}`] || []).filter(m => m.status === 1)
}

// ─── 管理员模块 ──────────────────────────────────────────
export const mockAdmins = {
  async login({ adminCode, password }) {
    await delay()
    if (adminCode === 'admin001' && password === '123456') {
      return ok({
        id: 1, adminCode: 'admin001', adminName: '系统管理员',
        role: 'super', status: 1
      }, '登录成功')
    }
    const { ElMessage } = await import('element-plus')
    ElMessage.error('编码或密码错误')
    return Promise.reject(new Error('编码或密码错误'))
  }
}

// ─── 省份模块 ─────────────────────────────────────────────
export const mockGridProvince = {
  async listAll() {
    await delay()
    return ok(PROVINCES, '查询成功')
  }
}

// ─── 城市模块 ─────────────────────────────────────────────
export const mockGridCity = {
  async listByProvince(provinceId) {
    await delay()
    return ok(CITIES[provinceId] || [], '查询成功')
  }
}

// ─── 网格员模块 ───────────────────────────────────────────
export const mockGridMember = {
  async listByCity(provinceId, cityId) {
    await delay()
    const key = `${provinceId}-${cityId}`
    const defaultMembers = [
      { id: 99, memberCode: 'gm9901', memberName: '张网格', phone: '13900000001', provinceId, cityId, status: 1 },
      { id: 100, memberCode: 'gm9902', memberName: '李网格', phone: '13900000002', provinceId, cityId, status: 1 },
    ]
    return ok(GRID_MEMBERS[key] || defaultMembers, '查询成功')
  }
}

// ─── AQI 反馈模块 ─────────────────────────────────────────
// 内存中可变副本，支持指派操作
const feedbackStore = AQI_FEEDBACKS.map(item => ({ ...item }))

export const mockAqiFeedback = {
  async page(params) {
    await delay()
    let list = [...feedbackStore]

    if (params.state !== undefined && params.state !== null && params.state !== '') {
      list = list.filter(f => f.state === Number(params.state))
    }
    if (params.cityCode) {
      list = list.filter(f => f.cityCode.includes(params.cityCode))
    }
    if (params.telId) {
      list = list.filter(f => f.telId.includes(params.telId))
    }
    if (params.startTime) {
      list = list.filter(f => f.feedbackTime >= params.startTime)
    }
    if (params.endTime) {
      list = list.filter(f => f.feedbackTime <= params.endTime)
    }

    // 按id降序
    list.sort((a, b) => b.id - a.id)
    return ok(paginate(list, params.pageNum, params.pageSize), '查询成功')
  },

  async getById(id) {
    await delay()
    const item = feedbackStore.find(f => f.id === Number(id))
    if (!item) return Promise.reject({ code: 404, message: '记录不存在' })
    return ok(item, '查询成功')
  },

  async assign({ id, gmId }) {
    await delay(300)
    const item = feedbackStore.find(f => f.id === Number(id))
    if (item) {
      item.gmId = gmId
      item.state = 1
      item.assignTime = new Date().toLocaleString('zh-CN').replace(/\//g, '-')
      // 查找网格员姓名
      for (const members of Object.values(GRID_MEMBERS)) {
        const m = members.find(m => m.id === gmId)
        if (m) { item.gmName = m.memberName; break }
      }
    }
    return ok(1, '指派成功')
  },

  async updateState({ id, state }) {
    await delay(200)
    const item = feedbackStore.find(f => f.id === Number(id))
    if (item) item.state = state
    return ok(1, '更新成功')
  }
}

// ─── 统计模块 ─────────────────────────────────────────────
export const mockStatistics = {
  async page(params) {
    await delay()
    let list = [...STATISTICS_RECORDS]

    if (params.cityName) {
      // 通过城市名称模糊匹配 cityCode（简化逻辑）
      const allCities = Object.values(CITIES).flat()
      const matchCodes = allCities
        .filter(c => c.cityName.includes(params.cityName))
        .map(c => c.cityCode)
      list = list.filter(s => matchCodes.includes(s.cityCode))
    }
    if (params.isExceed !== undefined && params.isExceed !== null && params.isExceed !== '') {
      list = list.filter(s => s.isExceed === Number(params.isExceed))
    }
    if (params.startTime) {
      list = list.filter(s => s.confirmTime >= params.startTime)
    }
    if (params.endTime) {
      list = list.filter(s => s.confirmTime <= params.endTime)
    }

    list.sort((a, b) => b.id - a.id)
    return ok(paginate(list, params.pageNum, params.pageSize), '查询成功')
  },

  async getById(id) {
    await delay()
    const item = STATISTICS_RECORDS.find(s => s.id === Number(id))
    if (!item) return Promise.reject({ code: 404, message: '记录不存在' })
    return ok(item, '查询成功')
  },

  async provinceTotal() {
    await delay()
    const provinceMap = {}
    for (const p of PROVINCES) {
      provinceMap[p.provinceCode.slice(0, 2)] = {
        provinceName: p.provinceName,
        exceedCount: 0,
        totalCount: 0
      }
    }
    for (const s of STATISTICS_RECORDS) {
      const key = s.cityCode.slice(0, 2)
      if (provinceMap[key]) {
        provinceMap[key].totalCount++
        if (s.isExceed) provinceMap[key].exceedCount++
      }
    }
    const result = Object.values(provinceMap)
      .filter(p => p.totalCount > 0)
      .map(p => ({
        ...p,
        exceedRate: p.totalCount > 0
          ? ((p.exceedCount / p.totalCount) * 100).toFixed(1) + '%'
          : '0%'
      }))
    return ok(result, '查询成功')
  },

  async aqiDistribute() {
    await delay()
    const levelNames = ['优', '良', '轻度污染', '中度污染', '重度污染', '严重污染']
    const counts = [0, 0, 0, 0, 0, 0]
    for (const s of STATISTICS_RECORDS) {
      const v = s.aqiValue
      if (v <= 50) counts[0]++
      else if (v <= 100) counts[1]++
      else if (v <= 150) counts[2]++
      else if (v <= 200) counts[3]++
      else if (v <= 300) counts[4]++
      else counts[5]++
    }
    const total = STATISTICS_RECORDS.length
    const data = counts.map((count, i) => ({
      level: i + 1,
      levelName: levelNames[i],
      count,
      percentage: total > 0 ? ((count / total) * 100).toFixed(1) + '%' : '0%'
    }))
    return ok(data, '查询成功')
  },

  async trend() {
    await delay()
    const monthMap = {}
    // 生成近12个月
    for (let i = 11; i >= 0; i--) {
      const d = new Date()
      d.setMonth(d.getMonth() - i)
      const key = `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}`
      monthMap[key] = 0
    }
    for (const s of STATISTICS_RECORDS) {
      const key = s.confirmTime.slice(0, 7)
      if (key in monthMap && s.isExceed) monthMap[key]++
    }
    const data = Object.entries(monthMap).map(([month, exceedCount]) => ({ month, exceedCount }))
    return ok(data, '查询成功')
  },

  async totalCount() {
    await delay()
    return ok(STATISTICS_RECORDS.length, '查询成功')
  },

  async goodCount() {
    await delay()
    const count = STATISTICS_RECORDS.filter(s => s.aqiValue <= 100).length
    return ok(count, '查询成功')
  },

  async provinceCoverage() {
    await delay()
    const coveredCodes = new Set(STATISTICS_RECORDS.map(s => s.cityCode.slice(0, 2)))
    const rate = ((coveredCodes.size / 34) * 100).toFixed(1) + '%'
    return ok(rate, '查询成功')
  },

  async cityCoverage() {
    await delay()
    const coveredCodes = new Set(STATISTICS_RECORDS.map(s => s.cityCode))
    const rate = ((coveredCodes.size / 106) * 100).toFixed(1) + '%'
    return ok(rate, '查询成功')
  }
}

// ─── 公众监督反馈模块（admin.js）──────────────────────────
// 智能指派规则：本市优先、外省兜底，城市权限由「后端」(本 mock) 统一校验
export const mockFeedback = {
  // 分页查询：复用 AQI 反馈分页，并补充城市名称
  async page(params) {
    const res = await mockAqiFeedback.page(params)
    res.data.records = res.data.records.map(r => ({
      ...r,
      cityName: resolveCity(r.cityCode)?.city.cityName || r.cityCode
    }))
    return res
  },

  // 详情：依据 afId 查询，并附带城市名称
  async detail(afId) {
    const res = await mockAqiFeedback.getById(afId)
    const r = resolveCity(res.data.cityCode)
    res.data = {
      ...res.data,
      cityName: r?.city.cityName || res.data.cityCode,
      provinceName: r?.province.provinceName || '-'
    }
    return res
  },

  // 本市网格员：后端依据 afId 反查反馈省市，匹配本市在岗人员
  async localMembers(afId) {
    await delay()
    const fb = feedbackStore.find(f => f.id === Number(afId))
    if (!fb) return fail('反馈单不存在', 404)
    const r = resolveCity(fb.cityCode)
    if (!r) {
      return ok({ cityName: fb.cityCode, provinceName: '-', hasLocal: false, members: [] }, '本市无可用网格员')
    }
    const members = localOnDutyMembers(r.province.id, r.city.id)
    return ok({
      provinceId: r.province.id,
      provinceName: r.province.provinceName,
      cityId: r.city.id,
      cityName: r.city.cityName,
      hasLocal: members.length > 0,
      members
    }, members.length ? '查询成功' : '本市无可用网格员')
  },

  // 跨省网格员：后端先校验本市确无在岗人员，再返回外省在岗网格员
  async crossProvinceMembers(afId) {
    await delay()
    const fb = feedbackStore.find(f => f.id === Number(afId))
    if (!fb) return fail('反馈单不存在', 404)
    const r = resolveCity(fb.cityCode)
    if (r && localOnDutyMembers(r.province.id, r.city.id).length > 0) {
      return fail('本市存在可用网格员，禁止跨省调派')
    }
    const ownProvinceId = r?.province.id
    const result = []
    for (const [key, list] of Object.entries(GRID_MEMBERS)) {
      const [pid, cid] = key.split('-').map(Number)
      if (pid === ownProvinceId) continue
      const province = PROVINCES.find(p => p.id === pid)
      const city = (CITIES[pid] || []).find(c => c.id === cid)
      for (const m of list.filter(x => x.status === 1)) {
        result.push({ ...m, provinceName: province?.provinceName, cityName: city?.cityName })
      }
    }
    return ok(result, '查询成功')
  },

  // 提交指派：后端二次校验城市权限
  async assign({ afId, gmId }) {
    await delay(300)
    const fb = feedbackStore.find(f => f.id === Number(afId))
    if (!fb) return fail('反馈单不存在', 404)
    if (fb.state !== 0) return fail('该反馈已指派，请勿重复操作')

    const member = findMemberById(gmId)
    if (!member || member.status !== 1) return fail('所选网格员不可用')

    const r = resolveCity(fb.cityCode)
    const localMembers = r ? localOnDutyMembers(r.province.id, r.city.id) : []
    const isLocalMember = localMembers.some(m => m.id === Number(gmId))

    if (localMembers.length > 0) {
      // 本市有人 → 必须指派本市人员
      if (!isLocalMember) return fail('本市存在可用网格员，必须指派本市人员')
    }
    // 本市无人 → 允许跨省（此时所选必为外省人员，已通过 status 校验）

    fb.gmId = member.id
    fb.gmName = member.memberName
    fb.state = 1
    fb.isRemote = localMembers.length === 0
    fb.assignTime = new Date().toLocaleString('zh-CN').replace(/\//g, '-')
    return ok(1, fb.isRemote ? '跨省调派成功' : '本市指派成功')
  }
}
