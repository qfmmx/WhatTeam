package com.example.supervisorbackend.controller;

import com.example.supervisorbackend.common.ApiResponse;
import com.example.supervisorbackend.entity.GridCity;
import com.example.supervisorbackend.entity.GridProvince;
import com.example.supervisorbackend.service.RegionService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/region")
public class RegionController {

    private final RegionService regionService;

    public RegionController(RegionService regionService) {
        this.regionService = regionService;
    }

    @GetMapping("/provinces")
    public ApiResponse<List<GridProvince>> listProvinces() {
        return ApiResponse.success("查询成功", regionService.listProvinces());
    }

    @GetMapping("/cities")
    public ApiResponse<List<GridCity>> listCities(@RequestParam("provinceId") Integer provinceId) {
        return ApiResponse.success("查询成功", regionService.listCities(provinceId));
    }
}
