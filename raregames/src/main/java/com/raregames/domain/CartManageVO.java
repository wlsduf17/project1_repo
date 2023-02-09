package com.raregames.domain;

import lombok.Data;

/*
 * 장바구니관리VO클래스 
 */

@Data
public class CartManageVO {
	
	/*
	 * CART_INFO
	 * CART_NO, PROD_NO, MBER_ID
	 */
	
	//장바구니번호
	private Integer cartNo;
	//상품번호
	private Integer prodNo;
	//회원ID
	private String mberId;
	
	
}
