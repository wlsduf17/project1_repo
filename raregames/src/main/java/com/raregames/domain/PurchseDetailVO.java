package com.raregames.domain;

import lombok.Data;

/*
 * 구매상세정보 VO클래스
 */

@Data
public class PurchseDetailVO {
	
	/*
	 * PURCHSE_DETAIL
	 * PURCHSE_NO, PROD_NO, PROD_NM, PROD_PRICE, DISCNT_RATE
	 */
	
	//구매번호
	private Integer purchseNo;
	//상품번호
	private Integer prodNo;
	//상품명
	private String prodNm;
	//가격
	private int prodPrice;
	//할인율
	private double discntRate;
	
}
