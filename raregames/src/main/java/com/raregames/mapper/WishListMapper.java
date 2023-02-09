package com.raregames.mapper;

import java.util.List;

import com.raregames.domain.WishListProdVO;
import com.raregames.domain.WishListVO;

public interface WishListMapper {
	
	public int insertWishList(WishListVO wishListVO);
	
	public List<WishListProdVO> selectWishList(String mberId);
	
	public int deleteWishList(WishListVO wishListVO);
	
	public int deleteProdAll(Integer prodNo);
	
	public int deleteMberAll(String mberId);
}
