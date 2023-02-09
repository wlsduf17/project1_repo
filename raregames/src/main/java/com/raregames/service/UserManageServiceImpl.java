package com.raregames.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raregames.domain.UserManageVO;
import com.raregames.mapper.UserManageMapper;

import lombok.Setter;

@Service
public class UserManageServiceImpl implements UserManageService{

	@Setter(onMethod_ = @Autowired)
	private UserManageMapper userManageMapper;
	
	@Override
	public UserManageVO selectUser(String userId) {
		return userManageMapper.selectUser(userId);
	}

	@Override
	public int updateRcntConectDe() {
		return userManageMapper.updateRcntConectDe();
	}
	
	
	
}
