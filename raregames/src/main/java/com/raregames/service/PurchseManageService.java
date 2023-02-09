package com.raregames.service;

import java.util.List;

import com.raregames.domain.Criteria;
import com.raregames.domain.PurchseDetailList;
import com.raregames.domain.PurchseDetailVO;
import com.raregames.domain.PurchseManageVO;
import com.raregames.domain.PurchseProdVO;

public interface PurchseManageService {
	
	public int insertPurchse(PurchseManageVO purchseManageVO, PurchseDetailList purchseDetailList);
	
	public List<PurchseManageVO> selectPurchseListWithPaging(Criteria criteria);
	
	public int getTotalCo(Criteria criteria);
	
	public List<PurchseDetailVO> selectPurchseDetail(Integer purchseNo);
	
	public List<PurchseProdVO> selectMberPurchseList(String mberId);
	
}
