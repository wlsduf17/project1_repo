package com.raregames.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.raregames.domain.CartProdVO;
import com.raregames.domain.WishListProdVO;
import com.raregames.domain.WishListVO;
import com.raregames.mapper.CartManageMapper;
import com.raregames.mapper.WishListMapper;

import lombok.Setter;

@Service
public class WishListServiceImpl implements WishListService{
	
	@Setter(onMethod_ = @Autowired)
	private WishListMapper wishlistMapper;
	@Setter(onMethod_ = @Autowired)
	private CartManageMapper cartManageMapper;
	
	/*
	 * 위시리스트에 상품 추가
	 * - 장바구니에서 제거
	 */
	@Transactional
	@Override
	public int insertWishList(WishListVO wishListVO) {
		//회원의 장바구니에 존재하면 제거
		List<CartProdVO> cartList = cartManageMapper.selectCartList(wishListVO.getMberId());
		cartList.forEach(CartProdVO -> {
			if(CartProdVO.getProdNo() == wishListVO.getProdNo()) {
				cartManageMapper.deleteCart(wishListVO.getProdNo(), wishListVO.getMberId());
			}
		});
		return wishlistMapper.insertWishList(wishListVO);
	}

	@Override
	public List<WishListProdVO> selectWishList(String mberId) {
		return wishlistMapper.selectWishList(mberId);
	}

	@Override
	public int deleteWishList(WishListVO wishListVO) {
		return wishlistMapper.deleteWishList(wishListVO);
	}
	
	
	
}
