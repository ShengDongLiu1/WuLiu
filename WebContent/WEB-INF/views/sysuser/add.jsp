<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>编辑用户功能</title>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>assets/jslib/bootstrap/css/bootstrap.css">
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>assets/css/theme.css">
		<link rel="stylesheet"
			href="<%=basePath%>assets/jslib/font-awesome/css/font-awesome.css">
		<script src="<%=basePath%>assets/jslib/jquery-1.8.2.min.js"
			type="text/javascript"></script>
           <script type="text/javascript">
        
        	$(function(){				
				$.ajax({
					type:"post",
					url:"<%=basePath%>user/listrolejson",
					success:function(list){
						$.each(list,function(i,item){
							var role=$("#role");
						
							$("<option></option>").val(item.roleid).html(item.rolename).attr("selected","selected").appendTo(role);
													
					    });
					}
			    });
			
					var usernameflag = false;//用户名
					var usertruenameflag = false;//用户姓名
					var userpwdflag = false;//用户密码
					var userphoneflag = false;//用户电话
				
				
					$("#username").blur(function(e){					
						if($("#username").val()==null || $("#username").val()==""){						
							$("#msg").text("用户名不能为空");
							$("#msg").css("color","red");
							usernameflag = false;
						}else if(($("#username").val()).length<2){
							$("#msg").text("用户名长度至少为2");
							$("#msg").css("color","red");
							usernameflag = false;
						}else{						
							$.ajax({
								url:"<%=basePath%>user/checkusername",
								data:"username="+$("#username").val(),
								type:'post',
								success: function(msg){																								
									if(msg.code==500){
										$("#msg").text(msg.msg);
										usernameflag = false;
									}else if(msg.code==200){
										$("#msg").text(msg.msg);
										$("#msg").css("color","green");
										usernameflag = true;
									}
								}
							});
						}																	
				});	
					
					$("#usertruename").blur(function(e){
						if($("#usertruename").val()==null || $("#usertruename").val()==""){
							$("#usertruenamemsg").text("用户姓名不能为空");	
							$("#usertruenamemsg").css("color","red");
							usertruenameflag = false;					
						}
						else if(($("#usertruename").val().length<2)){
							$("#usertruenamemsg").text("用户姓名长度至少为2");
							$("#usertruenamemsg").css("color","red");
							usertruenameflag = false;
						}else{
							usertruenameflag = true;
							$("#usertruenamemsg").text("");	
							
						}
																					
					});	
					
					
					
					$("#userphone").blur(function(e){
						RegularExp=/^[0-9]{11}$/
						if($("#userphone").val()==null || $("#userphone").val()==""){
							
							$("#userphonemsg").text("用户电话不能为空");	
							$("#userphonemsg").css("color","red");
							userphoneflag = false;					
							
						}else if(isNaN($("#userphone").val())){
							$("#userphonemsg").text("用户电话必须为数字");	
							$("#userphonemsg").css("color","red");
							userphoneflag = false;
						}else if(!RegularExp.test($("#userphone").val())){
							$("#userphonemsg").text("用户电话格式不正确");	
							$("#userphonemsg").css("color","red");
							userphoneflag = false;
						}
						else{
							 userphoneflag = true;
							$("#userphonemsg").text("");	
						
						}
																					
					});	
					
					$("#userpwd").blur(function(e){
						
						if($("#userpwd").val()==null || $("#userpwd").val()==""){
							
							$("#userpwdmsg").text("密码不能为空");	
							$("#userpwdmsg").css("color","red");
							userpwdflag = false;					
							
						}else if(($("#userpwd").val()).length<3){
							$("#userpwdmsg").text("密码长度至少为3");
							$("#userpwdmsg").css("color","red");
							userpwdflag = false;
						}
						else{
							$("#userpwdmsg").text("");	
							userpwdflag = true;
						}
																					
					});	
					
					$("#button").click(function(e){
						
						if(usernameflag && usertruenameflag && userpwdflag){
							
							$("form").submit();
						}
						
					});
			});
        </script>    
  </head>
  <body class="content1">

		<ul class="breadcrumb">
			<li>
				<a href="user/listuser">用户管理</a>
				<span class="divider">/</span>
			</li>
			<li class="active">
				编辑用户功能
			</li>
		</ul>

		<div class="container-fluid">
			<div class="row-fluid">
				<form method="post" action="<%=basePath%>user/add">
					<div class="btn-toolbar">
						<input type="button" id="button" class="btn btn-primary" value="保存 ">
						<a href="<%=basePath%>user/listuser" class="btn">取消</a>

					</div>

					<div class="well">
						<div class="tab-pane active in">
						<input type="hidden" name="userid" value="${item.userid}"/>
							<label>
								用户名：
							</label>
							<input type="text" name="username" value="${item.username}" id="username"/>
							<span id="msg"></span>
							<label>
								用户姓名：
							</label>
							<input type="text" id="usertruename" name="usertruename" value="${item.usertruename}"/>
							<span id="usertruenamemsg"></span>
							<div style="margin-bottom: 10px">
								<label>
									用户性别：
								</label>
								<input id="usersex" name="usersex"   type="radio" name="sex" value="男" checked="checked" /> 男 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input id="usersex" name="usersex"  type="radio" name="sex" value="女" /> 女
							</div>
							<div>
								<label>
									用户电话：
								</label>
							</div>
							<input type="text" id="userphone" name="userphone" value="${item.userphone}"/>
							<span id="userphonemsg"></span>
							<label>
								用户职位：
							</label>
							<select name="uposition">
									<option value="成品库库长" selected="selected">成品库库长</option>
									<option value="总帐组长">总帐组长</option>	
									<option value="仓管组长	" selected="selected">仓管组长</option>
									<option value="仓管员">仓管员</option>	
									<option value="辅工组长">仓管员</option>	
									<option value="辅工组长">辅助工</option>
							</select>
							<label>
								用户密码：
							</label>
							<input type="text" id="userpwd" name="userpwd" value="${item.userpwd}"/>
							<span id="userpwdmsg"></span>
							<label>
								用户状态：
							</label>
							<select name="userstate">
								<option value="1" selected="selected">正常</option>
								<option value="0">锁定</option>		
							</select>
                            
                            <label>
								选择角色：
							</label>
							<select name="roleid" id="role">
                            </select>
							<div style="color: red">
								${msg}
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>
