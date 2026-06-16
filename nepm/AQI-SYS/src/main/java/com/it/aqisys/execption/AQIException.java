package com.it.aqisys.execption;

import com.it.aqisys.result.ResultCodeEnum;
import lombok.Data;

@Data
public class AQIException extends RuntimeException{
    private Integer code;
    public AQIException(Integer code, String message){
        super(message);
        this.code = code;
    }
    public AQIException(ResultCodeEnum resultCodeEnum){
        super(resultCodeEnum.getMessage());
        this.code = resultCodeEnum.getCode();
    }
}
