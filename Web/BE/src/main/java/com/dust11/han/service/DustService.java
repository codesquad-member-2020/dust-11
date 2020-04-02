package com.dust11.han.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class DustService {

  private final Logger logger = LoggerFactory.getLogger(DustService.class);

  private final RestTemplate restTemplate;

  public DustService(RestTemplate restTemplate) {
    this.restTemplate = restTemplate;
  }

}
