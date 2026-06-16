package com.it.aqisys.service;

import com.it.aqisys.pojo.Admin;
import com.it.aqisys.pojo.vo.AdminLoginResultVo;
import com.it.aqisys.pojo.vo.LoginVo;

public interface LoginService {
    AdminLoginResultVo login(LoginVo loginVo);

}
