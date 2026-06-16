package com.it.aqisys.controler;
import com.it.aqisys.pojo.vo.AdminLoginResultVo;
import com.it.aqisys.pojo.vo.LoginVo;
import com.it.aqisys.result.Result;
import com.it.aqisys.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 管理员登录控制器
 */
@RestController
@RequestMapping({"/auth/admin", "/admins"})
public class LoginController {
    
    /**
     * 登录服务接口
     */
    @Autowired
    private LoginService loginService;

    /**
     * 管理员登录接口
     * @param loginVo 登录参数视图对象
     * @return 返回管理员登录结果
     */
    @PostMapping("/login")
    public Result<AdminLoginResultVo> login(@RequestBody LoginVo loginVo){
        AdminLoginResultVo resultVo = loginService.login(loginVo);
        return Result.ok(resultVo);
    }
}
