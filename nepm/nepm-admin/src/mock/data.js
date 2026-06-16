// ============================================================
// 全局模拟数据，所有 mock 模块共享此数据源
// ============================================================

export const PROVINCES = [
  { id: 1, provinceCode: '110000', provinceName: '北京市' },
  { id: 2, provinceCode: '310000', provinceName: '上海市' },
  { id: 3, provinceCode: '210000', provinceName: '辽宁省' },
  { id: 4, provinceCode: '130000', provinceName: '河北省' },
  { id: 5, provinceCode: '370000', provinceName: '山东省' },
  { id: 6, provinceCode: '440000', provinceName: '广东省' },
  { id: 7, provinceCode: '410000', provinceName: '河南省' },
  { id: 8, provinceCode: '340000', provinceName: '安徽省' },
  { id: 9, provinceCode: '320000', provinceName: '江苏省' },
  { id: 10, provinceCode: '330000', provinceName: '浙江省' },
]

export const CITIES = {
  1: [
    { id: 1, cityCode: '110100', cityName: '北京市', provinceId: 1 },
    { id: 2, cityCode: '110200', cityName: '朝阳区', provinceId: 1 },
    { id: 3, cityCode: '110300', cityName: '海淀区', provinceId: 1 },
  ],
  2: [
    { id: 4, cityCode: '310100', cityName: '黄浦区', provinceId: 2 },
    { id: 5, cityCode: '310200', cityName: '浦东新区', provinceId: 2 },
    { id: 6, cityCode: '310300', cityName: '静安区', provinceId: 2 },
  ],
  3: [
    { id: 7, cityCode: '210200', cityName: '大连市', provinceId: 3 },
    { id: 8, cityCode: '210300', cityName: '鞍山市', provinceId: 3 },
    { id: 9, cityCode: '210100', cityName: '沈阳市', provinceId: 3 },
  ],
  4: [
    { id: 10, cityCode: '130100', cityName: '石家庄市', provinceId: 4 },
    { id: 11, cityCode: '130200', cityName: '唐山市', provinceId: 4 },
    { id: 12, cityCode: '130300', cityName: '秦皇岛市', provinceId: 4 },
  ],
  5: [
    { id: 13, cityCode: '370100', cityName: '济南市', provinceId: 5 },
    { id: 14, cityCode: '370200', cityName: '青岛市', provinceId: 5 },
    { id: 15, cityCode: '370300', cityName: '淄博市', provinceId: 5 },
  ],
  6: [
    { id: 16, cityCode: '440100', cityName: '广州市', provinceId: 6 },
    { id: 17, cityCode: '440300', cityName: '深圳市', provinceId: 6 },
    { id: 18, cityCode: '440400', cityName: '珠海市', provinceId: 6 },
  ],
  7: [
    { id: 19, cityCode: '410100', cityName: '郑州市', provinceId: 7 },
    { id: 20, cityCode: '410200', cityName: '开封市', provinceId: 7 },
    { id: 21, cityCode: '410300', cityName: '洛阳市', provinceId: 7 },
  ],
  8: [
    { id: 22, cityCode: '340100', cityName: '合肥市', provinceId: 8 },
    { id: 23, cityCode: '340200', cityName: '芜湖市', provinceId: 8 },
    { id: 24, cityCode: '340300', cityName: '蚌埠市', provinceId: 8 },
  ],
  9: [
    { id: 25, cityCode: '320100', cityName: '南京市', provinceId: 9 },
    { id: 26, cityCode: '320200', cityName: '无锡市', provinceId: 9 },
    { id: 27, cityCode: '320300', cityName: '徐州市', provinceId: 9 },
  ],
  10: [
    { id: 28, cityCode: '330100', cityName: '杭州市', provinceId: 10 },
    { id: 29, cityCode: '330200', cityName: '宁波市', provinceId: 10 },
    { id: 30, cityCode: '330300', cityName: '温州市', provinceId: 10 },
  ],
}

export const GRID_MEMBERS = {
  // key 格式: `${provinceId}-${cityId}`
  '3-7': [
    { id: 1, memberCode: 'gm1001', memberName: '徐昊', phone: '12687643458', provinceId: 3, cityId: 7, status: 1 },
    { id: 2, memberCode: 'gm1002', memberName: '郭磊', phone: '13512345678', provinceId: 3, cityId: 7, status: 1 },
    { id: 3, memberCode: 'gm1003', memberName: '王芳', phone: '15812345678', provinceId: 3, cityId: 7, status: 2 },
  ],
  '1-1': [
    { id: 4, memberCode: 'gm1004', memberName: '李明', phone: '13612345678', provinceId: 1, cityId: 1, status: 1 },
    { id: 5, memberCode: 'gm1005', memberName: '张伟', phone: '13712345678', provinceId: 1, cityId: 1, status: 1 },
  ],
  '9-25': [
    { id: 6, memberCode: 'gm1006', memberName: '夏保演', phone: '13812345678', provinceId: 9, cityId: 25, status: 1 },
    { id: 7, memberCode: 'gm1007', memberName: '柯猛', phone: '13912345678', provinceId: 9, cityId: 25, status: 1 },
    { id: 8, memberCode: 'gm1008', memberName: '叶凯', phone: '18612345678', provinceId: 9, cityId: 25, status: 2 },
  ],
  '7-19': [
    { id: 9, memberCode: 'gm1009', memberName: '曹玉', phone: '18712345678', provinceId: 7, cityId: 19, status: 1 },
    { id: 10, memberCode: 'gm1010', memberName: '金全发', phone: '18812345678', provinceId: 7, cityId: 19, status: 1 },
  ],
  '6-16': [
    { id: 11, memberCode: 'gm1011', memberName: '美佳', phone: '18912345678', provinceId: 6, cityId: 16, status: 1 },
    { id: 12, memberCode: 'gm1012', memberName: '陈旭', phone: '19012345678', provinceId: 6, cityId: 16, status: 1 },
  ],
}

export const AQI_FEEDBACKS = [
  { id: 38, telId: '17345988896', cityCode: '210200', aqiValue: 175, feedbackTime: '2022-10-27 16:29:26', state: 0, gmId: null, remark: '月黑风高，空气浑浊，难道是杀人夜？' },
  { id: 37, telId: '13812345678', cityCode: '340100', aqiValue: 220, feedbackTime: '2022-10-26 10:41:05', state: 0, gmId: null, remark: '空气质量很差，能见度极低' },
  { id: 36, telId: '15634567890', cityCode: '320100', aqiValue: 310, feedbackTime: '2022-10-26 10:39:57', state: 0, gmId: null, remark: '附近工厂排放异常，气味刺鼻' },
  { id: 35, telId: '18934567890', cityCode: '140100', aqiValue: 140, feedbackTime: '2022-10-26 10:39:13', state: 0, gmId: null, remark: '街道灰尘很大，感觉空气不好' },
  { id: 34, telId: '13534567890', cityCode: '310200', aqiValue: 165, feedbackTime: '2022-09-26 10:37:56', state: 0, gmId: null, remark: '今天天空呈灰色，雾霾严重' },
  { id: 33, telId: '15734567890', cityCode: '410100', aqiValue: 182, feedbackTime: '2022-09-26 10:36:56', state: 0, gmId: null, remark: '能见度不足200米，很担心' },
  { id: 32, telId: '18234567890', cityCode: '230100', aqiValue: 258, feedbackTime: '2022-09-26 10:35:12', state: 1, gmId: 4, gmName: '李明', assignTime: '2022-09-27 09:00:00', remark: '秸秆焚烧导致烟雾弥漫' },
  { id: 31, telId: '15734567890', cityCode: '320100', aqiValue: 130, feedbackTime: '2022-09-26 10:33:58', state: 1, gmId: 6, gmName: '夏保演', assignTime: '2022-09-27 10:00:00', remark: '感觉空气有点呛' },
  { id: 30, telId: '18234567890', cityCode: '330100', aqiValue: 245, feedbackTime: '2022-08-26 10:32:34', state: 1, gmId: 11, gmName: '美佳', assignTime: '2022-08-27 08:30:00', remark: '工厂附近污染严重' },
  { id: 29, telId: '13234567890', cityCode: '140100', aqiValue: 168, feedbackTime: '2022-08-26 10:29:46', state: 1, gmId: 9, gmName: '曹玉', assignTime: '2022-08-27 09:30:00', remark: '今天空气特别差' },
  { id: 28, telId: '13645678901', cityCode: '110100', aqiValue: 45, feedbackTime: '2022-08-20 09:15:00', state: 2, gmId: 4, gmName: '李明', assignTime: '2022-08-21 10:00:00', remark: '感觉空气不错但想确认一下' },
  { id: 27, telId: '15045678901', cityCode: '440100', aqiValue: 78, feedbackTime: '2022-08-18 14:22:00', state: 2, gmId: 11, gmName: '美佳', assignTime: '2022-08-19 09:00:00', remark: '空气还可以，稍微有点灰' },
  { id: 26, telId: '18145678901', cityCode: '320200', aqiValue: 195, feedbackTime: '2022-08-15 08:30:00', state: 0, gmId: null, remark: '附近道路施工扬尘严重' },
  { id: 25, telId: '13745678901', cityCode: '370100', aqiValue: 112, feedbackTime: '2022-08-10 16:45:00', state: 0, gmId: null, remark: '今天雾蒙蒙的，能见度低' },
  { id: 24, telId: '15845678901', cityCode: '210200', aqiValue: 88, feedbackTime: '2022-08-05 11:00:00', state: 1, gmId: 1, gmName: '徐昊', assignTime: '2022-08-06 09:00:00', remark: '空气一般，偶有异味' },
  { id: 23, telId: '18945678901', cityCode: '130100', aqiValue: 275, feedbackTime: '2022-07-28 07:30:00', state: 2, gmId: 5, gmName: '张伟', assignTime: '2022-07-29 09:00:00', remark: '重度污染，户外活动受限' },
  { id: 22, telId: '13245678901', cityCode: '410200', aqiValue: 155, feedbackTime: '2022-07-20 15:00:00', state: 0, gmId: null, remark: '汽车尾气和工业废气混合' },
  { id: 21, telId: '15645678901', cityCode: '340200', aqiValue: 62, feedbackTime: '2022-07-15 10:30:00', state: 1, gmId: 9, gmName: '曹玉', assignTime: '2022-07-16 09:00:00', remark: '还算良好，稍微有些灰尘' },
  { id: 20, telId: '18345678901', cityCode: '330200', aqiValue: 330, feedbackTime: '2022-07-10 09:00:00', state: 2, gmId: 11, gmName: '美佳', assignTime: '2022-07-11 08:00:00', remark: '严重污染，口罩都挡不住' },
  { id: 19, telId: '13145678901', cityCode: '320300', aqiValue: 48, feedbackTime: '2022-07-05 14:00:00', state: 2, gmId: 7, gmName: '柯猛', assignTime: '2022-07-06 09:00:00', remark: '空气很好，今天适合户外运动' },
]

export const STATISTICS_RECORDS = [
  { id: 38, cityCode: '210200', aqiValue: 175, confirmTime: '2022-10-27 17:01:52', gmId: 1, isExceed: 1 },
  { id: 37, cityCode: '330100', aqiValue: 245, confirmTime: '2022-08-26 13:29:25', gmId: 11, isExceed: 1 },
  { id: 36, cityCode: '330100', aqiValue: 310, confirmTime: '2022-10-26 13:28:50', gmId: 11, isExceed: 1 },
  { id: 35, cityCode: '320100', aqiValue: 130, confirmTime: '2022-09-26 13:28:09', gmId: 6, isExceed: 1 },
  { id: 34, cityCode: '210200', aqiValue: 165, confirmTime: '2022-07-26 12:26:14', gmId: 1, isExceed: 1 },
  { id: 33, cityCode: '210200', aqiValue: 182, confirmTime: '2022-06-26 13:24:58', gmId: 2, isExceed: 1 },
  { id: 32, cityCode: '210300', aqiValue: 130, confirmTime: '2022-05-26 13:24:14', gmId: 3, isExceed: 1 },
  { id: 31, cityCode: '410100', aqiValue: 168, confirmTime: '2022-04-26 13:23:20', gmId: 9, isExceed: 1 },
  { id: 30, cityCode: '410100', aqiValue: 112, confirmTime: '2022-07-26 12:52:18', gmId: 10, isExceed: 1 },
  { id: 29, cityCode: '410100', aqiValue: 168, confirmTime: '2022-09-26 12:51:39', gmId: 9, isExceed: 1 },
  { id: 28, cityCode: '110100', aqiValue: 45, confirmTime: '2022-08-21 10:30:00', gmId: 4, isExceed: 0 },
  { id: 27, cityCode: '440100', aqiValue: 78, confirmTime: '2022-08-19 09:30:00', gmId: 11, isExceed: 0 },
  { id: 26, cityCode: '320200', aqiValue: 195, confirmTime: '2022-08-16 09:00:00', gmId: 7, isExceed: 1 },
  { id: 25, cityCode: '370100', aqiValue: 112, confirmTime: '2022-08-11 10:00:00', gmId: null, isExceed: 1 },
  { id: 24, cityCode: '210200', aqiValue: 88, confirmTime: '2022-08-06 10:30:00', gmId: 1, isExceed: 0 },
  { id: 23, cityCode: '130100', aqiValue: 275, confirmTime: '2022-07-29 10:00:00', gmId: 5, isExceed: 1 },
  { id: 22, cityCode: '410200', aqiValue: 155, confirmTime: '2022-07-21 09:00:00', gmId: null, isExceed: 1 },
  { id: 21, cityCode: '340200', aqiValue: 62, confirmTime: '2022-07-16 10:00:00', gmId: 9, isExceed: 0 },
  { id: 20, cityCode: '330200', aqiValue: 330, confirmTime: '2022-07-11 09:00:00', gmId: 11, isExceed: 1 },
  { id: 19, cityCode: '320300', aqiValue: 48, confirmTime: '2022-07-06 10:00:00', gmId: 7, isExceed: 0 },
  { id: 18, cityCode: '110100', aqiValue: 35, confirmTime: '2022-06-20 09:00:00', gmId: 4, isExceed: 0 },
  { id: 17, cityCode: '310100', aqiValue: 88, confirmTime: '2022-06-15 10:00:00', gmId: null, isExceed: 0 },
  { id: 16, cityCode: '440300', aqiValue: 55, confirmTime: '2022-06-10 11:00:00', gmId: 12, isExceed: 0 },
  { id: 15, cityCode: '210200', aqiValue: 220, confirmTime: '2022-06-05 09:30:00', gmId: 1, isExceed: 1 },
  { id: 14, cityCode: '130200', aqiValue: 185, confirmTime: '2022-05-28 10:00:00', gmId: 5, isExceed: 1 },
  { id: 13, cityCode: '320100', aqiValue: 72, confirmTime: '2022-05-20 14:00:00', gmId: 6, isExceed: 0 },
  { id: 12, cityCode: '410100', aqiValue: 145, confirmTime: '2022-05-15 09:00:00', gmId: 9, isExceed: 1 },
  { id: 11, cityCode: '370200', aqiValue: 95, confirmTime: '2022-05-10 10:30:00', gmId: null, isExceed: 0 },
  { id: 10, cityCode: '330100', aqiValue: 280, confirmTime: '2022-04-25 08:30:00', gmId: 11, isExceed: 1 },
  { id: 9,  cityCode: '110100', aqiValue: 42, confirmTime: '2022-04-18 09:00:00', gmId: 4, isExceed: 0 },
  { id: 8,  cityCode: '440100', aqiValue: 67, confirmTime: '2022-04-10 11:00:00', gmId: 11, isExceed: 0 },
  { id: 7,  cityCode: '210300', aqiValue: 190, confirmTime: '2022-03-28 10:00:00', gmId: 3, isExceed: 1 },
  { id: 6,  cityCode: '320300', aqiValue: 38, confirmTime: '2022-03-20 09:00:00', gmId: 7, isExceed: 0 },
  { id: 5,  cityCode: '340100', aqiValue: 155, confirmTime: '2022-03-15 10:30:00', gmId: null, isExceed: 1 },
  { id: 4,  cityCode: '410200', aqiValue: 112, confirmTime: '2022-03-10 09:00:00', gmId: null, isExceed: 1 },
  { id: 3,  cityCode: '130100', aqiValue: 230, confirmTime: '2022-02-25 08:00:00', gmId: 5, isExceed: 1 },
  { id: 2,  cityCode: '110100', aqiValue: 58, confirmTime: '2022-02-15 10:00:00', gmId: 4, isExceed: 0 },
  { id: 1,  cityCode: '310200', aqiValue: 88, confirmTime: '2022-01-20 09:30:00', gmId: null, isExceed: 0 },
]
