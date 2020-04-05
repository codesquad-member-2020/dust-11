package com.dust11.han.model;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class Image {

  private String order;
  private String url;

  public Image(String order, String url) {
    this.order = order;
    this.url = url;
  }

  public String getOrder() {
    return order;
  }

  public String getUrl() {
    return url;
  }

  @Override
  public String toString() {
    return new ToStringBuilder(this, ToStringStyle.SHORT_PREFIX_STYLE)
        .append("order", order)
        .append("url", url)
        .toString();
  }
}
