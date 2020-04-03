package com.dust11.han.controller;

import com.dust11.han.api.ApiResult;
import com.dust11.han.service.DustService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import java.io.IOException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/dust")
@Api(tags = "미세먼지 조회")
public class DustRestController {

  private final Logger logger = LoggerFactory.getLogger(DustRestController.class);
  private final DustService dustService;

  public DustRestController(DustService dustService) {
    this.dustService = dustService;
  }

  @GetMapping("{region}")
  @ApiOperation("region(읍면동) 에 대한 24시간 미세먼지 현황 반환")
  public ApiResult<String> getDustFromRegion(
      @PathVariable(value = "region") @ApiParam(value = "예시 : 상현동") String region)
      throws IOException {
    return ApiResult.OK(dustService.getDust(region));
  }

}
