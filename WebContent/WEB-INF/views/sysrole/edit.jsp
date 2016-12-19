<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>编辑角色功能</title>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>assets/jslib/bootstrap/css/bootstrap.css">
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>assets/css/theme.css">
		<link rel="stylesheet"
			href="<%=basePath%>assets/jslib/font-awesome/css/font-awesome.css">
		<script src="<%=basePath%>assets/jslib/jquery-1.7.2.min.js"
			type="text/javascript"></script>


  </head>
  <body class="content1">
		<div class="header">
			<h1 class="page-title">
				编辑角色功能
			</h1>
		</div>

		<ul class="breadcrumb">
			<li>
				<a href="role/list">角色管理</a>
				<span class="divider">/</span>
			</li>
			<li class="active">
				编辑角色功能
			</li>
		</ul>

		<div class="container-fluid">
			<div class="row-fluid">
				<form method="post" action="<%=basePath%>role/update">
					<div class="btn-toolbar">
						<input type="submit" class="btn btn-primary" value="保存 ">
						<a href="<%=basePath%>role/list" class="btn">取消</a>

					</div>

					<div class="well">
						<div class="tab-pane active in">
							<label>
								角色名称：
							</label>
							<input type="hidden" name="roleid" value="${item.roleid}" />
							<input type="text" name="rolename" value="${item.rolename}"/>
							<label>
								角色说明：
							</label>
							<input type="text" name="roledesc" maxlength="20"
								value="${item.roledesc}">
							<label>
								角色状态：
							</label>
							<select name="rolestate">
								<c:choose>
									<c:when test="${item.rolestate==\"1\"}">
									<option value="1" selected="selected">正常</option>
									<option value="0">锁定</option>		
									</c:when>
									<c:otherwise>
									<option value="1">正常</option>
									<option value="0" selected="selected">锁定</option>	
									</c:otherwise>
								</c:choose>
								
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
