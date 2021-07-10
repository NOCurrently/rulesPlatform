package com.xc.config;

import com.alibaba.fastjson.parser.Feature;
import com.alibaba.fastjson.serializer.DoubleSerializer;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.alibaba.fastjson.support.config.FastJsonConfig;
import com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.http.converter.ByteArrayHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.ParameterBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.schema.ModelRef;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.service.Parameter;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

/**
 * @author zhangyang
 * @date 2018/7/25
 * 拦截器配置
 */
@Configuration
@EnableSwagger2
public class WebMvcConfig extends WebMvcConfigurationSupport {

    @Value("${swagger2.base.url}")
    private String swagger2Url;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/static/**")
                .excludePathPatterns("/error")
                .excludePathPatterns("/ping")
                .excludePathPatterns("/login")
                .excludePathPatterns("/swagger-ui.html")
                .excludePathPatterns("/web/userLogin");
        super.addInterceptors(registry);

    }
    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        FastJsonConfig fastJsonConfig = new FastJsonConfig();
        fastJsonConfig.setFeatures(Feature.DisableCircularReferenceDetect);
        fastJsonConfig.setSerializerFeatures(SerializerFeature.SkipTransientField,
                SerializerFeature.DisableCircularReferenceDetect);
        fastJsonConfig.getSerializeConfig().put(Double.class, new DoubleSerializer());

        List<MediaType> list = new ArrayList<MediaType>();
        list.add(new MediaType("application", "json", StandardCharsets.UTF_8));
        FastJsonHttpMessageConverter fastJsonHttpMessageConverter = new FastJsonHttpMessageConverter();
        fastJsonHttpMessageConverter.setSupportedMediaTypes(list);
        fastJsonHttpMessageConverter.setFastJsonConfig(fastJsonConfig);
        converters.add(fastJsonHttpMessageConverter);

        ByteArrayHttpMessageConverter byteArrayHttpMessageConverter = new ByteArrayHttpMessageConverter();
        converters.add(byteArrayHttpMessageConverter);
    }



    @Bean
    public Docket createRestApi() {
        ParameterBuilder parameterBuilder = new ParameterBuilder();
        Parameter appVersion = parameterBuilder.name("appVersion").description("appVersion").modelRef(new ModelRef("string")).parameterType("header").required(false).build();
        Parameter cookie = parameterBuilder.name("auth").description("auth").modelRef(new ModelRef("string")).parameterType("header").required(false).build();
        List<Parameter> headerParameters = new ArrayList<>();
        headerParameters.add(appVersion);
        headerParameters.add(cookie);
        return new Docket(DocumentationType.SWAGGER_2)
                .host(swagger2Url)
                .apiInfo(apiInfo())
                //公共参数
                .globalOperationParameters(headerParameters)
                .select()
                //为当前包路径
                .apis(RequestHandlerSelectors.basePackage("com.xc"))
                .paths(PathSelectors.any())
                .build();
    }

    /**
     * @param
     * @return springfox.documentation.service.ApiInfo
     * @Description 构建 api文档的详细信息函数
     * @methodName apiInfo
     * @author ethan.hu
     * @date 2018/12/14 18:25
     */
    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                //页面标题
                .title("规则平台")
                //创建人
                .contact(new Contact("肖超", "https://www.baidu.com/", "xiaochao_bos@163.com"))
                //版本号
                .version("1.0")
                //描述
                .description("规则平台")
                .build();
    }

    @Override
    protected void addResourceHandlers(ResourceHandlerRegistry registry) {


        // 解决swagger无法访问

        registry.addResourceHandler("/swagger-ui.html").addResourceLocations("classpath:/META-INF/resources/");

        // 解决swagger的js文件无法访问

        registry.addResourceHandler("/webjars/**").addResourceLocations("classpath:/META-INF/resources/webjars/");

        registry.addResourceHandler("/**").addResourceLocations("classpath:/static/");
        registry.addResourceHandler("/templates/**").addResourceLocations("classpath:/templates/");
    }
}
