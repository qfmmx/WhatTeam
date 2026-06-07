package com.example.supervisorbackend.service;

import com.example.supervisorbackend.entity.GridCity;
import com.example.supervisorbackend.entity.GridProvince;

import java.util.List;

public interface RegionService {

    List<GridProvince> listProvinces();

    List<GridCity> listCities(Integer provinceId);
}
