package com.it.aqisys.service.serviceImpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.it.aqisys.execption.AQIException;
import com.it.aqisys.mapper.AdminMapper;
import com.it.aqisys.pojo.Admin;
import com.it.aqisys.pojo.vo.AdminLoginResultVo;
import com.it.aqisys.pojo.vo.LoginVo;
import com.it.aqisys.result.ResultCodeEnum;
import com.it.aqisys.service.LoginService;

import com.it.aqisys.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private AdminMapper adminMapper;
    @Override
    public AdminLoginResultVo login(LoginVo loginVo) {
        String password = loginVo.getPassword(); //获取密码
        String adminCode = loginVo.getAdminCode(); //获取登陆编号

        //如果密码或者用户名为空，抛出异常
        if(password==null || adminCode==null){
            throw new AQIException(ResultCodeEnum.ADMIN_ACCOUNT_ERROR);
        }
        QueryWrapper<Admin> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("admin_code",adminCode);
        queryWrapper.eq("password",password);
        Admin admin = adminMapper.selectOne(queryWrapper);
        //如果用户不存在，抛出异常
        if(admin==null){
            throw new AQIException(ResultCodeEnum.ADMIN_ACCOUNT_ERROR);
        }
        AdminLoginResultVo result = new AdminLoginResultVo();
        result.setId(admin.getAdminId());
        result.setAdminCode(admin.getAdminCode());
        result.setAdminName("系统管理员"); // 数据库没有此字段，补充默认值
        result.setRole("super"); // 补充角色
        result.setStatus(1); // 补充状态
        return result;
    }
}
