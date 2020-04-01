package com.dust11.han.model;

import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class Pm10List {

  private List<Pm10Request> list;

  public List<Pm10Request> getList() {
    return list;
  }

  public void setList(List<Pm10Request> list) {
    this.list = list;
  }


  @Override
  public String toString() {
    return new ToStringBuilder(this, ToStringStyle.JSON_STYLE)
        .append("list", list)
        .toString();
  }
}
