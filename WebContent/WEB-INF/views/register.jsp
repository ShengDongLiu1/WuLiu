<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en-US">

<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
    <meta charset="utf-8">
    <meta name="keywords" content="jQuery,easyform,form validation,javascript,js,jq,jquery,表单验证,插件">
    <meta name="description" content="jQuery.Easyform表单验证插件">

    <title>注册</title>

    <meta name="description" content="">
    <meta http-equiv="cleartype" content="on">

    <link rel="stylesheet" href="<%=path %>/register/css/platform-1.css">
    <link rel="stylesheet" href="<%=path %>/register/js/easyform/easyform.css">

    <link rel="stylesheet" href="<%=path %>/register/css/tab.css">

    <script src="<%=path %>/register/js/jquery-2.1.0.min.js"></script>
</head>
<body>

<div class="page">

    <div class="header">
        <a class="link title-ani"  data-letters="用户注册">用户注册</a>
        <br>
    </div>

    <div class="form-div">
        <form id="reg-form"  method="post">
            <table>
                <tr>
                    <td>用户名</td>
                    <td><input name="cemail" type="text" id="uid"
                               data-easyform="length:4 16;char-normal;real-time;ajax:ajax_demo(1);"
                               data-message="用户名必须为4—16位的英文字母或数字"
                               data-easytip="position:top;class:easy-blue;" data-message-ajax="用户名已存在!">
                    </td>
                </tr>
                <tr>
                    <td>密码</td>
                    <td><input name="cpassword" type="password" id="psw1" data-easyform="length:4 12;"
                               data-message="密码必须为4—12位"
                               data-easytip="class:easy-blue;"></td>
                </tr>
                <tr>
                    <td>确认密码</td>
                    <td><input name="cpassword2" type="password" id="psw2" data-easyform="length:4 12;equal:#psw1;"
                               data-message="两次密码输入要一致" data-easytip="class:easy-blue;"></td>
                </tr>
            </table>
			<div  style="line-height:30px; margin-left:40px;  text-indent:5px;color:#F30" id="loginTips">&nbsp;</div>
            <div class="buttons" style="margin-top: 50px;">
                <input value="注 册" onclick="doadd()" type="button" style="margin-right:150px; margin-top:6px;">
            </div>
            <br class="clear">
        </form>
    </div>
    
    <div class="footer">
                     立即注册个新用户吧！
    </div>
	
</div>

<script>

   function doadd(){
		   var cemail = $("#uid").val()
	    	var cpassword1 = $("#psw1").val()
	    	var cpassword2 = $("#psw2").val()
			cemail = $.trim(cemail);
		   	cpassword1 = $.trim(cpassword1);
		   	cpassword2 = $.trim(cpassword2);
			$("#loginTips").css({display:"none"});	
			if(cemail == ""){
				$("#loginTips").html("请输用户名!").fadeIn();
				$("#loginBtn").val('登录').removeAttr('disabled');
				return false;
			}else if(cemail.length <4){
				$("#loginTips").html("请输入不小于四位数用户名!").fadeIn();
				$("#loginBtn").val('登录').removeAttr('disabled');
				return false;
			}else if(cpassword1 == ''){
				$("#loginTips").html("请输入密码!").fadeIn();
				$("#loginBtn").val('登录').removeAttr('disabled');
				return false;
			}else if(cpassword1.length <4){
				$("#loginTips").html("请输入不小于四位数的密码!").fadeIn();
				$("#loginBtn").val('登录').removeAttr('disabled');
				return false;
			}else if(cpassword2 == ''){
				$("#loginTips").html("请再次输入密码!").fadeIn();
				$("#loginBtn").val('登录').removeAttr('disabled');
				return false;
			}else if(cpassword2.length <4){
				$("#loginTips").html("请输入不小于四位数的密码!").fadeIn();
				$("#loginBtn").val('登录').removeAttr('disabled');
				return false;
			}else if(cpassword1!=cpassword2){
				$("#loginTips").html("两次密码不一致!").fadeIn();
				$("#loginBtn").val('登录').removeAttr('disabled');
				return false;
			}else{
		    	$.post("<%=path %>/customer/save2",{'cemail':cemail,'cpassword':cpassword1},function(index){
		    		if(index.success ){
		         	  alert("注册成功！");
		         	  window.location.href="<%=path%>/customer/login";
		    		}else{
		    			$("#loginTips").html("该用户已存在!").fadeIn();
						$("#loginBtn").val('登录').removeAttr('disabled');
		    		}
		   		},"json");
			}
   }
    

</script>

</body>
</html>
