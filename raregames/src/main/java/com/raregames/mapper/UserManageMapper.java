package com.raregames.mapper;

import com.raregames.domain.UserManageVO;

public interface UserManageMapper {
	
	public UserManageVO selectUser(String userId);
	
	public int updateRcntConectDe();
	
}
