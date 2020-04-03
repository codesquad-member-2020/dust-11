package com.dust11.han.controller;

import com.dust11.han.api.ApiResult;
import com.dust11.han.error.EncodingException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GeneralExceptionHandler {

  private Logger logger = LoggerFactory.getLogger(GeneralExceptionHandler.class);

  private ResponseEntity<ApiResult> newResponse(Throwable throwable, HttpStatus status) {
    HttpHeaders httpHeaders = new HttpHeaders();
    httpHeaders.add("ContentType", "application/json");
    return new ResponseEntity<>(ApiResult.ERROR(throwable, status), httpHeaders, status);
  }

  @ExceptionHandler(EncodingException.class)
  public ResponseEntity<?> WrongEncode(EncodingException e) {
    logger.debug("EncodeException, {}", e.getMessage());
    return newResponse(e, HttpStatus.BAD_REQUEST);
  }
}
