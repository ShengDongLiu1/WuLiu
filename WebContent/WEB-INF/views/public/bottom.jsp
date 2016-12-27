<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>宏图物流有限公司</title>
<link href="<%=path %>/style/css.css" rel="stylesheet" type="text/css" />
</head>

<body>
<table width="920" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td height="10"></td>
	</tr>
</table>
<table width="920" border="0" align="center" cellpadding="0" cellspacing="0" class="td1">
	<tr height="26" align="center">
		<td width="10" bgcolor="#FFFFFF">&nbsp;</td>
		<td width="80">&nbsp;</td>

		
					<td><a href="<%=path %>/customer/index" class="footer1" >网站首页</a></td>
		
					<td>|</td>
		
					<td><a href="<%=path %>/customer/info" class="footer1" >企业介绍</a></td>
		
					<td>|</td>
		
					<td><a href="<%=path %>/customer/management" class="footer1" >经营范围</a></td>
		
					<td>|</td>
		
					<td><a href="<%=path %>/customer/network" >服务网络</a></td>
		
					<td>|</td>
		
					<td><a href="<%=path %>/customer/flow" class="footer1" >业务流程</a></td>
		
					<td>|</td>
					<c:if test="${customer != null}">
						<td><a href="<%=basePath %>message.jsp" class="footer1" >客户留言</a></td>
						<td>|</td>
					</c:if>
					<td><a href="#" class="footer1" >联系我们</a></td>
		

		<td width="80">&nbsp;</td>
		<td width="10" bgcolor="#FFFFFF">&nbsp;</td>
	</tr>
</table>

<table width="920" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr height="54">
		<td width="10">&nbsp;</td>
		<td width="170" align="center">
			<select style="width:150px;" onChange="if (this.options[this.selectedIndex].value != '') window.open(this.options[this.selectedIndex].value, '', '');">
				<option value="">友情链接</option>
				
					<option value="http://www.google.cn/">Google</option>
				
					<option value="http://www.baidu.com/">百度</option>
				
			</select>
		</td>
		<td align="right" style="color:#000;"><span style="font-family:Arial;font-size:10px;">COPYRIGHTS 2016&nbsp;&nbsp;ALL RIGHTS RESERVED</span>&nbsp;&nbsp;版权所有:宏图物流有限公司&nbsp;&nbsp;<a href="http://www.miibeian.gov.cn/" target="_blank" class="footer2">备案号申请中</a>&nbsp;&nbsp;设计制作:<a href="http://hujin619.blog.163.com/" target="_blank" class="footer2">宏图x</a></td>
		<td width="10">&nbsp;</td>
	</tr>
</table>
<table width="920" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="40">
		</td>
	</tr>
</table>
</body>
</html>
