package com.dust11.han.model;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class TmXYRequest {

  private String sidoName;
  private String sggName;
  private String tmX;
  private String tmY;
  private String umdName;

  public String getSidoName() {
    return sidoName;
  }

  public String getSggName() {
    return sggName;
  }

  public String getTmX() {
    return tmX;
  }

  public String getTmY() {
    return tmY;
  }

  public String getUmdName() {
    return umdName;
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this, ToStringStyle.JSON_STYLE)
        .append("sidoName", sidoName)
        .append("sggName", sggName)
        .append("tmX", tmX)
        .append("tmY", tmY)
        .append("umdName", umdName)
        .toString();
  }
}
