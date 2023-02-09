package com.raregames.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.raregames.domain.Criteria;
import com.raregames.domain.FeatureVO;
import com.raregames.domain.GenreVO;
import com.raregames.domain.ProdManageVO;
import com.raregames.mapper.CartManageMapper;
import com.raregames.mapper.ProdManageMapper;
import com.raregames.mapper.ReviewManageMapper;
import com.raregames.mapper.WishListMapper;
import com.raregames.utils.UploadFileUtils;

import lombok.Setter;

@Service
public class ProdManageServiceImpl implements ProdManageService{
	
	@Resource(name = "uploadFolder")
	private String uploadFolder;//업로드폴더
	@Setter(onMethod_ = @Autowired)
	private ProdManageMapper prodManageMapper;
	@Setter(onMethod_ = @Autowired)
	private ReviewManageMapper reviewManageMapper;
	@Setter(onMethod_ = @Autowired)
	private WishListMapper wishListMapper;
	@Setter(onMethod_ = @Autowired)
	private CartManageMapper cartManageMapper;
	
	/*
	 * 상품등록
	 * 파일업로드, 상품DB저장 트랜잭션
	 */
	@Transactional
	@Override
	public int insertProd(ProdManageVO prodManageVO, MultipartFile upload) {
		
		//파일업로드
		prodManageVO.setProdImg(UploadFileUtils.uploadFile(uploadFolder, new Date(), upload));
		//상품DB저장
		return prodManageMapper.insertProd(prodManageVO);
	}
	
	@Override
	public List<GenreVO> selectGenreList() {
		return prodManageMapper.selectGenreList();
	}
	
	@Override
	public List<FeatureVO> selectFeatureList() {
		return prodManageMapper.selectFeatureList();
	}
	
	@Override
	public List<ProdManageVO> selectProdList() {
		return prodManageMapper.selectProdList();
	}
	
	@Override
	public List<ProdManageVO> selectProdListWithPaging(Criteria criteria) {
		return prodManageMapper.selectProdListWithPaging(criteria);
	}

	@Override
	public int getTotalCo(Criteria criteria) {
		return prodManageMapper.getTotalCo(criteria);
	}
	
	@Override
	public ProdManageVO selectProd(Integer prodNo) {
		return prodManageMapper.selectProd(prodNo);
	}
	
	/*
	 * 상품삭제
	 * 이미지&썸네일 삭제, 장바구니, 위시리스트, 리뷰, 상품 DB 삭제
	 */
	@Transactional
	@Override
	public int deleteProd(Integer prodNo) {
		//상품정보로 파일경로 생성
		ProdManageVO prodManageVO = prodManageMapper.selectProd(prodNo);
		String uploadFolderPath = UploadFileUtils.getUploadFolderPath(prodManageVO.getLastUpdtDe());
		//이미지 & 썸네일 파일 삭제
		UploadFileUtils.deleteFile(uploadFolder, uploadFolderPath, prodManageVO.getProdImg());
		//장바구니 삭제
		cartManageMapper.deleteProdAll(prodNo);
		//위시리스트 삭제
		wishListMapper.deleteProdAll(prodNo);
		//리뷰삭제
		reviewManageMapper.deleteProdAll(prodNo);
		//상품 삭제
		return prodManageMapper.deleteProd(prodNo);
	}
	
	/*
	 * 상품수정
	 * 이미지&썸네일 삭제, 파일업로드, 상품DB수정 트랜잭션
	 */
	@Transactional
	@Override
	public int modifyProd(ProdManageVO prodManageVO, MultipartFile upload) {
		//기존상품정보
		ProdManageVO olderProdManageVO = prodManageMapper.selectProd(prodManageVO.getProdNo());
		//기존상품정보 파일경로
		String olderUploadFolderPath = UploadFileUtils.getUploadFolderPath(olderProdManageVO.getFrstRegistDe());
		//기존상품 파일명
		String olderFileName = olderProdManageVO.getProdImg();
		//새로운 파일업로드
		if(upload.getSize() > 0) {
			//기존이미지 & 썸네일 파일 삭제
			UploadFileUtils.deleteFile(uploadFolder, olderUploadFolderPath, olderFileName);
			//이미지 & 썸네일 업로드
			prodManageVO.setProdImg(UploadFileUtils.uploadFile(uploadFolder, olderProdManageVO.getFrstRegistDe(), upload));
		}else {
			//기존파일정보
			prodManageVO.setProdImg(olderFileName);
		}
		//상품 DB 수정
		return prodManageMapper.updateProd(prodManageVO);
	}
	
	/*
	 *	장르코드로 장르명 불러오기 
	 */
	@Override
	public List<GenreVO> selectGenreNm(String genreCd) {
		List<GenreVO> genreList =  new ArrayList<GenreVO>();
		String[] genreCdArr = genreCd.split(",");
		for(int i=0; i<genreCdArr.length; i++) {
			GenreVO genreVO = new GenreVO();
			genreVO.setGenreCd(genreCdArr[i]);
			genreVO.setGenreNm(prodManageMapper.selectGenreNm(genreCdArr[i])); 
			genreList.add(genreVO);
		}
		
		return genreList;
	}
	
	/*
	 * 기능코드로 기능명 불러오기 
	 */
	@Override
	public List<FeatureVO> selectFeatureNm(String featureCd) {
		List<FeatureVO> featureList =  new ArrayList<FeatureVO>();
		String[] featureCdArr = featureCd.split(",");
		for(int i=0; i<featureCdArr.length; i++) {
			FeatureVO featureVO = new FeatureVO();
			featureVO.setFeatureCd(featureCdArr[i]);
			featureVO.setFeatureNm(prodManageMapper.selectFeatureNm(featureCdArr[i]));
			featureList.add(featureVO);
		}
		
		return featureList;
	}

	@Override
	public List<ProdManageVO> selectCategoryListWithPaging(Criteria criteria,
			String genreCd, String featureCd) {
		return prodManageMapper.selectCategoryListWithPaging(criteria, genreCd, featureCd);
	}

	@Override
	public int getCategoryTotalCo(Criteria criteria, String genreCd,
			String featureCd) {
		return prodManageMapper.getCategoryTotalCo(criteria ,genreCd, featureCd);
	}
	
	@Override
	public List<ProdManageVO> selectOnSaleProdList() {
		return prodManageMapper.selectOnSaleProdList();
	}
	
	@Override
	public List<ProdManageVO> selectNewReleaseProdList() {
		return prodManageMapper.selectNewReleaseProdList();
	}

	@Override
	public List<ProdManageVO> selectTopSellerProdList() {
		return prodManageMapper.selectTopSellerProdList();
	}

	


	

	

	

	

	
	
	
}
