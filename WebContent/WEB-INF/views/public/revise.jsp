<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>客户密码修改</title>
  <link rel="stylesheet" type="text/css" href="<%=path %>/style/revise.css">
  <script type="text/javascript">
	function UpdatePwd(){
		/* 清除font标签的数据 */
		document.getElementById("msg1").innerText="";
		document.getElementById("msg2").innerText="";
		document.getElementById("msg3").innerText="";
		var userpwd=document.getElementById("userpwd").value;
		var newUserpwd=document.getElementById("newuserpwd").value;
		var newUserpwd1=document.getElementById("newuserpwd1").value;
		if(userpwd == "" || userpwd == null){
			document.getElementById("msg1").innerText="请输入原密码~";
			return false;
		}
		if(userpwd != "${user.userpwd}"){
			document.getElementById("msg1").innerText="原密码错误~";
			return false;
		}
		if(newUserpwd == "" || newUserpwd == null){
			document.getElementById("msg2").innerText="请输入新密码~";
			return false;
		}
		if(newUserpwd1 == "" || newUserpwd1 == null){
			document.getElementById("msg3").innerText="请确认新密码~";
			return false;
		}
		if(newUserpwd == "${user.userpwd}"){
			document.getElementById("msg2").innerText="新密码与旧密码不能相同~";
			return false;
		}
		if(newUserpwd != newUserpwd1){
			document.getElementById("msg3").innerText="两次输入的密码不一致~";
			return false;
		}
		if(newUserpwd == newUserpwd1){
			alert("修改成功.........     下次登录后有效");
			$("#update_form").submit();
		}
	}
</script>
  
</head>
<body>
  <div class="container">
    <div class="login">
      <h1>客户密码修改</h1>
      <form id="update_form" method="post" action="<%=path %>/customer/updatePwd">
      	<input type="hidden" name="userid" value="${user.userid}" readonly="readonly">
        <p><input type="text" name="username" id="username" value="${user.username}" readonly="readonly"></p>
        <p><input type="password" name="userpwd" id="userpwd" value="" placeholder="请输入原密码"></p>
		<div style="height:10px; font-size:18px ; text-align:center"><font id="msg1" color="red"></font></div>
		
		<p><input type="password" name="newUserpwd" id="newuserpwd" value="" placeholder="请输入新密码"></p>
		<div style="height:10px; font-size:18px ; text-align:center"><font id="msg2" color="red"></font></div>
		
		<p><input type="password" name="newUserpwd1" id="newuserpwd1" value="" placeholder="请确认新密码"></p>
        <div style="height:10px; font-size:18px ; text-align:center"><font id="msg3" color="red"></font></div>
        
        <p class="submit"><input type="submit" id="btn5" name="commit" value="确认修改" onclick="return UpdatePwd();"></p>
      </form>
    </div>
  </div>
</body>
</html>