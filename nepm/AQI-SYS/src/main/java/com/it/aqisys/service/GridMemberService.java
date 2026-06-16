package com.it.aqisys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.it.aqisys.pojo.GridMember;
import com.it.aqisys.pojo.vo.GridMemberVo;

import java.util.List;

public interface GridMemberService extends IService<GridMember> {
    List<GridMemberVo> getGridMember(Integer province, Integer city);
    
    List<GridMemberVo> getCrossMembers(Integer provinceId);
}
