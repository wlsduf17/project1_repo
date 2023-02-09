package com.raregames.service;

import java.util.List;

import com.raregames.domain.WishListProdVO;
import com.raregames.domain.WishListVO;

public interface WishListService {
	
	public int insertWishList(WishListVO wishListVO);
	
	public List<WishListProdVO> selectWishList(String mberId);
	
	public int deleteWishList(WishListVO wishListVO);
	
}
