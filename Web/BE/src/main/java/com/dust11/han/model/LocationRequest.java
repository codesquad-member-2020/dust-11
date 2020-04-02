package com.dust11.han.model;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class LocationRequest {

  private String addr;
  private String stationName;
  private String tm;

  public String getAddr() {
    return addr;
  }

  public String getStationName() {
    return stationName;
  }

  public String getTm() {
    return tm;
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this, ToStringStyle.JSON_STYLE)
        .append("addr", addr)
        .append("stationName", stationName)
        .append("tm", tm)
        .toString();
  }
}
