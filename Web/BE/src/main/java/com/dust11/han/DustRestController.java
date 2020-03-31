package com.dust11.han;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api")
@Api(tags = "미세먼지")
public class DustRestController {

  @Value("${api.key}")
  private String key;

  @GetMapping("locations/tm")
  @ApiOperation("요청하면 상현동에 대한 tm,ty 좌표를 반환해요 ")
  public String tmty() throws IOException {
    StringBuilder urlBuilder = new StringBuilder("http://openapi.airkorea.or.kr/openapi/services/rest/MsrstnInfoInqireSvc/getTMStdrCrdnt"); /*URL*/
    urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+key); /*Service Key*/
    urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
    urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지 번호*/
    urlBuilder.append("&" + URLEncoder.encode("umdName","UTF-8") + "=" + URLEncoder.encode("상현동", "UTF-8")); /*읍면동명*/
    urlBuilder.append("&" + URLEncoder.encode("_returnType","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
    URL url = new URL(urlBuilder.toString());
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");
    conn.setRequestProperty("Content-type", "application/json");
    BufferedReader rd;
    if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
      rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    } else {
      rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
    }
    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = rd.readLine()) != null) {
      sb.append(line);
    }
    rd.close();
    conn.disconnect();
    return sb.toString();
  }

  @GetMapping("locations/xy")
  @ApiOperation("요청하면 상현동 (tmX, tmY) 대해 가장 가까운 측정소를 반환해요")
  public String xy() throws IOException {
    StringBuilder urlBuilder = new StringBuilder("http://openapi.airkorea.or.kr/openapi/services/rest/MsrstnInfoInqireSvc/getNearbyMsrstnList"); /*URL*/
    urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+key); /*Service Key*/
    urlBuilder.append("&" + URLEncoder.encode("tmX","UTF-8") + "=" + URLEncoder.encode("206821.728892", "UTF-8")); /*TM측정방식 X좌표*/
    urlBuilder.append("&" + URLEncoder.encode("tmY","UTF-8") + "=" + URLEncoder.encode("422405.691035", "UTF-8")); /*TM측정방식 Y좌표*/
    urlBuilder.append("&" + URLEncoder.encode("_returnType","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
    URL url = new URL(urlBuilder.toString());
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");
    conn.setRequestProperty("Content-type", "application/json");
    BufferedReader rd;
    if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
      rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    } else {
      rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
    }
    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = rd.readLine()) != null) {
      sb.append(line);
    }
    rd.close();
    conn.disconnect();
    return sb.toString();
  }


  @GetMapping("/dust")
  @ApiOperation("요청하면 상현동에서 제일 가까운 광교동 측정소에 대해 하루치 미세먼지 현황에 대해 반환해요 ")
  public String dust() throws IOException {
    StringBuilder urlBuilder = new StringBuilder("http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty"); /*URL*/
    urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+key); /*Service Key*/
    urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("24", "UTF-8")); /*한 페이지 결과 수*/
    urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지 번호*/
    urlBuilder.append("&" + URLEncoder.encode("stationName","UTF-8") + "=" + URLEncoder.encode("광교동", "UTF-8")); /*측정소 이름*/
    urlBuilder.append("&" + URLEncoder.encode("dataTerm","UTF-8") + "=" + URLEncoder.encode("DAILY", "UTF-8")); /*요청 데이터기간 (하루 : DAILY, 한달 : MONTH, 3달 : 3MONTH)*/
    urlBuilder.append("&" + URLEncoder.encode("_returnType","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
    urlBuilder.append("&" + URLEncoder.encode("ver","UTF-8") + "=" + URLEncoder.encode("1.3", "UTF-8")); /*버전별 상세 결과 참고문서 참조*/

    URL url = new URL(urlBuilder.toString());
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");
    conn.setRequestProperty("Content-type", "application/json");
    BufferedReader rd;
    if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
      rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    } else {
      rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
    }
    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = rd.readLine()) != null) {
      sb.append(line);
    }
    rd.close();
    conn.disconnect();
    return sb.toString();
  }

  @GetMapping("/pm10")
  @ApiOperation("요청하면 2020-03-31 기준인, PM10에 대한 대기오염정보를 반환해요 ")
  public String pm10Animations() throws IOException {
    StringBuilder urlBuilder = new StringBuilder("http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMinuDustFrcstDspth"); /*URL*/
    urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+key); /*Service Key*/
    urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지 번호*/
    urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
    urlBuilder.append("&" + URLEncoder.encode("searchDate","UTF-8") + "=" + URLEncoder.encode("2020-03-31", "UTF-8")); /*측정소 이름*/
    urlBuilder.append("&" + URLEncoder.encode("InformCode","UTF-8") + "=" + URLEncoder.encode("PM10", "UTF-8")); /*요청 데이터기간 (하루 : DAILY, 한달 : MONTH, 3달 : 3MONTH)*/
    urlBuilder.append("&" + URLEncoder.encode("_returnType","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
    urlBuilder.append("&" + URLEncoder.encode("ver","UTF-8") + "=" + URLEncoder.encode("1.1", "UTF-8")); /*버전별 상세 결과 참고문서 참조*/

    URL url = new URL(urlBuilder.toString());
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");
    conn.setRequestProperty("Content-type", "application/json");
    BufferedReader rd;
    if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
      rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    } else {
      rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
    }
    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = rd.readLine()) != null) {
      sb.append(line);
    }
    rd.close();
    conn.disconnect();
    return sb.toString();
  }
}
