package com.dust11.han.controller;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

@Controller
@RequestMapping("api/location")
@Api(tags = "위치 정보 기반 조회")
public class LocationController {

  private final Logger logger = LoggerFactory.getLogger(LocationController.class);
  private final RestTemplate restTemplate;
  private final Gson gson;

  @Value("${api.location.key}")
  private String key;

  @Value("${api.location.url}")
  private String apiUrl;


  public LocationController(RestTemplate restTemplate, Gson gson) {
    this.restTemplate = restTemplate;
    this.gson = gson;
  }

  @GetMapping("{longitude}/{latitude}")
  @ApiOperation("경도, 위도를 기반으로 미세먼지 현황 조회")
  public String trans(
      @PathVariable(value = "longitude") @ApiParam(value = "경도 예시 : 127.1086228") String x,
      @PathVariable(value = "latitude") @ApiParam(value = "위도 예시 : 37.4012191") String y)
      throws IOException {
    StringBuilder url = new StringBuilder(apiUrl);
    url.append("?x=").append(URLEncoder.encode(x, "UTF-8"));
    url.append("&y=").append(URLEncoder.encode(y, "UTF-8"));
    url.append("&input_coord=").append("WGS84");
    url.append("&output_coord=").append("TM");

    HttpHeaders httpHeaders = new HttpHeaders();
    httpHeaders.add("Authorization", "KakaoAK " + key);
    URI uri = URI.create(url.toString());
    HttpEntity<String> request = new HttpEntity<>(httpHeaders);
    ResponseEntity<String> responseEntity = restTemplate
        .exchange(uri, HttpMethod.GET, request, String.class);

    JsonElement jsonElement = JsonParser.parseString(responseEntity.getBody());

    String region = jsonElement.getAsJsonObject().get("documents")
        .getAsJsonArray().get(0).getAsJsonObject().get("address")
        .getAsJsonObject().get("region_3depth_name").getAsString();
    return "redirect:/api/dust/" + URLEncoder.encode(region, "UTF-8");
  }
}
