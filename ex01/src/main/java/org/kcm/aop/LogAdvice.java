package org.kcm.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {

	@Before("execution(* org.kcm.service.SampleService*.*(..))")
	//SampleService로 시작하는 파일들의 모든 메소드를 시작하기 전에 실행되는 것임.
	public void logBefore() {
		log.info("========================================");
	}
	
	@Before("execution(* org.kcm.service.SampleService*.doAdd(String,String))&&args(str1,str2)")
	public void logBeforeWithParam(String str1, String str2) {
		log.info("str1 : "+str1);
		log.info("str2 : "+str2);
	}
	
	@AfterThrowing(pointcut = "execution(* org.kcm.service.SampleService*.*(..))", throwing = "e")
	public void logException(Exception e) {
		log.info("exception!!");
		log.info("exception!! : "+e);
	}
	
	@Around("execution(* org.kcm.service.SampleService*.*(..))")
	public Object logTime(ProceedingJoinPoint pjp) {
		long start = System.currentTimeMillis();
		log.info("Target : "+pjp.getTarget());
		log.info("Param : "+Arrays.toString(pjp.getArgs()));
		Object result = null;
		try {
			result = pjp.proceed();
		}catch (Throwable e) {}
			long end = System.currentTimeMillis();
			log.info("time : "+(end-start));
			return result;
		}
}
