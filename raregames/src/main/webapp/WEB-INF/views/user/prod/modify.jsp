<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<!-- datepicker -->
<link rel="stylesheet"
	href="../../bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
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
					?????? ?????? <small>Optional description</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
					<li class="active">Here</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content">
				<!-- form start -->
				<form role="form" action="/user/prod/modify" method="post"
					enctype="multipart/form-data">
					<div class="row">
						<!-- left column -->
						<div class="col-md-6">
							<!-- general form elements -->
							<div class="box box-primary">
								<div class="box-header with-border">
									<h3 class="box-title">?????? ??????</h3>
								</div>
								<!-- /.box-header -->
								<div class="box-body">
								
									<div class="form-group">
										<label for="prodNo">????????????</label> <input type="text"
											class="form-control" id="prodNo" name="prodNo" value='<c:out value="${prodManageVO.prodNo }" />'
											readonly>
									</div>
									<div class="form-group">
										<label for="prodNm">?????????</label> <input type="text"
											class="form-control" id="prodNm" name="prodNm" value='<c:out value="${prodManageVO.prodNm }" />'>
									</div>
									<div class="form-group">
										<label for="prodPrice">??????</label> <input type="text"
											class="form-control" id="prodPrice" name="prodPrice"
											value='<c:out value="${prodManageVO.prodPrice }" />'>
									</div>
									<div class="form-group">
										<label for="discntRate">?????????</label> <input type="text"
											class="form-control" id="discntRate" name="discntRate"
											value='<c:out value="${prodManageVO.discntRate }" />'>
									</div>
									<div class="form-group">
										<label for="">?????????</label> <input type="file" id="upload"
											name="upload">

									</div>
									<div class="form-group">
										<label for="previewImg">????????????</label>
										<div>
											<img id="previewImg" src="/user/prod/showThumbnail?
											prodImg=<c:out value="${prodManageVO.prodImg }"/>
											&frstRegistDe=<fmt:formatDate value="${prodManageVO.frstRegistDe }" pattern="yyyy-MM-dd"/>"
											style="width:180px;height:270px;">
										</div>
									</div>
									<div class="form-group">
										<label for="purchaseAt">????????????</label> <select
											class="form-control" id="purchaseAt" name="purchaseAt">
											<option value="Y" ${prodManageVO.purchaseAt == 'Y' ? 'selected' : ''} >
												??????</option>
											<option value="N" ${prodManageVO.purchaseAt == 'N' ? 'selected' : ''} >
												?????????</option>
										</select>
									</div>
								</div>
								<!-- /.box-body -->
							</div>
							<!-- /.box -->

							<!-- /.box-body -->
						</div>
						<!-- /.box -->

						<!-- right column -->
						<div class="col-md-6">
							<!-- general form elements disabled -->
							<div class="box box-warning">
								<div class="box-header with-border">
									<h3 class="box-title">?????? ??????</h3>
								</div>
								<!-- /.box-header -->
								<div class="box-body">

									<div class="form-group">
										<label for="gameRating">????????????</label> <select
											class="form-control" id="gameRating" name="gameRating">
											<option value="all" ${prodManageVO.gameRating == 'all' ? 'selected' : ''} >
												???????????????</option>
											<option value="12+" ${prodManageVO.gameRating == '12+' ? 'selected' : ''} >
												12????????????</option>
											<option value="15+" ${prodManageVO.gameRating == '15+' ? 'selected' : ''} >
												15????????????</option>
											<option value="18+" ${prodManageVO.gameRating == '18+' ? 'selected' : ''} >
												????????? ????????????</option>
										</select>
									</div>
									<div class="form-group">
										<label for="developer">?????????</label> <input type="text"
											class="form-control" id="developer" name="developer"
											value='<c:out value="${prodManageVO.developer }" />'>
									</div>
									<div class="form-group">
										<label for="publisher">????????????</label> <input type="text"
											class="form-control" id="publisher" name="publisher"
											value='<c:out value="${prodManageVO.publisher }" />'>
									</div>
									<div class="form-group">
										<label for="platform">?????????</label> <select class="form-control"
											id="platform" name="platform">
											<option value="Windows" ${prodManageVO.platform == 'Windows' ? 'selected' : ''} >
												Windows</option>
											<option value="Mac OS" ${prodManageVO.platform == 'Mac OS' ? 'selected' : ''} >
												Mac OS</option>
										</select>
									</div>

									 <div class="form-group">
						                <label>?????????</label>
										
						                <div class="input-group">
						                  <div class="input-group-addon">
						                    <i class="fa fa-calendar"></i>
						                  </div>
						                  <input type="text" class="form-control" name="releaseDe" value='<fmt:formatDate value="${prodManageVO.releaseDe }" pattern="yyyy/MM/dd"/>'
						                  	data-inputmask="'alias': 'yyyy/mm/dd'" data-mask>
						                </div>
						              </div>
									
									<div class="form-group">
										<label class="col-sm-12">??????</label>
										<c:forEach items="${genreList }" var="genreVO">
												<div class="col-sm-4">
													<div class="checkbox">
														<label> <input type="checkbox" name="genreCd"
															value="${genreVO.genreCd }" > 
															${genreVO.genreNm }
														</label>
													</div>
												</div>
										</c:forEach>
									</div>

									<div class="form-group">
										<label class="col-sm-12">??????</label>
										<c:forEach items="${featureList }" var="featureVO">
											<div class="col-sm-4">
												<div class="checkbox">
													<label> <input type="checkbox" name="featureCd"
														value="${featureVO.featureCd}" >
														${featureVO.featureNm }
													</label>
												</div>
											</div>
										</c:forEach>
									</div>
									
								</div>
								<!-- /.box-body -->
							</div>
							<!-- /.box -->
						</div>
						<!--/.col (right) -->

						<!-- ckEditor -->
						<div class="col-md-12">
							<div class="box box-info">
								<div class="box-header with-border">
									<h3 class="box-title">?????? ??????</h3>
								</div>
								<textarea id="prodCn" name="prodCn" rows="10" cols="100"><c:out value="${prodManageVO.prodCn }" /></textarea>
							</div>
							<div class="box-footer">
								<button type="submit" class="btn btn-primary">??????</button>
								<button type="button" class="btn btn-danger" id="btnCancle">??????</button>
							</div>
						</div>
					</div>
				</form>
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
	<!-- InputMask -->
	<script src="/plugins/input-mask/jquery.inputmask.js"></script>
	<script src="/plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
	<script src="/plugins/input-mask/jquery.inputmask.extensions.js"></script>
	<!-- bootstrap datepicker -->
	<script
		src="/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
	<!-- Page script -->
	<script>
		$(function () {
			//Datemask dd/mm/yyyy
		    $('#datemask').inputmask('yyyy/mm/dd', { 'placeholder': 'yyyy/mm/dd' })
		    //Money Euro
		    $('[data-mask]').inputmask()
			//Date picker
			$('#datepicker').datepicker({
				autoclose : true
			})
		});
	</script>

	<!-- CKEditor?????? -->
	<script>
		$(document).ready(function() {

			let ckeditor_config = {
				resize_enabled : false,
				enterMode : CKEDITOR.ENTER_BR,
				shiftEnterMode : CKEDITOR.ENTER_P,
				toolbarCanCollapse : true,
				removePlugins : "elementspath",
				filebrowserUploadUrl : "editor/imageUpload"//????????? ???????????? ??????
			};
			CKEDITOR.replace('prodCn', ckeditor_config);

		});
	</script>
	
	<!-- JQuery -->
	<script>
	
		$(document).ready(function(){
			
			//??????????????? ????????????
			function readImage(input){
				if(input.files && input.files[0]){
					
					let imgPath = $("#upload").val();//?????????????????????
					let ext = imgPath.substring(imgPath.lastIndexOf(".")+1).toLowerCase();//???????????????
					
					if(ext == "gif" || ext == "png" || ext == "jpg" || ext == "jpeg"){
						//reader????????????
						const reader = new FileReader();
						//reader?????? ?????? ?????? => ????????? ??????(???????????? ????????? ??????)
						reader.onload = (e) => {
							const previewImage = document.getElementById('previewImg');
							previewImage.src = e.target.result;
						}
						reader.readAsDataURL(input.files[0]);
					}else{
						$("#upload").val("");
						alert("????????? ????????? ???????????????.");
					}
				}
			}
			//?????????????????? ??????
			document.getElementById('upload').addEventListener('change', (e) => {
				readImage(e.target);
			});
		
			//?????????????????? ??????
			let prodGenreCd = '<c:out value="${prodManageVO.genreCd }" />';
			const prodGenreCdArr = prodGenreCd.split(",");
			$("input[name=genreCd]").each(function(index, item){
				let genreCd = $(item).val();
				//????????? ?????? ?????? ?????? ??????
				if(prodGenreCdArr.indexOf(genreCd) > -1){
					$(item).prop("checked", true);
				}
			});
			
			//?????????????????? ??????
			let prodFeatureCd = '<c:out value="${prodManageVO.featureCd }" />';
			const prodFeatureCdArr = prodFeatureCd.split(",");
			$("input[name=featureCd]").each(function(index, item){
				let featureCd = $(item).val();
				//????????? ?????? ?????? ?????? ??????
				if(prodFeatureCdArr.indexOf(featureCd) > -1){
					$(item).prop("checked", true);
				}
			});
			
			//????????????
			$("#btnCancle").on("click", function(){
				location.href = "/user/prod/list";
			});
			
		});
	
	</script>
</body>
</html>