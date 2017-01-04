<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>宏图物流有限公司</title>
<link href="<%=path %>/style/css.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="<%=path %>/warehouse/css/index.css"/>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>assets/css/theme.css">
<link rel="stylesheet"
	href="<%=basePath%>assets/jslib/font-awesome/css/font-awesome.css">
<script type="text/javascript" src="<%=path %>/js/region_select.js"></script>
<script type="text/javascript" src="<%=path %>/warehouse/js/jquery-1.8.3.min.js"></script>
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

/**
 * 我的所有订单
 */
function mygoods(pa){
	var page=1;
	var addpage=0;
	if(pa == 2){//上一页
		addpage=$("#page").html();
		page=parseInt(addpage)-1;
		if(page == 0){
			page=1;
			alert("当前页已经是第一页");
		}
	}else if(pa == 3){//下一页
		addpage=$("#page").html();
		page+=parseInt(addpage);
		if(parseInt($("#count").html())<page){
			page=parseInt($("#count").html());
			alert("当前页已经是最后一页");
		}
	}
	$(".addtr").remove();
	$.post("<%=path%>/goods/myGoods",{'page':page,'rows':4},function(index){
		 var tbody = ""; 
		$.each(index.listGoods,function(n,value){
	        var trs = "";  
            trs += " <tr class='addtr'> "+
            "<td class='td'> " +value.gordernumber+ " </td> "+
            "<td class='td'>" + value.gname +"</td> "+
            "<td class='td'>" + value.gcount +"</td> "+
            "<td class='td'>" + value.gunit +"</td> "+
            "<td class='td'>" + isNull(value.gweight) +"</td> "+
            "<td class='td'>" + isNull(value.gvolume) +"</td> "+
            "<td class='td'>" + isNull(value.gsize) +"</td > "+
            "<td class='td'>" + value.ggrade +"</td > "+
            "<td class='td'> <p style='width:65px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;' title="+value.gdescribe+">" + value.gdescribe +"</p></td> "+
            "<td class='td'>" + goodsState(value.gstate) +"</td> "+
            "<td class='td'> "+formatDateTime(new Date(value.gorderstime))+" </td>"+
            " </tr>";  
            tbody += trs;         
        });  
        $(".mygoods").append(tbody);  
	    $("#page").html(index.page);
	    $("#count").html(index.count);
	    $("#total").html(index.total);
	},"json");
}

/* 如果为空 */
function isNull(val){
	if(val == '' || val == null){
		return '未知';
	}else{
		return val;
	}
}

function goodsState(state){
	if(state == '1'){
		return "<span class='dai'>待揽收</span>";
	}else if(state == '2'){
		return "<span class='yi'>已揽收</span>";
	}else if(state == '3'){
		return "<span class='ju'>已拒收</span>";
	}
}

/* 将Thu Mar 19 2015 12:00:00 GMT+0800 (中国标准时间)转换为2015-3-19 12:00:00 */
var formatDateTime = function (date) {  
    var y = date.getFullYear();  
    var m = date.getMonth() + 1;  
    m = m < 10 ? ('0' + m) : m;  
    var d = date.getDate();  
    d = d < 10 ? ('0' + d) : d;  
    var h = date.getHours();  
    var minute = date.getMinutes();  
    minute = minute < 10 ? ('0' + minute) : minute;  
    return y + '-' + m + '-' + d+' '+h+':'+minute;  
};

function getValues(){
	var message="*请输入值";
	var gname=$("#gname").val();
	var gcount=$("#gcount").val();
	var gunit=$("#gunit option:selected").val();
	var ggrade=$("#ggrade option:selected").val();
	var gconsignee=$("#gconsignee").val();
	var greaddress=$("#greaddress").val();
	var grephone=$("#grephone").val();
	var gorigin=$("#gorigin").val();
	var gendpoint=$("#gendpoint").val();
	var gdescribe=$("#gdescribe").val();
	 var reg = /^0?1[3|4|5|8][0-9]\d{8}$/;
	if(gname == ''){
		$('.error1').html(message);
		return false;
	}else if(gcount == ''){
		$('.error2').html(message);
		return false;
	}else if(gcount < 1){
		$('.error2').html('*数值有误');
		return false;
	}else if(gunit == ''){
		$('.error3').html(message);
		return false;
	}else if(ggrade == ''){
		$('.error7').html(message);
		return false;
	}else if(gconsignee == ''){
		$('.error8').html(message);
		return false;
	}else if(greaddress == ''){
		$('.error9').html(message);
		return false;
	}else if(grephone == ''){
		$('.error10').html(message);
		return false;
	}else if (!reg.test(grephone)) {
		$('.error10').html('*号码有误');
		return false;
	}else if(gdescribe == ''){
		$('.error13').html(message);
		return false;
	}
}
$(document).ready(function(){
    $("input").focus(function(){//获取焦点
    	$('.message').html('');
    });
    $("input").blur(function(){//失去焦点
    	getValues();
    });

	var message='${result}';
	if(message != ''){
		$('.title1').html("<span style='color:red;font-size:20px;'>"+message+"</span>");
		window.setInterval(showalert, 3000);
	}
});
function showalert(){ 
	$('.title1').html('我的货物订单');
}
</script>
<style type="text/css">
.autoScroll{  
   width:98%;  
   height:130px;  
   overflow:auto;
   overflow-x:hidden;         
} 
.td{border:solid #add9c0; border-width:0px 0px 1px 0px; padding:10px 0px;text-align:center;}
.table{border:solid #add9c0; border-width:1px 0px 0px 1px; font-size:13px;}

.subpage{
	background:#224762;
	color:white;
	font-size:20px;
	border-radius:5px;
}
.message{color:red;}

.dai{color:orange;}

.yi{color:green;}

.ju{color:red;}

#s_province,#s_city,#s_county,#location_p,#location_c,#location_a{
	margin:0px;
	width:70px;
	font-size:12px;
}
</style>
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
							<td width="100" height="20" align="center" ><font size="3"><a href="<%=basePath %>customer/revise">修改密码</a></font></td>
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
	<tr height="35">
		<td width="10">&nbsp;</td>
		<td width="900">
			<img src="image/icon_1.gif" width="10" height="9">&nbsp;&nbsp;<a href="">首页</a> &gt; <a href="">我的订单</a>
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
					<td align="center" class="title1">我的货物订单</td>
				</tr>
			</table><br></br>
			<!-- jsp代码写在这里 -->
		<div class="box_2 autoScroll" style="height: 430px;">
		   	<div class="tabBox_t" >
		           <div class="tabBox">
		             <ul class="tabNav">
		               <li onclick="mygoods(1)">我的订单</li>
		               <li class="now">添加订单</li>
		             </ul>
		             <div class="tabCont">
		               <div class="ctn">
							<table class="table table-hover mygoods" style="width:100%;">
								<thead>
									<tr>
										<th class='td'>货物订单号</th>
										<th class='td'>货物名称</th>
										<th class='td'>货物数量</th>
										<th class='td'>货物单位</th>
										<th class='td'>货物重量</th>
										<th class='td'>货物体积</th>
										<th class='td'>货物尺寸</th>
										<th class='td'>货物等级</th>
										<th class='td'>货物描述</th>
										<th class='td'>货物状态</th>
										<th class='td'>下单时间</th>
									</tr>
								</thead>
							</table>
							<div>
								<a href="javacscript:void(0)" onclick="mygoods(2)" style="background:#224762;color:white;font-size:15px;border-radius:5px;text-decoration:none;">上一页</a>&nbsp;&nbsp;
								<a href="javacscript:void(0)" onclick="mygoods(3)" style="background:#224762;color:white;font-size:15px;border-radius:5px;text-decoration:none;">下一页</a>&nbsp;&nbsp;
								当前页 第<span id="page"></span>页&nbsp;&nbsp;
								共<span id="count"></span>页&nbsp;&nbsp;
								共<span id="total"></span>条数据&nbsp;&nbsp;
							</div>
		               </div>
		             </div>
		             <div class="tabCont" style="display:block;">
		               <div class="ctn">
		               		<form action="<%=path %>/goods/add" method="post">
			               		<table style="width: 760px;">
									<tr height="60">
										<td align="right">货物名称：</td>
										<td align="left"><input name="gname" type="text" id="gname" placeholder="请输入货物名称"><span class="message error1"></span></td>
										<td align="right">货物数量：</td>
										<td align="left"><input name="gcount" type="number" id="gcount" placeholder="请输入货物数量"><span class="message error2"></span></td>
									</tr>
									<tr height="60">
										<td align="right">货物单位：</td>
										<td align="left">
											<select name="gunit" id="gunit">
												<option value="">- 请选择货物单位 -</option>
												<option value="箱">箱</option>
												<option value="个">个</option>
												<option value="条">条</option>
												<option value="袋">袋</option>
												<option value="盒">盒</option>
												<option value="包">包</option>
												<option value="瓶">瓶</option>
												<option value="罐">罐</option>
												<option value="辆">辆</option>
												<option value="只">只</option>
												<option value="套">套</option>
												<option value="尊">尊</option>
												<option value="块">块</option>
												<option value="其它">其它</option>
											</select>
											<span class="message  error3"></span>
										</td>
										<td align="right">货物等级：</td>
										<td align="left">
											<select name="ggrade" id="ggrade">
												<option value="">- 请选择货物等级 -</option>
												<option value="1">等级 1</option>
												<option value="2">等级 2</option>
												<option value="3">等级 3</option>
												<option value="4">等级 4</option>
												<option value="5">等级 5</option>
											</select>
											<span class="message error7"></span>
										</td>
									</tr>
									<tr height="60">
										<td align="right">收货人：</td>
										<td align="left"><input name="gconsignee" type="text" id="gconsignee" placeholder="请输入收货人"><span class="message error8"></span></td>
										<td align="right">收货地址：</td>
										<td align="left"><input name="greaddress" type="text" id="greaddress" placeholder="请输入收货地址"><span class="message error9"></span></td>
									</tr>
									<tr height="60">
										<td align="right">收货电话：</td>
										<td align="left"><input name="grephone" type="text" id="grephone" placeholder="请输入收货电话"><span class="message error10"></span></td>
										<td align="right">起始地点：</td><!-- <input name="gorigin" type="text" id="gorigin" placeholder="请输入起始地点"><span class="message error11"></span> -->
										<td align="left">
											<select name="location_p" id="location_p"></select>
										    <select name="location_c" id="location_c"></select>
										    <select name="location_a" id="location_a"></select>
										</td>
									</tr>
									<tr height="60">
										<td align="right">到达地点：</td><!-- <input name="gendpoint" type="text" id="gendpoint" placeholder="请输入到达地点"> -->
										<td align="left">
											<select id="s_province" name="location_p1"></select>
										    <select id="s_city" name="location_c1" ></select>
										    <select id="s_county" name="location_a1"></select>
										</td>
									</tr>
									<tr height="60">
										<td align="right">货物描述：</td>
										<td align="left" colspan=3>
											<textarea name="gdescribe" id="gdescribe" cols=97 rows=4 style="border:0px;"></textarea>
											<span class="message error13"></span>
										</td>
									</tr>
									<tr align="center">
										<td colspan=4 align="center"><input type="submit" value="添    加" class="subpage" onclick="return getValues();"/></td>
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
<script type="text/javascript">new PCAS('location_p', 'location_c', 'location_a', '', '', '');new PCAS('location_p1', 'location_c1', 'location_a1', '上海市', '', '');</script>
</body>
</html>
