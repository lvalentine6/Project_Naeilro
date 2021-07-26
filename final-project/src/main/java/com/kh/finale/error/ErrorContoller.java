package com.kh.finale.error;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.extern.slf4j.Slf4j;

//@ControllerAdvice(annotations = {Controller.class})
@Slf4j
public class ErrorContoller {
	@ExceptionHandler(Exception.class)
	public String handler(HttpServletRequest request, Exception e) {
		log.error("오류 발생", e);
		return "error/handler";
	}
	
}
