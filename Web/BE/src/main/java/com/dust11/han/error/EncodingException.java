package com.dust11.han.error;

import java.io.IOException;

public class EncodingException extends IOException {

  public EncodingException(String message) {
    super("EncodeException : " + message);
  }
}
