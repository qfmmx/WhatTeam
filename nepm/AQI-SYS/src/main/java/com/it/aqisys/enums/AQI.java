package com.it.aqisys.enums;

public enum AQI {
    LEVEL_1(1,  "优"),
    LEVEL_2(2,  "良"),
    LEVEL_3(3,  "轻度污染"),
    LEVEL_4(4,  "中度污染"),
    LEVEL_5(5,  "重度污染"),
    LEVEL_6(6,  "严重污染");
    private int code;
    private String message;
    AQI(int code,String message){
        this.code=code;
        this.message=message;
    }
    public static String getMessage(int code){
        for(AQI value:AQI.values()){
            if(value.code==code){
                return value.message;
            }
        }
        return null;
    }
}
