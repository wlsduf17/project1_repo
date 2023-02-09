package com.raregames.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnailator;

/*
 * 파일 업로드 관련기능을 담당하는 클래스
 * 주요기능 : 파일업로드, 업로드파일 삭제
 */
public class UploadFileUtils {
	
	/*
	 * 파일업로드(썸네일 생성)
	 * - 파라미터 
	 * 		uploadFolder 	: 업로드폴더
	 * 		date			: 경로생성날짜
	 * 		multipartFile	: 첨부파일 정보
	 */
	public static String uploadFile(String uploadFolder, Date date, MultipartFile multipartFile) {
		
		//업로드파일경로 생성
		String uploadFolderPath = getUploadFolderPath(date);//날짜경로생성
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		//고유 업로드파일명 생성
		String originalFileName = multipartFile.getOriginalFilename();//원본파일명
		String uploadFileName = UUID.randomUUID().toString() + "_" + originalFileName;//업로드파일명
		
		try {
			//파일 저장
			File saveFile = new File(uploadPath, uploadFileName);
			multipartFile.transferTo(saveFile);
			
			//이미지 파일의 경우, 썸네일 생성
			if(checkImageType(saveFile)) {
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 180, 270);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return uploadFileName;
	}
	
	/*
	 * 이미지파일 체크 
	 */
	private static  boolean checkImageType(File saveFile) {
		
		try {
			String contentType = Files.probeContentType(saveFile.toPath());
			return contentType.startsWith("image");
		} catch (Exception e) {	
			e.printStackTrace();
		}
		
		return false;
	}
	
	/*
	 * 날짜경로 생성
	 */
	public static String getUploadFolderPath(Date date) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);	
	}
	
	/*
	 * 파일 출력기능
	 * - 이미지파일을 byte[]로 클라이언트에 전달 
	 * - 파라미터
	 * 		uploadFolder 		: 업로드폴더
	 * 		uploadFolderPath	: 업로드폴더경로(날짜경로)
	 * 		fileName	 		: 파일명
	 */
	public static ResponseEntity<byte[]> getFileByte
			(		String uploadFolder,
					String uploadFolderPath,
					String fileName){
		
		ResponseEntity<byte[]> entity = null;
		//파일경로 생성
		File uploadFPath = new File(uploadFolder, uploadFolderPath);
		File uploadFile = new File(uploadFPath, fileName);
		
		try {
			//Header에 MIME정보 담아서 전달
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(uploadFile.toPath()));
			//FileCopyUtils를 통해 파일정보 byte[]로 복사 전송
			entity = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(uploadFile), header, HttpStatus.OK);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return entity;
	}
	
	/*
	 * 이미지 & 썸네일 삭제
	 * - 파라미터
	 * 		uploadFolder 		: 업로드폴더
	 * 		uploadFolderPath	: 업로드폴더경로(날짜경로)
	 * 		fileName	 		: 파일명
	 */
	public static void deleteFile(String uploadFolder, String uploadFolderPath, String fileName) {
		//이미지파일 삭제
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		File uploadFile = new File(uploadPath, fileName);
		uploadFile.delete();
		//썸네일파일 삭제
		String thumbnailFileName = "s_" + fileName;
		File thumbnail = new File(uploadPath, thumbnailFileName);
		thumbnail.delete();
		
	}
	
	
	
}
