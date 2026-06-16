package com.it.aqisys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.it.aqisys.pojo.AQIFeedBack;
import com.it.aqisys.pojo.vo.AQIFeedBackDetailVo;
import com.it.aqisys.pojo.vo.AQIFeedBackQueryVo;
import com.it.aqisys.pojo.vo.AQIFeedBackVo;
import org.apache.ibatis.annotations.Param;

public interface AQIFeedBackMapper extends BaseMapper<AQIFeedBack> {
    IPage<AQIFeedBackVo> pageItem(Page<AQIFeedBackVo> page, AQIFeedBackQueryVo queryVo);

    AQIFeedBackDetailVo getFeedBackDetail(@Param("afId") Integer afId);

    void assignFeedBack(@Param("gridMemberId") String gridMemberId, @Param("afId") Integer afId);
}
