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

	<!-- Breadcrumb Begin -->
	<div class="breadcrumb-option">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__links">
						<a href="/"><i class="fa fa-home"></i> Home</a> <span>Cart</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Breadcrumb End -->
	
	<!-- c:set -->
	<c:set var="cartListProdNm" />
	<c:forEach items="${cartList }" var="cartListVO" varStatus="status">
		<c:set var="cartListProdNm" value="${cartListProdNm } ${cartListVO.prodNm }"/>
		<c:if test="${!status.last }">
			<c:set var="cartListProdNm" value="${cartListProdNm },"/>
		</c:if>		
	</c:forEach>
	
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
											<h4>My Cart</h4>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<c:if test="${not empty cartList }">
									<c:forEach items="${cartList }" var="cartListVO"
										varStatus="status">
										<div class="col-lg-12 col-md-12 col-sm-12">
											<div class="product__item ">
												<div class="col-lg-4 col-md-4 col-sm-4" style="float: left;">
													<div class="product__item__pic set-bg" data-setbg="">
														<img
															src="/cart/showThumbnail?
															prodImg=<c:out value="${cartListVO.prodImg }"/>
															&frstRegistDe=<fmt:formatDate value="${cartListVO.frstRegistDe }"
															pattern="yyyy-MM-dd"/>">
													</div>
												</div>
												<div class="col-lg-8 col-md-8 col-sm-8" style="float: left;">
													<div class="product__item__text" style="color: white;">
														<h5 style="margin-bottom: 15px; font-size: 25px;">
															<a href="/prod/detail?prodNo=${cartListVO.prodNo }">
																<c:out value="${cartListVO.prodNm }" />
															</a>
														</h5>
														<span>가격: </span>
														<c:if test="${cartListVO.discntRate == '1' }">
															<fmt:formatNumber type="currency"
																value="${cartListVO.prodPrice }" />
														</c:if>
														<c:if test="${cartListVO.discntRate != '1' }">
															<span class="discnt"><fmt:formatNumber
																	type="percent" value="${cartListVO.discntRate }" /></span>
															<span style="text-decoration: line-through; color: gray">
																<fmt:formatNumber type="currency"
																	value="${cartListVO.prodPrice }" />
															</span>
															<fmt:formatNumber type="currency"
																value="${cartListVO.prodPrice * cartListVO.discntRate }" />
														</c:if>
														<br><br> <span>게임등급: </span>
														<c:if test="${cartListVO.gameRating == '18+'}">청소년 이용불가</c:if>
														<c:if test="${cartListVO.gameRating == '15+'}">15세이용가</c:if>
														<c:if test="${cartListVO.gameRating == '12+'}">12세이용가</c:if>
														<c:if test="${cartListVO.gameRating == 'all'}">전체이용가</c:if>
														<br><br> <span>플랫폼: </span> ${cartListVO.platform }
														<div style="margin-top: 40px;">
															<button type="button" class="site-btn" name="btnMoveWish"
																data-prod-no="${cartListVO.prodNo }">위시리스트 이동</button>
															<button type="button" class="site-btn" name="btnDelete"
																data-prod-no="${cartListVO.prodNo }">삭제</button>
														</div>
													</div>
												</div>
											</div>
										</div>
										<!-- hidden Form -->
										<input type="hidden"
											name="purchseDetailList[${status.index }].prodNo"
											value='<c:out value="${cartListVO.prodNo }" />'>
										<input type="hidden"
											name="purchseDetailList[${status.index }].prodNm"
											value='<c:out value="${cartListVO.prodNm }" />'>
										<input type="hidden"
											name="purchseDetailList[${status.index }].prodPrice"
											value='<c:out value="${cartListVO.prodPrice }" />'>
										<input type="hidden"
											name="purchseDetailList[${status.index }].discntRate"
											value='<c:out value="${cartListVO.discntRate }" />'>
									</c:forEach>
								</c:if>
								<c:if test="${empty cartList }">
									<div class="col-lg-12 col-md-12 col-sm-12">
										<div class="product__item">
											<h4 style="color: white; text-align: center">장바구니가
												비어있습니다.</h4>
										</div>
									</div>
								</c:if>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-md-6 col-sm-8">
						<div class="product__sidebar" style="margin-top: 70px;">
							<div class="product__sidebar__view">
								<div class="section-title">
									<h5>구매 및 결제</h5>
								</div>
								<div class="payment__box">
									<div>가격</div>
									<c:set var="totalPrice" value="0" />
									<c:forEach items="${cartList }" var="cartListVO">
										<c:set var="totalPrice" value="${totalPrice + cartListVO.prodPrice }" />
									</c:forEach>
									<div>
										<fmt:formatNumber type="currency" value="${totalPrice }" />
									</div>
								</div>
								<div class="payment__box">
									<div>할인가격</div>
									<c:set var="totalDiscntPrice" value="0" />
									<c:forEach items="${cartList }" var="cartListVO">
										<c:set var="totalDiscntPrice" value="${totalDiscntPrice + ((1 - cartListVO.discntRate)*cartListVO.prodPrice) }" />
									</c:forEach>
									<div>
										<fmt:formatNumber type="currency" value="${totalDiscntPrice }" />
									</div>
								</div>
								<div class="payment__box__bar"></div>
								<div class="payment__box">
									<div>소계</div>
									<div>
										<fmt:formatNumber type="currency"
											value="${totalPrice - totalDiscntPrice }" />
									</div>
								</div>
								<div class="payment__box__button">
									<button type="button" class="site-btn" id="btnPurchse">구매하기</button>
								</div>
								<div class="payment__box__button">
									<input type="image" id="check_module" src="/img/payment_icon_yellow_small.png">
								</div>
							</div>
						</div>
					</div>
					<!-- hidden Form -->
					<input type="hidden" name="purchsePrice"
						value='<fmt:formatNumber value="${totalPrice - totalDiscntPrice }" pattern="#" />'>
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
	<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

	<!-- JQuery -->
	<script>
		$(document).ready(function() {
			
			//구매버튼
			$("#btnPurchse").on("click", function(){
				$("#purchseForm").submit();
			});
			
			//위시리스트 이동 버튼
			$("button[name=btnMoveWish]").on("click", function(){
				let prodNo = $(this).data("prod-no");
				$.ajax({
					url : "/prod/wishList/insert",
					type : "post",
					dataType : "text",
					data : {
						prodNo : prodNo
					},
					success : function(data) {
						if (data == "success") {
							location.href = "/cart/list";
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
					url : "/cart/delete",
					type : "post",
					dataType : "text",
					data : {
						prodNo : prodNo
					},
					success : function(data) {
						if (data == "success") {
							location.href = "/cart/list";
						} else {
							alert("삭제에 실패하였습니다.");
						}

					}

				});

			});
			
			//결제대행(PG) kakaopay 처리 
			 let mberId = "<c:out value='${loginMber.mberId }' />";
			 let purchsePrice = "<fmt:formatNumber value='${totalPrice - totalDiscntPrice }' pattern='#' />";
			$("#check_module").click(function (e) {
				e.preventDefault();
				var IMP = window.IMP; // 생략가능
				IMP.init('imp12928365'); 
				// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
				// ''안에 띄어쓰기 없이 가맹점 식별코드를 붙여넣어주세요. 안그러면 결제창이 안뜹니다.
				IMP.request_pay({
					pg: 'kakaopay',
					pay_method: 'card',
					merchant_uid: 'merchant_' + new Date().getTime(),
					/* 
					 *  merchant_uid에 경우 
					 *  https://docs.iamport.kr/implementation/payment
					 *  위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
					 */
					name: "${cartListProdNm }",
					// 결제창에서 보여질 이름
					// name: '주문명 : ${auction.a_title}',
					// 위와같이 model에 담은 정보를 넣어 쓸수도 있습니다.
					amount: purchsePrice,
					// amount: ${bid.b_bid},
					// 가격 
					buyer_name: mberId,
					// 구매자 이름, 구매자 정보도 model값으로 바꿀 수 있습니다.
					// 구매자 정보에 여러가지도 있으므로, 자세한 내용은 맨 위 링크를 참고해주세요.
					}, function (rsp) {
						console.log(rsp);
					if (rsp.success) {
						var msg = '결제가 완료되었습니다.';
						msg += '결제 금액 : ' + rsp.paid_amount;
						$("#purchseForm").submit();
						// 결제 성공 시 정보를 넘겨줘야한다면 body에 form을 만든 뒤 위의 코드를 사용하는 방법이 있습니다.
						// 자세한 설명은 구글링으로 보시는게 좋습니다.
					} else {
						var msg = '결제에 실패하였습니다.';
						msg += '에러내용 : ' + rsp.error_msg;
					}
					alert(msg);
				});
			});
			
			
		});
	</script>

	<script type="text/javascript"></script>

</body>

</html>