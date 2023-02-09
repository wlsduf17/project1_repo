<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                        <h2>Sign Up</h2>
                        <p>Welcome to the Rare Games.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Normal Breadcrumb End -->

    <!-- Signup Section Begin -->
    <section class="signup spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="login__form">
                        <h3>Sign Up</h3>
                        <form method="" action="">
                            <div class="input__item">
                                <input type="text" id="authCode" placeholder="Authentication Code" name="authCode">
                                <span class="icon_lock"></span>
                            </div>
                            <button type="button" id="btnSignup" class="site-btn">Sign Up Now</button>
                        </form>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="login__social__links">
                        <h3>Login With:</h3>
                        <ul>
                            <li><a href="#" class="facebook"><i class="fa fa-facebook"></i> Sign in With Facebook</a>
                            </li>
                            <li><a href="#" class="google"><i class="fa fa-google"></i> Sign in With Google</a></li>
                            <li><a href="#" class="twitter"><i class="fa fa-twitter"></i> Sign in With Twitter</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Signup Section End -->
	
	<!-- Hidden Form Begin -->
	<form method="post" action="./signup" id="signupForm">
		<input type="hidden" name="mberId" value='<c:out value="${signup.mberId }" />' >
        <input type="hidden" name="mberPassword" value='<c:out value="${signup.mberPassword }" />' >
        <input type="hidden" name="mberNm" value='<c:out value="${signup.mberNm }" />' >
        <input type="hidden" name="mberNicknm" value='<c:out value="${signup.mberNicknm }" />' >
        <input type="hidden" name="infoReceptAt" value='<c:out value="${signup.infoReceptAt }" />' >
	</form>
	<!-- Hidden Form End -->
		
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
			
			let authCode = $("#authCode");
			
			//Sign up 버튼 클릭시 작동
			$("#btnSignup").on("click", function(){
				
				//공백검사
				if(authCode.val() == "" || authCode.val() == null){
                    alert("인증코드를 입력하세요.");
                    authCode.focus();
                    return;
                }
				
				//메일인증확인
				$.ajax({
	                url:"/mber/checkAuthCode",
	                type:"get",
	                dataType:"text",
	                data:{authCode: authCode.val()},
	                success:function(data){
						//인증 성공 -> 회원가입처리
	                	if(data == "success"){
	                		alert("회원가입이 완료되었습니다.");
	                		//회원가입처리
	                		$("#signupForm").submit();
	                		
	                	}else if(data = "not Equal"){
	                		alert("인증코드가 일치하지 않습니다.");
	                		authCode.val("");
	                		authCode.focus();
	                		return;
	                	}
	                }

	            });
				
				
			});
			
			
			
        });
		
	</script>
	
</body>

</html>