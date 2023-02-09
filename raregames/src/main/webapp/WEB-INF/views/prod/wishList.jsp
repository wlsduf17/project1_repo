<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<head>
<%@include file="/WEB-INF/views/include/head.jsp"%>
<style>
div .payment__box {
	display: flex;
	justify-content: space-between;
	margin-top: 25px;
}

div .payment__box div {
	color: white;
}

div .payment__box__button {
	margin-top: 25px;
}

div .payment__box__button button {
	width: 100%;
}

div .payment__box__bar {
	width: 100%;
	height: 1px;
	border: 1px solid white;
	margin-top: 15px;
	margin-bottom: 15px;
}
</style>
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
						<a href="/"><i class="fa fa-home"></i> Home</a> <span>WishList</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Breadcrumb End -->

	<!-- Product Section Begin -->
	<section class="product-page spad">
		<div class="container">
			<form action="/user/purchse/insert" method="post" id="purchseForm">
				<div class="row">
					<div class="col-lg-8">
						<div class="product__page__content">
							<div class="product__page__title">
								<div class="row">
									<div class="col-lg-8 col-md-8 col-sm-6">
										<div class="section-title">
											<h4>WishList</h4>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<c:if test="${not empty wishList}">
									<c:forEach items="${wishList }" var="wishListProdVO"
										varStatus="status">
										<div class="col-lg-12 col-md-12 col-sm-12">
											<div class="product__item ">
												<div class="col-lg-4 col-md-4 col-sm-4" style="float: left;">
													<div class="product__item__pic set-bg" data-setbg="">
														<img
															src="/cart/showThumbnail?
															prodImg=<c:out value="${wishListProdVO.prodImg }"/>
															&frstRegistDe=<fmt:formatDate value="${wishListProdVO.frstRegistDe }"
															pattern="yyyy-MM-dd"/>">
													</div>
												</div>
												<div class="col-lg-8 col-md-8 col-sm-8" style="float: left;">
													<div class="product__item__text" style="color: white;">
														<h5 style="margin-bottom: 15px; font-size: 25px;">
															<a href="/prod/detail?prodNo=${wishListProdVO.prodNo }">${wishListProdVO.prodNm }</a>
														</h5>
														<span>가격: </span>
														<c:if test="${wishListProdVO.discntRate == '1' }">
															<fmt:formatNumber type="currency"
																value="${wishListProdVO.prodPrice }" />
														</c:if>
														<c:if test="${wishListProdVO.discntRate != '1' }">
															<span class="discnt"><fmt:formatNumber
																	type="percent" value="${wishListProdVO.discntRate }" /></span>
															<span style="text-decoration: line-through; color: gray">
																<fmt:formatNumber type="currency"
																	value="${wishListProdVO.prodPrice }" />
															</span>
															<fmt:formatNumber type="currency"
																value="${wishListProdVO.prodPrice * wishListProdVO.discntRate }" />
														</c:if>
														<br><br> <span>게임등급: </span>
														<c:if test="${wishListProdVO.gameRating == '18+'}">청소년 이용불가</c:if>
														<c:if test="${wishListProdVO.gameRating == '15+'}">15세이용가</c:if>
														<c:if test="${wishListProdVO.gameRating == '12+'}">12세이용가</c:if>
														<c:if test="${wishListProdVO.gameRating == 'all'}">전체이용가</c:if>
														<br><br> <span>플랫폼: </span> ${wishListProdVO.platform }
														<div style="margin-top: 40px;">
															<button type="button" class="site-btn" name="btnMoveCart"
																data-prod-no="${wishListProdVO.prodNo }">장바구니에 담기</button>
															<button type="button" class="site-btn" name="btnDelete"
																data-prod-no="${wishListProdVO.prodNo }">삭제</button>
														</div>
													</div>
												</div>
											</div>
										</div>
										<!-- hidden Form -->
										<input type="hidden"
											name="purchseDetailList[${status.index }].prodNo"
											value='<c:out value="${wishListProdVO.prodNo }" />'>
										<input type="hidden"
											name="purchseDetailList[${status.index }].prodNm"
											value='<c:out value="${wishListProdVO.prodNm }" />'>
										<input type="hidden"
											name="purchseDetailList[${status.index }].prodPrice"
											value='<c:out value="${wishListProdVO.prodPrice }" />'>
										<input type="hidden"
											name="purchseDetailList[${status.index }].discntRate"
											value='<c:out value="${wishListProdVO.discntRate }" />'>
									</c:forEach>
								</c:if>
								<c:if test="${empty wishList }">
									<div class="col-lg-12 col-md-12 col-sm-12">
										<div class="product__item">
											<h4 style="color: white; text-align: center">위시리스트가
												비어있습니다.</h4>
										</div>
									</div>
								</c:if>
							</div>
						</div>
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
					<!-- hidden Form -->
					<input type="hidden" name="purchsePrice"
						value='<c:out value="${totalPrice - totalDiscntPrice }" />'>
				</div>
			</form>
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
			
			//장바구니 담기 버튼
			$("button[name=btnMoveCart]").on("click", function(){
				let prodNo = $(this).data("prod-no");
				$.ajax({
					url : "/cart/insert",
					type : "post",
					dataType : "text",
					data : {
						prodNo : prodNo
					},
					success : function(data) {
						if (data == "success") {
							location.href = "/prod/wishList";
						} else {
							alert("삭제에 실패하였습니다.");
						}

					}

				});
			});
			
			//삭제버튼
			$("button[name=btnDelete]").on("click", function() {
				let prodNo = $(this).data("prod-no");
				$.ajax({
					url : "/prod/wishList/delete",
					type : "post",
					dataType : "text",
					data : {
						prodNo : prodNo
					},
					success : function(data) {
						if (data == "success") {
							location.href = "/prod/wishList";
						} else {
							alert("삭제에 실패하였습니다.");
						}

					}

				});

			});

		});
	</script>



</body>

</html>