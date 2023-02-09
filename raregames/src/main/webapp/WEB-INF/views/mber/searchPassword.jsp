<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                        <h3>Did you forget the password?</h3>
                        <form method="post" action="./passwordAuthenMail" id="authenMailForm">
                            <div class="input__item">
                                <input type="text" id="mberId" placeholder="Email address" name="mberId">
                                <span class="icon_mail"></span>
                            </div>
                            <button type="button" class="site-btn" id="btnSendMail">Send Mail</button>
                        </form>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="login__register">
                        <h3>Dont’t Have An Account?</h3>
                        <a href="./signup" class="primary-btn">Register Now</a>
                    </div>
                </div>
            </div>
<!--             <div class="login__social"> -->
<!--                 <div class="row d-flex justify-content-center"> -->
<!--                     <div class="col-lg-6"> -->
<!--                         <div class="login__social__links"> -->
<!--                             <span>or</span> -->
<!--                             <ul> -->
<!--                                 <li><a href="#" class="facebook"><i class="fa fa-facebook"></i> Sign in With -->
<!--                                 Facebook</a></li> -->
<!--                                 <li><a href="#" class="google"><i class="fa fa-google"></i> Sign in With Google</a></li> -->
<!--                                 <li><a href="#" class="twitter"><i class="fa fa-twitter"></i> Sign in With Twitter</a> -->
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

	<!-- JQuery -->
	<script>
	
		$(document).ready(function(){

            $("#btnSendMail").on("click", function(){

                let mberId = $("#mberId");

                //공백검사
                if(mberId.val() == "" || mberId.val() == null){
                    alert("아이디를 입력하세요.");
                    mberId.focus();
                    return;
                }

              	//ID 중복여부 체크
                $.ajax({
                    url:"/mber/checkIdDplct",
                    type:"get",
                    dataType:"text",
                    data:{
                    	mberId: mberId.val()	
                    	},
                    success:function(data){
						//미중복 성공 -> 가입되지 않은 회원
                        if(data == "success"){
                            alert("가입되지 않은 메일입니다.");
                            mberId.val("");
                            mberId.focus();
                            return;
                        }else if(data == "IdDupl"){
                            //인증메일전송
                            $.ajax({
                                url:"/mber/sendAuthenMail",
                                type:"get",
                                dataType:"text",
                                data:{mberId: mberId.val()},
                                success:function(data){
                                	//메시지전송 성공 -> passwordAuthenMail화면으로 이동
                                    if(data == "success"){
                                    	alert("인증메일이 발송되었습니다.");
                                    	$("#authenMailForm").submit();
                                    }else{
                                        alert("인증메일 전송실패");
                                        return;
                                    }

                                }

                            });

                        }
                        
                    }

                });

            });

        });
	
	</script>

</body>

</html>