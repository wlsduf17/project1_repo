package com.raregames.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.raregames.domain.UserManageVO;


public class UserInterceptor extends HandlerInterceptorAdapter{ 

	/*
	 * 로그인 상태가 아니고 Ajax 요청이 아닌 경우
	 * 로그인 화면으로 이동 및 요청된 주소를 저장
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		UserManageVO userManageVO = (UserManageVO) session.getAttribute("loginUser");
		
		if(userManageVO == null) {
			
			//Ajax 요청 확인
			if(isAjaxRequest(request)) {
				response.sendError(400); //Ajax에 400에러 리턴
				return false;
			}else {
				//요청된 주소 저장
				getDestination(request);
				//로그인 화면으로 이동
				response.sendRedirect("/user/login");
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
