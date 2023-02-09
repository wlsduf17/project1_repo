package com.raregames.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

/*
 * 구매상품정보VO 클래스
 */
@Data
public class PurchseProdVO {
	
	//구매번호
	private Integer purchseNo;
	//회원ID
	private String mberId;
	//구매가격
	private int purchsePrice;
	//구매일
	private Date purchseDe;
	//상품번호
	private Integer prodNo;
	//상품명
	private String prodNm;
	//가격
	private int prodPrice;
	//할인율
	private double discntRate;
	//상품 이미지
	private String prodImg;
	//최초등록날짜
	private Date frstRegistDe;
	
}
