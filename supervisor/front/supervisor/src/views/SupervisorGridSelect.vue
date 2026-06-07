<template>
  <div class="page">
    <header class="header">
      <i class="fa fa-angle-left back" @click="goBack"></i>
      <span>选择网格</span>
      <div class="header-actions">
        <span class="action-link" @click="goHistory">历史</span>
        <span class="action-link logout" @click="handleLogout">退出</span>
      </div>
    </header>

    <div class="hero">
      <img src="../assets/supervisor-cover-banner-fit.png" alt="背景图">
    </div>

    <div class="slogan">保护环境人人有责</div>

    <div class="form-box">
      <div class="row">
        <label>所在省</label>
        <select v-model="form.provinceId" @change="handleProvinceChange">
          <option value="">请选择省份</option>
          <option v-for="item in provinces" :key="item.provinceId" :value="item.provinceId">
            {{ item.provinceName }}
          </option>
        </select>
      </div>

      <div class="row">
        <label>所在市</label>
        <select v-model="form.cityId">
          <option value="">请选择城市</option>
          <option v-for="item in cities" :key="item.cityId" :value="item.cityId">
            {{ item.cityName }}
          </option>
        </select>
      </div>

      <div class="row address-row">
        <label>地址</label>
        <textarea v-model="form.address" placeholder="具体地址"></textarea>
      </div>
    </div>

    <button class="primary-btn" @click="goNext">下一步</button>
    <MessageDialog :visible="dialogVisible" :message="dialogMessage" @close="dialogVisible = false" />
  </div>
</template>

<script setup>
import { onMounted, reactive, ref } from 'vue';
import { useRouter } from 'vue-router';
import { getSessionStorage, removeSessionStorage, setSessionStorage } from '../common';
import { gridCityApi, gridProvinceApi } from '../api';
import MessageDialog from '../components/MessageDialog.vue';
import { validateGridForm } from '../utils/supervisorValidation';

const router = useRouter();
const provinces = ref([]);
const cities = ref([]);

const form = reactive({
  provinceId: '',
  cityId: '',
  address: ''
});

const supervisor = ref(null);
const dialogVisible = ref(false);
const dialogMessage = ref('');

const showDialog = (message) => {
  dialogMessage.value = message;
  dialogVisible.value = true;
};

const goBack = () => {
  removeSessionStorage('supervisor');
  removeSessionStorage('supervisorFeedbackDraft');
  router.replace('/login');
};

const goHistory = () => {
  router.push('/history');
};

const handleLogout = () => {
  removeSessionStorage('supervisor');
  removeSessionStorage('supervisorFeedbackDraft');
  router.replace('/login');
};

const loadProvinces = async () => {
  const response = await gridProvinceApi.listAll();
  if (response.data.code === 200) {
    provinces.value = response.data.data || [];
  }
};

const loadCities = async (provinceId) => {
  const response = await gridCityApi.listByProvince(provinceId);
  if (response.data.code === 200) {
    cities.value = response.data.data || [];
  } else {
    cities.value = [];
  }
};

const handleProvinceChange = async () => {
  form.cityId = '';
  if (!form.provinceId) {
    cities.value = [];
    return;
  }
  await loadCities(form.provinceId);
};

const goNext = () => {
  const validationMessage = validateGridForm(form);
  if (validationMessage) {
    showDialog(validationMessage);
    return;
  }

  const province = provinces.value.find(item => item.provinceId === Number(form.provinceId));
  const city = cities.value.find(item => item.cityId === Number(form.cityId));

  setSessionStorage('supervisorFeedbackDraft', {
    provinceId: Number(form.provinceId),
    provinceName: province?.provinceName || '',
    cityId: Number(form.cityId),
    cityName: city?.cityName || '',
    address: form.address.trim()
  });
  router.push('/aqi');
};

onMounted(async () => {
  supervisor.value = getSessionStorage('supervisor');
  if (!supervisor.value) {
    router.push('/login');
    return;
  }

  const draft = getSessionStorage('supervisorFeedbackDraft');
  if (draft) {
    form.provinceId = draft.provinceId || '';
    form.cityId = draft.cityId || '';
    form.address = draft.address || '';
  }

  await loadProvinces();
  if (form.provinceId) {
    await loadCities(form.provinceId);
  }
});
</script>

<style scoped>
.page {
  height: 100%;
  background: #d7ecef;
  overflow-y: auto;
}

.header {
  height: 52px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 16px;
  background: #fff;
  font-size: 22px;
  color: #333;
}

.back {
  width: 24px;
  font-size: 28px;
  cursor: pointer;
}

.hero {
  height: 230px;
  padding: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.hero img {
  width: 100%;
  height: 100%;
  display: block;
  object-fit: cover;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}

.action-link {
  color: #5d7a84;
  font-size: 14px;
  cursor: pointer;
}

.logout {
  color: #d36f57;
}

.slogan {
  text-align: center;
  color: #dc6a4f;
  font-size: 24px;
  font-weight: bold;
  margin: 10px 0 24px;
}

.form-box {
  padding: 0 22px;
}

.row {
  display: flex;
  align-items: center;
  margin-bottom: 24px;
}

.row label {
  width: 70px;
  font-size: 16px;
  color: #444;
}

.row select,
.row textarea {
  flex: 1;
  border: none;
  background: transparent;
  outline: none;
  font-size: 16px;
  border-bottom: 1px solid rgba(0, 0, 0, 0.08);
  padding: 8px 0;
}

.address-row {
  align-items: flex-start;
}

.address-row textarea {
  min-height: 90px;
  resize: none;
}

.primary-btn {
  width: calc(100% - 44px);
  margin: 36px 22px 20px;
  height: 48px;
  border: none;
  border-radius: 8px;
  background: #79b7c6;
  color: #fff;
  font-size: 24px;
  cursor: pointer;
}
</style>
