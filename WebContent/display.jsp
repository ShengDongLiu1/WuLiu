<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>极速物流服务有限公司</title>
<link href="<%=basePath %>style/css.css" rel="stylesheet" type="text/css" />
</head>
<body>

<jsp:include flush="true" page="top.jsp"></jsp:include>

<table width="920" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr height="35">
		<td width="10">&nbsp;</td>
		<td width="900">
			<img src="<%=basePath %>image/icon_1.gif" width="10" height="9">&nbsp;&nbsp;<a href="">首页</a> &gt; <a href="">产品中心</a> &gt; <a href="">物流车辆</a>
			
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
					<td align="center" class="title1">物流车辆</td>
				</tr>
			</table>

			<table width="88%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr height="20">
					<td></td>
				</tr>
				
				<tr>
					<td class="content1">
						
								<table align="center" width="0" border="0" cellspacing="5" cellpadding="">
									<tr>
										<td><img src="<%=basePath %>image/200712643685265.jpg"  onload="if (this.width > 800) this.width = 800;"></td>
									</tr>
								</table>
						
					</td>
				</tr>
				<tr height="30">
					<td></td>
				</tr>
			</table>

		</td>
		<td width="10">&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td align="center" valign="top">
			<table width="90%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="1" background="images/line_point2.gif"></td>
				</tr>
				<tr>
					<td height="30" align="right"><a href="#"><img src="<%=basePath %>image/bt_up.gif" width="27" height="11" border="0"></a></td>
				</tr>
				<tr>
					<td align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td>&nbsp;</td>
	</tr>
</table>


</body>
<jsp:include flush="true" page="bottom.jsp"></jsp:include>
</html>
