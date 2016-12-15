<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en-US">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta name="keywords" content="网站模板,登录页面模板,登陆页面模板,登录界面模板,登录页面表单验证">
<meta name="description" content="登录宏图物流网提供大量的登录页面模板的学习和下载">
<link type="text/css" href="<%=path %>/themes/css/v3/reset.css" rel="stylesheet">
<link type="text/css" href="<%=path %>/themes/css/v3/public.css" rel="stylesheet">
<link type="text/css" href="<%=path %>/themes/css/v3/register.css" rel="stylesheet">

<!-- bootstrap -->
<!-- 新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">

<!-- 可选的Bootstrap主题文件（一般不用引入） -->
<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap-theme.min.css">

<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="http://cdn.bootcss.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
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
	.loginad .loginadbtn a{ display:block; width:190px; height:40px; margin:0 auto; text-align:center; line-height:40px; font-size:16px; color:#009fe3; font-weight:bold; background:url(/themes/images/v3/btn.png) center center no-repeat;
		-moz-border-radius:6px;
		-khtml-border-radius:6px;
		-webkit-border-radius:6px;
		border-radius:6px;
	}
</style>
</head>
<body>
	<div id="header">
		<div class="header">
			<h1 class="png_bg">登录宏图物流网</h1>
		<a href="<%=basePath%>index.jsp" class="nav2" ><button type="button" class="btn btn-warning">返回首页</button></a>
		</div>
	</div>	
	
	<div class="login_bg">
		<div class="form">
        	<div class="loginad">
            	<div class="loginadtitle">宏图物流网在线预约API全新发布了</div>
                <div class="loginaddes">通过提供的API实现全国范围内物流、人员信息检索，以及在线预约挂号功能</div>
                <div class="loginadbtn"><a  href="docs/api/id/59" target="_blank">马上查看</a></div>
            </div>
			
			<form name="loginForm" id="login_form" method="post" action="<%=path %>/customer/khlogin">
				<h2>登录宏图物流网</h2>
				<div class="div_user"><span></span><input  name="cemail" class="username" type="text" placeholder="客户名" /></div>
				<div class="div_pw"><span></span><input class="pw" name="cpassword" type="password" placeholder="密码" /></div>
				<div class="div_box">
					<a class="forgetPw" href="forget">忘记密码？</a>
				</div>
				<div><input class="login_btn"  type="submit" value="登录" /></div>
                <div style="line-height:30px; text-indent:5px;color:#F30" id="loginTips">&nbsp;</div>
				<h4>可以使用下面方式登录<a class="#" href="register">立即注册</a></h4>
				<a href="#"><img src="<%=path %>/themes/images/oauth/csdn.png" alt="" /></a>
			</form>
		</div>
	</div>
	
	
<!-- footer start -->
<div id="footer" class="clear">
    <h1 class="png_bg">登录宏图物流网</h1>
    <div class="friendLink clear">
        <a  href="#" target="_blank" title="隐私政策" rel="nofollow">隐私政策</a>
        <a href="#" target="_blank" rel="nofollow">服务条款</a>
        <a href="#" target="_blank" rel="nofollow">关于我们</a>
        <a href="#" target="_blank" rel="nofollow">人员招聘</a>
        <a href="#" target="_blank" rel="nofollow">联系我们</a>
        <a href="#" target="_blank" rel="nofollow">友情链接</a>
    </div>
    <p>上海微一科技有限公司©版权所有 沪ICP备140068998</p>
    <div class="weixin">
        <img src="<%=path %>/themes/images/v3/weiyi_qr.png" alt="" />
        <h3>关注宏图物流科技</h3>
    </div>
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
			username = $.trim(username);
				userpass = $.trim(userpass);
			$("#loginTips").css({display:"none"});	
			
			if(username.length <5){
				//$("#username_tips").html("请输入正确的用户名!").css({display:"block"});
				$("#loginTips").html("请输入正确的用户名!").fadeIn();
				$("#loginBtn").val('登录').removeAttr('disabled');
				return false;
			}
			if(userpass == ''){
				$("#loginTips").html("请输入正确的密码!").fadeIn();
				$("#loginBtn").val('登录').removeAttr('disabled');
				return false;
			}
			
			$("#login_form").ajaxSubmit(function(e){
				var obj  = json_parse(e);
				var code = obj.code;
				if(code == '1')
				{
					//sycSiteLogin();
					if(refer){
						window.location.href = refer;
					}else{
						window.location.href = 'my';
					}
					
				}else if(code == '-1'){
					$("#loginTips").html(obj.info).fadeIn();
					$("#loginBtn").val('登录').removeAttr('disabled');
					return false;
				}else if(code == '-2'){
					$("#loginTips").html(obj.info).fadeIn();
					$("#loginBtn").val('登录').removeAttr('disabled');
					return false;
				}else if(code == '-4'){
					$("#loginTips").html(obj.info).fadeIn();
					$("#loginBtn").val('登录').removeAttr('disabled');
					return false;
				}else{
					$("#loginTips").html(obj.info).fadeIn();
					$("#loginBtn").val('登录').removeAttr('disabled');
					return false;
				}
				
			})

		})
	})
	
	function sycSiteLogin(){
		/* $.get('login/syc',function(e){
			
		}) */
	}
	
	//bind keyCode=13 Event
	$(function(){
		document.onkeydown = function(e){ 
		    var ev = document.all ? window.event : e;
		    if(ev.keyCode==13) {

		    	$("#loginBtn").click();

		     }
		}
	}); 
</script>
</body>
</html>