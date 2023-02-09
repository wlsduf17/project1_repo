<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 로그인 이전 -->
<c:if test="${sessionScope.loginMber == null }">
<header class="header">
      <div class="container">
          <div class="row">
              <div class="col-lg-2">
                  <div class="header__logo">
                      <a href="/" style="color:white;font-size:28px;font-weight:bold;">
                          <span style="color:#e53637;font-size:28px;font-weight:bold;">Rare</span>Games
                      </a>
                  </div>
              </div>
              <div class="col-lg-8">
                  <div class="header__nav">
                      <nav class="header__menu mobile-menu">
                          <ul>
                          	<li class="active"><a href="/">Homepage</a></li>
                         	<li><a href="/prod/categories">Categories <span class="arrow_carrot-down"></span></a>
                          		<ul class="dropdown" style="padding:0px;">
                          			<li><a style="background-color:#e53637;color:white;">장르</a></li>
									<c:forEach items="${navGenreList }" var="genreVO">
                                    	<li><a href="/prod/categories?genreCd=${genreVO.genreCd }">${genreVO.genreNm }</a></li>
                                     </c:forEach>
                                     <li><a style="background-color:#e53637;color:white;">기능</a></li>
                                     <c:forEach items="${navFeatureList }" var="featureVO">
                                    	<li><a href="/prod/categories?featureCd=${featureVO.featureCd }">${featureVO.featureNm }</a></li>
                                     </c:forEach>
                                  </ul>
                              </li>
                               <li><a href="/prod/wishList">WishList</a></li>
	                            <li><a href="/cart/list">Cart</a></li>
                          </ul>
                      </nav>
                  </div>
              </div>
              <div class="col-lg-2">
                  <div class="header__right">
                      <a href="/mber/login"><span class="icon_profile"></span></a>
                  </div>
              </div>
          </div>
          <div id="mobile-menu-wrap"></div>
      </div>
  </header>
  </c:if>
  
  <!-- 로그인 이후 -->
  <c:if test="${sessionScope.loginMber != null }">
  <header class="header">
    <div class="container">
        <div class="row">
            <div class="col-lg-2">
                <div class="header__logo">
                    <a href="/" style="color:white;font-size:28px;font-weight:bold;">
                    	<span style="color:#e53637;font-size:28px;font-weight:bold;">Rare</span>Games
                	</a>
                </div>
            </div>
            <div class="col-lg-7">
                <div class="header__nav">
                    <nav class="header__menu mobile-menu">
                        <ul>
                            <li class="active"><a href="/">Homepage</a></li>
                            <li><a href="/prod/categories">Categories <span class="arrow_carrot-down"></span></a>
                                <ul class="dropdown" style="padding:0px;">
                          			<li><a style="background-color:#e53637;color:white;">장르</a></li>
									<c:forEach items="${navGenreList }" var="genreVO">
                                    	<li><a href="/prod/categories?genreCd=${genreVO.genreCd }">${genreVO.genreNm }</a></li>
                                     </c:forEach>
                                     <li><a style="background-color:#e53637;color:white;">기능</a></li>
                                     <c:forEach items="${navFeatureList }" var="featureVO">
                                    	<li><a href="/prod/categories?featureCd=${featureVO.featureCd }">${featureVO.featureNm }</a></li>
                                     </c:forEach>
                            	</ul>
                            </li>
                            <li><a href="/prod/wishList">WishList<c:if test="${wishList.size() > 0 }">
                            (${wishList.size() })</c:if></a></li>
                            <li><a href="/cart/list">Cart<c:if test="${cartList.size() > 0 }">
                            (${cartList.size() })</c:if></a></li>
                        </ul>
                    </nav>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="header__right">
                <nav class="header__menu">
               		<ul>
	                    <li><a href="" style="display:inline;"><span class="icon_profile" style="margin-right:15px;color:#3c763d;"></span>
	                    <span style="color:white;font-size:15px;">${loginMber.mberNicknm }</span></a>
                    <ul class="dropdown" style="top:40px;background-color:#070720;">
                        <li><a href="/mber/account" style="color:white;">ACCOUNT</a></li>
                        <li><a href="/mber/myGames" style="color:white;">MY GAMES</a></li>
                        <li><a href="/mber/logout" style="color:#e53637;">LOGOUT</a></li>
                    </ul>
                    </li>
                    </ul>
                    </nav>
                </div>
            </div>
        </div>
        <div id="mobile-menu-wrap"></div>
    </div>
</header>
</c:if>
