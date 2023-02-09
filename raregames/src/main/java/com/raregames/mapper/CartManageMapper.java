package com.raregames.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.raregames.domain.CartProdVO;
import com.raregames.domain.CartManageVO;

public interface CartManageMapper {
	
	public int insertCart(CartManageVO cartManageVO);
		
	public List<CartProdVO> selectCartList(String mberId);
	
	public int deleteCart
			(		@Param("prodNo") Integer prodNo, 
					@Param("mberId") String mberId);
	
	public int deleteMberAll(String mberId);
	
	public int deleteProdAll(Integer prodNo);
}
