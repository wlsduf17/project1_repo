package com.raregames.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class EmailDTO {
	
	//송신자 이름
	private String senderNm;
	//송신자 메일주소
	private String senderEmailAdres;
	//수신자 메일주소
	private String recpntEmailAdres;
	//제목
	private String emailSubject;
	//메시지
	private String emailMessage;
	
}
