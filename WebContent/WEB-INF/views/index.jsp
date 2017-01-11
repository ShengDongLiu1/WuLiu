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
		<title>欢迎使用宏图物流仓库管理系统</title>
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
	color: #000;
	font-weight: bold;
}
.limg{backgroung-color:red;}

.alt{
	width:50.5%;
	height:41px;
	color:white;
	margin:0 auto;
	line-height:41px;
	font-size:15px;
	float:right;
}
#gundong{
	height:41px;
	width:100%;
	scrollamount:5;
	scrolldelay:10;
	direction:left; 
	hspace:0;
	vspace:0;
}
.look{color:yellow}

.soner{height:28px;
	line-height:28px;
	padding-left:15px;
	background:#EEEEEE;
	border-bottom:1px solid white;
}

.soner:hover{
	background:#606E89;
	color:white;
	cursor: pointer;
	font-weight:bold;
}

#mess{color:#000}

#xiala a:hover{background:#EEEEEE;}

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
		<!-- 顶部div -->
		<div data-options="region:'north',border:false" style="height:42px;background:#E0ECFF;">
		</div>
		<div class="navbar" style="background:#E0ECFF">
			<ul class="nav pull-right">
				<li id="fat-menu" class="dropdown">
					<a href="#" role="button" class="dropdown-toggle"data-toggle="dropdown">
					<i class="icon-user"></i>
						${user.usertruename}(${user.sysrole.rolename})
					<i class="icon-caret-down"></i>
					</a>

					<ul class="dropdown-menu">
						<li>
							<a tabindex="-1" class="visible-phone" href="#">Settings</a>
						</li>
						<li class="divider visible-phone"></li>
						<li id="xiala">
							<a tabindex="-1" href="<%=basePath%>user/logout" target="_top">Logout</a>
							<a tabindex="-1" href="javascript:void(0)" onclick="show()" target="_top">锁屏</a>
							<a tabindex="-1" href="<%=basePath%>QRcode.jsp?user=${user.ujobnumber}">生成二维码</a>
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
				<div style="width:54%;float:left;height:41px;">
					<marquee id="gundong" loop=0 behavior=scroll onmouseover="this.stop()" onmouseout="this.start()">
					 	<span id="mess"></span>
					</marquee>
				</div>
				<div style="width:230px;height:41px;float:right;">
					<form action="http://www.baidu.com/baidu" target="_blank">
						<a href="http://www.baidu.com/"><img src="https://gss0.bdstatic.com/70cFsjip0QIZ8tyhnq/img/logo-80px.gif" alt="Baidu" align="bottom" border="0"></a>
						<input class="easyui-validatebox easyui-textbox" type=text name=word style="width: 80px;"  placeholder="百度一下">
						<input type="submit" value="百度搜索" class="easyui-linkbutton" data-options="iconCls:'icon-search',required:false">
					</form>
				</div>
				<p style="clear:both"></p>
			</div>
		</div>
		<div data-options="region:'west',split:true,title:'菜单'" style="width:220px;border:0px">
			<div class="easyui-accordion" style="width:100%;border:0px;">
				<c:forEach items="${initfun}" var="top">
					<c:if test="${top.funpid==\"-1\"}">
						<div data-options="title:'${top.funname}', iconCls:'tool_box'" style="overflow:auto;border:0px;">
							<c:forEach items="${initfun}" var="child">
								<c:if test="${child.funpid==top.funid}">
									<div class="soner" onclick="addTab('${child.funname}','<%=basePath%>${child.funurl}')">
										<span>${child.funname}</span>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
		<div data-options="region:'center'" style="border:0px;">
			<div id="tabs" class="easyui-tabs" style="height:100%;">
				<div title="主页">
					<iframe name="main" height="600px" width="100%" scrolling="auto"
						frameborder="0" src="<%=basePath%>user/welcome">
	
					</iframe>
				</div>
			</div>
		</div>
		<div data-options="region:'south',border:false" style="height:35px;background:#E0ECFF;text-align:center;font-size:15px;">版权&copy;</div>
		 <div id="addWin" class="easyui-window" title="地图名片"
             data-options="iconCls:'icon-edit', closable:true, closed:true"
             style="width: 545px; height: 700px; padding: 5px;">
             	<iframe width="504" height="731" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://j.map.baidu.com/4Cmgj"></iframe>
        </div>
		<script type="text/javascript" src="<%=basePath %>js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/jquery-easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
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
				lockUser='lockUser';
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