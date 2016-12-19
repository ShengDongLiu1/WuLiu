<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	String Path =request.getContextPath();
    	
    %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="<%=Path %>/js/jquery-1.10.2.min.js"></script>

<script type="text/javascript" src="<%=Path %>/js/jquery.qrcode.min.js"></script>

<script>

jQuery(function(){
	jQuery('#output').qrcode("${user.usertruename}");

})
</script>
</head>
<body >
	
	<div id="output"></div>
	<div>请扫描二维码</div>
</body>
</html>
