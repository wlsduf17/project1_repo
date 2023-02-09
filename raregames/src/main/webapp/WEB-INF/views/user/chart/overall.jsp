<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

<!-- Google Chart -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
	//상품별 총 매출
	google.charts.load("current", {packages:["corechart"]});
    google.charts.setOnLoadCallback(totalSalesPerProdChart);
    function totalSalesPerProdChart() {
    	var data = google.visualization.arrayToDataTable(${totalSalesPerProdChart });

      	var options = {
        	title: "상품별 총 매출"
      	};
      	var chart = new google.visualization.BarChart(document.getElementById("totalSalesPerProdChart"));
     	chart.draw(data, options);
  	}
    
    //년도별 총 매출
    google.charts.load("current", {packages:["corechart"]});
    google.charts.setOnLoadCallback(totalSalesPerYearChart);
    function totalSalesPerYearChart() {
    	var data = google.visualization.arrayToDataTable(${totalSalesPerYearChart });

      	var options = {
	        title: "년도별 총 매출"
      	};
      	var chart = new google.visualization.ColumnChart(document.getElementById("totalSalesPerYearChart"));
      	chart.draw(data, options);
	}
    
    //월별 총 매출
   	google.charts.load("current", {packages:["corechart"]});
    google.charts.setOnLoadCallback(totalSalesPerMonthChart);
    function totalSalesPerMonthChart() {
      	var data = google.visualization.arrayToDataTable(${totalSalesPerMonthChart });

      	var options = {
        	title: "월별 상품 총 매출"
      	};
      	var chart = new google.visualization.ColumnChart(document.getElementById("totalSalesPerMonthChart"));
      	chart.draw(data, options);	
   	}
    
 </script>
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
					구매 통계
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
					<li class="active">Here</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
				<div id="totalSalesPerProdChart" style="width: 900px; height: 300px;"></div>
			</section>
			
			<section class="content container-fluid">
				<div id="totalSalesPerYearChart" style="width: 900px; height: 300px;"></div>
			</section>
			
			<section class="content container-fluid">
				<div id="totalSalesPerMonthChart" style="width: 900px; height: 300px;"></div>
					<div class="row">
						<div class="col-md-2">
							<div class="form-group">
								<label for="year">년도</label> <select
									class="form-control" id=year name="year">
										<option value="">--</option>
									<c:forEach items="${purchseDeYear }" var="year">
										<option value="${year }">${year }</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="col-md-2">
							<div class="form-group">
								<label for="month">월</label> <select
									class="form-control" id="month" name="month">
									<option value="">--</option>
								</select>
							</div>
						</div>
						<div class="col-md-2">
							<div class="form-group">
								<button type="button" id="btnPurchseDe" class="btn btn-primary" style="margin-top:25px;">입력</button>
							</div>
						</div>
					</div>
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
	<!-- JQuery -->
	<script>
		
		$(document).ready(function(){
			
			$("#year").on("change", function(){
				let year = $("#year").val();
				$.ajax({
					url:"/user/chart/selectMonth",
					type:"get",
					dataType:"JSON",
					data:{
						year: year
						},
					success:function(data){
						$("#month").empty();
						$("#month").append("<option value=''>--</option>");
						$.each(data, function(index, item){
							
							$("#month").append("<option value=" + item + ">" + item + "</option>");
						});
					}
					
				});
			});
			
			$("#btnPurchseDe").on("click", function(){
				let year = $("#year").val();
				let month = $("#month").val();
				if(year == null || year == ""){
					alert("년도를 선택해주세요.");
					return;
				}
				if(month == null || month == ""){
					alert("월을 선택해주세요.");
					return;
				}
				let purchseDe = year + "/" + month;
				location.href = "/user/chart/overall?purchseDe=" + purchseDe;
				
			});
			
		});
	
	</script>
</body>
</html>