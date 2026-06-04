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
