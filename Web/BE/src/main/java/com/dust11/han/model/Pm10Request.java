package com.dust11.han.model;

import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;

public class Pm10Request {

  private List<Image> images;
  private String informGrade;
  private String informOverall;
  private String dataTime;

  public Pm10Request(List<Image> images, String informGrade,
      String informOverall, String dataTime) {
    this.images = images;
    this.informGrade = informGrade;
    this.informOverall = informOverall;
    this.dataTime = dataTime;
  }

  public List<Image> getImages() {
    return images;
  }

  public String getInformGrade() {
    return informGrade;
  }

  public String getInformOverall() {
    return informOverall;
  }

  public String getDataTime() {
    return dataTime;
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this)
        .append("images", images)
        .append("informGrade", informGrade)
        .append("informOverall", informOverall)
        .append("dataTime", dataTime)
        .toString();
  }
}
