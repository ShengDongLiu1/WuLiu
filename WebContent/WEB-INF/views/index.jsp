<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<base target="main" />
		<title>欢迎使用XXXX系统</title>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>assets/jslib/bootstrap/css/bootstrap.css">
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>assets/css/theme.css">
		<link rel="stylesheet"
			href="<%=basePath%>assets/jslib/font-awesome/css/font-awesome.css">
		<script src="<%=basePath%>assets/jslib/jquery-1.7.2.min.js"
			type="text/javascript"></script>
			

<style type="text/css">

#line-chart {
	height: 300px;
	width: 800px;
	margin: 0px auto;
	margin-top: 1em;
}

.brand {
	font-family: georgia, serif;
}

.brand .first {
	color: #ccc;
	font-style: italic;
}

.brand .second {
	color: #fff;
	font-weight: bold;
}
</style>
		<!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
	</head>

	<!--[if lt IE 7 ]> <body class="ie ie6"> <![endif]-->
	<!--[if IE 7 ]> <body class="ie ie7 "> <![endif]-->
	<!--[if IE 8 ]> <body class="ie ie8 "> <![endif]-->
	<!--[if IE 9 ]> <body class="ie ie9 "> <![endif]-->
	<!--[if (gt IE 9)|!(IE)]><!-->
	<body class="">
		<!--<![endif]-->

		<div class="navbar">
			<div class="navbar-inner">
				<ul class="nav pull-right">
					<li id="fat-menu" class="dropdown">
						<a href="#" role="button" class="dropdown-toggle"
							data-toggle="dropdown"> <i class="icon-user"></i>
							${user.usertruename}(${user.sysrole.rolename})  <i class="icon-caret-down"></i>
						</a>

						<ul class="dropdown-menu">
							
							
							<li>
								<a tabindex="-1" class="visible-phone" href="#">Settings</a>
							</li>
							<li class="divider visible-phone"></li>
							<li>
								<a tabindex="-1" href="<%=basePath%>user/logout" target="_top">Logout</a>
								<a tabindex="-1" href="<%=basePath%>QRcode.jsp?user=${user.usertruename}">生成二维码</a>
							</li>
						</ul>
					</li>

				</ul>
				<a class="brand" href="#"><span class="first">欢迎使用</span> <span
					class="second">XXX系统</span> </a>
			</div>
		</div>

		<div class="sidebar-nav">
		
		
			<c:forEach items="${initfun}" var="top">
				<c:if test="${top.funpid==\"-1\"}">
					<a href="#error-menu${top.funid}" class="nav-header collapsed"
						data-toggle="collapse"><i class="icon-briefcase"></i>${top.funname}<i
						class="icon-chevron-up"></i> </a>
					<ul id="error-menu${top.funid}" class="nav nav-list collapse">
						<c:forEach items="${initfun}" var="child">
							<c:if test="${child.funpid==top.funid}">
								<li>
									<a href="<%=basePath%>${child.funurl}">${child.funname}</a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</c:if>
			</c:forEach>
		
		</div>
		<div class="content">
			<iframe name="main" height="600px" width="100%" scrolling="auto"
				frameborder="0" src="<%=basePath%>user/welcome">

			</iframe>
		</div>
		<script src="<%=basePath%>assets/jslib/bootstrap/js/bootstrap.js"></script>
	</body>
</html>