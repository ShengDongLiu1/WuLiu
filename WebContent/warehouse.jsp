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
<script type="text/javascript" src="warehouse/js/jquery-1.8.3.min.js"></script>
<link rel="stylesheet" type="text/css" href="warehouse/css/index.css"/>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>assets/css/theme.css">
<link rel="stylesheet"
	href="<%=basePath%>assets/jslib/font-awesome/css/font-awesome.css"></script>
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


<table width="920" height="500" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td width="10">&nbsp;</td>
		<td align="center" valign="top">
			<table width="90%" border="0" cellspacing="0" cellpadding="0">
				<tr height="35">
					<td align="center" class="title1">我的仓储</td>
				</tr>
			</table><br></br>
			<!-- jsp代码写在这里 -->
		<div class="box_2" style="height: 430px;">
		   	<div class="tabBox_t" >
		           <div class="tabBox">
		             <ul class="tabNav">
		               <li>我的仓储</li>
		               <li class="now">添加仓储</li>
		             </ul>
		             <div class="tabCont">
		               <div class="ctn">
							<table class="table table-hover" style="width: 760px;">
								<tr>
									<th>货物编号</th>
									<th>货物订单号</th>
									<th>货物名称</th>
									<th>货物数量</th>
									<th>货物单位</th>
									<th>货物重量</th>
									<th>货物体积</th>
									<th>货物尺寸</th>
									<th>货物等级</th>
									<th>货物描述</th>
									<th>货物状态</th>
								</tr>
								<tr>
									<td>1111</td>
									<td>1111</td>
									<td>1111</td>
									<td>1111</td>
									<td>1111</td>
									<td>1111</td>
									<td>1111</td>
									<td>1111</td>
									<td>1111</td>
									<td>1111</td>
									<td>1111</td>
								</tr>
							</table>
		               </div>
		             </div>
		             <div class="tabCont" style="display:block;">
		               <div class="ctn">
		               		<form action="" method="post">
			               		<table style="width: 760px;">
									<tr height="60">
										<td align="right">货物名称：</td>
										<td align="left"><input name="gname" type="text" size="30" placeholder="请输入货物名称"></td>
										<td align="right">货物数量：</td>
										<td align="left"><input name="gcount" type="text" size="30" placeholder="请输入货物数量"></td>
									</tr>
									<tr height="60">
										<td align="right">货物单位：</td>
										<td align="left">
											<select name="gunit">
												<option>- 请选择货物单位 -</option>
											</select>
										</td>
										<td align="right">货物重量：</td>
										<td align="left"><input name="gweight" type="text" size="30" placeholder="请输入货物重量"></td>
									</tr>
									<tr height="60">
										<td align="right">货物体积：</td>
										<td align="left"><input name="gvolume" type="text" size="20" placeholder="请输入货物体积"></td>
										<td align="right">货物尺寸：</td>
										<td align="left"><input name="gsize" type="text" size="30" placeholder="请输入货物尺寸"></td>
									</tr>
									<tr height="60">
										<td align="right">货物等级：</td>
										<td align="left">
											<select name="ggrade">
												<option>- 请选择货物等级 -</option>
											</select>
										</td>
										<td align="right">货物描述：</td>
										<td align="left"><input name="gdescribe" type="text" size="30" placeholder="请输入货物描述"></td>
									</tr>
									<tr height="60">
										<td align="right">货物状态：</td>
										<td align="left">
											<select name="gstate">
												<option>- 请选择货物状态 -</option>
											</select>
										</td>
									</tr>
									<tr align="center">
										<td colspan=4 align="center"><a href="#">添加</a></td>
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
