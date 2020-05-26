package edu.ahpu.util;

import org.apache.poi.ss.formula.functions.T;

/**
 * 响应头工具类
 *
 * @author jinfei
 * @create 2020-04-15 19:41
 */
public class Result<T> {

    private String message; //通讯消息

    private boolean flag; //通讯状态

    private T data; //通讯数据

    public Result() {
    }

    public Result(boolean flag, String message, T data) {
        this.message = message;
        this.flag = flag;
        this.data = data;
    }

    public static <T> Result build(boolean flag, String message, T data) {
        return new Result(flag, message, data);
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isFlag() {
        return flag;
    }

    public void setFlag(boolean flag) {
        this.flag = flag;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
