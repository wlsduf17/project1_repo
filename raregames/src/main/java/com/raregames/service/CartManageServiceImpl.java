package com.raregames.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.raregames.domain.CartProdVO;
import com.raregames.domain.WishListProdVO;
import com.raregames.domain.WishListVO;
import com.raregames.domain.CartManageVO;
import com.raregames.mapper.CartManageMapper;
import com.raregames.mapper.WishListMapper;

import lombok.Setter;

@Service
public class CartManageServiceImpl implements CartManageService{
	
	@Setter(onMethod_ = @Autowired)
	private CartManageMapper cartManageMapper;
	@Setter(onMethod_ = @Autowired)
	private WishListMapper wishListMapper;
	
	/*
	 * 장바구니에 상품 추가
	 * - 위시리스트에서 제거
	 */
	@Transactional
	@Override
	public int insertCart(CartManageVO cartManageVO) {
		//회원의 위시리스트에 존재하면 제거
		List<WishListProdVO> wishList = wishListMapper.selectWishList(cartManageVO.getMberId());
		wishList.forEach(wishListProdVO -> {
			if(wishListProdVO.getProdNo() == cartManageVO.getProdNo()) {
				WishListVO wishListVO = new WishListVO();
				wishListVO.setProdNo(cartManageVO.getProdNo());
				wishListVO.setMberId(cartManageVO.getMberId());
				wishListMapper.deleteWishList(wishListVO);
			}
		});
		return cartManageMapper.insertCart(cartManageVO);
	}

	@Override
	public List<CartProdVO> selectCartList(String mberId) {
		return cartManageMapper.selectCartList(mberId);
	}

	@Override
	public int deleteCart(Integer prodNo, String mberId) {
		return cartManageMapper.deleteCart(prodNo, mberId);
	}
	
	
	
	
	
}
