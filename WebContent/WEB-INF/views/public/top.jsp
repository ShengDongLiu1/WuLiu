<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>宏图物流有限公司</title>
<link href="style/css.css" rel="stylesheet" type="text/css" />
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
							<td width="300" height="20" align="center" ><a href="<%=path%>/customer/personal"><font size="5">欢迎<font color="red">${customer.cemail }</font></a>登录</font></td>
							<td width="160" height="20" align="center" ><font size="5"><a tabindex="-1" href="<%=path %>/customer/klogout" target="_top">Logout</a></font></td>
							<td width="70" align="center" class="td2"><a href="<%=basePath %>customer/revise">修改密码</a></td>
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
	<tr>
		<td width="10">&nbsp;</td>
		<td width="900"><object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0' width='900' height='260'><param name='movie' value='image/logo.swf'><param name='quality' value='high'><param name='wmode' value='transparent'><embed src='<%=basePath %>image/logo.swf' width='900' height='260' quality='high' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' wmode='transparent'></embed></object></td>
		<td width="10">&nbsp;</td>
	</tr>
</table>
</body>
</html>