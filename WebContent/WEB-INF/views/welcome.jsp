<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>欢迎使用后台管理系统</title>
    
	<link rel="stylesheet" type="text/css"
			href="<%=basePath%>assets/jslib/bootstrap/css/bootstrap.css">
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>assets/css/theme.css">
		<link rel="stylesheet"
			href="<%=basePath%>assets/jslib/font-awesome/css/font-awesome.css">
		<script src="<%=basePath%>assets/jslib/jquery-1.7.2.min.js"
			type="text/javascript"></script>


<script type="text/javascript" src="<%=basePath%>assets/jslib/jquery-sj.js"></script>

<script type="text/javascript" src="<%=basePath%>assets/jslib/zzsc.js"></script>
  </head>
  
 <body class="content1">
		<div class="header">
			<h1 class="page-title"> 
				主页
			</h1>
		</div>
		<ul class="breadcrumb">
			
			<li class="active">
				Home
			</li>
		</ul>
		<div class="container-fluid">
			<div class="row-fluid">
				

				
					<div class="span12">
							<div class="hero-unit" style="margin-top:10px;">
							
							<h1 style="padding-left:100px;">
								欢迎使用后台管理系统！
								
							</h1>
					
							</div>
							<div id="zzsc">

  								<canvas id="canvas" width="920" height="400"></canvas>
								
							</div>
					</div>
				
				
			</div>
		</div>
	</body>
</html>
