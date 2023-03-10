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
					?????? ?????? <small>?????? ?????? ??????</small>
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
								<h3 class="box-title">Product List</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
							<div class="row">
								<div class="col-sm-1">
									<button type="button" class="btn btn-block btn-danger"
										id="btnCheckDelete" style="width:80px;">????????????</button>
								</div>
								<div class="col-sm-1">
								</div>
								<div class="col-sm-10">
									<div class="btn-group">
										<button type="button" class="btn btn-block btn-primary"
										id="btnAll" style="width:80px;">????????????</button>
										<button type="button" class="btn btn-flat btn-success"
										id="btnSell" style="width:80px;">??????</button>
										<button type="button" class="btn btn-flat btn-danger"
										id="btnUnSell" style="width:80px;">?????????</button>
										<button type="button" class="btn btn-block btn-info"
										id="btnDiscnt" style="width:80px;">??????</button>
	                    			</div>
								</div>
							</div>
								<table id="example1" class="table table-bordered table-striped">
									<thead>
										<tr>
											<th><input type="checkbox" id="allCheckbox"></th>
											<th>????????????</th>
											<th>?????????</th>
											<th>??????</th>
											<th>?????????</th>
											<th>?????????</th>
											<th>????????????</th>
											<th>?????????</th>
											<th>????????????</th>
											<th>?????????</tH>
											<th>?????????<th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${prodList }" var="prodManageVO">
											<tr>
												<td><input type="checkbox" name="check" value="${prodManageVO.prodNo }"></td>
												<td><c:out value="${prodManageVO.prodNo }" /></td>
												<td>
													<img src="/user/prod/showThumbnail?
													prodImg=<c:out value="${prodManageVO.prodImg }"/>
													&frstRegistDe=<fmt:formatDate value="${prodManageVO.frstRegistDe }" pattern="yyyy-MM-dd"/>"
													style="width: 80px; height: 120px;"> <br>
													<c:out value="${prodManageVO.prodNm }" />
												</td>
												<td><fmt:formatNumber type="currency"
														value="${prodManageVO.prodPrice }" /></td>
												<td><c:out value="${prodManageVO.discntRate }" /></td>
												<td><fmt:formatNumber type="currency"
														value="${prodManageVO.prodPrice * prodManageVO.discntRate }" /></td>
												<td>
													<c:if test="${prodManageVO.purchaseAt == 'Y'}"><span class="label label-success">??????</span></c:if>
													<c:if test="${prodManageVO.purchaseAt == 'N'}"><span class="label label-danger">?????????</span></c:if>
												</td>
												<td><c:out value="${prodManageVO.developer }" /></td>
												<td><c:out value="${prodManageVO.publisher }" /></td>
												<td><fmt:formatDate value="${prodManageVO.frstRegistDe }" pattern="yyyy-MM-dd"/></td>
												<td><fmt:formatDate value="${prodManageVO.lastUpdtDe }" pattern="yyyy-MM-dd"/></td>
												<td><button type="button" class="btn btn-block btn-warning" name="btnModify" data-prod-no="${prodManageVO.prodNo }">??????</button></td>
												<td><button type="button" class="btn btn-block btn-danger" name="btnDelete" data-prod-no="${prodManageVO.prodNo }">??????</button></td>
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
										                    <option value="prodNm" 
										                    	<c:out value="${paging.criteria.searchType eq 'prodNm' ? 'selected' : '' }" /> >?????????</option>
										                    <option value="developer" 
										                    	<c:out value="${paging.criteria.searchType eq 'developer' ? 'selected' : '' }" />>?????????</option>
										                    <option value="publisher" 
										                    	<c:out value="${paging.criteria.searchType eq 'publisher' ? 'selected' : '' }" />>????????????</option>
								                    	</select>
								                    </span>
								                	<input type="text" class="form-control" id="searchTerm" value='<c:out value="${paging.criteria.searchTerm }" />'>
								                    <span class="input-group-btn">
								                    	<button type="button" class="btn btn-info btn-flat" id="btnSearch"
								                    		style="background-color:#337ab7;border-color:#337ab7;">??????</button>
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
									<form action="/user/prod/list" method="get" id="pagingForm">
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
 			
 			//?????? ???????????? & ?????? ???????????? ??????
 			$("#allCheckbox").on("click", function(){
 				$("input[name=check]").prop("checked", this.checked);
 			});
 			$("input[name=check]").on("click", function(){
				$("#allCheckbox").prop("checked", true);
				$("input[name=check]").each(function(i, e){
					if(!$(e).is(':checked')){	
						$("#allCheckbox").prop("checked", false);
					}
				});
			});
 			
 			//????????? ??????
 			let pagingForm = $("#pagingForm"); 
 			$(".paginate_button a").on("click", function(e){
 				e.preventDefault();
 				pagingForm.find("input[name=pageNo]").val($(this).data("dt-idx"));
 				pagingForm.attr("action", "/user/prod/list");
 				pagingForm.submit();
 			});
 			
 			//?????? ??????
 			$("#btnSearch").on("click", function(){
 				pagingForm.find("input[name=searchType]").val($("#searchType").val());
 				pagingForm.find("input[name=searchTerm]").val($("#searchTerm").val());
 				pagingForm.attr("action", "/user/prod/list");
 				pagingForm.submit();
 			});
 			
 			//????????????
 			$("button[name=btnModify]").on("click", function(){
 				let prodNo = $(this).data("prod-no");
 				pagingForm.find("input[name=prodNo]").remove();
 				pagingForm.append("<input type='hidden' name='prodNo' value='" + prodNo + "'>");
 				pagingForm.attr("action", "/user/prod/modify");
 				pagingForm.submit();
 			});
 			
 			//????????????
 			$("button[name=btnDelete]").on("click", function(){
 				let prodNo = $(this).data("prod-no");
 				pagingForm.find("input[name=prodNo]").remove();
 				pagingForm.append("<input type='hidden' name='prodNo' value='" + prodNo + "'>");
 				pagingForm.attr("action", "/user/prod/delete");
 				pagingForm.attr("method", "post");
 				pagingForm.submit();
 			});
 			
 			//???????????? Ajax??????
 			$("#btnCheckDelete").on("click", function(){
 				
 				if(!confirm("????????? ????????? ?????????????????????????"))return;
 				
 				let prodNoArr = [];
 				$("input[name=check]:checked").each(function(){
 					
 					let prodNo = $(this).val();
 					prodNoArr.push(prodNo);
 				});
 				
 				$.ajax({
					url:"/user/prod/checkDelete",
					type:"post",
					dataType:"text",
					data:{
						prodNoArr: prodNoArr
						},
					success:function(data){
						if(data == "success"){
							alert("????????? ?????????????????????.");
							location.href = "/user/prod/list";
						}
					}
 				});
 			});
 			
 			//???????????? ??????
			$("#btnAll").on("click", function(){
				pagingForm.find("input[name=searchType]").val("");
				pagingForm.find("input[name=pageNo]").val("1");
 				pagingForm.attr("action", "/user/prod/list");
 				pagingForm.submit();
 				
 			});	
 			
 			//?????? ??????
 			$("#btnSell").on("click", function(){
 				pagingForm.find("input[name=searchType]").val("Sell");
 				pagingForm.find("input[name=pageNo]").val("1");
 				pagingForm.attr("action", "/user/prod/list");
 				pagingForm.submit();
 			});		
 			
 			//????????? ??????
 			$("#btnUnSell").on("click", function(){
 				pagingForm.find("input[name=searchType]").val("UnSell");
 				pagingForm.find("input[name=pageNo]").val("1");
 				pagingForm.attr("action", "/user/prod/list");
 				pagingForm.submit();
 				
 			});
 			
 			//?????? ??????
			$("#btnDiscnt").on("click", function(){
				pagingForm.find("input[name=searchType]").val("Discnt");
				pagingForm.find("input[name=pageNo]").val("1");
 				pagingForm.attr("action", "/user/prod/list");
 				pagingForm.submit();
 				
 			});		
 		});
 	
 	</script>
 
 
</body>
</html>