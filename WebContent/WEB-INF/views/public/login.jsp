<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String path=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>宏图物流登录</title>
<link type="text/css" href="<%=path %>/themes/css/v3/reset.css" rel="stylesheet">
<link type="text/css" href="<%=path %>/themes/css/v3/public.css" rel="stylesheet">
<link type="text/css" href="<%=path %>/themes/css/v3/register.css" rel="stylesheet">
<link rel="shortcut icon" href="<%=path %>/favicon.ico" />
<script type="text/javascript">
if(top.location!=self.location)top.location=self.location;
</script>
<script src="<%=path %>/themes/js/jquery.min.js" type="text/javascript"></script>
<script src="<%=path %>/themes/js/jquery.form.js" type="text/javascript"></script>
<script src="<%=path %>/themes/js/json.parse.js" type="text/javascript"></script>
<style>
	.loginad{
		width:580px;
		height:595px;
		position: absolute;
	}
	.loginad .loginadtitle{
		width:100%;
		text-align:center;
		line-height:60px;
		font-size:32px;
		font-family:"幼圆",Microsoft Yahei;
		margin-top:70px;
		color:#FFF;
	}
	.loginad .loginaddes{
		line-height:30px;
		color:#FFF;
		font-family:Microsoft Yahei;
		font-size:16px;
		text-align:center
	}
	.loginad .loginadimg{
		width:100%; 
		height:320px;
		margin-top:40px;
		
	}
	.loginad .loginadbtn{ width:100%; height:40px; margin-top:30px; }
	.loginad .loginadbtn a{ display:block; width:190px; height:40px; margin:0 auto; text-align:center; line-height:40px; font-size:16px; color:#009fe3; font-weight:bold; background:url(<%=path%>/themes/images/v3/btn.png) center center no-repeat;
		-moz-border-radius:6px;
		-khtml-border-radius:6px;
		-webkit-border-radius:6px;
		border-radius:6px;
	}
</style>
</head>
<body>
	
	<div class="login_bg">
		<div class="form">
        	<div class="loginad">
            	<div class="loginadtitle">宏图物流网在线预约API全新发布了</div>
                <div class="loginaddes">通过提供的API实现全国范围内物流、人员信息检索，以及在线下单功能</div>
            </div>
			
			<form name="loginForm" id="login_form" method="post" action="login/ldo">
				<h2><a href="<%=path %>/customer/index">登录宏图物流网</a></h2>
				<div class="div_user">
					<span></span>
					<input name="cemail" class="username" type="text" placeholder="用户名" />
				</div>
				<div class="div_pw">
					<span></span>
					<input name="cpassword" class="pw" type="password" placeholder="密码" />
				</div>
				<div class="">
					<input type="text" class="code" placeholder="验证码" maxlength="4"/>&nbsp;&nbsp;&nbsp;
					<img id="codeimg" src="<%=path%>/yzm/code" onclick="changeImg()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
				<div><input class="login_btn" id="loginBtn" type="button" value="登录" /></div>
                <div style="line-height:30px; text-indent:5px;color:#F30" id="loginTips">&nbsp;</div>
				<h4><a class="#" href="<%=path %>/customer/zc">立即注册</a></h4>
			</form>
		</div>
	</div>
	
	
<!-- footer start -->
<div id="footer" class="clear">
    <h1 >宏图物流网</h1>
    <div class="friendLink clear">
        <a  href="#" target="_blank" title="隐私政策" rel="nofollow">隐私政策</a>
        <a href="#" target="_blank" rel="nofollow">服务条款</a>
        <a href="#" target="_blank" rel="nofollow">关于我们</a>
        <a href="#" target="_blank" rel="nofollow">人员招聘</a>
        <a href="#" target="_blank" rel="nofollow">联系我们</a>
        <a href="#" target="_blank" rel="nofollow">友情链接</a>
    </div>
    <p>宏图物流有限公司©版权所有 赣ICP备140068998</p>
</div>
<script type="text/javascript">
    var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
    document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F5d12e2b4eed3b554ae941c0ac43c330a' type='text/javascript'%3E%3C/script%3E"));
</script>
<!-- footer end -->
<script type="text/javascript">
	var refer='';
	$(document).ready(function(){
		$("#loginBtn").click(function(){
			$("#loginBtn").val('登录中...').attr("disabled","disabled");
			var username = $(".username").val();
			var userpass = $(".pw").val();
			var code = $(".code").val();
				username = $.trim(username);
				userpass = $.trim(userpass);
				code = $.trim(code);
			$("#loginTips").css({display:"none"});	
			
			if(username == ""){
				$("#loginTips").html("请输用户名!").fadeIn();
				$("#loginBtn").val('登录').removeAttr('disabled');
				return false;
			}else if(username.length <4){
				$("#loginTips").html("请输入不小于四位数用户名!").fadeIn();
				$("#loginBtn").val('登录').removeAttr('disabled');
				return false;
			}else if(userpass == ''){
				$("#loginTips").html("请输入密码!").fadeIn();
				$("#loginBtn").val('登录').removeAttr('disabled');
				return false;
			}else if(code == ''){
				$("#loginTips").html("请输入验证码!").fadeIn();
				$("#loginBtn").val('登录').removeAttr('disabled');
				return false;
			}else if(code.length < 4){
				$("#loginTips").html("请输入四位数验证码!").fadeIn();
				$("#loginBtn").val('登录').removeAttr('disabled');
				return false;
			}else{
				$.post("<%=path%>/customer/customerLogin",{'cemail':username,'cpassword':userpass,'code':code},function(index){
					if(index.success == 'admin'){
						window.location.href="<%=path%>/user/index";
					}else if(index.success == 'customer'){
						window.location.href="<%=path%>/customer/index";
					}else{
						$("#loginTips").html(index.result).fadeIn();
						$("#loginBtn").val('登录').removeAttr('disabled');
					}
				},"json");
			}
		})		
	})
	
	//按下回车键登录
	$(function(){
		document.onkeydown = function(e){ 
		    var ev = document.all ? window.event : e;
		    if(ev.keyCode==13) {

		    	$("#loginBtn").click();

		     }
		}
	}); 
	//点击验证码 更换
	function changeImg() {  
		var code=document.getElementById("codeimg");
		code.src="<%=path%>/yzm/code?"+Math.random();
    }
</script>
</body>
</html>