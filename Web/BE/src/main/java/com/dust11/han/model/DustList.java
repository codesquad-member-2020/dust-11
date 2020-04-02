package com.dust11.han.model;

import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class DustList {

  private List<DustRequest> list;
  private String stationName;

  public List<DustRequest> getList() {
    return list;
  }

  public String getStationName() {
    return stationName;
  }

  public void setList(List<DustRequest> list) {
    this.list = list;
  }

  public void setStationName(String stationName) {
    this.stationName = stationName;
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this, ToStringStyle.JSON_STYLE)
        .append("stationName", stationName)
        .append("list", list)
        .toString();
  }
}
