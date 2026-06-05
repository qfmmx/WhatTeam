package com.networker.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.networker.entity.GridMember;
import com.networker.mapper.GridMemberMapper;
import org.springframework.stereotype.Service;

@Service
public class GridMemberService extends ServiceImpl<GridMemberMapper, GridMember> {

    public GridMember login(String gmCode, String password) {
        LambdaQueryWrapper<GridMember> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(GridMember::getGmCode, gmCode)
               .eq(GridMember::getPassword, password)
               .eq(GridMember::getState, 0);
        return this.getOne(wrapper);
    }
}
