import axios from 'axios';

const instance = axios.create({
  baseURL: '/api',
  timeout: 10000
});

export const gridMemberApi = {
  login: (loginCode, password) => {
    return instance.post('/gridMember/login', {
      loginCode,
      password
    });
  }
};

export const feedbackApi = {
  list: (gmId, pageNum = 1, pageSize = 10) => {
    return instance.post(`/feedback/list?gmId=${gmId}`, {
      pageNum,
      pageSize
    });
  },

  submit: (data) => {
    return instance.post('/feedback/submit', data);
  }
};

export default { gridMemberApi, feedbackApi };
