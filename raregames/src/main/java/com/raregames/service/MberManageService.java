package com.raregames.service;

import java.util.List;

import com.raregames.domain.Criteria;
import com.raregames.domain.MberManageVO;

public interface MberManageService {

	public int insertMber(MberManageVO mberManageVO);
	
	public MberManageVO checkNicknmDplct(String mberNicknm);

	public MberManageVO checkIdDplct(String mberId);
	
	public MberManageVO selectMber(String mberId);
			
	public int updateMber(MberManageVO mberManageVO);
	
	public int updatePassword(String mberId, String mberPassword); 
	
	public int deleteMber(String mberId);
	
	public int updateRcntConectDe();
	
	public List<MberManageVO> selectMberListWithPaging(Criteria criteria);
	
	public int getTotalCo(Criteria criteria);
}
