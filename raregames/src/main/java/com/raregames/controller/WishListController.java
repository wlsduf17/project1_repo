package com.raregames.controller;

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

import com.raregames.domain.MberManageVO;
import com.raregames.domain.WishListVO;
import com.raregames.service.ProdManageService;
import com.raregames.service.WishListService;

import lombok.Setter;

@RequestMapping("/prod/*")
@Controller
public class WishListController {
	
	@Setter(onMethod_ = @Autowired)
	private WishListService wishListService;
	@Setter(onMethod_ = @Autowired)
	private ProdManageService prodManageService;
	
	/*
	 * 위시리스트 화면으로 이동
	 * - 위시리스트 MberGlobalAdvice 클래스에서 model 제공
	 */
	@GetMapping("/wishList")
	public void wishListView(Model model) {
		
		//사이드바 추천상품
		model.addAttribute("prodList", prodManageService.selectProdList());
	}
	
	/*
	 * 위시리스트 추가 처리
	 */
	@ResponseBody
	@PostMapping("/wishList/insert")
	public ResponseEntity<String> insertWishListAjax
			(		@RequestParam("prodNo") Integer prodNo,
					HttpSession session)throws Exception {
		
		ResponseEntity<String> entity = null;
		
		WishListVO wishListVO = new WishListVO();
		
		String mberId = ((MberManageVO)(session.getAttribute("loginMber"))).getMberId();
		wishListVO.setMberId(mberId);
		wishListVO.setProdNo(prodNo);
		
		try {
			//위시리스트 추가
			wishListService.insertWishList(wishListVO);
			//장바구니 제거
			
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	/*
	 * 위시리스트 제거 처리
	 */
	@ResponseBody
	@PostMapping("/wishList/delete")
	public ResponseEntity<String> deleteWishListAjax
			(		@RequestParam("prodNo") Integer prodNo,
					HttpSession session)throws Exception {
		
		ResponseEntity<String> entity = null;
		
		WishListVO wishListVO = new WishListVO();
		
		String mberId = ((MberManageVO)(session.getAttribute("loginMber"))).getMberId();
		wishListVO.setMberId(mberId);
		wishListVO.setProdNo(prodNo);
		
		try {
			wishListService.deleteWishList(wishListVO);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
