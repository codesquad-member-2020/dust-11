package com.dust11.han.model;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class Pm10Request {

  private String imageUrl1;
  private String imageUrl2;
  private String imageUrl3;
  private String informGrade;
  private String informOverall;
  private String dataTime;

  public String getImageUrl1() {
    return imageUrl1;
  }

  public String getImageUrl2() {
    return imageUrl2;
  }

  public String getImageUrl3() {
    return imageUrl3;
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
    return new ToStringBuilder(this, ToStringStyle.JSON_STYLE)
        .append("imageUrl1", imageUrl1)
        .append("imageUrl2", imageUrl2)
        .append("imageUrl3", imageUrl3)
        .append("informGrade", informGrade)
        .append("informOverall", informOverall)
        .append("dataTime", dataTime)
        .toString();
  }
}
