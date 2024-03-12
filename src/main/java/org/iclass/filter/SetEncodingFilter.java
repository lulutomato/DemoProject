package org.iclass.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

//@WebFilter(servletNames = { "SetEncodingFilter" })  	//애노테이션 또는 web.xml 에서 설정합니다.
public class SetEncodingFilter implements Filter {
	
	private static final Logger logger = LoggerFactory.getLogger(SetEncodingFilter.class);

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
						throws IOException, ServletException {
		
	
	//doFilter 메소드의 인자 request는 타입이 HttpServletRequest(인터페이스) 가 아닙니다.
	//   							     ServletRequest 부모 인터페이스 타입으로 다운캐스팅 필요합니다.
		HttpServletRequest httpRequest = (HttpServletRequest)request;		
		logger.info(":::::::: 요청 전 SetEncodingFilter: {} , {} ::::::::",httpRequest.getServletPath(),System.currentTimeMillis());
		
		httpRequest.setCharacterEncoding("UTF-8");

	//필터는 체인(묶다.연결하다)으로 구성될 수 있으므로 다음 필터 실행합니다. 
		chain.doFilter(request, response);
	// chain.doFilter 이후는	요청을 모두 처리하고 응답을 보낼 때 실행됩니다.
		logger.info(":::::::: 요청 후 SetEncodingFilter: {} , {} ::::::::",httpRequest.getServletPath(),System.currentTimeMillis());

	}
	// 이 필터는 모든 요청에 대한 문자인코딩을 UTF-8로 합니다. 따라서 서블릿에서
	// request.setCharacterEncoding("UTF-8"); 코딩은 작성 안해도 됩니다.
}
