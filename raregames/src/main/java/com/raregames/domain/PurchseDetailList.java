package com.raregames.domain;

import java.util.List;

import lombok.Data;

/*
 * 파라미터로 PurchseDetailVO를 리스트로 받기 위한 목적 
 */

@Data
public class PurchseDetailList {
	
	private List<PurchseDetailVO> purchseDetailList;
	
}
