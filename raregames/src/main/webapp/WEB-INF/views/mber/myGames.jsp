<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
</head>

<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Header Section Begin -->
   	<%@include file="/WEB-INF/views/include/header.jsp" %>
    <!-- Header End -->
	
	<!-- 현재시간 -->
	<c:set var="now" value="<%=new java.util.Date()%>" />
	<fmt:parseNumber var="now_num" value="${now.time }" integerOnly="true" />
	
    <!-- Normal Breadcrumb Begin -->
    <section class="normal-breadcrumb set-bg" data-setbg="/img/normal-breadcrumb2.png">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="normal__breadcrumb__text">
                        <h2>My Games</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Normal Breadcrumb End -->

   <!-- Product Section Begin -->
    <section class="product-page spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                	<div class="section-title">
                		<h4>구매한 상품</h4>
                	</div>
                    <div class="product__page__content">
                        <div class="row">
                       <c:forEach items="${purchseProdList }" var="purchseProdVO">
	                            <div class="col-lg-4 col-md-6 col-sm-6">
	                                <div class="product__item">
	                                    <div class="product__item__pic set-bg" data-setbg="" style="height:270px;">
                           					<a href="/prod/detail?prodNo=${purchseProdVO.prodNo }">
		                                    	<img src="/user/prod/showThumbnail?
													prodImg=<c:out value="${purchseProdVO.prodImg }"/>
													&frstRegistDe=<fmt:formatDate value="${purchseProdVO.frstRegistDe }"
													pattern="yyyy-MM-dd"/>" >
	                               			</a>
	                                    </div>
	                                    <div class="product__item__text">
	                                        <h5 style="color:white;">${purchseProdVO.prodNm }</h5>
	                                        <span style="color:#b7b7b7;font-size:14px;">구매일: </span>
	                                        <span style="color:#b7b7b7;font-size:12px;"><fmt:formatDate value="${purchseProdVO.purchseDe }" pattern="yyyy-MM-dd"/></span>
	                                    </div>
	                                </div>
	                            </div>
                            </c:forEach>
                        </div>
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
		</div>
</section>
<!-- Product Section End -->

    <!-- Footer Section Begin -->
  	<%@include file="/WEB-INF/views/include/footer.jsp" %>

      <!-- Footer Section End -->

      <!-- Search model Begin -->
      <div class="search-model">
        <div class="h-100 d-flex align-items-center justify-content-center">
            <div class="search-close-switch"><i class="icon_close"></i></div>
            <form class="search-model-form">
                <input type="text" id="search-input" placeholder="Search here.....">
            </form>
        </div>
    </div>
    <!-- Search model end -->

    <!-- Js Plugins -->
   	<%@include file="/WEB-INF/views/include/js_plugins.jsp" %>


</body>

</html>