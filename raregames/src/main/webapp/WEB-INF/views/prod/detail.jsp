<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
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
						<a href="/prod/categories">Categories</a>
						<span>${prodManageVO.prodNm }</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Breadcrumb End -->

	<!-- Anime Section Begin -->
	<section class="anime-details spad">
		<div class="container">
			<div class="anime__details__content">
				<div class="row">
				
					<div class="col-lg-3">
						<div class="anime__details__pic set-bg" data-setbg="">
							<img src="/prod/showProdImg?
								prodImg=<c:out value="${prodManageVO.prodImg }"/>
								&frstRegistDe=<fmt:formatDate value="${prodManageVO.frstRegistDe }"
								pattern="yyyy-MM-dd"/>" style="width:100%;height:100%;">
						</div>
					</div>
					<div class="col-lg-9">
						<div class="anime__details__text">
							<div class="anime__details__title">
								<h3>${prodManageVO.prodNm }</h3>
							</div>

							<div class="anime__details__widget">
								<div class="row">
									<div class="col-lg-6 col-md-6">
										<ul>
											<li><span>장르:</span>
												<c:forEach items="${genreList }" var="genreVO" varStatus="status">
													<a href="/prod/categories?genreCd=${genreVO.genreCd }" class="genreFeature">${genreVO.genreNm }</a><c:if test="${!status.last }">,&nbsp;</c:if>
												</c:forEach></li>
											<li><span>기능:</span>
												<c:forEach items="${featureList }" var="featureVO" varStatus="status">
													<a href="/prod/categories?featureCd=${featureVO.featureCd}" class="genreFeature">${featureVO.featureNm }</a><c:if test="${!status.last }">,&nbsp;</c:if>
												</c:forEach></li>
											<li><span>가격:</span>
												<c:if test="${prodManageVO.discntRate == '1' }">
													<fmt:formatNumber type="currency" value="${prodManageVO.prodPrice }" />
												</c:if>
												<c:if test="${prodManageVO.discntRate != '1' }">
													<span class="discnt"><fmt:formatNumber type="percent" value="${prodManageVO.discntRate }" /></span>
													<span style="text-decoration:line-through;color:gray;width:auto;">
													<fmt:formatNumber type="currency" value="${prodManageVO.prodPrice }" /></span>
													<fmt:formatNumber type="currency" value="${prodManageVO.prodPrice * prodManageVO.discntRate }" />
												</c:if>
											</li>
										</ul>
									</div>
									<div class="col-lg-6 col-md-6">
										<ul>
											<li><span>게임등급:</span>
											<c:if test="${prodManageVO.gameRating == 'all' }"> 전체이용가</c:if> 
											<c:if test="${prodManageVO.gameRating == '12+' }"> 12세이용가</c:if> 
											<c:if test="${prodManageVO.gameRating == '15+' }"> 15세이용가</c:if> 
											<c:if test="${prodManageVO.gameRating == '18+' }"> 청소년이용불가</c:if> 
											</li>
											<li><span>개발사:</span> <c:out value="${prodManageVO.developer }" /></li>
											<li><span>퍼블리셔:</span> <c:out value="${prodManageVO.publisher }" /></li>
											<li><span>출시일:</span> <fmt:formatDate value="${prodManageVO.releaseDe }" pattern="yyyy-MM-dd"/> </li>
											<li><span>플랫폼:</span> <c:out value="${prodManageVO.platform }" /></li>
										</ul>
									</div>
								</div>
							</div>
							<div class="anime__details__btn">
								<c:set var="purchseAt" value="false" />
                                <c:set var="cartAt" value="false" />
                                <c:set var="wishListAt" value="false" />
                                
								<c:forEach items="${purchseProdList }" var="purchseProdVO">
                            		<c:if test="${purchseProdVO.prodNo == prodManageVO.prodNo }">
                            			<c:set var="purchseAt" value="true" />
                                	</c:if>
                                </c:forEach>
                                <c:forEach items="${cartList }" var="cartProdVO">
                                	<c:if test="${cartProdVO.prodNo == prodManageVO.prodNo }">
                                		<c:set var="cartAt" value="true" />
                                	</c:if>
                                </c:forEach>
                                 <c:forEach items="${wishList }" var="wishListProdVO">
                                	<c:if test="${wishListProdVO.prodNo == prodManageVO.prodNo }">
                                		<c:set var="wishListAt" value="true" />
                                	</c:if>
                                </c:forEach>
                            		<c:if test="${purchseAt }">
                                		<a href="/" class="watch-btn"><span>이미구매한 상품입니다.</span> <i class="fa fa-angle-right"></i></a>
                                	</c:if>
                           		<c:if test="${!purchseAt }">
	                            	<c:if test="${wishListAt }">
	                            		<a href="" class="follow-btn" id="" data-prod-no="${prodManageVO.prodNo }"><i class="fa fa-heart"></i> 위시리스트에 있음 </a>
	                            	</c:if>
                           			<c:if test="${!wishListAt }">
	                            		<a href="" class="follow-btn" id="btnAddWishList" data-prod-no="${prodManageVO.prodNo }"><i class="fa fa-heart-o"></i> 위시리스트에 추가 </a>
	                            	</c:if>
                                	<c:if test="${cartAt }">
		                            	<a href="/cart/list" class="watch-btn"><span>장바구니 보기</span> <i class="fa fa-angle-right"></i></a>
                                	</c:if>
	                            	<c:if test="${!cartAt }">
		                            	<a href="" class="watch-btn" id="btnAddProdCart" data-prod-no="${prodManageVO.prodNo }"><span>장바구니에 담기</span> <i
	                                	class="fa fa-angle-right"></i></a>
                                	</c:if>
                                </c:if>
                            </div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-8">
					<div class="anime__details__review">
						<div class="section-title">
							<h5>INTRODUCTION</h5>
						</div>
					</div>
					<div class="blog__details__item__text" style="color:white;">
						${prodManageVO.prodCn }
					</div>
				</div>
				<div class="col-lg-4 col-md-6 col-sm-8">
					<div class="product__sidebar">
						<div class="product__sidebar__comment">
							<div class="section-title">
								<h5>RECOMMENDATION</h5>
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
			<div class="row">
				<div class="col-lg-8 col-md-8" id="prodReview">
				<!-- 상품리뷰 -->
				</div>
			</div>
	</section>
	<!-- Anime Section End -->

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
	
		//상품번호
		let prodNo = "<c:out value='${prodManageVO.prodNo}' />";
		
		$(document).ready(function(){
			//상품리뷰로드
			let prodReview = function(){
					$("#prodReview").load("/review/prod?prodNo=" + prodNo);
			}
			prodReview();
			
			//장바구니 담기 버튼
			$("#btnAddProdCart").on("click", function(e){
				e.preventDefault();
				//로그인 여부 확인
				let loginMber = "<c:out value='${sessionScope.loginMber}' />";
				if(loginMber == null || loginMber == ""){
					alert("로그인이 필요합니다.");
					location.href = "/mber/login";
					return;
				}
				$.ajax({
					url:"/cart/insert",
					type:"post",
					dataType:"text",
					data:{
						prodNo: prodNo
						},
					success:function(data){
						if(data == "success"){
							if(!confirm("장바구니에 추가되었습니다.\n장바구니로 이동하시겠습니까?")){
								location.href = "";
								return;
							}
							location.href = "/cart/list";
						}else{
							alert("장바구니에 추가하는데 실패하였습니다.");
						}
					}
				});
				
			});
			
			//위시리스트 추가 버튼
			$("#btnAddWishList").on("click", function(e){
				e.preventDefault();
				//로그인 여부 확인
				let loginMber = "<c:out value='${sessionScope.loginMber}' />";
				if(loginMber == null || loginMber == ""){
					alert("로그인이 필요합니다.");
					location.href = "/mber/login";
					return;
				}
				$.ajax({
					url:"/prod/wishList/insert",
					type:"post",
					dataType:"text",
					data:{
						prodNo: prodNo
						},
					success:function(data){
						if(data == "success"){
							if(!confirm("위시리스트에 추가되었습니다.\n위시리스트로 이동하시겠습니까?")){
								location.href = "";
								return;
							}
							location.href = "/prod/wishList";
						}else{
							alert("위시리스트에 추가하는데 실패하였습니다.");
						}
					}
				});
				
			});
			
			//리뷰 페이징 처리
 			$("#prodReview").on("click", ".product__pagination a", function(e){
 				e.preventDefault();
 				let pageNo = $(this).data("dt-idx");
 				let pageSize = $("#prodReview").find("input[name=pageSize]").val();
 				$("#prodReview").load("/review/prod?prodNo=" + prodNo + "&pageNo=" + pageNo + "&pageSize=" + pageSize);
 			});
			
			//별점클릭 처리
 			$("#prodReview").on("click", "div.rating a", function(e){
 				e.preventDefault();
 				$(this).parent().find("i").prop("class", "fa fa-star-o");
 				$(this).find("i").prop("class", "fa fa-star");
 				$(this).prevAll("a").find("i").prop("class", "fa fa-star");
 				
 				let star_score = 0;
 				$(this).parent().find("i").each(function(index, item){
 					if($(item).prop("class") == "fa fa-star"){
 						star_score += 1;
 					}
 				});
 				$("#prodReview").find("input.reviewScore").val(star_score);
 			});
			
 			//리뷰버튼클릭
 			$("#prodReview").on("click", "#btnReview", function(e){
 				//로그인 여부 확인
 				let loginMber = "<c:out value='${sessionScope.loginMber}' />";
				if(loginMber == null || loginMber == ""){
					alert("로그인이 필요합니다.");
					location.href = "/mber/login";
					return;
				}
				//입력 정보
				let reviewScore = $("#prodReview").find("input.reviewScore").val();
				let reviewCn = $("#prodReview").find("textarea.reviewCn").val(); 
				//공백검사
				if(reviewScore == null || reviewScore == ""){
					alert("리뷰 점수를 입력해주세요.");
					return;
				}
				if(reviewCn == null || reviewCn == ""){
					alert("리뷰 내용을 입력해주세요.");
					$("#prodReview").find("textarea.reviewCn").focus();
					return;
				}
				//리뷰등록처리
 				$.ajax({
 					url:"/review/insert",
 					type:"post",
 					dataType:"text",
 					data:{
 						prodNo: prodNo,
 						reviewCn: reviewCn,
 						reviewScore: reviewScore
 						},
 					success:function(data){
 						if(data == "success"){
 							prodReview();
 						}else{
 							alert("리뷰등록에 실패하였습니다.");
 							return;
 						}
 						
 					}
 				});
 			});
 			
 			//리뷰수정버튼
			$("#prodReview").on("click", ".product__item__text .btnReviewModify", function(e){
				e.preventDefault();
				//기존 리뷰 내용
				let reviewNo = $(this).data("review-no");
 				let oldReviewCn = $(this).data("review-cn");
				let oldReviewScore = $(this).data("review-score");
				
				let reviewItem = $(this).parents(".anime__review__item");
				//리뷰 별점 hide & show
				reviewItem.find(".old__review").hide();
				reviewItem.find(".new__review").show();
				//리뷰 내용 hide & show
				reviewItem.find(".oldReviewCn").hide();
				reviewItem.find(".newReviewCn").show();
				reviewItem.find(".newReviewCn").val(oldReviewCn).focus();
				//리뷰 버튼 hide & show
				reviewItem.find(".btnReviewModify").parents("li").hide();
				reviewItem.find(".btnReviewDelete").parents("li").hide();
				reviewItem.find(".btnReviewConfirm").parents("li").show();
				reviewItem.find(".btnReviewCancel").parents("li").show();
				
				//취소버튼
				reviewItem.find(".btnReviewCancel").on("click", function(e){
					e.preventDefault();
					prodReview();
					return;
				});
				//확인 버튼
				reviewItem.find(".btnReviewConfirm").on("click", function(e){
					e.preventDefault();
					let reviewScore = reviewItem.find("input.reviewScore").val();
					let reviewCn = reviewItem.find("input.newReviewCn").val();
					//공백검사
					if(reviewScore == null || reviewScore == ""){
						alert("리뷰 점수를 입력해주세요.");
						return;
					}
					if(reviewCn == null || reviewCn == ""){
						alert("리뷰 내용을 입력해주세요.");
						reviewItem.find("input.newReviewCn").focus();
						return;
					}
					//리뷰수정 Ajax처리
					$.ajax({
	 					url:"/review/modify",
	 					type:"post",
	 					dataType:"text",
	 					data:{
	 						reviewNo: reviewNo,
	 						reviewScore: reviewScore,
	 						reviewCn: reviewCn
	 						},
	 					success:function(data){
	 						if(data == "success"){
	 							prodReview();
	 						}else{
	 							alert("리뷰삭제에 실패하였습니다.");
	 							return;
	 						}
	 						
	 					}
	 				});
					
				});
				
			});
 			
			//리뷰삭제버튼
			$("#prodReview").on("click", ".product__item__text .btnReviewDelete", function(e){
				e.preventDefault();
				let reviewNo = $(this).data("review-no");
				//리뷰삭제처리
				$.ajax({
 					url:"/review/delete",
 					type:"post",
 					dataType:"text",
 					data:{
 						reviewNo: reviewNo,
 						},
 					success:function(data){
 						if(data == "success"){
 							prodReview();
 						}else{
 							alert("리뷰삭제에 실패하였습니다.");
 							return;
 						}
 						
 					}
 				});
			});
 			
 			
		});
	
	</script>
	
</body>

</html>