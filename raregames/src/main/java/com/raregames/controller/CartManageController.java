package com.raregames.controller;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.raregames.domain.CartProdVO;
import com.raregames.domain.CartManageVO;
import com.raregames.domain.MberManageVO;
import com.raregames.service.CartManageService;
import com.raregames.utils.UploadFileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/cart/*")
@Controller
public class CartManageController {
	
	@Resource(name = "uploadFolder")
	private String uploadFolder;//업로드폴더
	
	@Setter(onMethod_ = @Autowired)
	private CartManageService cartManageService; 
	
	/*
	 * 장바구니 목록 화면으로 이동
	 * - 장바구니목록 MberGlobalAdvice 클래스에서 model 제공
	 */
	@GetMapping("/list")
	public void cartListView() {
		
	}
	
	/*
	 * 상품목록 썸네일 이미지 출력
	 * - 파라미터 
	 * 		prodImg 		: 이미지파일명
	 * 		frstRegistDe	: 최초등록날짜
	 * - 최초등록날짜로 파일경로를 구성해 이미지를 byte[]로 클라이언트에 전송
	 */
	@ResponseBody
	@GetMapping("/showThumbnail")
	public ResponseEntity<byte[]> showThumbnail
			(		String prodImg, 
					String frstRegistDe){
		
		ResponseEntity<byte[]> entity = null;
		//날짜포맷을 파일경로로 변경
		String filePath = frstRegistDe.replace("-", File.separator);
		String thumbnailFileName = "s_" + prodImg;
		
		entity = UploadFileUtils.getFileByte(uploadFolder, filePath, thumbnailFileName);
		
		return entity;
	}
	
	/*
	 * 상품 장바구니에 추가 Ajax처리
	 */
	@ResponseBody
	@PostMapping("/insert")
	public ResponseEntity<String> insertCartAjax
			(		@RequestParam("prodNo") Integer prodNo,
					HttpSession session)throws Exception {
		
		ResponseEntity<String> entity = null;
		
		MberManageVO manageVO = (MberManageVO)session.getAttribute("loginMber");
		CartManageVO cartManageVO = new CartManageVO();
		cartManageVO.setMberId(manageVO.getMberId());
		cartManageVO.setProdNo(prodNo);
		
		try {
			cartManageService.insertCart(cartManageVO);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/*
	 * 상품 장바구니 제거 Ajax처리
	 */
	@ResponseBody
	@PostMapping("/delete")
	public ResponseEntity<String> delteProdCartAjax
			(		@RequestParam("prodNo") Integer prodNo,
					HttpSession session)throws Exception {
		
		ResponseEntity<String> entity = null;
		
		MberManageVO manageVO = (MberManageVO)session.getAttribute("loginMber");
		
		try {
			cartManageService.deleteCart(prodNo, manageVO.getMberId());
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
}
