import axios from 'axios';

const instance = axios.create({
  baseURL: '/api',
  timeout: 10000
});

export const supervisorApi = {
  checkPhone: (phone) => {
    return instance.get('/supervisor/checkPhone', {
      params: { phone }
    });
  },

  register: (data) => {
    return instance.post('/supervisor/register', data);
  },

  login: (phone, password) => {
    return instance.post('/supervisor/login', {
      phone,
      password
    });
  }
};

export const gridProvinceApi = {
  listAll: () => {
    return instance.get('/region/provinces');
  }
};

export const gridCityApi = {
  listByProvince: (provinceId) => {
    return instance.get('/region/cities', {
      params: { provinceId }
    });
  }
};

export const aqiApi = {
  listAll: () => {
    return Promise.resolve({
      data: {
        code: 200,
        message: '查询成功',
        data: [
          {
            aqiId: 1,
            chineseExplain: '优',
            aqiExplain: '空气质量令人满意，基本无空气污染',
            color: '#30b34f'
          },
          {
            aqiId: 2,
            chineseExplain: '良',
            aqiExplain: '空气质量可接受，但某些污染物可能对极少数异常敏感人群健康有较弱影响',
            color: '#f6c11d'
          },
          {
            aqiId: 3,
            chineseExplain: '轻度污染',
            aqiExplain: '易感人群症状有轻度加剧，健康人群出现刺激症状',
            color: '#ff8c2b'
          },
          {
            aqiId: 4,
            chineseExplain: '中度污染',
            aqiExplain: '进一步加剧易感人群症状，可能对健康人群心脏、呼吸系统有影响',
            color: '#d6443c'
          },
          {
            aqiId: 5,
            chineseExplain: '重度污染',
            aqiExplain: '心脏病和肺病患者症状显著加剧，运动耐受力降低',
            color: '#8a2be2'
          },
          {
            aqiId: 6,
            chineseExplain: '严重污染',
            aqiExplain: '健康人群运动耐受力降低，有明显强烈症状，应尽量避免外出',
            color: '#7E0023'
          }
        ]
      }
    });
  }
};

export const aqiFeedbackApi = {
  save: (data) => {
    return instance.post('/aqiFeedback/save', data);
  },

  listByTel: (telId) => {
    return instance.get('/aqiFeedback/listByTel', {
      params: { telId }
    });
  },

  detail: (id) => {
    return instance.get(`/aqiFeedback/${id}`);
  }
};

export default {
  supervisorApi,
  gridProvinceApi,
  gridCityApi,
  aqiApi,
  aqiFeedbackApi
};
