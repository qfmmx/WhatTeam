package com.it.aqisys.controler;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.it.aqisys.pojo.vo.*;
import com.it.aqisys.result.Result;
import com.it.aqisys.service.StatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 统计分析模块控制器
 */
@RestController
@RequestMapping("/statistics")
public class StatisticsController {
    
    /**
     * 统计分析服务接口
     */
    @Autowired
    private StatisticsService statisticsService;
    
    /**
     * 分页查询AQI确认数据
     * @param queryVo 统计查询参数
     * @return 返回分页统计数据
     */
    @PostMapping("/page")
    public Result<IPage<StatisticsVo>> getPageItem(@RequestBody StatisticsQueryVo queryVo){
        long current = queryVo.getPageNum() != null ? queryVo.getPageNum() : 1;
        long size = queryVo.getPageSize() != null ? queryVo.getPageSize() : 10;
        Page<StatisticsVo> page=new Page<>(current,size);
        IPage<StatisticsVo> result= statisticsService.getPageItem(page,queryVo);
        return Result.ok(result);

    }
    
    /**
     * 根据确认数据id查询确认数据详情
     * @param id 统计记录ID
     * @return 返回单条统计记录详情
     */
    @GetMapping("/{id}")
    public Result<StatisticsDetailVo> getStatisticsDetail(@PathVariable Integer id){
          StatisticsDetailVo res=statisticsService.getStatisticsDetail(id);
          return Result.ok(res);
    }
    
    /**
     * 根据省分组查询所有分项信息
     * @return 返回各省超标数据统计
     */
    @GetMapping("/provinceTotal")
    public Result<List<CountByProvinceVo>> groupByProvince(){
        List<CountByProvinceVo> res=statisticsService.groupByProvince();
        return Result.ok(res);
    }
    
    /**
     * 统计aqi指数分布
     * @return 返回AQI等级分布统计数据
     */
    @GetMapping("/aqiDistribute")
    public Result<List<AQIDistributionVo>> aqiDistribution(){
        List<AQIDistributionVo> res=statisticsService.aqiDistribution();
        return Result.ok(res);
    }
    
    /**
     * 获取AQI指数超标趋势
     * @return 返回近12个月的超标趋势
     */
    @GetMapping("/trend")
    public Result<List<AQITrendVo>> aqiTrend(){
        List<AQITrendVo> res=statisticsService.aqiTrend();
        return Result.ok(res);
    }
    
    /**
     * 获取AQI指数其他统计信息 - 累计检测总数
     * @return 返回累计检测总数
     */
    @GetMapping("/totalCount")
    public Result<Integer> getAqiTotalCount(){
        OtherCountVo res=statisticsService.otherCount();
        return Result.ok(res.getCount());
    }

    /**
     * 获取空气良好天数
     * @return 返回空气良好天数
     */
    @GetMapping("/goodCount")
    public Result<Integer> getAqiGoodCount(){
        OtherCountVo res=statisticsService.otherCount();
        return Result.ok(res.getGoodAqiCount());
    }

    /**
     * 获取省份覆盖率
     * @return 返回省份覆盖率百分比字符串
     */
    @GetMapping("/provinceCoverage")
    public Result<String> getProvinceCoverage(){
        OtherCountVo res=statisticsService.otherCount();
        return Result.ok(String.format("%.1f%%", res.getCoverProvince()));
    }

    /**
     * 获取城市覆盖率
     * @return 返回城市覆盖率百分比字符串
     */
    @GetMapping("/cityCoverage")
    public Result<String> getCityCoverage(){
        OtherCountVo res=statisticsService.otherCount();
        return Result.ok(String.format("%.1f%%", res.getCoverBigCity()));
    }

    /**
     * 获取大屏全量聚合数据
     * @return 返回大屏所需的综合数据对象
     */
    @GetMapping("/dashboard")
    public Result<DashboardVo> getDashboardData() {
        DashboardVo data = statisticsService.getDashboardData();
        return Result.ok(data);
    }
}
