<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 2 | Log in</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="../../bower_components/bootstrap/dist/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../bower_components/font-awesome/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="../../bower_components/Ionicons/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/AdminLTE.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="../../plugins/iCheck/square/blue.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

  <!-- Google Font -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>
<body class="hold-transition login-page">
<script>
	
		let msg = "${msg }";
		if(msg == "IdIncorrect"){
			 alert("가입되지 않은 아이디 입니다.");
		}else if(msg == "PwIncorrect"){
			alert("비밀번호가 틀립니다.");
		}
	
	</script>

<div class="login-box">
  <div class="login-logo">
    <a href=""><b>Login</b></a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <p class="login-box-msg">Sign in to start your session</p>

    <form action="/user/login2" method="post" id="loginForm">
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="User ID" name="userId">
        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="Password" name="userPassword">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="row">
        <div class="col-xs-8">
        </div>
        <!-- /.col -->
        <div class="col-xs-4">
          <button type="button" class="btn btn-primary btn-block btn-flat" name="btnSignIn">Sign In</button>
        </div>
        <!-- /.col -->
      </div>
    </form>

  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 3 -->
<script src="../../bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="../../bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="../../plugins/iCheck/icheck.min.js"></script>
<!-- Jquery -->
<script>

	$(document).ready(function(){
		
		$("button[name=btnSignIn]").on("click", function(){

			$("#loginForm").submit();
			
			
// 			let userId = $("input[name=userId]").val();
// 			let userPassword = $("input[name=userPassword]").val();
// 			$.ajax({
// 				url:"/user/login",
// 				type:"post",
// 				dataType:"text",
// 				data:{
// 					userId: userId,
// 					userPassword: userPassword
// 					},
// 				success:function(data){
// 					if(data == "success"){
// 					location.href = "/user/main";
// 					}else if(data == "IdIncorrect"){
//                         alert("가입되지 않은 아이디 입니다.");
//                         mberId.val("");
//                         mberId.focus();
//                         return;
//                     }else if(data == "PwIncorrect"){
//                         alert("비밀번호가 틀립니다.");
//                         mberPassword.val("");
//                         mberPassword.focus();
//                         return;
//                     }
// 				}
// 			});
			
			
			
		});
		
	});

</script>

</body>
</html>
