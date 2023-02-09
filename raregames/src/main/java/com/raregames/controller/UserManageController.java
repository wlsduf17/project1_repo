package com.raregames.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.raregames.domain.UserManageVO;
import com.raregames.service.UserManageService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
/*
 * 관리자에 대한 controller 클래스 정의
 * 
 * 주요기능 : 관리자 로그인, 로그아웃
 * 
 * 관리자 ID : admin, Password : 1234
 */
@Log4j
@RequestMapping("/user/*")
@Controller
public class UserManageController {
	
	@Setter(onMethod_ = @Autowired)
	private UserManageService userManageService;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder cryptPassEnc;
	
	/*
	 * 관리자 메인화면으로 이동
	 */
	@GetMapping("/main")
	public void adminMainView() {
		
	}
	
	/*
	 * 관리자 로그인 화면으로 이동
	 */
	@GetMapping("/login")
	public void adminLoginView() {
		
	}
	
	/*
	 * 로그인 Ajax처리
	 */
	@ResponseBody
	@PostMapping("/login")
	public ResponseEntity<String> actionLoginAjax
			(		@RequestParam("userId") String userId,
					@RequestParam("userPassword") String userPassword,
					HttpSession session) throws Exception{
		
		ResponseEntity<String> entity = null;
		String result = "";
		
		UserManageVO userManageVO = userManageService.selectUser(userId);
		//아이디 확인
		if(userManageVO == null) {
			result = "IdIncorrect";
		}else {
			//비밀번호 확인
			if(cryptPassEnc.matches(userPassword, userManageVO.getUserPassword())) {
				result = "success";
				session.setAttribute("loginUser", userManageVO);
				//최근접속날짜 업데이트
				userManageService.updateRcntConectDe();
			}else {
				result = "PwIncorrect";
			}
		}
		entity = new ResponseEntity<String>(result, HttpStatus.OK);
		
		return entity;
	}
	
	/*
	 * 로그인 처리
	 */
	@PostMapping("/login2")
	public String actionLogin
			(		@RequestParam("userId") String userId,
					@RequestParam("userPassword") String userPassword,
					HttpSession session, RedirectAttributes rttr) throws Exception{
		
		UserManageVO userManageVO = userManageService.selectUser(userId);
		String url = "";
		//아이디 확인
		if(userManageVO == null) {
			rttr.addFlashAttribute("msg", "IdIncorrect");
			url = "/user/login";
		}else {
			//비밀번호 확인
			if(cryptPassEnc.matches(userPassword, userManageVO.getUserPassword())) {
				rttr.addFlashAttribute("msg", "success");
				session.setAttribute("loginUser", userManageVO);
				//최근접속날짜 업데이트
				userManageService.updateRcntConectDe();
				//UserInterceptor에서 생성한 주소 불러오기
				String destination = (String) session.getAttribute("destination");
				url = (destination != null ? (String)destination : "/user/main");
			}else {
				rttr.addFlashAttribute("msg", "PwIncorrect");
				url = "/user/login";
			}
		}
		
		return "redirect:" + url;
	}
	
	/*
	 * 로그아웃 처리
	 */
	@GetMapping("/logout")
	public String actionLogout(HttpSession session) {
		//세션소멸
		session.invalidate();
		
		return "redirect:/user/login";
	}
	
}
