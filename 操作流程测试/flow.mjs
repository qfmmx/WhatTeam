import pkg from '/Users/qfmmx/.npm/_npx/e41f203b7505f1fb/node_modules/playwright/index.js'
const { chromium } = pkg
const EXEC = '/Users/qfmmx/Library/Caches/ms-playwright/chromium-1223/chrome-mac-arm64/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing'
const SHOT = './操作流程测试/截图'
const VID  = './操作流程测试/录屏'
const SIZE = { width: 1280, height: 800 }
const phone = '139' + String(Date.now()).slice(-8)
let n = 0
const sleep = ms => new Promise(r => setTimeout(r, ms))

const browser = await chromium.launch({ executablePath: EXEC })
const context = await browser.newContext({ viewport: SIZE, recordVideo: { dir: VID, size: SIZE } })
context.setDefaultTimeout(8000)          // 失败步骤最多等 8s，避免长时间黑屏
const page = await context.newPage()

async function shot(name) { n++; await sleep(700); await page.screenshot({ path: `${SHOT}/${String(n).padStart(2,'0')}-${name}.png` }); console.log('shot', name) }
async function step(label, fn) { try { await fn() } catch (e) { console.log('  ⚠ '+label+': '+e.message.split('\n')[0]) } }
const waitOptions = (idx) => page.waitForFunction(i => { const s = document.querySelectorAll('select')[i]; return s && s.options.length > 1 }, idx, { timeout: 8000 })

// ============ 1) 公众监督员端 (8084) — 注册→登录→选网格→反馈 ============
await page.goto('http://localhost:8084/login', { waitUntil: 'networkidle' }).catch(()=>{})
await shot('监督员-登录页')
// 注册
await step('进入注册', async () => { await page.getByText('注册').first().click(); await sleep(700) })
await step('填注册', async () => {
  await page.locator('input[placeholder="请输入手机号码"]').fill(phone)
  await page.locator('input[placeholder="真实姓名便于我们联系您"]').fill('流程测试员')
  await page.locator('input[placeholder="年龄"]').fill('28')
  await page.locator('input[type=radio]').first().check()
  await page.locator('input[placeholder="请输入密码"]').fill('123456')
  await page.locator('input[placeholder="请再次输入密码"]').fill('123456')
})
await shot('监督员-注册填写')
await step('提交注册', async () => { await page.getByRole('button', { name: /^注册/ }).click(); await sleep(1200) })
await shot('监督员-注册结果')
// 登录（回到登录页，登录后由 app 自动进入选网格页）
await page.goto('http://localhost:8084/login', { waitUntil: 'networkidle' }).catch(()=>{})
await step('登录', async () => {
  await page.locator('input[placeholder="输入手机号"]').fill(phone)
  await page.locator('input[placeholder="输入登录密码"]').fill('123456')
  await page.getByRole('button', { name: /^登录/ }).click()
  await page.waitForURL('**/grid', { timeout: 8000 }).catch(()=>{})
  await sleep(1000)
})
await shot('监督员-登录后(选网格)')
// 选择网格地址（等省份选项加载）
await step('选省', async () => { await waitOptions(0); await page.locator('select').first().selectOption({ index: 1 }); await sleep(1000) })
await step('选市', async () => { await waitOptions(1); await page.locator('select').nth(1).selectOption({ index: 1 }) })
await step('填地址', async () => { await page.locator('[placeholder="具体地址"]').fill('XX路XX号网格监测点') })
await shot('监督员-选择网格地址')
await step('下一步', async () => { await page.getByRole('button', { name: /下一步/ }).click(); await sleep(1200) })
// 反馈 AQI（in-app 已到 /aqi）
await step('选等级', async () => { await page.locator('.grade-btn').nth(3).click() })
await step('填反馈', async () => { await page.locator('textarea, input[placeholder="请填写反馈信息"]').first().fill('该区域空气浑浊、能见度低，疑似工业污染。') })
await shot('监督员-填写反馈信息')
await step('提交反馈', async () => { await page.getByRole('button', { name: /提交/ }).click(); await sleep(1500) })
await shot('监督员-反馈提交结果')

// ============ 2) 系统管理员端 (5173) — 登录→查反馈→指派 ============
await page.goto('http://localhost:5173/login', { waitUntil: 'networkidle' }).catch(()=>{})
await step('管理员登录', async () => {
  await page.getByPlaceholder('请输入管理员编码').fill('AD001')
  await page.getByPlaceholder('请输入登录密码').fill('123456')
  await page.getByRole('button', { name: '登 录' }).click()
  await page.waitForURL('**/home', { timeout: 8000 }).catch(()=>{})
})
await shot('管理员-登录后首页')
await page.goto('http://localhost:5173/feedback', { waitUntil: 'networkidle' }).catch(()=>{})   // admin 用 sessionStorage，goto 安全
await shot('管理员-查询公众反馈列表')
await page.goto('http://localhost:5173/feedback/1', { waitUntil: 'networkidle' }).catch(()=>{})
await sleep(1000)
await shot('管理员-反馈详情')
await step('指派网格员', async () => {
  await page.locator('.el-select').first().click(); await sleep(500)
  await page.locator('.el-select-dropdown__item').first().click(); await sleep(400)
  await page.getByRole('button', { name: '确认指派' }).click(); await sleep(1500)
})
await shot('管理员-指派网格员完成')

// ============ 3) 网格员端 (8083) — 登录→查任务→实地检测 ============
await page.goto('http://localhost:8083/login', { waitUntil: 'networkidle' }).catch(()=>{})
await step('网格员登录', async () => {
  await page.locator('input[placeholder="请输入编码"]').fill('GM004')
  await page.locator('input[placeholder="请输入密码"]').fill('grid444')
  await page.locator('input[type=checkbox]').first().check().catch(()=>{})
  await page.getByRole('button', { name: /^登录/ }).click()
  await page.waitForURL('**/feedbackList', { timeout: 8000 }).catch(()=>{})
  await sleep(1200)
})
await shot('网格员-登录后任务列表')
await step('进任务详情', async () => { await page.locator('.check-btn').first().click(); await sleep(1200) })
await shot('网格员-任务详情')
await step('填实测数据', async () => {
  await page.locator('input[placeholder="请输入SO2浓度"]').fill('45')
  await page.locator('input[placeholder="请输入CO浓度"]').fill('6')
  await page.locator('input[placeholder="请输入PM2.5浓度"]').fill('80')
})
await shot('网格员-填写AQI实测数据')
await step('提交实测', async () => { await page.getByRole('button', { name: /提交实测数据/ }).click(); await sleep(1500) })
await shot('网格员-提交实测结果')

// ============ 4) 决策者 / 可视化大屏 (5174) ============
await page.goto('http://localhost:5174', { waitUntil: 'networkidle' }).catch(()=>{})
await sleep(2500)
await shot('决策者-可视化大屏')

await sleep(1000)
const vpath = await page.video().path()
await context.close(); await browser.close()
import { renameSync } from 'fs'
renameSync(vpath, `${VID}/操作流程完整演示.webm`)
console.log('DONE', `${VID}/操作流程完整演示.webm`)
