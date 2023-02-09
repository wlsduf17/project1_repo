<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<meta name ="google-signin-client_id" content="988245641096-q213ksa4gml6o2n47hepv704kneh7l6e.apps.googleusercontent.com">
</head>

<body>

	<script>
	
		let msg = "${msg }";
		if(msg == "IdIncorrect"){
			 alert("가입되지 않은 아이디 입니다.");
		}else if(msg == "PwIncorrect"){
			alert("비밀번호가 틀립니다.");
		}
	
	</script>
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
                        <h2>Login</h2>
                        <p>Welcome to the Rare Games.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Normal Breadcrumb End -->

    <!-- Login Section Begin -->
    <section class="login spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="login__form">
                        <h3>Login</h3>
                        <form method="post" action="/mber/login2" id="loginForm">
                            <div class="input__item">
                                <input type="text" id="mberId" placeholder="Email address" name="mberId">
                                <span class="icon_mail"></span>
                            </div>
                            <div class="input__item">
                                <input type="password" id="mberPassword" placeholder="Password" name="mberPassword">
                                <span class="icon_lock"></span>
                            </div>
                            <button type="button" class="site-btn" id="btnLogin">Login</button>
                        </form>
                        <a href="/mber/searchPassword" class="forget_pass">Forgot Your Password?</a>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="login__register">
                        <h3>Don’t Have An Account?</h3>
                        <a href="/mber/signup" class="primary-btn">SIGN UP</a>
                    </div>
                </div>
            </div>
<!--             <div class="login__social"> -->
<!--                 <div class="row d-flex justify-content-center"> -->
<!--                     <div class="col-lg-6"> -->
<!--                         <div class="login__social__links"> -->
<!--                             <span>or</span> -->
<!--                             <ul> -->
<!--                                 <li><a href="" class="facebook"><i class="fa fa-facebook"></i> Sign in With Facebook</a></li> -->
<!--                                 <li><a href="" class="google"><i class="fa fa-google"></i> Sign in With Google</a></li> -->
<!--                                 <li><a href="" class="twitter"><i class="fa fa-twitter"></i> Sign in With Twitter</a> -->
<!--                                 </li> -->
<!--                             </ul> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
        </div>
    </section>
    <!-- Login Section End -->

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
	<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
	
	<!-- JQuery -->
	<script>
		
		$(document).ready(function(){
			
			//버튼클릭 로그인
            $("#btnLogin").on("click", function(){
            	login();
            });
            //Enter 클릭시 로그인	
            $("#loginForm").on("keydown", function(key){
            	if(key.keyCode == 13){
            		login();	
            	}
            });
            
			//로그인 함수 
           	let login = function(){
	       		let mberId = $("#mberId");
	            let mberPassword = $("#mberPassword");
	
	            //공백검사
	            if(mberId.val() == "" || mberId.val() == null){
	                alert("아이디를 입력하세요.");
	                mberId.focus();
	                return;
	            }
	            if(mberPassword.val() == "" || mberPassword.val() == null){
	                alert("비밀번호를 입력하세요.");
	                mberPassword.focus();
	                return;
	            }
	
	            //로그인 처리
	            $("#loginForm").submit();
                   
                   //로그인 Ajax처리
//                    $.ajax({
//                        url:"/mber/login",
//                        type:"post",
//                        dataType:"text",
//                        data:{
//                            mberId: mberId.val(),
//                            mberPassword: mberPassword.val()
//                            },
//                        success:function(data){
//                            if(data == "success"){
//                                location.href = "/";
//                            }else if(data == "IdIncorrect"){
//                                alert("가입되지 않은 아이디 입니다.");
//                                mberId.val("");
//                                mberId.focus();
//                                return;
//                            }else if(data == "PwIncorrect"){
//                                alert("비밀번호가 틀립니다.");
//                                mberPassword.val("");
//                                mberPassword.focus();
//                                return;
//                            }
//                        }
//                    });
           	}
			
        });
	
	</script>
	
</body>

</html>