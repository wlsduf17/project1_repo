<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
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

	<!-- Hero Section Begin -->
	<section class="hero">
		<div class="container">
			<div class="hero__slider owl-carousel">
				<div class="hero__items set-bg" data-setbg="/img/hero/hero-1.jpg">
					<div class="row">
						<div class="col-lg-6">
							<div class="hero__text">
								<div class="label">Action</div> <div class="label">RPG</div>
								<h2>NieR:Automata</h2>
								<p>NieR: Automata tells the story of androids 2B, 9S and A2 and their battle to reclaim the machine-driven dystopia overrun by powerful machines</p>
								<a href="/prod/detail?prodNo=6" class="btnHero"><span>Buy Now</span> <i
									class="fa fa-angle-right"></i></a>
							</div>
						</div>
					</div>
				</div>
				<div class="hero__items set-bg" data-setbg="/img/hero/hero-2.jpg">
					<div class="row">
						<div class="col-lg-6">
							<div class="hero__text">
								<div class="label">RPG</div> <div class="label">Open World</div>
								<h2>ELDEN RING</h2>
								<p>드넓은 필드와 던전 탐험을 통해 미지의 것들을 발견해 보세요. 앞길을 막아서는 난관과 그것을 극복했을 때의 달성감, 그리고 등장인물들의 의도가 교착하는 군상극도 즐기실 수 있습니다.</p>
								<a href="/prod/detail?prodNo=1" class="btnHero"><span>Buy Now</span> <i
									class="fa fa-angle-right"></i></a>
							</div>
						</div>
					</div>
				</div>
				<div class="hero__items set-bg" data-setbg="/img/hero/hero-3.jpg">
					<div class="row">
						<div class="col-lg-6">
							<div class="hero__text">
								<div class="label">Action</div> <div class="label">Open World</div>
								<h2>Monster Hunter: World</h2>
								<p>새로운 생명의 땅. 사냥하라, 본능에 따라! 시리즈 최신작 'Monster Hunter: World'에서는 새롭게 제작된 다양한 지형과 생태계가 살아 숨쉬는 세계에서 궁극의 사냥 생활을 체험할 수 있습니다.</p>
								<a href="/prod/detail?prodNo=2" class="btnHero"><span>Buy Now</span> <i
									class="fa fa-angle-right"></i></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Hero Section End -->

	<!-- Product Section Begin -->
	<section class="product spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-8">

					<!-- Games on Sale -->
					<div class="trending__product">
						<div class="row">
							<div class="col-lg-8 col-md-8 col-sm-8">
								<div class="section-title">
									<h4>Games on Sale</h4>
								</div>
							</div>
							<div class="col-lg-4 col-md-4 col-sm-4">
								<div class="btn__all">
									<a href="/prod/categories?searchType=onSale" class="primary-btn">View All <span
										class="arrow_right"></span></a>
								</div>
							</div>
						</div>
						<div class="row">
							<c:forEach items="${onSaleProdList }" var="prodManageVO" begin="0"
								end="5">
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
													<c:if test="${purchseProdVO.prodNo == prodManageVO.prodNo }">
														<li>이미 구매</li>
													</c:if>
												</c:forEach>
												<c:forEach items="${cartList }" var="cartProdVO">
													<c:if test="${cartProdVO.prodNo == prodManageVO.prodNo }">
														<li>장바구니에 있음</li>
													</c:if>
												</c:forEach>
												<c:forEach items="${wishList }" var="WishListProdVO">
													<c:if test="${WishListProdVO.prodNo == prodManageVO.prodNo }">
														<li>위시리스트</li>
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
					<!-- Games on Sale End -->

					<!--  New Release -->
					<div class="recent__product">
						<div class="row">
							<div class="col-lg-8 col-md-8 col-sm-8">
								<div class="section-title">
									<h4>New Release</h4>
								</div>
							</div>
							<div class="col-lg-4 col-md-4 col-sm-4">
								<div class="btn__all">
									<a href="/prod/categories?searchType=newRelease" class="primary-btn">View All <span
										class="arrow_right"></span></a>
								</div>
							</div>
						</div>
						<div class="row">
							<c:forEach items="${newReleaseProdList }" var="prodManageVO"
								begin="0" end="5">
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
													<c:if test="${purchseProdVO.prodNo == prodManageVO.prodNo }">
														<li>이미 구매</li>
													</c:if>
												</c:forEach>
												<c:forEach items="${cartList }" var="cartProdVO">
													<c:if test="${cartProdVO.prodNo == prodManageVO.prodNo }">
														<li>장바구니에 있음</li>
													</c:if>
												</c:forEach>
												<c:forEach items="${wishList }" var="WishListProdVO">
													<c:if test="${WishListProdVO.prodNo == prodManageVO.prodNo }">
														<li>위시리스트</li>
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
					<!--  New Release End-->

					<!--  Top Seller -->
					<div class="popular__product">
						<div class="row">
							<div class="col-lg-8 col-md-8 col-sm-8">
								<div class="section-title">
									<h4>Top Seller</h4>
								</div>
							</div>
							<div class="col-lg-4 col-md-4 col-sm-4">
								<div class="btn__all">
									<a href="/prod/categories?searchType=topSeller" class="primary-btn">View All <span
										class="arrow_right"></span></a>
								</div>
							</div>
						</div>
						<div class="row">
							<c:forEach items="${topSellerProdList }" var="prodManageVO" begin="0"
								end="5">
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
												<c:forEach items="${cartList }" var="cartProdVO">
													<c:if test="${cartProdVO.prodNo == prodManageVO.prodNo }">
														<li>장바구니에 있음</li>
													</c:if>
												</c:forEach>
												<c:forEach items="${wishList }" var="WishListProdVO">
													<c:if
														test="${WishListProdVO.prodNo == prodManageVO.prodNo }">
														<li>위시리스트</li>
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
					<!--  Top Seller End -->
				</div>
				<div class="col-lg-4 col-md-6 col-sm-8">
					<div class="product__sidebar">
						<div class="product__sidebar__comment">
							<div class="section-title">
								<h5>MOST POPULAR</h5>
							</div>
							<c:forEach items="${prodList }" var="prodManageVO" begin="0"
								end="4">
								<div class="product__sidebar__comment__item">
									<div class="product__sidebar__comment__item__pic">
										<img
											src="/user/prod/showThumbnail?
										prodImg=<c:out value="${prodManageVO.prodImg }"/>
										&frstRegistDe=<fmt:formatDate value="${prodManageVO.frstRegistDe }"
										pattern="yyyy-MM-dd"/>"
											style="width: 90px; height: 120px;">
									</div>
									<div class="product__sidebar__comment__item__text">
										<ul>
											<c:forEach items="${purchseProdList }" var="purchseProdVO">
												<c:if test="${purchseProdVO.prodNo == prodManageVO.prodNo }">
													<li>이미 구매</li>
												</c:if>
											</c:forEach>
											<c:forEach items="${cartList }" var="cartProdVO">
												<c:if test="${cartProdVO.prodNo == prodManageVO.prodNo }">
													<li>장바구니에 있음</li>
												</c:if>
											</c:forEach>
											<c:forEach items="${wishList }" var="WishListProdVO">
												<c:if
													test="${WishListProdVO.prodNo == prodManageVO.prodNo }">
													<li>위시리스트</li>
												</c:if>
											</c:forEach>
										</ul>
										<h5 style="color: white;">
											<a href="/prod/detail?prodNo=${prodManageVO.prodNo }">
												${prodManageVO.prodNm }</a>
										</h5>
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
											<span class="discnt" style="float:left;"><fmt:formatNumber type="percent"
													value="${prodManageVO.discntRate }" /></span>
											<h5 style="color: white; display: inline; font-size: 16px;float: left;">
												<span style="text-decoration: line-through; color: gray;float: left;"><fmt:formatNumber
														type="currency" value="${prodManageVO.prodPrice }" /></span>
												<fmt:formatNumber type="currency"
													value="${prodManageVO.prodPrice * prodManageVO.discntRate }" />
											</h5>
										</c:if>
									</div>
								</div>
							</c:forEach>
						</div>
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


</body>

</html>