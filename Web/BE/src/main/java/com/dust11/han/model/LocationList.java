package com.dust11.han.model;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class LocationList {

  private List<LocationRequest> list = new ArrayList<>();

  public List<LocationRequest> getList() {
    return list;
  }

  public void setList(List<LocationRequest> list) {
    this.list = list;
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this, ToStringStyle.JSON_STYLE)
        .append("list", list)
        .toString();
  }
}
