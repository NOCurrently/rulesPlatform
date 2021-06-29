package com.xc;

import org.apache.dubbo.config.spring.context.annotation.EnableDubbo;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Description: 启动类
 * 
 * @author 肖超
 * @date 2018年9月18日
 */
//@ImportResource("classpath:applicationContext.xml")
@SpringBootApplication(scanBasePackages={"com.xc"})
//@EnableCaching
@EnableDubbo
public class Application {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}
}
