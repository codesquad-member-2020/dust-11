package com.dust11.han.model;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class DustRequest {

  private String pm10Grade;
  private String pm10Grade1h;
  private String pm10Value;
  private String pm10Value24;
  private String dataTime;

  public String getPm10Grade() {
    return pm10Grade;
  }

  public String getPm10Grade1h() {
    return pm10Grade1h;
  }

  public String getPm10Value() {
    return pm10Value;
  }

  public String getPm10Value24() {
    return pm10Value24;
  }

  public String getDataTime() {
    return dataTime;
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this, ToStringStyle.JSON_STYLE)
        .append("pm10Grade", pm10Grade)
        .append("pm10Grade1h", pm10Grade1h)
        .append("pm10Value", pm10Value)
        .append("pm10Value24", pm10Value24)
        .append("dataTime", dataTime)
        .toString();
  }
}
