<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
		<td valign="bottom"><img src="<%=basePath %>image/logo.jpg" width="483" height="65"></td>
		<td align="right" valign="bottom">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr height="16">
					<td width="70" align="center" class="td1"><a href="<%=basePath %>customer/login" onClick="this.style.behavior='url(#default#homepage)';this.setHomePage(window.location.href);return(false);" style="BEHAVIOR: url(#default#homepage)"><img src="<%=basePath %>image/bt_top2.gif" width="70" height="22" border="0"></a></td>
					<td width="8">&nbsp;</td>
					<td width="70" align="center" class="td2"><a href="javascript:window.external.AddFavorite(window.location.href, document.title)"><img src="<%=basePath %>image/bt_top1.gif" width="70" height="22" border="0"></a></td>
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

		
					<td><a href="<%=basePath%>index.jsp" class="nav2" >网站首页</a></td>
					<td>&nbsp;</td>
		
					<td><a href="<%=basePath%>info.jsp" class="nav" >企业介绍</a></td>
					<td>&nbsp;</td>
		
					<td><a href="<%=basePath%>management.jsp" class="nav" >经营范围</a></td>
					<td>&nbsp;</td>
		
					<td><a href="<%=basePath%>network.jsp" class="nav" >服务网络</a></td>
					<td>&nbsp;</td>
		
					<td><a href="<%=basePath%>flow.jsp" class="nav">业务流程</a></td>
					<td>&nbsp;</td>
		
					<td><a href="<%=basePath%>message.jsp" class="nav" >客户留言</a></td>
					<td>&nbsp;</td>
		
					<td><a href="<%=basePath%>warehouse.jsp" class="nav" >我的仓储</a></td>
					<td>&nbsp;</td>
		

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