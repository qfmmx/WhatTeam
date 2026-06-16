package com.it.aqisys.service.serviceImpl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.it.aqisys.mapper.StatisticsMapper;
import com.it.aqisys.pojo.GridCity;
import com.it.aqisys.pojo.Statistics;
import com.it.aqisys.pojo.vo.*;
import com.it.aqisys.service.GridCityService;
import com.it.aqisys.service.GridMemberService;
import com.it.aqisys.service.GridProvinceService;
import com.it.aqisys.service.StatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class StatisticsServiceImpl extends ServiceImpl<StatisticsMapper, Statistics> implements StatisticsService {
    @Autowired
    private StatisticsMapper statisticsMapper;
    @Autowired
    private GridProvinceService gridProvinceService;
    @Autowired
    private GridCityService gridCityService;
    @Override
    public IPage<StatisticsVo> getPageItem(Page<StatisticsVo> page, StatisticsQueryVo queryVo) {
        return statisticsMapper.getPageItem(page,queryVo);
    }

    @Override
    public StatisticsDetailVo getStatisticsDetail(Integer id) {
        return statisticsMapper.getStatisticsDetail(id);
    }

    @Override
    public List<CountByProvinceVo> groupByProvince() {
        return  statisticsMapper.groupByProvince();
    }

    @Override
    public List<AQIDistributionVo> aqiDistribution() {
        return statisticsMapper.aqiDistribution();
    }

    @Override
    public List<AQITrendVo> aqiTrend() {
        return statisticsMapper.aqiTrend();
    }

    @Override
    public OtherCountVo otherCount() {

        OtherCountVo res = statisticsMapper.otherCount();
        long gridProvinceCount = gridProvinceService.count();
        //获取省覆盖率
        res.setCoverProvince(gridProvinceCount * 100.0 / 34);
        long gridCityCount = gridCityService.count();
        //获取城市覆盖率
        res.setCoverBigCity(gridCityCount * 100.0 / 694);
        return res;

    }

    @Override
    public DashboardVo getDashboardData() {
        DashboardVo vo = new DashboardVo();
        
        OtherCountVo otherCount = this.otherCount();
        vo.setTotalAqiCount(otherCount.getCount());
        vo.setGoodAqiCount(otherCount.getGoodAqiCount());
        vo.setProvinceCoverage(String.format("%.1f%%", otherCount.getCoverProvince()));
        vo.setCityCoverage(String.format("%.1f%%", otherCount.getCoverBigCity()));
        
        vo.setAqiDistributeData(this.aqiDistribution());
        vo.setAqiTrendData(this.aqiTrend());
        vo.setProvinceTotalData(this.groupByProvince());
        
        vo.setPm25Data(statisticsMapper.getPm25Statis());
        vo.setSo2Data(statisticsMapper.getSo2Statis());
        vo.setCoData(statisticsMapper.getCoStatis());
        
        return vo;
    }
}
