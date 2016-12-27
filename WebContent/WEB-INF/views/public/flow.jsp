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
<title>宏图物流有限公司</title>
<link href="<%=path %>/style/css.css" rel="stylesheet" type="text/css" />
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
			<img src="<%=basePath %>image/icon_1.gif" width="10" height="9">&nbsp;&nbsp;<a href="">首页</a> &gt; <a href="">业务流程</a> &gt; <a href="">业务流程</a>
			
		</td>
		<td width="10">&nbsp;</td>
	</tr>
</table>


<table width="920" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td width="10">&nbsp;</td>
		<td width="245" align="center" valign="top">

			<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="20">
		<td width="80" align="center" class="font1">业务流程</td>
		<td width="80" align="center" class="font2">Business process</td>
		<td class="line1">&nbsp;</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="20">
		<td></td>
	</tr>
</table>



		<table width="227" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td align="center"><a href="" class="menu01">业务流程</a></td>
			</tr>
			<tr height="8">
				<td></td>
			</tr>
		</table>

		

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr height="30">
		<td></td>
	</tr>
</table>



<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr height="20">
		<td width="80" align="center" class="font1">联系信息</td>
		<td width="80" align="center" class="font2">Contact</td>
		<td class="line1">&nbsp;</td>
	</tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr height="20">
		<td></td>
	</tr>
	<tr style="line-height:22px;font-family:Arial;">
		<td><P>公司名称：<FONT face=Verdana>宏图物流有限公司</FONT> <BR>
			 联系电话：110&nbsp; 119 &nbsp;120<BR>
			 总部地址：赣州技师学院小红楼2单元302-1</P>
             <P>Q&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q：3838438</P>
             <P>手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 机：13838384384</P></td>
	</tr>
	<tr height="20">
		<td></td>
	</tr>
</table>

		</td>
		<td align="right" valign="top">

			<table width="97%" border="0" cellspacing="0" cellpadding="0">
				<tr height="35">
					<td align="center" class="title1">业务流程</td>
				</tr>
			</table>


			

				<table width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr height="20">
						<td></td>
					</tr>
					
					<tr>
						<td class="content1">
							
									<table align="center" width="0" border="0" cellspacing="5" cellpadding="">
										<tr>
											<td><img src="<%=basePath %>image/200712855189361.gif"  onload="if (this.width > 600) this.width = 600;"></td>
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
		<td>&nbsp;</td>
		<td align="right" valign="top">
			<table width="97%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="1" background="<%=basePath %>images/line_point2.gif"></td>
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

<jsp:include flush="true" page="bottom.jsp"></jsp:include>
</body>
</html>
