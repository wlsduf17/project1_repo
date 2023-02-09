<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>

<head>
<%@include file="/WEB-INF/views/include/head.jsp"%>
</head>

<body>
	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>

	<!-- Header Section Begin -->
	<%@include file="/WEB-INF/views/include/header.jsp"%>
	<!-- Header End -->

	<!-- 현재시간 -->
	<c:set var="now" value="<%=new java.util.Date()%>" />
	<fmt:parseNumber var="now_num" value="${now.time }" integerOnly="true" />

	<!-- Breadcrumb Begin -->
	<div class="breadcrumb-option">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__links">
						<a href="/"><i class="fa fa-home"></i> Home</a>
						<c:choose>
							<c:when test="${genreList[0] != null && featureList[0] != null}">
								<a href="/prod/categories">Categories</a>
								<span>${genreList[0].genreNm } &
									${featureList[0].featureNm }</span>
							</c:when>
							<c:when test="${genreList[0] != null }">
								<a href="/prod/categories">Categories</a>
								<span>${genreList[0].genreNm }</span>
							</c:when>
							<c:when test="${featureList[0] != null }">
								<a href="/prod/categories">Categories</a>
								<span>${featureList[0].featureNm }</span>
							</c:when>
							<c:when test="${genreList[0] == null && featureList[0] == null }">
								<span>Categories</span>
							</c:when>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Breadcrumb End -->

	<!-- Product Section Begin -->
	<section class="product-page spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-8">
					<div class="product__page__content">
						<div class="product__page__title">
							<div class="row">
								<div class="col-lg-8 col-md-8 col-sm-6">
									<div class="section-title">
										<c:choose>
											<c:when
												test="${genreList[0] != null && featureList[0] != null}">
												<h4>${genreList[0].genreNm }&
													${featureList[0].featureNm }</h4>
											</c:when>
											<c:when test="${genreList[0] != null }">
												<h4>${genreList[0].genreNm }</h4>
											</c:when>
											<c:when test="${featureList[0] != null }">
												<h4>${featureList[0].featureNm }</h4>
											</c:when>
											<c:when
												test="${genreList[0] == null && featureList[0] == null }">
												<h4>전체</h4>
											</c:when>
										</c:choose>
									</div>
								</div>
								<div class="col-lg-4 col-md-4 col-sm-6">
								  	<div class="product__page__filter">
	                                	<p>Order by:</p>
	                                   	<select id="searchType">
	                                   		<option value=""
	                                       		<c:out value="${paging.criteria.searchType eq '' ? 'selected' : '' }" /> >--</option>
	                                       	<option value="onSale"
	                                       		<c:out value="${paging.criteria.searchType eq 'onSale' ? 'selected' : '' }" /> >할인</option>
	                                      	<option value="newRelease"
	                                      		<c:out value="${paging.criteria.searchType eq 'newRelease' ? 'selected' : '' }" /> >신작</option>
	                                       	<option value="topSeller"
	                                       		<c:out value="${paging.criteria.searchType eq 'topSeller' ? 'selected' : '' }" /> >판매순</option>
	                                   	</select>
	                                </div>
								</div>
							</div>
						</div>
						<div class="row">
							<c:forEach items="${prodList }" var="prodManageVO">
								<div class="col-lg-4 col-md-6 col-sm-6">
									<div class="product__item">
										<div class="product__item__pic set-bg" data-setbg=""
											style="height: 270px;">
											<a href="/prod/detail?prodNo=${prodManageVO.prodNo }"> <img
												src="/user/prod/showThumbnail?
													prodImg=<c:out value="${prodManageVO.prodImg }"/>
													&frstRegistDe=<fmt:formatDate value="${prodManageVO.frstRegistDe }"
													pattern="yyyy-MM-dd"/>">
											</a>
										</div>
										<div class="product__item__text">
											<h5 style="color: white;">${prodManageVO.prodNm }</h5>
											<ul>
												<c:forEach items="${purchseProdList }" var="purchseProdVO">
													<c:if
														test="${purchseProdVO.prodNo == prodManageVO.prodNo }">
														<li>이미 구매</li>
													</c:if>
												</c:forEach>
											</ul>
											<c:set var="releaseDe" value="${prodManageVO.releaseDe }" />
											<fmt:parseNumber var="releaseDe_num"
												value="${releaseDe.time }" integerOnly="true" />
											<fmt:formatNumber var="time_differ_month"
												value="${(now_num - releaseDe_num)/(1000*60*60*24) }"
												pattern="#" />
											<c:if test="${time_differ_month <= 30 }">
												<span class="new">신규</span>
												<br>
											</c:if>
											<c:if test="${prodManageVO.discntRate == '1' }">
												<h5 style="color: white; font-size: 16px;">
													<fmt:formatNumber type="currency"
														value="${prodManageVO.prodPrice }" />
												</h5>
											</c:if>
											<c:if test="${prodManageVO.discntRate != '1' }">
												<span class="discnt"><fmt:formatNumber type="percent"
														value="${prodManageVO.discntRate }" /></span>
												<h5 style="color: white; display: inline; font-size: 16px;">
													<span style="text-decoration: line-through; color: gray"><fmt:formatNumber
															type="currency" value="${prodManageVO.prodPrice }" /></span>
													<fmt:formatNumber type="currency"
														value="${prodManageVO.prodPrice * prodManageVO.discntRate }" />
												</h5>
											</c:if>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
					<div class="product__pagination">
						<c:if test="${paging.prev }">
							<a href="" data-dt-idx="${paging.startPage - 1 }"><i
								class="fa fa-angle-double-left"></i></a>
						</c:if>
						<c:forEach begin="${paging.startPage }" end="${paging.endPage }"
							var="pageNo">
							<a href="" data-dt-idx="${pageNo }"
								class="${paging.criteria.pageNo == pageNo ? 'current-page' : '' }">${pageNo }</a>
						</c:forEach>
						<c:if test="${paging.next }">
							<a href="" data-dt-idx="${paging.endPage + 1 }"><i
								class="fa fa-angle-double-right"></i></a>
						</c:if>
					</div>
					<!-- paging Form -->
					<form action="/prod/categories" method="get" id="pagingForm">
						<input type="hidden" name="pageNo" value="${paging.criteria.pageNo }"> 
						<input type="hidden" name="pageSize" value="${paging.criteria.pageSize }">
						<input type="hidden" name="searchType" value="${paging.criteria.searchType }">
						<input type="hidden" name="genreCd" value="${genreCd }">
						<input type="hidden" name="featureCd" value="${featureCd }">
					</form>
				</div>
				<div class="col-lg-4 col-md-6 col-sm-8">
					<div class="product__sidebar">
						<div class="product__sidebar__view" style="margin-bottom:30px;">
							<div class="section-title">
								<h5>Genre</h5>
							</div>
								<div class="product__sidebar__comment__item__text" style="margin:10px;">
									<a href="" class="sideGenre" data-genre-cd="">전체 보기</a>
								</div>
							<c:forEach items="${navGenreList }" var="genreVO">
								<div class="product__sidebar__comment__item__text" style="margin:10px;">
									<a href="" class="sideGenre" data-genre-cd="${genreVO.genreCd }">${genreVO.genreNm }</a>
								</div>
							</c:forEach>
						</div>
					</div>
					<div class="product__sidebar__comment">
						<div class="section-title">
							<h5>Feature</h5>
						</div>
						<c:forEach items="${navFeatureList }" var="featureVO">
							<div class="product__sidebar__comment__item__text" style="margin:10px;">
								<a href="" class="sideFeature" data-feature-cd="${featureVO.featureCd }">${featureVO.featureNm }</a>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Product Section End -->

	<!-- Footer Section Begin -->
	<%@include file="/WEB-INF/views/include/footer.jsp"%>
	<!-- Footer Section End -->

	<!-- Search model Begin -->
	<div class="search-model">
		<div class="h-100 d-flex align-items-center justify-content-center">
			<div class="search-close-switch">
				<i class="icon_close"></i>
			</div>
			<form class="search-model-form">
				<input type="text" id="search-input" placeholder="Search here.....">
			</form>
		</div>
	</div>
	<!-- Search model end -->

	<!-- Js Plugins -->
	<%@include file="/WEB-INF/views/include/js_plugins.jsp"%>

	<!-- JQuery -->
	<script>
		$(document).ready(function() {
			//페이징 처리
			let pagingForm = $("#pagingForm");
			$(".product__pagination a").on("click", function(e) {
				e.preventDefault();
				pagingForm.find("input[name=pageNo]").val($(this).data("dt-idx"));
				pagingForm.attr("action", "/prod/categories");
				pagingForm.submit();
			});
			//정렬 변경시
			$("#searchType").on("change", function(){
				pagingForm.find("input[name=searchType]").val($(this).val());
				pagingForm.submit();
			});
			//장르 클릭
			$("a.sideGenre").on("click", function(e){
				e.preventDefault();
				pagingForm.find("input[name=genreCd]").val($(this).data("genre-cd"));
				pagingForm.submit();			
			});
			//기능 클릭
			$("a.sideFeature").on("click", function(e){
				e.preventDefault();
				pagingForm.find("input[name=featureCd]").val($(this).data("feature-cd"));
				pagingForm.submit();			
			});
		});
		
	</script>

</body>

</html>