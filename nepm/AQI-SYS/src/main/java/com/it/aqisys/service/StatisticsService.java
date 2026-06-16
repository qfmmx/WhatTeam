package com.it.aqisys.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.it.aqisys.pojo.Statistics;
import com.it.aqisys.pojo.vo.*;

import java.util.List;

public interface StatisticsService extends IService<Statistics> {
    IPage<StatisticsVo> getPageItem(Page<StatisticsVo> page, StatisticsQueryVo queryVo);

    StatisticsDetailVo getStatisticsDetail(Integer id);

    List<CountByProvinceVo> groupByProvince();


    List<AQIDistributionVo> aqiDistribution();

    List<AQITrendVo> aqiTrend();

    OtherCountVo otherCount();

    DashboardVo getDashboardData();
}
