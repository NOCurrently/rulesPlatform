package com.xc.config;


import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import javax.annotation.PostConstruct;

/**
 * freemark配置
 *
 * @author tangwei
 * @data 2019-04-12
 */
@Slf4j
@Configuration
public class FreeMarkerConfig {

    @Autowired
    private freemarker.template.Configuration configuration;


    @Value("${backend.cms.console.base.url}")
    private String ctx;


    /**
     * Spring 初始化的时候加载配置
     *
     * @throws Exception
     */
    @PostConstruct
    public void setConfigure() throws Exception {

        // 加载html的资源路径
        configuration.setSharedVariable("base", ctx);

    }


}
