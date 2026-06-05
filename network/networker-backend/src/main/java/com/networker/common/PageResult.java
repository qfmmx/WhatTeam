package com.networker.common;

import lombok.Data;

import java.util.List;

@Data
public class PageResult<T> {
    private Long total;
    private List<T> records;
    private Integer current;
    private Integer size;

    public static <T> PageResult<T> of(Long total, List<T> records, Integer current, Integer size) {
        PageResult<T> pageResult = new PageResult<>();
        pageResult.total = total;
        pageResult.records = records;
        pageResult.current = current;
        pageResult.size = size;
        return pageResult;
    }
}
