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
		<link rel="stylesheet" type="text/css" href="<%=basePath %>js/jquery-easyui/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=basePath %>js/jquery-easyui/themes/icon.css">
		<script type="text/javascript" src="<%=basePath %>js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/jquery-easyui/jquery.easyui.min.js"></script>

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
	<body class="easyui-layout">
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
								<a tabindex="-1" href="<%=basePath%>QRcode.jsp?user=${user.username}">生成二维码</a>
							</li>
						</ul>
					</li>

				</ul>
				<a class="brand" href="#"><span class="first">欢迎使用</span> <span
					class="second">宏图物流仓库管理系统</span> </a>
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
									<a href="javascript:;" onclick="addTab('${child.funname}','<%=basePath%>${child.funurl}')">${child.funname}</a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</c:if>
			</c:forEach>
<!-- 			<object type="application/x-shockwave-flash" style="outline:none;" data="http://cdn.abowman.com/widgets/hamster/hamster.swf?" width="240" height="240"><param name="movie" value="http://cdn.abowman.com/widgets/hamster/hamster.swf?"></param><param name="AllowScriptAccess" value="always"></param><param name="wmode" value="opaque"></param></object>
 -->
		</div> 
	 	<div class="content">
			<div id="tabs" class="easyui-tabs" style="height: 100%;">
				<div title="主页" style="padding:10px;">
				<iframe name="main" height="600px" width="100%" scrolling="auto"
					frameborder="0" src="<%=basePath%>user/welcome">

				</iframe>
				</div>
			</div>
		</div> 	
		
		<script src="<%=basePath%>assets/jslib/bootstrap/js/bootstrap.js"></script>
		<script type="text/javascript">
		function addTab(title, url){
			if($("#tabs").tabs("exists",title)){//exists:表示去判断指定的title的tab选项卡是否已经打开
			 $("#tabs").tabs("select",title);//如果tab选项卡已经打开过，则直接显示该选项卡			
			}else {
				$("#tabs").tabs("add",{
					title:title, //指定标题
					content:tabContent(url),
					border:false,
					closable:true //选项卡是否可以被关闭
				});
			}
		}
		
		function tabContent(url) {
			return '<iframe scrolling="true"  name="main" frameborder="0" src="' + url + '" style="width:100%;height:100%;"></iframe>';
		}
		</script>
	</body>
</html>