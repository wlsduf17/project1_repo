package com.raregames.service;

import java.util.List;

import com.raregames.domain.CartProdVO;
import com.raregames.domain.CartManageVO;

public interface CartManageService {
	
	public int insertCart(CartManageVO cartManageVO);
	
	public List<CartProdVO> selectCartList(String mberId);
	
	public int deleteCart(Integer prodNo, String mberId);
}
