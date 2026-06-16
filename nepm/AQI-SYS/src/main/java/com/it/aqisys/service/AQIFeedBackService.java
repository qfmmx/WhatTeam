package com.it.aqisys.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.it.aqisys.pojo.AQIFeedBack;
import com.it.aqisys.pojo.vo.AQIFeedBackDetailVo;
import com.it.aqisys.pojo.vo.AQIFeedBackQueryVo;
import com.it.aqisys.pojo.vo.AQIFeedBackVo;

public interface AQIFeedBackService extends IService<AQIFeedBack> {
    IPage<AQIFeedBackVo>  pageItem(Page<AQIFeedBackVo> page, AQIFeedBackQueryVo queryVo);

    AQIFeedBackDetailVo getFeedBackDetail(Integer afId);

    void assignFeedBack(String gridMemberId, Integer afId);

    void updateState(Integer id, Integer state);
}
