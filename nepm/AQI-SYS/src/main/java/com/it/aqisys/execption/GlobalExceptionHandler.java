package com.it.aqisys.execption;

import com.it.aqisys.result.Result;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Result handle(Exception e){
        e.printStackTrace();
        return Result.fail();
    }

    @ExceptionHandler(AQIException.class)
    @ResponseBody
    public Result handle(AQIException e){
        e.printStackTrace();
        return Result.fail(e.getCode(),e.getMessage());
    }

}
