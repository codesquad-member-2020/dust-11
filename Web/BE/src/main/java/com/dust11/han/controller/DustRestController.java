package com.dust11.han.controller;

import com.dust11.han.model.DustList;
import com.dust11.han.model.LocationList;
import com.dust11.han.model.LocationRequest;
import com.dust11.han.model.Pm10Request;
import com.dust11.han.model.TmXYList;
import com.dust11.han.model.TmXYRequest;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
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
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("api/dust")
@Api(tags = "미세먼지 조회")
public class DustRestController {

  private final Logger logger = LoggerFactory.getLogger(DustRestController.class);
  private final RestTemplate restTemplate;
  private final Gson gson;

  @Value("${api.dust.key}")
  private String key;

  @Value("${api.dust.url}")
  private String apiUrl;

  public DustRestController(RestTemplate restTemplate, Gson gson) {
    this.restTemplate = restTemplate;
    this.gson = gson;
  }

  @GetMapping("{region}")
  @ApiOperation("region(읍면동) 에 대한 24시간 미세먼지 현황 반환")
  public String get(@PathVariable(value = "region") @ApiParam(value = "예시 : 상현동") String umdName)
      throws IOException {
    StringBuilder url = new StringBuilder(apiUrl + "/MsrstnInfoInqireSvc/getTMStdrCrdnt");
    url.append("?").append(URLEncoder.encode("ServiceKey", "UTF-8")).append("=").append(key);
    url.append("&").append(URLEncoder.encode("numOfRows", "UTF-8")).append("=")
        .append(URLEncoder.encode("10", "UTF-8"));
    url.append("&").append(URLEncoder.encode("pageNo", "UTF-8")).append("=")
        .append(URLEncoder.encode("1", "UTF-8"));
    url.append("&").append(URLEncoder.encode("umdName", "UTF-8")).append("=")
        .append(URLEncoder.encode(umdName, "UTF-8"));
    url.append("&").append(URLEncoder.encode("_returnType", "UTF-8")).append("=")
        .append(URLEncoder.encode("json", "UTF-8"));

    HttpHeaders httpHeaders = new HttpHeaders();
    httpHeaders.setContentType(MediaType.APPLICATION_JSON);
    URI uri = URI.create(url.toString());
    HttpEntity<String> request = new HttpEntity<>(httpHeaders);
    ResponseEntity<String> responseEntity = restTemplate
        .exchange(uri, HttpMethod.GET, request, String.class);

    TmXYList tmXYList = gson.fromJson(responseEntity.getBody(), TmXYList.class);
    TmXYRequest tmXYRequest = tmXYList.getList().get(0);
    return getTmx(tmXYRequest.getTmX(), tmXYRequest.getTmY());
  }

  public String getTmx(String tmX, String tmY) throws IOException {
    StringBuilder url = new StringBuilder(apiUrl + "/MsrstnInfoInqireSvc/getNearbyMsrstnList");
    url.append("?").append(URLEncoder.encode("ServiceKey", "UTF-8")).append("=").append(key);
    url.append("&").append(URLEncoder.encode("tmX", "UTF-8")).append("=")
        .append(URLEncoder.encode(tmX, "UTF-8"));
    url.append("&").append(URLEncoder.encode("tmY", "UTF-8")).append("=")
        .append(URLEncoder.encode(tmY, "UTF-8"));
    url.append("&").append(URLEncoder.encode("_returnType", "UTF-8")).append("=")
        .append(URLEncoder.encode("json", "UTF-8"));

    HttpHeaders httpHeaders = new HttpHeaders();
    httpHeaders.setContentType(MediaType.APPLICATION_JSON);
    URI uri = URI.create(url.toString());
    HttpEntity<String> request = new HttpEntity<>(httpHeaders);
    ResponseEntity<String> responseEntity = restTemplate
        .exchange(uri, HttpMethod.GET, request, String.class);

    LocationList locationList = gson.fromJson(responseEntity.getBody(), LocationList.class);
    LocationRequest locationRequest = locationList.getList().get(0);
    return dust(locationRequest.getStationName());

  }


  private String dust(String stationName) throws IOException {
    StringBuilder url = new StringBuilder(
        apiUrl + "/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty");
    url.append("?").append(URLEncoder.encode("ServiceKey", "UTF-8")).append("=").append(key);
    url.append("&").append(URLEncoder.encode("numOfRows", "UTF-8")).append("=")
        .append(URLEncoder.encode("24", "UTF-8"));
    url.append("&").append(URLEncoder.encode("pageNo", "UTF-8")).append("=")
        .append(URLEncoder.encode("1", "UTF-8"));
    url.append("&").append(URLEncoder.encode("stationName", "UTF-8")).append("=")
        .append(URLEncoder.encode(stationName, "UTF-8"));
    url.append("&").append(URLEncoder.encode("dataTerm", "UTF-8")).append("=")
        .append(URLEncoder.encode("DAILY", "UTF-8"));
    url.append("&").append(URLEncoder.encode("_returnType", "UTF-8")).append("=")
        .append(URLEncoder.encode("json", "UTF-8"));
    url.append("&").append(URLEncoder.encode("ver", "UTF-8")).append("=")
        .append(URLEncoder.encode("1.3", "UTF-8"));

    HttpHeaders httpHeaders = new HttpHeaders();
    httpHeaders.setContentType(MediaType.APPLICATION_JSON);
    URI uri = URI.create(url.toString());
    HttpEntity<String> request = new HttpEntity<>(httpHeaders);
    ResponseEntity<String> responseEntity = restTemplate
        .exchange(uri, HttpMethod.GET, request, String.class);
    DustList dustList = gson.fromJson(responseEntity.getBody(), DustList.class);
    dustList.setStationName(stationName);
    return dustList.toString();

  }

  @GetMapping("/pm10/{date}")
  @ApiOperation("날짜 기준으로, PM10 대기오염정보 현황을 반환 ")
  public String pm10Animations(
      @PathVariable(value = "date") @ApiParam("예시 : 2020-04-01") String searchDate)
      throws IOException {
    StringBuilder url = new StringBuilder(
        "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMinuDustFrcstDspth"); /*URL*/
    url.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + key); /*Service Key*/
    url.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder
        .encode("1", "UTF-8"));
    url.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder
        .encode("10", "UTF-8"));
    url.append("&" + URLEncoder.encode("searchDate", "UTF-8") + "=" + URLEncoder
        .encode(searchDate, "UTF-8"));
    url.append("&" + URLEncoder.encode("InformCode", "UTF-8") + "=" + URLEncoder
        .encode("PM10", "UTF-8"));
    url.append(
        "&" + URLEncoder.encode("_returnType", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
    url.append("&" + URLEncoder.encode("ver", "UTF-8") + "=" + URLEncoder
        .encode("1.1", "UTF-8"));

    HttpHeaders httpHeaders = new HttpHeaders();
    httpHeaders.setContentType(MediaType.APPLICATION_JSON);
    URI uri = URI.create(url.toString());
    HttpEntity<String> request = new HttpEntity<>(httpHeaders);
    ResponseEntity<String> responseEntity = restTemplate
        .exchange(uri, HttpMethod.GET, request, String.class);
    JsonObject jsonObject = JsonParser.parseString(responseEntity.getBody()).getAsJsonObject()
        .get("list").getAsJsonArray().get(0).getAsJsonObject();
    Pm10Request pm10Request = new Pm10Request();
    pm10Request.setDataTime(jsonObject.get("dataTime").toString());
    pm10Request.setInformOverall(jsonObject.get("informOverall").toString());
    pm10Request.setInformGrade(jsonObject.get("informGrade").toString());
    pm10Request.getImages().add(jsonObject.get("imageUrl1").toString());
    pm10Request.getImages().add(jsonObject.get("imageUrl2").toString());
    pm10Request.getImages().add(jsonObject.get("imageUrl3").toString());
    return pm10Request.toString();
  }
}
