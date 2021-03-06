package com.ht.ssm.util;

public class ControllerResult {
	public final static String SUCCESS="success";
	public static final String FAIL = "fail";
	
	private String code;
	private String result;
	private String msg;

	public ControllerResult(String code, String result, String msg) {
		this.code = code;
		this.result = result;
		this.msg = msg;
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public static ControllerResult getSuccessRequest(String msg){
		return new ControllerResult("200", SUCCESS,  msg);
	}
	
	public static ControllerResult getFailResult(String msg) {
		return new ControllerResult("500", FAIL, msg);
	}
}
