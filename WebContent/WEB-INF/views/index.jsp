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
		<link rel="stylesheet" href="<%=basePath%>style/lock.css">
		
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
.limg{backgroung-color:red;}

.alt{
	width:60%;
	height:41px;
	color:white;
	margin:0 auto;
	line-height:41px;
	font-size:15px;
}
#gundong{
	height:41px;
	width:90%;
	scrollamount:5;
	scrolldelay:10;
	direction:left; 
	hspace:0;
	vspace:0;
}
.look{color:yellow}
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
		<div id="hidebg" oncontextmenu="return false"></div>
		<div id="hidebox" oncontextmenu="return false">
			<div id="loac_title">解锁系统</div>
			<div id="mass">
				<p>系统已锁定,请输入用户密码进行解密</p>
				<input type="password" name="old_password" style="display: none">
				<input type="password" name="old_password" id="lock_inp" placeholder="输入密码" onfocus="clearErr()">&nbsp;
				<a href="javascript:void(0)" onClick="hide();">
					<img src="<%=path%>/images/unlocked.png" alt="解锁" style="width:30px;height:30px;vertical-align:middle"/>
				</a><br />
				<span id="error" style="font-size:18px;color:red;font-weight:bold;"></span>
			</div>
		</div>
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
								<a tabindex="-1" href="javascript:void(0)" onclick="show()" target="_top">锁屏</a>
								<a tabindex="-1" href="<%=basePath%>QRcode.jsp?user=${user.username}">生成二维码</a>
								<a tabindex="-1" href='javascript:void(0)' onclick="openditu()">百度地图名片</a>
							</li>
						</ul>
					</li>

				</ul>
				<a class="brand" href="#">
					<span class="first">欢迎使用</span> 
					<span class="second">宏图物流仓库管理系统</span>
				</a>
				
				<div class="alt" >
					<!-- 文本滚动 -->
					<marquee id="gundong" loop=0 behavior=scroll onmouseover="this.stop()" onmouseout="this.start()">
					 	<span id="mess"></span>
					</marquee>
				</div>
				<div  style="float: right; margin-left: 1000px;" >
					<form action="http://www.baidu.com/baidu" target="_blank">
						<table bgcolor="#FFFFFF">
							<tr>
								<td>
									<input name=tn type=hidden value=baidu>
									<a href="http://www.baidu.com/"><img src="https://gss0.bdstatic.com/70cFsjip0QIZ8tyhnq/img/logo-80px.gif" alt="Baidu" align="bottom" border="0"></a>
									<input class="easyui-validatebox easyui-textbox" type=text name=word style="width: 80px;"  placeholder="百度一下">
									<input type="submit" value="百度搜索" class="easyui-linkbutton" data-options="iconCls:'icon-search',required:false">
								</td>
							</tr>
						</table>
					</form>
				</div>
			<p style="clear: both;"></p>
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
									<a href="javascript:void(0);" onclick="addTab('${child.funname}','<%=basePath%>${child.funurl}')">${child.funname}</a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</c:if>
			</c:forEach>
 			<%-- <object type="application/x-shockwave-flash" style="outline:none;" data="<%=path %>/image/hamster.swf" width="240" height="240"><param name="wmode" value="opaque"></param></object> --%>

		</div> 
	 	<div class="content">
			<div id="tabs" class="easyui-tabs" style="height: 100%;">
				<div title="主页" style="padding:10px;">
				<iframe name="main" height="600px" width="100%" scrolling="auto"
					frameborder="0" src="<%=basePath%>user/welcome">

				</iframe>
				</div>
			</div>
			<input type="hidden" id="refreshed" value="no">
		</div> 	
		
		 <div id="addWin" class="easyui-window" title="地图名片"
             data-options="iconCls:'icon-edit', closable:true, closed:true"
             style="width: 545px; height: 700px; padding: 5px;">
             	<iframe width="504" height="731" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://j.map.baidu.com/4Cmgj"></iframe>
        </div>
		
		<script src="<%=basePath%>assets/jslib/bootstrap/js/bootstrap.js"></script>
		<script src="<%=basePath%>js/Bubbles.js"></script>
		<script type="text/javascript">
		var lockUser='${lockUser}';
		if(lockUser != ''){
			show();
		}
		
		function show()  //显示隐藏层和弹出层	
		{	
			lockUser='lockUser';
			$('#lock_inp').val('');
		   var hideobj=document.getElementById("hidebg");
		   hidebg.style.display="block";  //显示隐藏层
		   hidebg.style.height=document.body.clientHeight+"px";  //设置隐藏层的高度为当前页面高度
		   document.getElementById("hidebox").style.display="block";  //显示弹出层
		   $.post("<%=path%>/user/lock",function(index){},"json");
		}
		
		function hide()  //去除隐藏层和弹出层
		{
			var pwd=$('#lock_inp').val();
			if(pwd == ''){
				$('#error').html('请输入解锁密码！');
				return false;
			}else{
				$.post("<%=path%>/user/unlock",{'pwd':pwd},function(index){
					if(index.result == 'success'){
						lockUser='';
						document.getElementById("hidebg").style.display="none";
						document.getElementById("hidebox").style.display="none";
					}else{
						$('#error').html(index.result);
					}
				},"json");
			}
		}
		
		function addTab(title, url){
			var lockUser='${lockUser}';
			if(lockUser != ''){
				location.reload([true]);
				return false;
			}
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
			
		function clearErr(){
			$('#error').html('');
		}
		
		document.onkeydown = function(e){
			if(window.event && window.event.keyCode == 123) {
				window.event.cancelBubble = true;
	            window.event.returnValue = false;
			}
		}
		
		var sta=1;
		// 移动了就更新最近一次移动的时间。 
		document.onmousemove = function(){ 
			if(lockUser != ''){
				document.getElementById("hidebox").style.display="block";
				noneImg();
			}
			window.lastMove = new Date().getTime();
		}; 
		window.lastMove = new Date().getTime();//最近一次移动时间 
		window.setInterval(function(){//每1秒钟检查一次。 
			var now = new Date().getTime();
			// 如果超时了 
			if( now - lastMove > 5000 ){ 
				// 自己写了撒。 
				if(lockUser != ''){
					document.getElementById("hidebox").style.display="none";
					if(sta == 1){
						Demo();
						sta=0;
					}else{
						lookImg();
					}
				}
			}
			//5分钟无操作自动锁屏
			if( now - lastMove > 500000 ){
				show();
			}
		}, 1000);
		
		function noneImg(){
			$(".boxImg").css("display","none");//隐藏
		}
		
		function lookImg(){
			$(".boxImg").css("display","block");//显示
		}
		
		//按下回车键解锁
		$(function(){
			document.onkeydown = function(e){ 
			    var ev = document.all ? window.event : e;
			    if(ev.keyCode==13) {

			    	hide();

			     }
			}
		}); 
		var MAX = 5;
		var i = 0;
		
		function Demo()
		{
			CreateBubble();
		
			if(++i < MAX){
				setTimeout(Demo, 1000);
			}
		}
		onload=function(){
			var e=document.getElementById("refreshed");
			if(e.value=="no"){
				e.value="yes";
			}else{
				e.value="no";
				location.reload();
			}
		}
		window.setTimeout("message()",5000);
		window.setInterval("message()",300000); 
		function message(){
			if(lockUser != ''){
				return false;
			}
			$.post("<%=path%>/goods/isGoods",function(index){
				if(index.isOrnull){
					$('#mess').html("<img src='<%=path%>/images/notice/new1.gif' width='35' alt='new'>"+index.countNum+"<a href='javascript:void(0)' class='look' onclick=\"addTab('客户订单','<%=path%>/goods/allGood')\">[查看]</a>");
				}
			},"json");
			$.post("<%=path%>/receipt/isReceipt",function(index){
				if(index.isOrnull){
					$('#mess').append("&nbsp;&nbsp;<img src='<%=path%>/images/notice/new2.gif' width='35' alt='new'>"+index.countNum+"<a href='javascript:void(0)' class='look' onclick=\"addTab('质检','<%=path%>/quality/godownEntry')\">[查看]</a>");
				}
			},"json");
			$.post("<%=path%>/inventory/isInventory",function(index){
				if(index.isOrnull){
					$('#mess').append("&nbsp;&nbsp;<img src='<%=path%>/images/notice/new3.gif' width='35' alt='new'>"+index.countNum+"<a href='javascript:void(0)' class='look' onclick=\"addTab('质检','<%=path%>/quality/godownEntry')\">[查看]</a>");
				}
			},"json");
			setTimeout("clearMess()",60000);
		}
		function clearMess(){
			$('#mess').html('');
		}
		
		
		function openditu(){
			   $("#addWin").window("open");
		}
		</script>
	</body>
</html>