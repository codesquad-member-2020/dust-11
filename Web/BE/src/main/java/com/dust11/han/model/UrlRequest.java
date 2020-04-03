package com.dust11.han.model;

import com.dust11.han.error.EncodingException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class UrlRequest {

  private StringBuilder url;

  public UrlRequest(String apiUrl, String serviceUrl) {
    url = new StringBuilder(apiUrl + serviceUrl);
  }

  public void addServiceKey(String key) {
    try {
      url.append("?").append(URLEncoder.encode("ServiceKey", "UTF-8")).append("=").append(key);
    } catch (UnsupportedEncodingException e) {
      new EncodingException("ServiceKey Encoding Exception");
    }
  }

  public void addParam(String key, String value) {
    try {
      url.append("&").append(URLEncoder.encode(key, "UTF-8")).append("=")
          .append(URLEncoder.encode(value, "UTF-8"));
    } catch (UnsupportedEncodingException e) {
      new EncodingException("Param Encoding Exception");
    }

  }

  public String getUrl() {
    return url.toString();
  }
}
