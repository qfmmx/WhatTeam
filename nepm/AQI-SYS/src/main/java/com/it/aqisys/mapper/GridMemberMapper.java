package com.it.aqisys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.it.aqisys.pojo.GridMember;
import com.it.aqisys.pojo.vo.GridMemberVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GridMemberMapper  extends BaseMapper<GridMember> {
    List<GridMemberVo> getGridMember(@Param("provinceId") Integer provinceId, @Param("cityId") Integer cityId);
    
    List<GridMemberVo> getCrossMembers(@Param("provinceId") Integer provinceId);
}
