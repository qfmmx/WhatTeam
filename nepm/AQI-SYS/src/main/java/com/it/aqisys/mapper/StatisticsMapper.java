package com.it.aqisys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.it.aqisys.pojo.Statistics;
import com.it.aqisys.pojo.vo.*;

import java.util.List;

public interface StatisticsMapper extends BaseMapper<Statistics> {
    IPage<StatisticsVo> getPageItem(Page<StatisticsVo> page, StatisticsQueryVo queryVo);

    StatisticsDetailVo getStatisticsDetail(Integer id);

    List<CountByProvinceVo> groupByProvince();

    List<AQIDistributionVo> aqiDistribution();

    List<AQITrendVo> aqiTrend();

    OtherCountVo otherCount();

    List<PollutantStatisVo> getPm25Statis();

    List<PollutantStatisVo> getSo2Statis();

    List<PollutantStatisVo> getCoStatis();

}
