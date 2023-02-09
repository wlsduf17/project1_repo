package com.raregames.service;

import com.raregames.domain.UserManageVO;

public interface UserManageService {
	
	public UserManageVO selectUser(String userId);
	
	public int updateRcntConectDe();
}
