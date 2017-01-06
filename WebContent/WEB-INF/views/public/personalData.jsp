<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>宏图物流有限公司</title>
<link href="<%=path %>/style/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=path %>/warehouse/js/jquery-1.8.3.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path %>/warehouse/css/index.css"/>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>assets/css/theme.css">
<link rel="stylesheet"
	href="<%=basePath%>assets/jslib/font-awesome/css/font-awesome.css">
<script type="text/javascript">
$(function(){
	$(".tabBox .tabNav li").click(function(){
		$(this).siblings("li").removeClass("now");
		$(this).addClass("now");
		$(this).parents(".tabBox").find(".tabCont").css("display","none");
		var i=$(this).index();
		$(this).parents(".tabBox").find(".tabCont:eq("+i+")").css("display","block");
		//console.log(i);
	});
})



function getValues(){    
	var message="*请输入值";
	var cname=$("#cname").val();
	var ccompany=$("#ccompany").val();
	var cphone=$("#cphone").val();
	var caddress=$("#caddress").val();

	 var reg = /^0?1[3|4|5|8][0-9]\d{8}$/;
	if(cname == ''){
		$('.error1').html(message);
		return false;
	}else if(ccompany == ''){
		$('.error2').html(message);
		return false;
	}else if(isNaN(cphone)){
		$('.error3').html('*需为数字');
		return false;
	}else if (!reg.test(cphone)) {
		$('.error3').html('*号码有误');
	}else if(caddress == ''){
		$('.error4').html(message);
		return false;
	}
}
$(document).ready(function(){
    $("input").focus(function(){//获取焦点
    	$('.message').html('');
    });
    $("input").blur(function(){//失去焦点
    	getValues();
    });

	var message='${result}';
	if(message != ''){
		$('.title1').html("<span style='color:red;font-size:20px;'>"+message+"</span>");
		window.setInterval(showalert, 3000);
	}
});
function showalert(){ 
	$('.title1').html('我的个人信息');
}
</script>
<style type="text/css">
.autoScroll{  
   width:98%;  
   height:130px;  
   overflow:auto;
   overflow-x:hidden;         
} 
.td{border:solid #add9c0; border-width:0px 0px 1px 0px; padding:10px 0px;text-align:center;}
.table{border:solid #add9c0; border-width:1px 0px 0px 1px; font-size:13px;}

.subpage{
	background:#224762;
	color:white;
	font-size:20px;
	border-radius:5px;
}
.message{color:red;}
</style>
</head>
<body>
<!-- Copyright ?2005. Spidersoft Ltd --><!-- /Copyright ?2005. Spidersoft Ltd -->
<table width="920" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="28"></td>
	</tr>
</table>
<table width="920" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr height="74">
		<td width="10">&nbsp;</td>
		<td valign="bottom"><img src="<%=basePath %>/image/logo.jpg" width="483" height="65"></td>
		<td align="right" valign="bottom">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr height="16">
					<c:choose>
						<c:when test="${empty customer}">
							<td width="70" align="center" class="td1"><a href="<%=basePath %>customer/login""><img src="<%=basePath %>image/bt_top2.gif" width="70" height="22" border="0"></a></td>
							<td width="8">&nbsp;</td>
							<td width="70" align="center" class="td2"><a href="<%=basePath %>customer/zc"><img src="<%=basePath %>image/bt_top1.gif" width="70" height="22" border="0"></a></td>
						</c:when>
						<c:otherwise>
							<td width="300" height="20" align="center" ><font size="5">欢迎<a href="<%=path %>/customer/personal"><font color="red">${customer.cemail }</font></a>登录</font></td>
							<td width="160" height="20" align="center" ><font size="5"><a tabindex="-1" href="<%=path %>/customer/klogout" target="_top">Logout</a></font></td>
						</c:otherwise>
					</c:choose>
				</tr>
			</table>
		</td>
		<td width="10">&nbsp;</td>
	</tr>
</table>

<table width="920" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td height="11"></td>
	</tr>
</table>

<table width="920" border="0" align="center" cellpadding="0" cellspacing="0" class="td1">
	<tr height="32" align="center">
		<td width="10" bgcolor="#FFFFFF">&nbsp;</td>
		<td>&nbsp;</td>
			<td><a href="<%=path %>/customer/index" class="nav2" >网站首页</a></td>
			<td>&nbsp;</td>

			<td><a href="<%=path %>/customer/info" class="nav" >企业介绍</a></td>
			<td>&nbsp;</td>

			<td><a href="<%=path %>/customer/management" class="nav" >经营范围</a></td>
			<td>&nbsp;</td>

			<td><a href="<%=path %>/customer/network" class="nav" >服务网络</a></td>
			<td>&nbsp;</td>

			<td><a href="<%=path %>/customer/flow" class="nav">业务流程</a></td>
			<td>&nbsp;</td>
			
			<c:if test="${customer != null}">
				<td><a href="<%=path %>/customer/message" class="nav" >客户留言</a></td>
				<td>&nbsp;</td>
	
				<td><a href="<%=path %>/customer/warehouse" class="nav" >我的货物</a></td>
				<td>&nbsp;</td>
			</c:if>
		<td width="10" bgcolor="#FFFFFF">&nbsp;</td>
	</tr>
</table>

<table width="920" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td height="3"></td>
	</tr>
</table>


<table width="920" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr height="35">
		<td width="10">&nbsp;</td>
		<td width="900">
			<img src="image/icon_1.gif" width="10" height="9">&nbsp;&nbsp;<a href="">首页</a> &gt; <a href="">个人信息</a>
		</td>
		<td width="10">&nbsp;</td>
	</tr>
</table>


<table width="920" height="500" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td width="10">&nbsp;</td>
		<td align="center" valign="top">
			<table width="90%" border="0" cellspacing="0" cellpadding="0">
				<tr height="35">
					<td align="center" class="title1">我的个人资料</td>
				</tr>
			</table><br></br>
			<!-- jsp代码写在这里 -->
		<div class="box_2 autoScroll" style="height: 430px;">
		   	<div class="tabBox_t" >
		           <div class="tabBox">
		             <ul class="tabNav">
		               <li class="now" >我的资料</li>
		               <li onclick="mygoods(1)">修改资料</li>
		             </ul>
		             <div class="tabCont" style="display:block;">
		               <div class="ctn">
			               		<table style="width: 760px;">
									<tr height="60">
										<td align="right">账号：</td>
										<td align="left"><span class="title1">${customer.cemail}</span></td>
										<td align="right">客户名：</td>
										<td align="left"><span class="title1">${customer.cname}</span></td>
									</tr>
									<tr height="60">
										<td align="right">客户公司：</td>
										<td align="left">
											<span class="title1">${customer.ccompany}</span>
										</td>
										<td align="right">客户电话：</td>
										<td align="left"><span class="title1">${customer.cphone}</span></td>
									</tr>
									<tr height="60">
										<td align="right">客户信用：</td>
										<td align="left"><span class="title1">${customer.ccredit}</span></td>
										<td align="right">客户地址：</td>
										<td align="left"><span class="title1">${customer.caddress}</span></td>
									</tr>
									
			               		</table>
		               	
							
		               </div>
		             </div>
		             <div class="tabCont" >
		               <div class="ctn">
		               		<form action="<%=path %>/customer/update" method="post">
			               		<table style="width: 760px;">
									<tr height="60">
										
										<td align="right">客户名称：</td>
										<td align="left"><input name="cname" type="text" id="cname" placeholder="${customer.cname}" /><span class="message error1"></span></td>
										<td align="right">客户公司：</td>
										<td align="left"><input name="ccompany" type="text" id="ccompany" placeholder="${customer.ccompany}" /><span class="message error2"></span></td>
									</tr>
									<tr height="60">
										<td align="right">客户电话：</td>
										<td align="left">
											<input name="cphone" type="text" id="cphone" placeholder="${customer.cphone}" />
											<span class="message  error3"></span>
										</td>
										<td align="right">客户地址：</td>
										<td align="left">
											<input name="caddress" type="text" id="caddress" placeholder="${customer.caddress}" />
											<span class="message  error4"></span>
										</td>
										<td align="left">
											<input name="cid" type="hidden" id="cid" value="${customer.cid}"/>
										</td>
										
									<tr align="center">
										<td colspan=4 align="center"><input type="submit" value="保    存" class="subpage" onclick="return getValues();"/></td>
									</tr>
			               		</table>
		               		</form>
		               </div>
		             </div>
		           </div>
		       </div>
		   </div>
		</td>
	</tr>
</table>
<jsp:include flush="true" page="bottom.jsp"></jsp:include>
</body>
</html>
