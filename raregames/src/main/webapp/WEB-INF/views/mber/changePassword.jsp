<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
    <%@include file="/WEB-INF/views/include/header.jsp" %>
    <!-- Header End -->

    <!-- Normal Breadcrumb Begin -->
    <section class="normal-breadcrumb set-bg" data-setbg="/img/normal-breadcrumb2.png">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="normal__breadcrumb__text">
                        <h2>Account</h2>
                        <p>Welcome to the official Anime blog.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Normal Breadcrumb End -->

    <!-- Blog Section Begin -->
     <section class="signup spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="account__form">
                        <h3 style="margin-top:50px;">Change Password</h3>
                        <form method="" action="" id="">
                             <div class="input__item">
                                <input type="password" id="mberPassword" placeholder="New Password" name="mberPassword">
                                <span class="icon_lock"></span>
                            </div>
                             <div class="input__item">
                                <input type="password" id="rePassword" placeholder="Check Password" name="rePassword">
                                <span class="icon_lock"></span>
                            </div>
                       		<input type="hidden" id="mberId" name="mberId" value='<c:out value="${authenMail }" />' >
                            <button type="button" class="site-btn" id="btnChange">Change</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Section End -->

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
	
	<!-- JQuery -->
	<script>
	
		$(document).ready(function(){

          	//Change버튼 클릭시 작동
            $("#btnChange").on("click", function(){
            	let mberId = $("#mberId");
            	let mberPassword = $("#mberPassword");
            	let rePassword = $("#rePassword");
            	console.log(mberId.val());
            	//공백검사
            	if(mberPassword.val() == "" || mberPassword.val() == null){
                    alert("새 비밀번호를 입력하세요.");
                    mberPassword.focus();
                    return;
                }
            	if(rePassword.val() == "" || rePassword.val() == null){
                    alert("새 비밀번호 확인을 입력하세요.");
                    rePassword.focus();
                    return;
                }
            	//비밀번호확인 검사
            	if(mberPassword.val() != rePassword.val()){
            		alert("비밀번호가 일치하지 않습니다.");
           		 	rePassword.focus();
           		 	rePassword.val("");
                    return;
            	}
            	//비밀번호 변경 처리
            	$.ajax({
                    url:"/mber/updatePassword",
                    type:"post",
                    dataType:"text",
                    data:{
                    	mberId: mberId.val(),
                    	mberPassword:  mberPassword.val()
                        },
                    success:function(data){
                        if(data == "success"){
                            alert("비밀번호를 변경하였습니다.");
							location.href = "/mber/login";
                        }else if(data == "update Password Fail"){
                            alert("비밀번호를 변경하는데 실패하였습니다.");
                            return;
                        }
                        
                    }

                });
            	
            });
            
        });
	
	</script>
	
</body>

</html>