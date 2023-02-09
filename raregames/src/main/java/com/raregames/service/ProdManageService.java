package com.raregames.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.raregames.domain.Criteria;
import com.raregames.domain.FeatureVO;
import com.raregames.domain.GenreVO;
import com.raregames.domain.ProdManageVO;

public interface ProdManageService {
	
	public int insertProd(ProdManageVO prodManageVO, MultipartFile upload);
	
	public List<GenreVO> selectGenreList();
	
	public List<FeatureVO> selectFeatureList();
	
	public List<ProdManageVO> selectProdList();
	
	public List<ProdManageVO> selectProdListWithPaging(Criteria criteria);
	
	public int getTotalCo(Criteria criteria);
	
	public ProdManageVO selectProd(Integer prodNo);
	
	public int deleteProd(Integer prodNo);
	
	public int modifyProd(ProdManageVO prodManageVO, MultipartFile upload);
	
	public List<GenreVO> selectGenreNm(String genreCd);
	
	public List<FeatureVO> selectFeatureNm(String featureCd);
	
	public List<ProdManageVO> selectCategoryListWithPaging
		(		Criteria criteria,
				String genreCd,
				String featureCd);
	
	public int getCategoryTotalCo
		(		Criteria criteria,
				String genreCd,
				String featureCd);
	
	public List<ProdManageVO> selectOnSaleProdList();
	
	public List<ProdManageVO> selectNewReleaseProdList();
	
	public List<ProdManageVO> selectTopSellerProdList();
}
