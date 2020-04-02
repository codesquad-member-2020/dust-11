package com.dust11.han.model;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class Pm10Request {

  private String imageUrl1;
  private String imageUrl2;
  private String imageUrl3;
  private String imageUrl4;
  private String imageUrl5;
  private String imageUrl6;
  private String imageUrl7;
  private String informGrade;
  private String informOverall;
  private String dataTime;

  public String getDataTime() {
    return dataTime;
  }

  public String getImageUrl1() {
    return imageUrl1;
  }

  public String getImageUrl2() {
    return imageUrl2;
  }

  public String getImageUrl3() {
    return imageUrl3;
  }

  public String getImageUrl4() {
    return imageUrl4;
  }

  public String getImageUrl5() {
    return imageUrl5;
  }

  public String getImageUrl6() {
    return imageUrl6;
  }

  public String getImageUrl7() {
    return imageUrl7;
  }

  public String getInformGrade() {
    return informGrade;
  }

  public String getInformOverall() {
    return informOverall;
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this, ToStringStyle.JSON_STYLE)
        .append("imageUrl1", imageUrl1)
        .append("imageUrl2", imageUrl2)
        .append("imageUrl3", imageUrl3)
        .append("imageUrl4", imageUrl4)
        .append("imageUrl5", imageUrl5)
        .append("imageUrl6", imageUrl6)
        .append("imageUrl7", imageUrl7)
        .append("informGrade", informGrade)
        .append("informOverall", informOverall)
        .append("dataTime", dataTime)
        .toString();
  }
}
