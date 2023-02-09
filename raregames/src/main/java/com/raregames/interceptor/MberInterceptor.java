package com.raregames.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.raregames.domain.MberManageVO;

import lombok.extern.log4j.Log4j;

/*
 * Filter, Interceptor, AOP 유사 개념들
 * Filter는 DispatcherServlet 이전에 실행되어 요청, 응답을 걸러 정제하는 역할, 말그대로 필터링
 * 보통 web.xml에서 등록하며, 일반적으로 인코딩 변환처리, XSS방어 등의 요청에 대한 처리로 사용
 * 
 * Interceptor는 DispatcherServlet와 Controller 사이에서 작동
 * 주로 로그인 체크, 권한체크 등에 사용된다. Spring Security로 로그인 작업시 이 작업을 피할 수 도 있다.
 * 
 * AOP는 Servlet단위에서 실행되는 Filter, Interceptor와 다르게 메소드 전후 지점 자유롭게 설정 가능하다.
 * 로깅, 트랜잭션, 에러처리 등 비즈니스단의 메서드에서 세부 조정이 필요할 때 사용한다.
 * 
 * 회원 로그인 Interceptor
 * servlet-context.xml 매핑주소
 * cart/list, prod/wishList
 */

@Log4j
public class MberInterceptor extends HandlerInterceptorAdapter{
	/*
	 * 로그인 상태가 아니고 Ajax 요청이 아닌 경우
	 * 로그인 화면으로 이동 및 요청된 주소를 저장
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		MberManageVO mberManageVO = (MberManageVO) session.getAttribute("loginMber");
		
		if(mberManageVO == null) {
			
			//Ajax 요청 확인
			if(isAjaxRequest(request)) {
				response.sendError(400); //Ajax에 400에러 리턴
				return false;
			}else {
				//요청된 주소 저장
				getDestination(request);
				//로그인 화면으로 이동
				response.sendRedirect("/mber/login");
				return false;
			}
			
		}
		return true;
	}
	
	
	//인터셉터 동작 전에 요청된 주소 정보를 저장하는 메서드
	private void getDestination(HttpServletRequest request) {
		
		String uri = request.getRequestURI(); //요청주소 /mber/list
		String query = request.getQueryString(); //쿼리스트링 pageSize=2
		
		if(query == null || query.equals("null")) {
			query = "";
		}else {
			query = "?" + query; // ?pageSize=2
		}
		String destination = uri + query; // /mber/list?pageSize=2
		
		if(request.getMethod().equals("GET")) {
			log.info("요청주소" + destination);
			//원래 요청된 주소
			request.getSession().setAttribute("destination", destination);
		}
		
	}
	
	
	//Ajax요청 여부 확인, Ajax의 경우 Redirect 작동x, Ajax가 원하는 값을 받지 못해 에러발생
	private boolean isAjaxRequest(HttpServletRequest request) {
		String header = request.getHeader("AJAX");
		if("true".equals(header)) {
			return true;
		}else {
			return false;
		}
		
	}
	
	
}
