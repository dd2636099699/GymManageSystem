package com.luguzhi.gymxmjpa.base;

import com.luguzhi.gymxmjpa.enums.ErrorCodeEnum;

public class Results {

    public static <T> Result<T> newSuccessResult(T data) {
        return newResult(data, "success", true,0);
    }

    public static <T> Result<T> newFailedResult(String message) {
        return newResult(null, message, false,-10000);
    }

    public static <T> Result<T> newFailedResult(Integer code, String message) {
        return newResult(null, message, false, code);
    }

    public static <T> Result<T> newFailedResult(ErrorCodeEnum errorCodeEnum) {
        return newResult(null, errorCodeEnum.getDescription(), false, errorCodeEnum.getCode());
    }

    public static <T> Result<T> newResult(T data, String message, boolean success,Integer code) {
        Result result = new Result();
        result.setData(data);
        result.setCode(code);
        result.setSuccess(success);
        result.setMessage(message);
        return result;
    }
}
