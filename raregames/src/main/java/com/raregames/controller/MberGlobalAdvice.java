package com.raregames.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.raregames.domain.CartProdVO;
import com.raregames.domain.MberManageVO;
import com.raregames.domain.PurchseProdVO;
import com.raregames.domain.WishListProdVO;
import com.raregames.service.CartManageService;
import com.raregames.service.ProdManageService;
import com.raregames.service.PurchseManageService;
import com.raregames.service.WishListService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

/*
 * 회원 페이지 공통 데이터 처리 Advice
 */

@Log4j
@ControllerAdvice(assignableTypes = {HomeController.class, CartManageController.class,
		MberManageController.class, MberProdManageController.class, WishListController.class})
public class MberGlobalAdvice {
	
	@Setter(onMethod_ = @Autowired)
	private PurchseManageService purchseManageService;
	@Setter(onMethod_ = @Autowired)
	private WishListService wishListService;
	@Setter(onMethod_ = @Autowired)
	private ProdManageService prodManageService;
	@Setter(onMethod_ = @Autowired)
	private CartManageService cartManageService;
	
	@ModelAttribute
	public void selectGenreList(Model model) {
		model.addAttribute("navGenreList", prodManageService.selectGenreList());
	}
	
	@ModelAttribute
	public void selectFeatureList(Model model) {
		model.addAttribute("navFeatureList", prodManageService.selectFeatureList());
	}
	
	@ModelAttribute
	public void selectPurchseProdList(Model model, HttpSession session) {
		if(!StringUtils.isEmpty(session.getAttribute("loginMber"))) {
			String mberId = ((MberManageVO)session.getAttribute("loginMber")).getMberId();
			//구매리스트
			List<PurchseProdVO> purchseProdList = purchseManageService.selectMberPurchseList(mberId);
			model.addAttribute("purchseProdList", purchseProdList);
			//위시리스트
			List<WishListProdVO> wishList = wishListService.selectWishList(mberId);
			model.addAttribute("wishList", wishList);
			//장바구니 리스트
			List<CartProdVO> cartList = cartManageService.selectCartList(mberId);
			model.addAttribute("cartList", cartList);
		}
	}
}
