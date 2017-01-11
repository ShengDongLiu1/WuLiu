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
<script type="text/javascript" src="<%=path %>/js/getCNdate.js"></script>
<script type="text/javascript">showCal();</script>
<style type="text/css">
	.yinli{color:green;font-size:14px;font-weight:bold;float:right;padding-right:13%;}
</style>
</head>
  
 <body class="content1">
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div style="text-align:right;">
						<iframe name="weather_inc" src="http://i.tianqi.com/index.php?c=code&id=1" width="390" height="35" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
					</div>
					<div class="hero-unit" style="padding-top:100px;">
						<h1 style="padding-left:100px;">
							欢迎使用后台管理系统！
						</h1>
			
					</div>
					<!-- <div id="zzsc">

								<canvas id="canvas" width="920" height="1000"></canvas>
						
					</div> -->
				</div>
			</div>
		</div>
	</body>
</html>
