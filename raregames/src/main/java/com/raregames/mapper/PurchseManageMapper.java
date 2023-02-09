package com.raregames.mapper;

import java.util.List;

import com.raregames.domain.Criteria;
import com.raregames.domain.PurchseDetailVO;
import com.raregames.domain.PurchseManageVO;
import com.raregames.domain.PurchseProdVO;

public interface PurchseManageMapper {

	public int insertPurchse(PurchseManageVO purchseManageVO);
	
	public int insertPurchseDetail(PurchseDetailVO purchseDetailVO);
	
	public List<PurchseManageVO> selectPurchseListWithPaging(Criteria criteria);
	
	public int getTotalCo(Criteria criteria);
	
	public List<PurchseDetailVO> selectPurchseDetail(Integer purchseNo);
	
	public List<PurchseProdVO> selectMberPurchseList(String mberId);
	
}
