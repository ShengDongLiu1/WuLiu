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
<link href="<%=path %>/style/css.css" rel="stylesheet" type="text/css" />
 <script src="<%=path %>/register/js/jquery-2.1.0.min.js"></script>
<script language="javascript">
	function check()
	{
		var comtitle = $("#comtitle").val();
		var comtype = $("#comtype").val();
		var comlevel = $("#comlevel").val();
		var comsysuser = $("#comsysuser").val();
		var comcontent = $("#comcontent").val();
		var comexpect = $("#comexpect").val();
		var comdescr = $("#comdescr").val();
		var comcusid = $("#comcusid").val();
		if (comtitle == "")
		{
			alert("请输入投诉标题！");
			return false;
		}
		else if (comlevel == "请选择")
		{
			alert("请选择投诉程度！");
			return false;
		}
		else if (comtype == "请选择")
		{
			alert("请选择投诉类型！");
			return false;
		}
		else if(comsysuser == "")
		{
			alert("请输入员工编码");
			return false;
		}
		else if(comcontent == "")
		{
			alert("请输入投诉内容");
			return false;
		}
		else if(comexpect == "")
		{
			alert("请输入期望结果");
			return false;
		}
		else if(comdescr == "")
		{
			alert("请输入备注说明");
			return false;
		}else{
			var comtitle = $("#comtitle").val();
			var comtype = $("#comtype").val();
			var comlevel = $("#comlevel").val();
			var comsysuser = $("#comsysuser").val();
			var comcontent = $("#comcontent").val();
			var comexpect = $("#comexpect").val();
			var comdescr = $("#comdescr").val();
			var comcusid = $("#comcusid").val();
		  $.post("${pageContext.request.contextPath}/complaints/addcomplaints", {
			  comtitle : comtitle,comtype : comtype,comlevel : comlevel,comsysuser : comsysuser
			  ,comcontent : comcontent,comexpect : comexpect,comdescr : comdescr,comcusid : comcusid
               }, function(result) {
                   if (result.success=='true1') {
                       alert("系统提示,"+"投诉成功");
                   } else {
                       alert("系统提示,"+"员工编码不正确！");
                   }
               }, "json");
		  
		}
		$("#comtitle").val("");
		$("#comtype").val("请选择");
		$("#comlevel").val("请选择");
		$("#comsysuser").val("");
		$("#comcontent").val("");
		$("#comexpect").val("");
		$("#comdescr").val("");
		$("#comcusid").val("");
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
			<img src="image/icon_1.gif" width="10" height="9">&nbsp;&nbsp;<a href="">首页</a> &gt; <a href="">客户反馈</a>
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
					<td align="center" class="title1">客户反馈</td>
				</tr>
			</table>

			
				<table width="90%" border="0" cellspacing="0" cellpadding="0">
					<tr height="20">
						<td></td>
					</tr>
				</table>
				<table width="90%" border="0" cellspacing="0" cellpadding="0" class="messageBorder">
					<tr>
						<td align="center" valign="top">
							<table width="98%" border="0" cellspacing="0" cellpadding="0">
								<tr height="25">
									<td width="15"><img src="image/icon_2.gif" width="11" height="11"></td>
									<td align="left" class="messageContent1">olina：</td>
								</tr>
								<tr>
								
									<td>&nbsp;</td>
									<td align="left" class="messageContent1">我想了解一下,你们公司的最新行业价格!</td>
								</tr>
								<tr height="20">
									<td></td>
									<td></td>
								</tr>
								<tr height="25">
									<td><img src="image/icon_3.gif" width="11" height="11"></td>
									<td align="left" class="messageContent2">管理员：</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td align="left" class="messageContent2"><P>您好!感谢您对本网站的关注,我们会尽快与您取得电话联系!</P></td>
								</tr>
								<tr height="20">
									<td></td>
									<td></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			

			<table width="90%" border="0" cellpadding="0" cellspacing="0">
				<tr height="30">
					<td align="right"></td>
				</tr>
			</table>

			
		<form name="form1" method="post"  >
				<table width="90%" border="0" cellspacing="0" cellpadding="0">
					

					<tr height="30">
						<td align="right">投诉标题：</td>
						<td align="left"><input name="comtitle" id="comtitle" type="text" size="10" maxlength="30" class="input2"></td>
						<input name="comcusid" id="comcusid" type="hidden" value="${customer.cemail }"/>
					</tr>
					<tr height="30">
						<td align="right">投诉类型：</td>
						<td align="left">
							<select name="comtype" id="comtype" class="input2"  style="width:90px">
							<option value="请选择" selected = "selected">请选择</option>
							<option value="生产类投诉">生产类投诉</option>
							<option value="销售类投诉">销售类投诉</option>
							<option value="品质类投诉">品质类投诉</option>
							<option value="采购类投诉">采购类投诉</option>
							<option value="物流类投诉">物流类投诉</option>
							<option value="其他投诉">其他投诉</option>
						</select>
						</td>
					</tr>
					
					<tr height="30">
						<td align="right">投诉程度：</td>
						<td align="left">
						<select name="comlevel" id="comlevel" class="input2"  style="width:90px">
							<option value="请选择" selected = "selected">请选择</option>
							<option value="普通">普通</option>
							<option value="紧急">紧急</option>
							<option value="非常紧急">非常紧急</option>
						</select>
						</td>
					</tr>
					<tr height="30">
						<td align="right">投诉工号：</td>
						<td align="left"><input name="comsysuser" id="comsysuser"  size="10" maxlength="30" class="input2"></input></td>
					</tr>
					<tr height="30">
						<td align="right">留言内容：</td>
						<td align="left"><textarea name="comcontent" id="comcontent"  cols="50" rows="8" class="input2"></textarea></td>
					</tr>
					<tr height="30">
						<td align="right">期望结果：</td>
						<td align="left"><textarea name="comexpect" id="comexpect" cols="50" rows="3" class="input2"></textarea></td>
					</tr>
					<tr height="30">
						<td align="right">备注说明：</td>
						<td align="left"><textarea name="comdescr" id="comdescr" cols="50" rows="3" class="input2"></textarea></td>
					</tr>
					<tr height="40">
						<td></td>
						<td align="left">
							<input type="button" value="发送 " onclick="check();">&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="reset" value=" 重填 ">
						</td>
					</tr>
				</table>
			</form>
			


			<table width="90%" border="0" cellpadding="0" cellspacing="0">
				<tr height="40">
					<td></td>
				</tr>
			</table>

		</td>
		<td width="10">&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td align="center" valign="top">
			<table width="97%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="1" background="images/line_point2.gif"></td>
				</tr>
				<tr>
					<td height="30" align="right"><a href="#"><img src="image/bt_up.gif" width="27" height="11" border="0"></a></td>
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
