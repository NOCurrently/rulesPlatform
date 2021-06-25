package com.xc.config;

import java.lang.annotation.Annotation;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;

import com.xc.annotation.Verify;
import com.xc.until.JsonUtil;
import org.apache.commons.lang3.ArrayUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

/**
 * 全局日志
 * 
 * @author 肖超
 * @Date 2018/8/29
 */
@Aspect
@Component
public class VerifyAop {

	private static final Validator validator= Validation.buildDefaultValidatorFactory().getValidator();;

	@Around("@within(org.springframework.stereotype.Controller) || @within(org.springframework.web.bind.annotation.RestController)")
	public Object doAround(ProceedingJoinPoint pjp) throws Throwable {
		MethodSignature signature = (MethodSignature) pjp.getSignature();
		Annotation[][] parameterAnnotations = signature.getMethod().getParameterAnnotations();
		Object[] args = pjp.getArgs();
		for (Annotation[] annotations : parameterAnnotations) {
			int paramIndex = ArrayUtils.indexOf(parameterAnnotations, annotations);
			for (Annotation annotations2 : annotations) {
				if (annotations2 instanceof Verify) {
					Object paramValue = args[paramIndex];
					Set<ConstraintViolation<Object>> violationSet = validator.validate(paramValue);
					if (violationSet != null && !CollectionUtils.isEmpty(violationSet)) {
                        List<String> resultList = violationSet.stream().map(ConstraintViolation::getMessage).collect(Collectors.toList());
						return WebResponse.fail("9999", JsonUtil.write2JsonStr(resultList));
					}
				}
			}
		}

		Object ob = pjp.proceed();

		return ob;
	}
}
