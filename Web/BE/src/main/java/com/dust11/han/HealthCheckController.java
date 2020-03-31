package com.dust11.han;

import com.dust11.han.api.ApiResult;
import io.swagger.annotations.Api;
import java.text.SimpleDateFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/_hcheck")
@Api(tags = "헬스체크 API")
public class HealthCheckController {

  private final static SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

  @GetMapping
  public ApiResult<String> healthCheck() {
    return ApiResult.OK(format1.format(System.currentTimeMillis()));
  }
}
