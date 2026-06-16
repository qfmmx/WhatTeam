package com.it.aqisys.pojo.vo;

import lombok.Data;
import java.util.List;

@Data
public class DashboardVo {
    private String provinceCoverage;
    private String cityCoverage;
    private Integer totalAqiCount;
    private Integer goodAqiCount;
    private List<AQIDistributionVo> aqiDistributeData;
    private List<AQITrendVo> aqiTrendData;
    private List<CountByProvinceVo> provinceTotalData;
    private List<PollutantStatisVo> pm25Data;
    private List<PollutantStatisVo> so2Data;
    private List<PollutantStatisVo> coData;
}
