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
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Normal Breadcrumb End -->

    <!-- Account Section Begin -->
     <section class="login spad">
        <div class="container">
            <div class="row">
            
            	<!-- 일반 설정 -->
                <div class="col-lg-12">
                    <div class="account__form">
                        <h3>일반 설정</h3>
                        <form method="" action="" id="">
                        	<h5 style="color:white;margin-bottom:20px;">계정 정보</h5>
                            <div class="input__item"><!-- 회원 ID -->
                                <input type="text" id="mberId" placeholder="Email address" name="mberId" value='<c:out value="${mberManageVO.mberId }" />' readonly>
                                <span class="icon_mail"></span>
                            </div>
                            <div class="input__item"><!-- 회원 이름 -->
                                <input type="text" id="mberNm" placeholder="Name" name="mberNm" value='<c:out value="${mberManageVO.mberNm }" />' readonly>
                                <span class="icon_profile"></span>
                            </div>
                            <h5 style="color:white;margin-bottom:20px;">상세 정보</h5>
                            <div class="input__item"><!-- 회원 닉네임 -->
                                <input type="text" id="mberNicknm" placeholder="Nickname" name="mberNicknm" value='<c:out value="${mberManageVO.mberNicknm }" />'>
                                <span class="icon_tag_alt"></span>
                            </div>
                            <div class="input__item"><!-- 휴대폰번호 -->
                                <input type="text" id="mbtlnum" placeholder="Moblie phone Number" name="mbtlnum" oninput="autoHyphen2(this)" value='<c:out value="${mberManageVO.mbtlnum }" />' maxlength="13">
                                <span class="icon_phone"></span>
                            </div>
                            <div class="input__item"><!-- 우편번호 -->
                                <input type="text" id="zip" style="width:50%;" placeholder="ZIP" name="zip" value='<c:out value="${mberManageVO.zip }" />' maxlength="5">
                                <span class="icon_house"></span>
                             	<button type="button" class="site-btn" style="margin-left: 15px;" onclick="sample6_execDaumPostcode()">우편번호찾기</button><!-- 우편번호찾기 버튼 -->
                            </div>
                             <div class="input__item"><!-- 주소 -->
                                <input type="text" id="adres" placeholder="Address" name="adres" value='<c:out value="${mberManageVO.adres }" />'>
                                <span class="icon_house"></span>
                            </div>
                             <div class="input__item"><!-- 상세주소 -->
                                <input type="text" id="detailAdres" placeholder="Detail Address" name="detailAdres" value='<c:out value="${mberManageVO.detailAdres }" />'>
                                <input type="hidden" id="sample6_extraAddress" placeholder="참고항목"><!-- 참고항목 Hidden -->
                                <span class="icon_house"></span>
                            </div>
                            <div><!-- 정보수신여부 -->
                                <input type="checkbox" id="infoReceptAt" name="infoReceptAt" value="Y" <c:out value="${mberManageVO.infoReceptAt == 'Y' ? 'checked' : ''}" /> >
                                <span style="color:white">Agree to receive e-mails related to Rare Games <br>products, news, events, and promotions.</span>
                            </div>
                            <button type="button" class="site-btn" id="btnModify">수정</button>
                        </form>
                    </div>
                </div>
                
                <!-- 비밀번호 변경 -->
                <div class="col-lg-12">
                    <div class="account__form">
                        <h3 style="margin-top:50px;">비밀번호 변경</h3>
                        <form method="" action="" id="">
                             <div class="input__item"><!-- 새 비밀번호 -->
                                <input type="password" id="mberPassword" placeholder="New Password" name="mberPassword">
                                <span class="icon_lock"></span>
                            </div>
                             <div class="input__item"><!-- 새 비밀번호 확인 -->
                                <input type="password" id="rePassword" placeholder="Check Password" name="rePassword">
                                <span class="icon_lock"></span>
                            </div>
                            <button type="button" class="site-btn" id="btnChange">변경</button>
                        </form>
                    </div>
                </div>
                
                <!-- 계정 삭제 -->
                 <div class="col-lg-12">
                    <div class="account__form">
                        <h3 style="margin-top:50px;">계정 삭제</h3>
                            <button type="button" class="site-btn" id="btnDelete">삭제</button>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Account Section End -->

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
	<script>
		
		//전화번호 자동 하이픈
		const autoHyphen2 = (target) => {
			 target.value = target.value
			   .replace(/[^0-9]/g, '')
			  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
			}
	
	</script>
	<!-- JQuery -->
	<script>
	
		$(document).ready(function(){
			//정규표현식
			let nicknameRegex = /^[a-zA-Z가-힣0-9_]{4,12}$/; //4~12자 영문대소문자, 한글, 숫자, 언더바(_)
			let mbtlnumRegex = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/; //휴대전화 정규표현식, -(대쉬) 유무 상관없음.
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
			
            //Modify버튼 클릭시 작동
            $("#btnModify").on("click", function(){
				let mberId = $("#mberId");
                let mberNicknm = $("#mberNicknm");
                let infoReceptAt = $("#infoReceptAt");
                let mbtlnum = $("#mbtlnum");
                let zip = $("#zip");
                let adres = $("#adres");
                let detailAdres = $("#detailAdres");
                
                //공백 & 유효성 검사
                if(checkBlank(mberNicknm, "닉네임을 입력하세요.")){return;}
				if(checkValidate(nicknameRegex, mberNicknm, "잘못된 닉네임 형식입니다.\n4~12자, 영문 대소문자, 한글, _(언더바) 사용가능, 띄어쓰기 불가합니다.")){return;}
                
				if(checkValidate(mbtlnumRegex, mbtlnum, "잘못된 전화번호 형식입니다.")){return;}
				
				//체크박스 Y/N처리
				if(infoReceptAt.is(":checked") == true){
					infoReceptAt.val("Y");			
				}else{
					infoReceptAt.val("");
				}
                
                //회원정보수정 처리
                $.ajax({
                    url:"/mber/updateMber",
                    type:"post",
                    dataType:"text",
                    data:{
                    	mberId : mberId.val(),
                        mberNicknm: mberNicknm.val(),
                        mbtlnum: mbtlnum.val(),
                        zip: zip.val(),
                        adres: adres.val(),
                        detailAdres: detailAdres.val(),
                        infoReceptAt: infoReceptAt.val()
                        },
                    success:function(data){
                        if(data == "success"){
                            alert("계정정보를 수정하였습니다.");
							location.href = "/mber/account";
                        }else if(data == "update Fail"){
                            alert("계정정보를 수정하는데 실패하였습니다.");
                            return;
                        }
                        
                    }

                });

            });
            
          	//Change버튼 클릭시 작동
            $("#btnChange").on("click", function(){
            	let mberId = $("#mberId");
            	let mberPassword = $("#mberPassword");
            	let rePassword = $("#rePassword");
            	//공백 & 유효성 검사
            	if(checkBlank(mberPassword, "비밀번호를 입력하세요.")){return;}
            	if(checkValidate(passwordRegex, mberPassword, "잘못된 비밀번호 형식입니다.\n최소 8자리, 숫자 한개 이상, 문자 한개 이상, 특수문자 한개 이상 사용가능합니다.")){return;}
            	
            	if(checkBlank(rePassword, "새 비밀번호 확인을 입력하세요.")){return;}
            	
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
							location.href = "/mber/account";
                        }else if(data == "update Password Fail"){
                            alert("비밀번호를 변경하는데 실패하였습니다.");
                            return;
                        }
                        
                    }

                });
            	
            });
            
          	//Delete버튼 클릭시 작동
            $("#btnDelete").on("click", function(){
            	let mberId = $("#mberId");
            	//계정삭제 선택창
            	if(confirm("계정을 삭제하시겠습니까?")){
            		//회원탈퇴 처리
            		$.ajax({
                        url:"/mber/deleteMber",
                        type:"post",
                        dataType:"text",
                        data:{
                        	mberId: mberId.val()
                            },
                        success:function(data){
                            if(data == "success"){
                            		alert("계정이 삭제되었습니다.");
                            		location.href = "/";
                            }else if(data == "delete Fail"){
                                alert("계정 삭제에 실패하였습니다.");
                                return;
                            }
                            
                        }

                    });
            		//취소
            	}else{
            		return;
            	}
            	
            });
            
        });
	
	</script>
	
	<!-- 다음 주소 api 추가 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('zip').value = data.zonecode;
	                document.getElementById("adres").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("detailAdres").focus();
	            }
	        }).open();
	    }
	</script>
	
</body>

</html>