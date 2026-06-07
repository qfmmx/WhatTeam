import test from 'node:test';
import assert from 'node:assert/strict';
import {
  validateLoginForm,
  validateRegisterForm,
  validateGridForm,
  validateFeedbackForm
} from '../src/utils/supervisorValidation.js';

test('validateLoginForm rejects invalid phone', () => {
  assert.equal(
    validateLoginForm({ telId: '123', password: '123456' }),
    '请输入正确的11位手机号'
  );
});

test('validateLoginForm accepts valid form', () => {
  assert.equal(
    validateLoginForm({ telId: '13800138001', password: '123456' }),
    ''
  );
});

test('validateRegisterForm rejects age outside range', () => {
  assert.equal(
    validateRegisterForm({
      telId: '13800138001',
      realName: '张三',
      birthday: '130',
      sex: 1,
      password: '123456',
      confirmPassword: '123456'
    }),
    '年龄请填写1到120之间的数字'
  );
});

test('validateRegisterForm rejects inconsistent password', () => {
  assert.equal(
    validateRegisterForm({
      telId: '13800138001',
      realName: '张三',
      birthday: '20',
      sex: 1,
      password: '123456',
      confirmPassword: '654321'
    }),
    '两次输入的密码不一致'
  );
});

test('validateGridForm rejects short address', () => {
  assert.equal(
    validateGridForm({ provinceId: '1', cityId: '2', address: '路口' }),
    '请填写至少3个字的详细地址'
  );
});

test('validateFeedbackForm rejects short content', () => {
  assert.equal(
    validateFeedbackForm({ estimatedGrade: 2, information: '不好' }),
    '请填写至少5个字的反馈信息'
  );
});

test('validateFeedbackForm accepts complete feedback', () => {
  assert.equal(
    validateFeedbackForm({ estimatedGrade: 2, information: '这里空气有明显异味' }),
    ''
  );
});
