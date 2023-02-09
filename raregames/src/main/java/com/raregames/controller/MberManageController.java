package com.raregames.controller;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.raregames.domain.EmailDTO;
import com.raregames.domain.MberManageVO;
import com.raregames.service.MberManageService;
import com.raregames.service.ProdManageService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

/*
 *  회원 관리에 대한 controller 클래스 정의
 *  
 *  주요기능 : 로그인, 로그아웃, 회원가입, 회원정보수정, 
 *  		   비밀번호변경, 회원탈퇴, 비밀번호 찾기
 *  부가기능 : 아이디/닉네임 중복체크, 메일인증
 */

@Log4j
@RequestMapping("/mber/*")
@Controller
public class MberManageController {
	
	@Setter(onMethod_ = @Autowired)
	private MberManageService mberManageService;
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder cryptPassEnc;
	@Setter(onMethod_ = @Autowired)
	private JavaMailSender mailSender;
	@Setter(onMethod_ = @Autowired)
	private ProdManageService prodManageService;
	
	
	/*
	 * 로그인화면으로 이동
	 */
	@GetMapping("/login")
	public void loginMberView() {
	}
	
	/*
	 * 로그인 Ajax처리(처음에 처리했던 작업)
	 */
	@ResponseBody
	@PostMapping("/login")
	public ResponseEntity<String> actionLoginAjax
			(		@RequestParam("mberId") String mberId,
					@RequestParam("mberPassword") String mberPassword,
					HttpSession session) throws Exception{
		
		ResponseEntity<String> entity = null;
		String result = "";
		
		MberManageVO mberManageVO = mberManageService.selectMber(mberId);
		//아이디 확인
		if(mberManageVO == null) {
			result = "IdIncorrect";
		}else {
			//비밀번호 확인(암호화 비번 매칭 메서드)
			if(cryptPassEnc.matches(mberPassword, mberManageVO.getMberPassword())) {
				result = "success";
				//세션생성(회원정보)
				session.setAttribute("loginMber", mberManageVO);
				//최근접속날짜 업데이트
				mberManageService.updateRcntConectDe();
			}else {
				result = "PwIncorrect";
			}
		}
		entity = new ResponseEntity<String>(result, HttpStatus.OK);
		
		return entity;
	}
	
	/*
	 * 로그인 처리 후 화면으로 이동(인터셉터의 경우 AJAX를 사용할 수 없음)
	 */
	@PostMapping("/login2")
	public String actionLogin(@RequestParam("mberId") String mberId,
			@RequestParam("mberPassword") String mberPassword,
			HttpSession session, RedirectAttributes rttr) throws Exception {
		
		MberManageVO mberManageVO = mberManageService.selectMber(mberId);
		String url = "";
		//계정일치확인(아이디 -> 비밀번호)
		if(mberManageVO == null) {
			rttr.addFlashAttribute("msg", "IdIncorrect");
			url = "/mber/login";
		}else {
			if(cryptPassEnc.matches(mberPassword, mberManageVO.getMberPassword())) {
				rttr.addFlashAttribute("msg", "success");
				session.setAttribute("loginMber", mberManageVO);
				//최근접속날짜 업데이트
				mberManageService.updateRcntConectDe();
				//MberInterceptor에서 생성한 세션 불러오기 = 요청한 주소정보
				String destination = (String) session.getAttribute("destination");
				url = (destination != null ? (String) destination : "/");
			}else {
				rttr.addFlashAttribute("msg", "PwIncorrect");
				url = "/mber/login";
			}
		}
		return "redirect:" + url;
	}
	
	
	/*
	 * 로그아웃 처리 후 기본화면으로 이동
	 */
	@GetMapping("/logout")
	public String actionLogout(HttpSession session) {
		//세션소멸
		session.invalidate();
		
		return "redirect:/";
	}
	
	/*
	 * 회원가입 화면으로 이동
	 */
	@GetMapping("/signup")
	public void signupMberView() {
	}
	
	/*
	 * 회원가입 처리 후 로그인화면으로 이동
	 */
	@PostMapping("/signup")
	public String signupMber(MberManageVO mberManageVO) throws Exception{
		//비밀번호 암호화
		mberManageVO.setMberPassword(cryptPassEnc.encode(mberManageVO.getMberPassword()));
		//체크박스 Y/N 처리
		mberManageVO.setInfoReceptAt(!StringUtils.isEmpty(mberManageVO.getInfoReceptAt()) ? "Y" : "N");
		
		mberManageService.insertMber(mberManageVO);
		
		return "redirect:/mber/login";
	}
	
	/*
	 * 입력한 닉네임과 ID에 대한 중복여부 체크하여 Ajax처리
	 */
	@ResponseBody
	@GetMapping("/checkDplct")
	public ResponseEntity<String> checkNicknmDplctAjax
			(		@RequestParam("mberNicknm") String mberNicknm,
					@RequestParam("mberId") String mberId) throws Exception{
		
		 ResponseEntity<String> entity = null;
		 String result = "";
		//닉네임 중복여부 체크(미중복 -> true)
		 if(StringUtils.isEmpty(mberManageService.checkNicknmDplct(mberNicknm))) {
			 //ID에 대한 중복여부 체크(미중복 -> true)
			 result = StringUtils.isEmpty(mberManageService.checkIdDplct(mberId)) ? "success" : "IdDupl"; 
		 }else {
			 result = "NicknmDupl";
		 }
		 entity = new ResponseEntity<String>(result, HttpStatus.OK);
		 
		 return entity;
	}
	
	/*
	 * 입력한 ID에 대한 중복여부(가입여부) 체크하여 Ajax처리
	 */
	@ResponseBody
	@GetMapping("/checkIdDplct")
	public ResponseEntity<String> checkIdDplctAjax
			(		@RequestParam("mberId") String mberId) throws Exception{
		
		 ResponseEntity<String> entity = null;
		 String result = "";
		 
		 //ID에 대한 중복여부 체크(미중복 -> true)
		 result = StringUtils.isEmpty(mberManageService.checkIdDplct(mberId)) ? "success" : "IdDupl";
		 
		 entity = new ResponseEntity<String>(result, HttpStatus.OK);
		 
		 return entity;
	}
	
	/*
	 * 메일인증 화면으로 이동
	 */
	@PostMapping("/authenMail")
	public void authenMailView(MberManageVO mberManageVO, Model model) {
		
		model.addAttribute("signup", mberManageVO);
	}
	
	/*
	 * 인증메일 전송 Ajax처리
	 * - 메일구성 파라미터 입력 필요
	 */
	@ResponseBody
	@GetMapping("/sendAuthenMail")
	public ResponseEntity<String> authenMailAjax
			(		@RequestParam("mberId") String mberId,
					HttpSession session) throws Exception{
		
		ResponseEntity<String> entity = null;
		//인증코드 생성(0-9 무작위 수)
		String authCode =  "";
		for(int i=0; i<6; i++) {
			authCode += String.valueOf(((int)(Math.random() * 10)));
		}
		//인증코드 세션에 저장
		session.setAttribute("authCode", authCode);
		//메일구성(2번째 파라미터 이메일주소 입력 필요)
		EmailDTO dto = new EmailDTO("Raregames", "wlsduf17@gmail.com", mberId, "인증메일", authCode);
		MimeMessage message = mailSender.createMimeMessage();
		try {
			message.addRecipient(RecipientType.TO, new InternetAddress(mberId));//수신자메일설정
			message.addFrom(new InternetAddress[] {
					new InternetAddress(dto.getSenderEmailAdres(), dto.getSenderNm())
					});//송신자메일,이름설정
			message.setSubject(dto.getEmailSubject(), "UTF-8");//메일제목
			message.setText(dto.getEmailMessage(), "UTF-8");//메일내용
			
			mailSender.send(message);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
			
		}catch(Exception ex) {
			ex.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/*
	 * 메일인증확인 처리
	 */
	@ResponseBody
	@GetMapping("/checkAuthCode")
	public ResponseEntity<String> checkAuthCodeAjax
			(		@RequestParam("authCode") String authCode,
					HttpSession session) {
		
		ResponseEntity<String> entity = null;
		
		String realAuthCode = (String) session.getAttribute("authCode");
		
		if(authCode.equals(realAuthCode)) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>("not Equal", HttpStatus.OK);
		}
		
		return entity;
	}
	
	/*
	 * 계정정보 화면으로 이동
	 */
	@GetMapping("/account")
	public void accountMberView(Model model, HttpSession session) {
		
		MberManageVO loginMber = (MberManageVO) session.getAttribute("loginMber");
		String mberId = loginMber.getMberId();
		
		model.addAttribute("mberManageVO", mberManageService.selectMber(mberId));
	}
	/*
	 * 회원정보수정 Ajax처리
	 */
	@ResponseBody
	@PostMapping("/updateMber")
	public ResponseEntity<String> updateMberAjax
			(		MberManageVO mberManageVO,
					HttpSession session) throws Exception{
		
		ResponseEntity<String> entity = null;
		log.info("회원수정정보" + mberManageVO);
		
		//체크박스 Y/N 처리
		mberManageVO.setInfoReceptAt(!StringUtils.isEmpty(mberManageVO.getInfoReceptAt()) ? "Y" : "N");
		
		
		int result = mberManageService.updateMber(mberManageVO);
		
		if(result == 1) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>("update Fail", HttpStatus.OK);
		}
		
		return entity;
	}
	
	/*
	 * 비밀번호 변경 Ajax처리
	 */
	@ResponseBody
	@PostMapping("/updatePassword")
	public ResponseEntity<String> updatePasswordAjax
				(		MberManageVO mberManageVO) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		//비밀번호 암호화
		mberManageVO.setMberPassword(cryptPassEnc.encode(mberManageVO.getMberPassword()));
		
		int result = mberManageService.updatePassword(mberManageVO.getMberId(), mberManageVO.getMberPassword());
		
		if(result == 1) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>("update Password Fail", HttpStatus.OK);
		}
		
		return entity;
	}
	
	/*
	 * 회원탈퇴 Ajax처리
	 */
	@ResponseBody
	@PostMapping("/deleteMber")
	public ResponseEntity<String> deleteMberAjax
				(		@RequestParam("mberId") String mberId,
						HttpSession session) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		int result = mberManageService.deleteMber(mberId);
		
		if(result == 1) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
			session.invalidate();
		}else {
			entity = new ResponseEntity<String>("delete Fail", HttpStatus.OK);
		}
		
		return entity;
	}
	
	/*
	 * 비밀번호찾기 화면으로 이동
	 */
	@GetMapping("/searchPassword")
	public void searchPasswordView() {
		
	}
	
	/*
	 * 비밀번호찾기 - 메일인증 화면으로 이동
	 */
	@PostMapping("/passwordAuthenMail")
	public void passwordAuthenMailView(@RequestParam("mberId") String mberId, Model model) {
		
		model.addAttribute("authenMail", mberId);
	}
	
	/*
	 * 비밀번호 변경 화면으로 이동
	 */
	@PostMapping("/changePassword")
	public void changePassword(@RequestParam("mberId") String mberId, Model model) {
		
		model.addAttribute("authenMail", mberId);
	}
	
	
	/*
	 * 마이페이지 화면으로 이동
	 */
	@GetMapping("/myGames")
	public void mypageView(Model model) {
		
		//사이드바 추천상품
		model.addAttribute("prodList", prodManageService.selectProdList());
		
	}
	
	
	
	
}
