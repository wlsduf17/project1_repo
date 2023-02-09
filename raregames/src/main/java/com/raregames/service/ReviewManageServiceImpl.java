package com.raregames.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raregames.domain.Criteria;
import com.raregames.domain.ReviewManageVO;
import com.raregames.mapper.ReviewManageMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
public class ReviewManageServiceImpl implements ReviewManageService{
	
	@Setter(onMethod_ = @Autowired)
	private ReviewManageMapper reviewManageMapper;
	
	
	@Override
	public int insertReview(ReviewManageVO reviewManageVO) {
		return reviewManageMapper.insertReview(reviewManageVO);
	}
	
	@Override
	public List<ReviewManageVO> selectReviewListWithPaging(Criteria criteria, Integer prodNo) {
		return reviewManageMapper.selectReviewListWithPaging(criteria, prodNo);
	}

	@Override
	public int getTotalCo(Integer prodNo) {
		return reviewManageMapper.getTotalCo(prodNo);
	}

	@Override
	public int modifyReview(ReviewManageVO reviewManageVO) {
		return reviewManageMapper.updateReview(reviewManageVO);
	}

	@Override
	public int deleteReview(Integer reviewNo) {
		return reviewManageMapper.deleteReview(reviewNo);
	}

	
	
	
	
	
}
