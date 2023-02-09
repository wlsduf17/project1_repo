<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table id="example1" class="table table-bordered table-striped">
	<thead>
		<tr>
			<th>상품번호</th>
			<th>상품명</th>
			<th>가격</th>
			<th>할인율</th>
			<th>판매가</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${purchseDetailList }" var="purchaseDetailVO">
			<tr>
				<td><c:out value="${purchaseDetailVO.prodNo }" /></td>
				<td>
					<c:out value="${purchaseDetailVO.prodNm }" />
				</td>
				<td><fmt:formatNumber type="currency"
						value="${purchaseDetailVO.prodPrice }" /></td>
				<td><c:out value="${purchaseDetailVO.discntRate }" /></td>
				<td><fmt:formatNumber type="currency"
						value="${purchaseDetailVO.prodPrice * purchaseDetailVO.discntRate }" /></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
