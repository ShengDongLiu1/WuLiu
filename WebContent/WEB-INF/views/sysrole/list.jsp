<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>角色管理</title>
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
				角色管理
			</h1>
		</div>
		<ul class="breadcrumb">
			<li class="active">
				角色列表
			</li>
		</ul>
		<div class="container-fluid">
			<div class="row-fluid">
				<form class="form-inline" method="post"
					action="<%=basePath%>role/search">
					<input class="input-xlarge" placeholder="角色名称..." name="rolename"
						type="text" value="${param.rolename}">
					<input class="btn icon-search" type="submit" value="查询" />
					<a class="btn btn-primary"
						href="<%=basePath%>role/add"> <i
						class="icon-plus"></i> 增加角色 </a>
				</form>

				<div class="well">
					<table class="table">
						<thead>
							<tr>
								<th>
									角色名称
								</th>
								<th>
									角色说明
								</th>
								<th>
									角色状态
								</th>
								<th style="width: 90px;text-align: center">
									操作
								</th>
							</tr>
						</thead>
						<tbody>
									
							<c:forEach items="${roleList}" var="item">
								<tr>
									<td>
										${item.rolename}
									</td>
									<td>
										${item.roledesc}
									</td>
									<td>
										<c:choose>
											<c:when test="${item.rolestate==\"1\"}">
												正常		
											</c:when>
											<c:otherwise>锁定</c:otherwise>
										</c:choose>
									</td>
									<td>
										<a href="<%=basePath%>role/update?roleid=${item.roleid}">编辑</a>
										
										&ensp;
										<a href="<%=basePath%>role/auth?roleid=${item.roleid}">权限</a>
									</td>
								</tr>
							</c:forEach>
					
						</tbody>
					</table>
					
				</div>
			</div>
		</div>
	</body>
</html>
