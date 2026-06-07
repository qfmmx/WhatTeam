const PHONE_REGEX = /^1\d{10}$/;

export function validateLoginForm(form) {
  if (!form.telId || !form.password) {
    return '请输入手机号和密码';
  }
  if (!PHONE_REGEX.test(form.telId.trim())) {
    return '请输入正确的11位手机号';
  }
  if (form.password.trim().length < 3) {
    return '密码长度不能少于3位';
  }
  return '';
}

export function validateRegisterForm(form) {
  if (!form.telId || !form.realName || !form.password || !form.confirmPassword || !form.age) {
    return '请填写完整信息';
  }
  if (!PHONE_REGEX.test(form.telId.trim())) {
    return '请输入正确的11位手机号';
  }
  if (form.realName.trim().length < 2) {
    return '真实姓名至少2个字';
  }
  if (!/^\d{1,3}$/.test(String(form.age).trim())) {
    return '年龄请填写1到3位数字';
  }
  const age = Number(String(form.age).trim());
  if (age < 1 || age > 120) {
    return '年龄请填写1到120之间的数字';
  }
  if (form.password.trim().length < 3) {
    return '密码长度不能少于3位';
  }
  if (form.password !== form.confirmPassword) {
    return '两次输入的密码不一致';
  }
  return '';
}

export function validateGridForm(form) {
  if (!form.provinceId || !form.cityId) {
    return '请选择完整的省市信息';
  }
  if (!form.address || !form.address.trim()) {
    return '请填写详细地址';
  }
  return '';
}

export function validateFeedbackForm(form) {
  if (!form.estimatedGrade) {
    return '请选择AQI等级';
  }
  if (!form.information || !form.information.trim()) {
    return '请填写反馈信息';
  }
  return '';
}
