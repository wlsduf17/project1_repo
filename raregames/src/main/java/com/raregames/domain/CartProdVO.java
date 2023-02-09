package com.raregames.domain;

import java.util.Date;

import lombok.Data;

/*
 * 장바구니 상품정보 VO클래스
 */

@Data
public class CartProdVO {
	
	//장바구니번호
	private Integer cartNo;
	//상품번호
	private Integer prodNo;
	//회원ID
	private String mberId;
	//상품명
	private String prodNm;
	//가격
	private int prodPrice;
	//할인율
	private double discntRate;
	//게임등급
	private String gameRating;
	//플랫폼
	private String platform;
	//상품 이미지
	private String prodImg;
	//최초등록날짜
	private Date frstRegistDe;
	
}
