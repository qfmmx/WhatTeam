package com.it.aqisys.enums;

public enum State {
    ASSIGN(1,"已指派"),
    NO_ASSIGN(0,"未指派"),
    FINISH(2,"已确认");
    private int code;
    private String message;
    State(int code,String message){
        this.code=code;
        this.message=message;
    }
}
