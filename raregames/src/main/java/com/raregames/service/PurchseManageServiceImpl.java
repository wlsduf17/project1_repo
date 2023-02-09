package com.raregames.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.raregames.domain.Criteria;
import com.raregames.domain.PurchseDetailList;
import com.raregames.domain.PurchseDetailVO;
import com.raregames.domain.PurchseManageVO;
import com.raregames.domain.PurchseProdVO;
import com.raregames.mapper.CartManageMapper;
import com.raregames.mapper.PurchseManageMapper;

import lombok.Setter;

@Service
public class PurchseManageServiceImpl implements PurchseManageService{
	
	@Setter(onMethod_ = @Autowired)
	private PurchseManageMapper purchseManageMapper;
	
	@Setter(onMethod_ = @Autowired)
	private CartManageMapper cartManageMapper;
	
	/*
	 * 구매정보 입력 트랜잭션
	 */
	@Transactional
	@Override
	public int insertPurchse(PurchseManageVO purchseManageVO, PurchseDetailList purchseDetailList) {
		//구매정보 DB 저장
		purchseManageMapper.insertPurchse(purchseManageVO);
		String mberId = purchseManageVO.getMberId();
		Integer purchseNo = purchseManageVO.getPurchseNo();
		//구매상세 DB 저장
		purchseDetailList.getPurchseDetailList().forEach(purchseDetailVO -> {
			purchseDetailVO.setPurchseNo(purchseNo);
			purchseManageMapper.insertPurchseDetail(purchseDetailVO);
		});
		//장바구니 삭제
		cartManageMapper.deleteMberAll(mberId);
		
		return 0;
	}

	@Override
	public List<PurchseManageVO> selectPurchseListWithPaging(
			Criteria criteria) {
		return purchseManageMapper.selectPurchseListWithPaging(criteria);
	}

	@Override
	public int getTotalCo(Criteria criteria) {
		return purchseManageMapper.getTotalCo(criteria);
	}

	@Override
	public List<PurchseDetailVO> selectPurchseDetail(Integer purchseNo) {
		return purchseManageMapper.selectPurchseDetail(purchseNo);
	}

	@Override
	public List<PurchseProdVO> selectMberPurchseList(String mberId) {
		return purchseManageMapper.selectMberPurchseList(mberId);
	}
	
	
	
}
