package com.dust11.han.model;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Pm10RequestDeserializer implements JsonDeserializer<Pm10Request> {

  private final Logger logger = LoggerFactory.getLogger(Pm10RequestDeserializer.class);

  @Override
  public Pm10Request deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context)
      throws JsonParseException {
    JsonObject jsonObject = json.getAsJsonObject();
    List<Image> images = new ArrayList<>();
    images.add(new Image("1", jsonObject.get("imageUrl1").getAsString()));
    images.add(new Image("2", jsonObject.get("imageUrl2").getAsString()));
    images.add(new Image("3", jsonObject.get("imageUrl3").getAsString()));

    logger.debug("images : {}", images);
    return new Pm10Request(
        images,
        jsonObject.get("informGrade").getAsString(),
        jsonObject.get("informOverall").getAsString(),
        jsonObject.get("dataTime").getAsString()
    );
  }
}
