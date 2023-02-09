package com.raregames.domain;

import lombok.Data;

/*
 *	위시리스트 VO클래스 
 */

@Data
public class WishListVO {
	
	/*
	 * WISHLIST
	 * WISHLIST_NO, PROD_NO, MBER_ID
	 */
	
	//위시리스트 번호
	private Integer wishlistNo;
	//상품번호
	private Integer prodNo;
	//회원ID
	private String mberId;
	
}
