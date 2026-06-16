package com.it.aqisys.service.serviceImpl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.it.aqisys.mapper.GridMemberMapper;
import com.it.aqisys.pojo.GridMember;
import com.it.aqisys.pojo.vo.GridMemberVo;
import com.it.aqisys.service.GridMemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GridMemberServiceImpl extends ServiceImpl<GridMemberMapper, GridMember> implements GridMemberService {
    @Autowired
    private GridMemberMapper gridMemberMapper;
    @Override
    public List<GridMemberVo> getGridMember(Integer provinceName, Integer cityName) {
        return gridMemberMapper.getGridMember(provinceName,cityName);

    }

    @Override
    public List<GridMemberVo> getCrossMembers(Integer provinceId) {
        return gridMemberMapper.getCrossMembers(provinceId);
    }
}
