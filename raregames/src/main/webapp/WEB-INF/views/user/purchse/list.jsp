<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<!-- Head_info  -->
<%@include file="/WEB-INF/views/user/include/head_info.jsp"%>
<head>
<!-- DataTables -->
<link rel="stylesheet"
	href="/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<!-- Main Header -->
		<%@include file="/WEB-INF/views/user/include/header.jsp"%>
		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="/WEB-INF/views/user/include/left_menu.jsp"%>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					구매 정보 <small>회원 구매 정보</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
					<li class="active">Here</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class="col-xs-12">
						<div class="box">
							<div class="box-header">
							
								<h3 class="box-title">Purchase List</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<div class="row">
									<div class="col-sm-1">
										<button type="button" class="btn btn-block btn-danger"
											id="btnExelDownload" style="width:80px;">엑셀 다운</button>
									</div>
								</div>
								<table id="example1" class="table table-bordered table-striped">
									<thead>
										<tr>
											<th>구매번호</th>
											<th>회원ID</th>
											<th>구매가격</th>
											<th>구매일</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${purchseList }" var="purchseManageVO" varStatus="status">
											<tr>
												<td><c:out value="${purchseManageVO.purchseNo }" /></td>
												<td>
													<c:out value="${purchseManageVO.mberId }" />
												</td>
												<td><fmt:formatNumber type="currency"
														value="${purchseManageVO.purchsePrice }" /></td>
												<td><fmt:formatDate value="${purchseManageVO.purchseDe}" pattern="yyyy-MM-dd HH:mm"/></td>
												<td><button type="button" class="btn btn-block btn-warning" name="btnDetail" data-purchse-no="${purchseManageVO.purchseNo }" data-trigger="0">상세</button></td>	
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<div class="row">
									<div class="col-sm-4">
										<div class="pagination">
							                    <div class="input-group">
								                    <span class="input-group-btn">
								                    	 <select class="form-control" id="searchType" style="width:auto;">
										                    <option value="mberId" 
										                    	<c:out value="${paging.criteria.searchType eq 'mberId' ? 'selected' : '' }" />>회원ID</option>
										                    <option value="purchseDe" 
										                    	<c:out value="${paging.criteria.searchType eq 'purchseDe' ? 'selected' : '' }" /> >구매일</option>
								                    	</select>
								                    </span>
								                	<input type="text" class="form-control" id="searchTerm" value='<c:out value="${paging.criteria.searchTerm }" />'>
								                    <span class="input-group-btn">
								                    	<button type="button" class="btn btn-info btn-flat" id="btnSearch"
								                    		style="background-color:#337ab7;border-color:#337ab7;">검색</button>
								                    </span>
								              </div>
						                </div>
									</div>
									<div class="col-sm-8" style="text-align:right;">
										<div class="dataTables_paginate paging_simple_numbers">
											<ul class="pagination">
												<c:if test="${paging.prev }">
												<li class="paginate_button previous" id="example2_previous">
													<a href="#" aria-controls="example2" 
														data-dt-idx="${paging.startPage - 1 }" tabindex="0">Previous</a>
												</li>
												</c:if>
												<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="pageNo">
												<li class="paginate_button ${paging.criteria.pageNo == pageNo ? 'active' : '' }">
													<a href="#" aria-controls="example2" 
														data-dt-idx="${pageNo }" tabindex="0">${pageNo }</a>
												</li>
												</c:forEach>
												<c:if test="${paging.next }">
												<li class="paginate_button next" id="example2_next">
													<a href="#" aria-controls="example2" 
														data-dt-idx="${paging.endPage + 1 }" tabindex="0">Next</a>
												</li>
												</c:if>
											</ul>
										</div>
									</div>
									<!-- paging Form -->
									<form action="/user/purchse/list" method="get" id="pagingForm">
										<input type="hidden" name="pageNo" value="${paging.criteria.pageNo }">
										<input type="hidden" name="pageSize" value="${paging.criteria.pageSize }">
										<input type="hidden" name="searchType" value="${paging.criteria.searchType }">
										<input type="hidden" name="searchTerm" value="${paging.criteria.searchTerm }">
									</form>
								</div>
								<!-- /.row -->
							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.box -->
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%@include file="/WEB-INF/views/user/include/footer.jsp"%>
	</div>
	<!-- ./wrapper -->

	<!-- REQUIRED JS SCRIPTS -->
	<%@include file="/WEB-INF/views/user/include/plugin_js.jsp"%>
	<!-- DataTables -->
	<script
		src="/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
	<script
		src="/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
	<!-- SlimScroll -->
	<script
		src="/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<!-- FastClick -->
	<script src="/bower_components/fastclick/lib/fastclick.js"></script>
 	
 	<!-- JQuery -->
 	<script>
 	
 		$(document).ready(function(){
 			
 			//페이징 처리
 			let pagingForm = $("#pagingForm"); 
 			$(".paginate_button a").on("click", function(e){
 				e.preventDefault();
 				pagingForm.find("input[name=pageNo]").val($(this).data("dt-idx"));
 				pagingForm.attr("action", "/user/purchse/list");
 				pagingForm.submit();
 			});
 			
 			//검색 처리
 			$("#btnSearch").on("click", function(){
 				pagingForm.find("input[name=searchType]").val($("#searchType").val());
 				pagingForm.find("input[name=searchTerm]").val($("#searchTerm").val());
 				pagingForm.attr("action", "/user/purchse/list");
 				pagingForm.submit();
 			});
 			
 			//주문상세 버튼
 			$("button[name=btnDetail]").on("click", function(){
 				let purchseNo = $(this).data("purchse-no");
 				
 				let tr = $(this).parent().parent();
 				tr.parent().find(".detail").remove();
 				
 				if($(this).data("trigger") == "0"){
 					$(this).data("trigger", "1");
 					tr.after("<tr class='detail'><td colspan='6'></td></tr>");
 	 				let detail = tr.next().children();
 	 				
 	 				let url = "/user/purchse/detail?purchseNo=" + purchseNo;
 					$(detail).load(url);	
 				}else if($(this).data("trigger") == "1"){
 					$(this).data("trigger", "0");				
 				}
 				
 				
 				
 			});
 			
 			//엑셀다운 버튼
 			$("#btnExelDownload").on("click", function(){
 				pagingForm.attr("action", "/user/purchse/excelDownload");
 				pagingForm.submit();
 			});
 			
 			
 		});
 	
 	</script>
 
 
</body>
</html>