package com.dust11.han.model;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class Pm10Request {

  private List<String> images;
  private String informGrade;
  private String informOverall;
  private String dataTime;

  public Pm10Request() {
    images = new ArrayList<>();
  }

  public List<String> getImages() {
    return images;
  }

  public void setImages(List<String> images) {
    this.images = images;
  }

  public String getInformGrade() {
    return informGrade;
  }

  public void setInformGrade(String informGrade) {
    this.informGrade = informGrade;
  }

  public String getInformOverall() {
    return informOverall;
  }

  public void setInformOverall(String informOverall) {
    this.informOverall = informOverall;
  }

  public String getDataTime() {
    return dataTime;
  }

  public void setDataTime(String dataTime) {
    this.dataTime = dataTime;
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this, ToStringStyle.JSON_STYLE)
        .append("images", images)
        .append("informGrade", informGrade)
        .append("informOverall", informOverall)
        .append("dataTime", dataTime)
        .toString();
  }
}
