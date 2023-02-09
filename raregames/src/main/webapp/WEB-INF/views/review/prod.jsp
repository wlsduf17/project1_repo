<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="anime__details__review">
	<div class="section-title">
		<h5>Reviews</h5>
	</div>
	<!-- 현재시간 -->
	<c:set var="now" value="<%=new java.util.Date() %>" />
	<fmt:parseNumber var="now_num" value="${now.time }" integerOnly="true" />
	
	<c:forEach items="${reviewList }" var="reviewManageVO">
	<div class="anime__review__item">
		<div class="anime__review__item__pic">
			<img src="/img/blog/details/comment-3.png" alt="">
		</div>
		<div class="anime__review__item__text">
			<div style="display:flex;justify-content:space-between">
			<h6>
				<!-- 최초등록 시간 -->
				<c:set var="frstRegistDe" value="${reviewManageVO.frstRegistDe }" />
				<fmt:parseNumber var="frstRegistDe_num" value="${frstRegistDe.time }" integerOnly="true" />
				<!-- 마지막 업데이트 시간 -->
				<c:set var="lastUpdtDe" value="${reviewManageVO.lastUpdtDe }" />
				<fmt:parseNumber var="lastUpdtDe_num" value="${lastUpdtDe.time }" integerOnly="true" />
				<!-- 최초등록 업데이트 시간 차이 -->
				<fmt:formatNumber var="modify_at" value="${lastUpdtDe_num - frstRegistDe_num}" pattern="#.#"/>
				<!-- 현재시간 마지막업데이트 시간 차이 -->
				<fmt:formatNumber var="time_differ_sec" value="${(now_num - lastUpdtDe_num)/(1000)}" pattern="#" />
				<fmt:formatNumber var="time_differ_min" value="${(now_num - lastUpdtDe_num)/(1000*60)}" pattern="#" />
				<fmt:formatNumber var="time_differ_hour" value="${(now_num - lastUpdtDe_num)/(1000*60*60)}" pattern="#" />
				<fmt:formatNumber var="time_differ_day" value="${(now_num - lastUpdtDe_num)/(1000*60*60*24)}" pattern="#" />
				${reviewManageVO.mberNicknm } - 
				<span>
				<c:if test="${time_differ_min < 1 }">
					${time_differ_sec } Sec ago
				</c:if>
				<c:if test="${time_differ_min >= 1 && time_differ_min < 60 }">
					${time_differ_min } Min ago
				</c:if>
				<c:if test="${time_differ_hour >= 1 && time_differ_hour < 24 }">
					${time_differ_hour } Hour ago
				</c:if>
				<c:if test="${time_differ_hour >= 24 }">
					${time_differ_day } Day ago
				</c:if>
				<c:if test="${modify_at != 0 }">(수정됨)</c:if>
				</span>
			</h6>
			<div class="anime__details__rating old__review" style="position:static;text-align:left;height:30px">
				<div class="rating">
				<c:choose>
					<c:when test="${reviewManageVO.reviewScore eq 0 }">
						<i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>
					</c:when>
					<c:when test="${reviewManageVO.reviewScore eq 1 }">
						<i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>
					</c:when>
					<c:when test="${reviewManageVO.reviewScore eq 2 }">
						<i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>
					</c:when>
					<c:when test="${reviewManageVO.reviewScore eq 3 }">
						<i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>
					</c:when>
					<c:when test="${reviewManageVO.reviewScore eq 4 }">
						<i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i>
					</c:when>
					<c:when test="${reviewManageVO.reviewScore eq 5 }">
						<i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i>
					</c:when>
				</c:choose>
				</div>
				<span style="font-size:12px;">${reviewManageVO.reviewScore } Score</span>
			</div>
			<!-- 수정버튼 클릭시 show() -->
			<div class="anime__details__rating new__review" style="position:static;text-align:left;height:30px;float:left;display:none;">
				<div class="rating">
					<a href=""><i class="fa fa-star-o"></i></a>
					<a href=""><i class="fa fa-star-o"></i></a>
				    <a href=""><i class="fa fa-star-o"></i></a>
					<a href=""><i class="fa fa-star-o"></i></a>
					<a href=""><i class="fa fa-star-o"></i></a>
				</div>
			</div>
			<input type="hidden" class="reviewScore" name="reviewScore">
			</div>
			<div class="review__content">
				<p class="oldReviewCn">${reviewManageVO.reviewCn }</p>
				<!-- 수정버튼 클릭시 show() -->
				<input type="text" class="newReviewCn" name="reviewCn" style="display:none;height:30%;width:70%">
				<c:if test="${sessionScope.loginMber.mberId == reviewManageVO.mberId }">
				<div class="product__item__text">
			    	<ul>
		             	<li><a href="" class="btnReviewModify"
		            	data-review-no="${reviewManageVO.reviewNo }"
		            	data-review-cn="${reviewManageVO.reviewCn }"
		            	data-review-score="${reviewManageVO.reviewScore }">수정
		            	</a></li>
		            	<li><a href="" class="btnReviewDelete"
		            	data-review-no="${reviewManageVO.reviewNo }">삭제
		            	</a></li>
		            	<li style="display:none;"><a href="" class="btnReviewConfirm">확인
		            	</a></li>
		            	<li style="display:none;"><a href="" class="btnReviewCancel">취소
		            	</a></li>
		            </ul>
	             </div>
	             </c:if>
			</div>
		</div>
	</div>
	</c:forEach>
	
	<div class="product__pagination">
		<c:if test="${paging.prev }">
			<a href="" data-dt-idx="${paging.startPage - 1 }"><i class="fa fa-angle-double-left"></i></a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="pageNo">
		<a href="" data-dt-idx="${pageNo }" class="${paging.criteria.pageNo == pageNo ? 'current-page' : '' }">${pageNo }</a>
		</c:forEach>
		<c:if test="${paging.next }">
			<a href="" data-dt-idx="${paging.endPage + 1 }"><i class="fa fa-angle-double-right"></i></a>
		</c:if>
	</div>
</div>


<div class="anime__details__form">
	<div class="section-title">
		<h5>Your Comment</h5>
	</div>
	<form action="#">
		<div class="anime__details__rating" style="position:static;text-align:left;height:30px;float:left;">
			<div class="rating">
				<a href=""><i class="fa fa-star-o"></i></a>
				<a href=""><i class="fa fa-star-o"></i></a>
			    <a href=""><i class="fa fa-star-o"></i></a>
				<a href=""><i class="fa fa-star-o"></i></a>
				<a href=""><i class="fa fa-star-o"></i></a>
			</div>
		</div>
		<input type="hidden" class="reviewScore" name="reviewScore">
		<textarea class="reviewCn" name="reviewCn" placeholder="Your Comment"></textarea>
		<button type="button" id="btnReview">
			<i class="fa fa-location-arrow"></i> Review
		</button>
	</form>
</div>
<!-- paging Form -->
<form action="" method="get" id="pagingForm">
	<input type="hidden" name="pageNo" value="${paging.criteria.pageNo }">
	<input type="hidden" name="pageSize" value="${paging.criteria.pageSize }">
		
</form>
