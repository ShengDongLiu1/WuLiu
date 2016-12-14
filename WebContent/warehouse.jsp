<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
    
    <%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>宏图物流有限公司</title>
<link href="style/css.css" rel="stylesheet" type="text/css" />
<script language="javascript">
	function check(form)
	{
		if (form.name.value == "")
		{
			alert("请输入您的姓名！");
			form.name.focus();
			return false;
		}
		if (form.content.value == "")
		{
			alert("请输入留言内容！");
			form.content.focus();
			return false;
		}

		return true;
	}
</script>
</head>
<body>
<jsp:include flush="true" page="top.jsp"></jsp:include>


<!-- Copyright ?2005. Spidersoft Ltd --><!-- /Copyright ?2005. Spidersoft Ltd -->
<table width="920" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td height="3"></td>
	</tr>
</table>


<table width="920" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr height="35">
		<td width="10">&nbsp;</td>
		<td width="900">
			<img src="image/icon_1.gif" width="10" height="9">&nbsp;&nbsp;<a href="">首页</a> &gt; <a href="">我的仓储</a>
		</td>
		<td width="10">&nbsp;</td>
	</tr>
</table>


<table width="920" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td width="10">&nbsp;</td>
		<td align="center" valign="top">
			<table width="90%" border="0" cellspacing="0" cellpadding="0">
				<tr height="35">
					<td align="center" class="title1">我的仓储</td>
				</tr>
			</table>
			<!-- jsp代码写在这里 -->
<jsp:include flush="true" page="bottom.jsp"></jsp:include>
</body>
</html>
