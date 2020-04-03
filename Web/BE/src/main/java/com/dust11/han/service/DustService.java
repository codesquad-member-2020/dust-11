package com.dust11.han.service;

import com.dust11.han.model.DustList;
import com.dust11.han.model.LocationList;
import com.dust11.han.model.LocationRequest;
import com.dust11.han.model.Pm10List;
import com.dust11.han.model.TmXYList;
import com.dust11.han.model.TmXYRequest;
import com.dust11.han.model.UrlRequest;
import com.google.gson.Gson;
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
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.client.RestTemplate;

@Service
public class DustService {

  private final Logger logger = LoggerFactory.getLogger(DustService.class);
  private final RestTemplate restTemplate;
  private final Gson gson;

  @Value("${api.dust.key}")
  private String key;

  @Value("${api.dust.url}")
  private String apiUrl;

  public DustService(RestTemplate restTemplate, Gson gson) {
    this.restTemplate = restTemplate;
    this.gson = gson;
  }

  public DustList getDust(String umdName) {
    UrlRequest request = new UrlRequest(apiUrl, "/MsrstnInfoInqireSvc/getTMStdrCrdnt");
    request.addServiceKey(key);
    request.addParam("numOfRows", "10");
    request.addParam("pageNo", "1");
    request.addParam("umdName", umdName);
    request.addParam("_returnType", "json");

    HttpHeaders httpHeaders = new HttpHeaders();
    httpHeaders.setContentType(MediaType.APPLICATION_JSON);
    logger.debug("url : {}", request.getUrl());
    URI uri = URI.create(request.getUrl());

    HttpEntity<String> entity = new HttpEntity<>(httpHeaders);
    ResponseEntity<String> responseEntity = restTemplate
        .exchange(uri, HttpMethod.GET, entity, String.class);

    TmXYList tmXYList = gson.fromJson(responseEntity.getBody(), TmXYList.class);
    TmXYRequest tmXYRequest = tmXYList.getList().get(0);
    return getTmx(tmXYRequest.getTmX(), tmXYRequest.getTmY());
  }

  public DustList getTmx(String tmX, String tmY) {
    UrlRequest request = new UrlRequest(apiUrl, "/MsrstnInfoInqireSvc/getNearbyMsrstnList");
    request.addServiceKey(key);
    request.addParam("tmX", tmX);
    request.addParam("tmY", tmY);
    request.addParam("_returnType", "json");

    HttpHeaders httpHeaders = new HttpHeaders();
    httpHeaders.setContentType(MediaType.APPLICATION_JSON);
    URI uri = URI.create(request.getUrl());
    HttpEntity<String> entity = new HttpEntity<>(httpHeaders);
    ResponseEntity<String> responseEntity = restTemplate
        .exchange(uri, HttpMethod.GET, entity, String.class);

    LocationList locationList = gson.fromJson(responseEntity.getBody(), LocationList.class);
    LocationRequest locationRequest = locationList.getList().get(0);
    return dust(locationRequest.getStationName());
  }

  private DustList dust(String stationName) {
    UrlRequest request = new UrlRequest(apiUrl, "/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty");
//    StringBuilder url = new StringBuilder(
//        apiUrl + "/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty");
    request.addServiceKey(key);
    request.addParam("numOfRows", "24");
    request.addParam("pageNo", "1");
    request.addParam("stationName", stationName);
    request.addParam("dataTerm", "DAILY");
    request.addParam("ver", "1.3");
    request.addParam("_returnType", "json");


//    url.append("?").append(URLEncoder.encode("ServiceKey", "UTF-8")).append("=").append(key);
//    url.append("&").append(URLEncoder.encode("numOfRows", "UTF-8")).append("=")
//        .append(URLEncoder.encode("24", "UTF-8"));
//    url.append("&").append(URLEncoder.encode("pageNo", "UTF-8")).append("=")
//        .append(URLEncoder.encode("1", "UTF-8"));
//    url.append("&").append(URLEncoder.encode("stationName", "UTF-8")).append("=")
//        .append(URLEncoder.encode(stationName, "UTF-8"));
//    url.append("&").append(URLEncoder.encode("dataTerm", "UTF-8")).append("=")
//        .append(URLEncoder.encode("DAILY", "UTF-8"));
//    url.append("&").append(URLEncoder.encode("_returnType", "UTF-8")).append("=")
//        .append(URLEncoder.encode("json", "UTF-8"));
//    url.append("&").append(URLEncoder.encode("ver", "UTF-8")).append("=")
//        .append(URLEncoder.encode("1.3", "UTF-8"));

    HttpHeaders httpHeaders = new HttpHeaders();
    httpHeaders.setContentType(MediaType.APPLICATION_JSON);
    URI uri = URI.create(request.getUrl());
    HttpEntity<String> entity = new HttpEntity<>(httpHeaders);
    ResponseEntity<String> responseEntity = restTemplate
        .exchange(uri, HttpMethod.GET, entity, String.class);
    DustList dustList = gson.fromJson(responseEntity.getBody(), DustList.class);
    dustList.setStationName(stationName);
    return dustList;
  }

  @GetMapping("/pm10/{date}")
  @ApiOperation("날짜 기준으로, PM10 대기오염정보 현황을 반환 ")
  public String pm10Animations(
      @PathVariable(value = "date") @ApiParam("예시 : 2020-04-01") String searchDate)
      throws IOException {
    StringBuilder url = new StringBuilder(
        "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMinuDustFrcstDspth"); /*URL*/
    url.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + key); /*Service Key*/
    url.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
    url.append(
        "&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("10", "UTF-8"));
    url.append("&" + URLEncoder.encode("searchDate", "UTF-8") + "=" + URLEncoder
        .encode(searchDate, "UTF-8"));
    url.append(
        "&" + URLEncoder.encode("InformCode", "UTF-8") + "=" + URLEncoder.encode("PM10", "UTF-8"));
    url.append(
        "&" + URLEncoder.encode("_returnType", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
    url.append("&" + URLEncoder.encode("ver", "UTF-8") + "=" + URLEncoder.encode("1.1", "UTF-8"));

    HttpHeaders httpHeaders = new HttpHeaders();
    httpHeaders.setContentType(MediaType.APPLICATION_JSON);
    URI uri = URI.create(url.toString());
    HttpEntity<String> request = new HttpEntity<>(httpHeaders);
    ResponseEntity<String> responseEntity = restTemplate
        .exchange(uri, HttpMethod.GET, request, String.class);
    Pm10List list = gson.fromJson(responseEntity.getBody(), Pm10List.class);
    return list.toString();
  }
}
