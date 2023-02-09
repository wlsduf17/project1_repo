package com.raregames.domain;

import lombok.Data;

@Data
public class ChartVO {
	
	//상품명
	private String prodNm;
	//상품별 총매출
	private int totalSalesPerProd;
	//년도
	private String year;
	//년도별 총매출
	private int totalSalesPerYear;
	//월별 총매출
	private int totalSalesPerMonth;
}
