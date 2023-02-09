<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                        <form method="post" action="./authenMail" id="signupForm">
                            <div class="input__item">
                                <input type="text" id="mberNm" placeholder="Your Name" name="mberNm">
                                <span class="icon_profile"></span>
                            </div>
                        	<div class="input__item">
                                <input type="text" id="mberNicknm" placeholder="Nickname" name="mberNicknm">
                                <span class="icon_tag_alt"></span>
                            </div>
                            <div class="input__item">
                                <input type="text" id="mberId" placeholder="Email address" name="mberId">
                                <span class="icon_mail"></span>
                            </div>
                            <div class="input__item">
                                <input type="password" id="mberPassword" placeholder="Password" name="mberPassword">
                                <span class="icon_lock"></span>
                            </div>
                            <div>
                                <input type="checkbox" name="infoReceptAt" value="Y">
                                <span style="color:white">I would like to receive news, survey and <br>special offers from Rare Games.</span>
                            </div>
                            <button type="button" id="btnSignup" class="site-btn">Next</button>
                        </form>
                    </div>
                </div>
                 <div class="col-lg-6">
                    <div class="login__register">
                        <h3>Already have an account?</h3>
                        <a href="/mber/login" class="primary-btn">Log In</a>
                    </div>
                </div>
<!--                 <div class="col-lg-6"> -->
<!--                     <div class="login__social__links"> -->
<!--                         <h3>Login With:</h3> -->
<!--                         <ul> -->
<!--                             <li><a href="#" class="facebook"><i class="fa fa-facebook"></i> Sign in With Facebook</a> -->
<!--                             </li> -->
<!--                             <li><a href="#" class="google"><i class="fa fa-google"></i> Sign in With Google</a></li> -->
<!--                             <li><a href="#" class="twitter"><i class="fa fa-twitter"></i> Sign in With Twitter</a></li> -->
<!--                         </ul> -->
<!--                     </div> -->
<!--                 </div> -->
            </div>
        </div>
    </section>
    <!-- Signup Section End -->

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
			//정규표현식
			let emailRegex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; //이메일
			let nameRegex = /^[가-힣]{2,4}$/; //2~4 한글
			let nicknameRegex = /^[a-zA-Z가-힣0-9_]{4,12}$/; //4~12자 영문대소문자, 한글, 숫자, 언더바(_)
			let passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/; //최소8자, 최소하나의 문자, 숫자, 특수문자
			//유효성검사 함수
			let checkValidate = function(regex, target, msg){
				if(!regex.test(target.val())){
					alert(msg);
					target.val("");
					target.focus();
					return true;
				}
				return false;
			}
			//공백검사 함수
			let checkBlank = function(target, msg){
				if(target.val() == "" || target.val() == null){
					alert(msg);
					target.focus();
					return true;
				}
				return false;
			}
			
			//Next 버튼 클릭시 작동
            $("#btnSignup").on("click", function(){
				
                let mberNm = $("#mberNm");
                let mberNicknm = $("#mberNicknm");
                let mberId = $("#mberId");
                let mberPassword = $("#mberPassword");

                //공백 검사 & 유효성검사
                if(checkBlank(mberNm, "이름을 입력하세요.")){return;}
				if(checkValidate(nameRegex, mberNm, "잘못된 이름 형식입니다.\n한글 2~4자 사용가능합니다.")){return;}
				
                if(checkBlank(mberNicknm, "닉네임을 입력하세요.")){return;}
                if(checkValidate(nicknameRegex, mberNicknm, "잘못된 닉네임 형식입니다.\n4~12자, 영문 대소문자, 한글, _(언더바) 사용가능, 띄어쓰기 불가합니다.")){return;}
                
                if(checkBlank(mberId, "메일을 입력하세요.")){return;}
				if(checkValidate(emailRegex, mberId, "잘못된 이메일 형식입니다.")){return;}
                
                if(checkBlank(mberPassword, "비밀번호를 입력하세요.")){return;}
                if(checkValidate(passwordRegex, mberPassword, "잘못된 비밀번호 형식입니다.\n최소 8자리, 숫자 한개 이상, 문자 한개 이상, 특수문자 한개 이상 사용가능합니다.")){return;}
                
            	//닉네임, ID 중복여부 체크
                $.ajax({
                    url:"/mber/checkDplct",
                    type:"get",
                    dataType:"text",
                    data:{
                    	mberNicknm: mberNicknm.val(),
                    	mberId: mberId.val()	
                    	},
                    success:function(data){

						//미중복 성공
                        if(data == "success"){
                            //인증메일전송
                            $.ajax({
                                url:"/mber/sendAuthenMail",
                                type:"get",
                                dataType:"text",
                                data:{mberId: mberId.val()},
                                success:function(data){
                                	//메시지전송 성공 -> authenMail화면으로 이동
                                    if(data == "success"){
                                    	alert("인증메일이 발송되었습니다.");
                                        $("#signupForm").submit();
                                    }else{
                                        alert("인증메일 전송실패");
                                        return;
                                    }
                                }
                            });
                            
                        }else if(data == "IdDupl"){
                            alert("사용중인 메일입니다.");
                            mberId.val("");
                            mberId.focus();
                            return;
                        }else if(data == "NicknmDupl"){
                        	alert("중복된 닉네임입니다.");
                            mberNicknm.val("");
                            mberNicknm.focus();
                            return;
                        }

                    }

                });
            	
            });

        });
	
	</script>
	
</body>

</html>