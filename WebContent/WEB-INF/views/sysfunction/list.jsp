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

		<title>系统功能列表</title>
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
				系统功能管理
			</h1>
		</div>
		<ul class="breadcrumb">
			<li>
				<a href="index.html">Home</a>
				<span class="divider">/</span>
			</li>
			<li class="active">
				功能列表
			</li>
		</ul>
		<div class="container-fluid">
			<div class="row-fluid">
				<form class="form-inline" method="post"
					action="<%=basePath%>function/search">
					<input class="input-xlarge" placeholder="功能名称..." name="funname"
						type="text" value="${param.funname}">
					<input class="btn icon-search" type="submit" value="查询" />
				
						 <a class="btn btn-primary" href="<%=basePath%>function/add"> 
						<i class="icon-plus"></i> 新建顶层功能
					</a>
				</form>

				<div class="well">
					<table class="table">
						<thead>
							<tr>
								<th>
									父功能
								</th>
								<th>
									功能名称
								</th>
								<th>
									功能地址
								</th>
								<th>
									功能状态
								</th>
								<th style="width: 90px;text-align: center">
									操作
								</th>
								<th style="width: 90px;">
									查看
								</th>
							</tr>
						</thead>
						<tbody>
							
							<c:forEach items="${funList}" var="item">
								
								<tr>
									<td>
										${item.funpname}
									</td>
									<td>
										${item.funname}
									</td>
									<td>
										${empty item.funurl?"无":item.funurl}
									</td>
									<td>
										<c:choose>
											<c:when test="${item.funstate==\"1\"}">
												正常		
											</c:when>
											<c:otherwise>锁定</c:otherwise>
										</c:choose>
									</td>
									<td>
										<a href="<%=basePath%>function/update?id=${item.funid}">编辑</a>
										&ensp;
										<a href="<%=basePath%>function/delete?id=${item.funid}">删除</a>
										&ensp;
									
									</td>
									<td>
									<c:if test="${empty item.funurl}">
											<a  href="<%=basePath%>function/addsub?funid=${item.funid}&pfunname=${item.funname}">增加子功能</a>
									</c:if>
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
