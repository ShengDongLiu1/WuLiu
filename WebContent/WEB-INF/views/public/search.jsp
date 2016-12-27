<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>宏图物流有限公司</title>
<link href="<%=basePath %>style/css.css" rel="stylesheet" type="text/css" />
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
			<img src="<%=basePath %>image/icon_1.gif" width="10" height="9">&nbsp;&nbsp;<a href="">首页</a> &gt; <a href="">企业介绍</a> &gt; <a href="">查询信息</a>
			
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
		<td width="80" align="center" class="font1">企业介绍</td>
		<td width="80" align="center" class="font2">About</td>
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
				<td align="center"><a href="" class="menu01">查询信息</a></td>
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
		<td><P>公司名称：<FONT face=Verdana>宏图物流有限公司<BR>
		  联系电话：110&nbsp; 119 &nbsp;120<BR>总部地址：<FONT face=Verdana>赣州技师学院小红楼2单元302-1</P>
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
					<td align="center" class="title1">查询信息</td>
				</tr>
			</table>


			

				<table width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr height="20">
						<td></td>
					</tr>
					
					<tr align="left">
						<td class="content1">
						
	<!--车型信息  -->
	
	<c:if test="${ !empty pager}">
							<div class="well">
					<table class="table" width="100%" style="text-align: center">
						<thead>
							<tr>
								<th>
									编号
								</th>
								<th>
									车型名称
								</th>
								<th>
									运载单位
								</th>
								
								
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pager.list}" var="item" varStatus="ct">
								<tr>     
									<td>
										${ct.count}
									</td>
									<td>
										${item.carType}
									</td>
									<td>
										${item.loadType}
									</td>
								
									
									
								</tr>
							</c:forEach>
						</tbody>
					</table>
				<c:if test="${  pager.list.size()>0}">
					<div class="page-info">
						<span>当前第${pager.current }页/共${pager.count }条/${pager.total }页</span>
						
						<c:if test="${pager.current gt 1}">
							<a href="<%=basePath%>car/list?current=1">首页</a>
							<a href="<%=basePath%>car/list?current=${pager.current - 1 }">上一页</a>
						</c:if>
						
						<c:if test="${pager.current lt pager.total }">
							<a href="<%=basePath%>car/list?current=${pager.current + 1 }">下一页</a>
							<a href="<%=basePath%>car/list?current=${pager.total }">尾页</a>
						</c:if>
					</div>
				</c:if>
					
				</div>
			</c:if>
			
			
			
			
	<!-- 车型信息 -->
	
	<!-- 车辆信息 -->
	<c:if test="${ !empty carpager}">
	<div class="well">
					<table class="table" width="100%" style="text-align: center">
						<thead>
							<tr>
								<th>
									车辆名称
								</th>
								<th>
									运载量
								</th>
								
								
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${carpager.list}" var="item" varStatus="ct">
								<tr>
									<td>
										${item.carName}
									</td>
									<td>
										${item.busload}
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				<c:if test="${carpager.list.size()>0}">
					<div class="page-info">
						<span>当前第${carpager.current }页/共${carpager.count }条/${carpager.total }页</span>
						
						<c:if test="${carpager.current gt 1 }">
							<a href="<%=basePath%>cartype/list?current=1"">首页</a>
							<a href="<%=basePath%>cartype/list?current=${carpager.current - 1 }">上一页</a>
						</c:if>
						
						<c:if test="${carpager.current lt carpager.total }">
							<a href="<%=basePath%>cartype/list?current=${carpager.current + 1 }">下一页</a>
							<a href="<%=basePath%>cartype/list?current=${carpager.total }">尾页</a>
						</c:if>
					</div>
				</c:if>
					
				</div>
			</c:if>
			
								
				<!-- 车辆信息 -->		
				<c:if test="${carpager.list.size() eq 0 || pager.list.size() eq 0}">
					<h1>没有数据</h1>
				</c:if>
				
								
								
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