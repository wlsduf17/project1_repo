package com.raregames.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.raregames.domain.Criteria;
import com.raregames.domain.MberManageVO;
import com.raregames.mapper.CartManageMapper;
import com.raregames.mapper.MberManageMapper;
import com.raregames.mapper.PurchseManageMapper;
import com.raregames.mapper.ReviewManageMapper;
import com.raregames.mapper.WishListMapper;

import lombok.Setter;

@Service
public class MberManageServiceImpl implements MberManageService{
	
	@Setter(onMethod_ = @Autowired)
	private MberManageMapper mberManageMapper;
	@Setter(onMethod_ = @Autowired)
	private PurchseManageMapper purchseManageMapper;
	@Setter(onMethod_ = @Autowired)
	private WishListMapper wishListMapper;
	@Setter(onMethod_ = @Autowired)
	private CartManageMapper cartManageMapper;
	@Setter(onMethod_ = @Autowired)
	private ReviewManageMapper reviewManageMapper;
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder cryptPassEnc;	//스프링시큐리티에서 제공하는 암호화 클래스

	
	@Override
	public int insertMber(MberManageVO mberManageVO) {
		return mberManageMapper.insertMber(mberManageVO);
	}


	@Override
	public MberManageVO checkNicknmDplct(String mberNicknm) {
		return mberManageMapper.checkNicknmDplct(mberNicknm);
	}


	@Override
	public MberManageVO checkIdDplct(String mberId) {
		return mberManageMapper.checkIdDplct(mberId);
	}


	@Override
	public MberManageVO selectMber(String mberId) {
		return mberManageMapper.selectMber(mberId);
	}


	@Override
	public int updateMber(MberManageVO mberManageVO) {
		return mberManageMapper.updateMber(mberManageVO);
	}


	@Override
	public int updatePassword(String mberId, String mberPassword) {
		return mberManageMapper.updatePassword(mberId, mberPassword);
	}

	/*
	 * 회원삭제
	 * 위시리스트, 장바구니 트랜잭션 삭제
	 */
	@Transactional
	@Override
	public int deleteMber(String mberId) {
		//위시리스트 삭제
		wishListMapper.deleteMberAll(mberId);
		//장바구니 삭제
		cartManageMapper.deleteMberAll(mberId);
		//리뷰 삭제
		reviewManageMapper.deleteMberAll(mberId);
		//회원 삭제
		return mberManageMapper.deleteMber(mberId);
	}


	@Override
	public int updateRcntConectDe() {
		// TODO Auto-generated method stub
		return mberManageMapper.updateRcntConectDe();
	}


	@Override
	public List<MberManageVO> selectMberListWithPaging(Criteria criteria) {
		return mberManageMapper.selectMberListWithPaging(criteria);
	}


	@Override
	public int getTotalCo(Criteria criteria) {
		return mberManageMapper.getTotalCo(criteria);
	}
	
}
