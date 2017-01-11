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
			blockAlt('当前页已经是第一页！');
		}
	}else if(pa == 3){//下一页
		addpage=$("#page").html();
		page+=parseInt(addpage);
		if(parseInt($("#count").html())<page){
			page=parseInt($("#count").html());
			blockAlt('当前页已经是最后一页！');
		}
	}
	$(".addtr").remove();
	$.post("<%=path%>/goods/myGoods",{'page':page,'rows':4},function(index){
		 var tbody = ""; 
		$.each(index.listGoods,function(n,value){
	        var trs = "";  
            trs += " <tr class='addtr'> "+
	            "<td class='td'> " +value.gordernumber+ " </td> "+
	            "<td class='td'><span onclick='getGoods("+value.gid+","+value.gstate+");' class='sp'>" + value.gname +"</span></td> "+
	            "<td class='td'>" + value.gcount +"</td> "+
	            "<td class='td'>" + value.gunit +"</td> "+
	            "<td class='td'>" + isNull(value.gweight) +"</td> "+
	            "<td class='td'>" + isNull(value.gvolume) +"</td> "+
	            "<td class='td'>" + isNull(value.gsize) +"</td > "+
	            "<td class='td'>" + value.ggrade +"</td > "+
	            "<td class='td'> <p style='width:65px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;' title="+value.gdescribe+">" + value.gdescribe +"</p></td> "+
	            "<td class='td'>" + goodsState(value.gstate) +"</td> "+
	            "<td class='td'> "+formatDateTime(new Date(value.gorderstime))+" </td>"+
	            "<td class='td'> "+caozuo(value.gid,value.gstate)+" </td>"+
            " </tr>";  
            tbody += trs;         
        });  
        $(".mygoods").append(tbody);  
	    $("#page").html(index.page);
	    $("#count").html(index.count);
	    $("#total").html(index.total);
	},"json");
}

/* 操作 */
function caozuo(gid,state){
	if(state == '1'){
		return "<span class='sp' onclick='cancel("+gid+")'>取消订单</span>"
	}else{
		return "无";
	}
}
/* 取消订单 */
function cancel(gid){
	$("#message").html('真的要取消订单吗？');
	$("#altYesRoNo").show(100);
	$("#isyes").click(function(){
		$("#altYesRoNo").hide(100);
		$.post("<%=path%>/goods/delGoods",{'gid':gid},function(index){
			blockAlt(index.result);
			mygoods(1);
		},"json");
	});
	$("#isno").click(function(){
		$("#altYesRoNo").hide(100);
		return false
	});
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
	}else if(state == '4'){
		return "<span class='ju'>已取消</span>";
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

/* 提交订单前检验 */
function getValues(){
	var message="*请输入值";
	var gname=$("#gname").val();
	var gcount=$("#gcount").val();
	var gunit=$("#gunit option:selected").val();
	var gweight=$("#gweight").val();
	var gvolume=$("#gvolume").val();
	var gsize=$("#gsize").val();
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
	}else if(gweight == ''){
		$('.error4').html(message);
		return false;
	}else if(isNaN(gweight)){
		$('.error4').html('*需为数字');
		return false;
	}else if(parseInt(gweight) <= 0){
		$('.error4').html('*数值有误');
		return false;
	}else if(gvolume == ''){
		$('.error5').html(message);
		return false;
	}else if(isNaN(gvolume)){
		$('.error5').html('*需为数字');
		return false;
	}else if(parseInt(gvolume) <= 0){
		$('.error5').html('*数值有误');
		return false;
	}else if(gsize == ''){
		$('.error6').html(message);
		return false;
	}else if(isNaN(gsize)){
		$('.error6').html('*需为数字');
		return false;
	}else if(parseInt(gsize) <= 0){
		$('.error6').html('*数值有误');
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
    	subUpGoods(0);
    });

	var message='${result}';
	if(message != ''){
		blockAlt(message);
		$('.title1').html("<span style='color:red;font-size:20px;'>"+message+"</span>");
		window.setInterval(showalert, 3000);
	}
});
function showalert(){ 
	$('.title1').html('我的货物订单');
}

mygoods(1);

/* 根据货物id查询货物信息 */
function getGoods(gid,gstate){
	if(gstate != '1'){
		blockAlt('请联系客服修改信息！');
		return false;
	}else{
		$.post("<%=path%>/goods/goodByid",{'gid':gid},function(index){
			$(".gid").val(index.goods.gid);
			$(".gname").val(index.goods.gname);
			$(".gcount").val(index.goods.gcount);
			$(".gunit").val(index.goods.gunit);
			$(".ggrade").val(index.goods.ggrade);
			$(".gconsignee").val(index.goods.gconsignee);
			$(".greaddress").val(index.goods.greaddress);
			$(".grephone").val(index.goods.grephone);
			$(".gdescribe").val(index.goods.gdescribe);
			$('#updateGoods').attr('style','position:fixed;right:17%;top:31%;');
			$("#updateGoods").show(200);
			var gorigin = index.goods.gorigin;
			var myarray = gorigin.split(" ");
			var gendpoint = index.goods.gendpoint;
			var myarray1 = gendpoint.split(" ");
			new PCAS('location_p2', 'location_c2', 'location_a2', myarray[0], myarray[1], myarray[2]);
			new PCAS('location_p3', 'location_c3', 'location_a3', myarray1[0], myarray1[1], myarray1[2]);
		});
	}
}

/* 提交修改信息 */
function subUpGoods(sta){
	var message='*请输入值';
	var gid=$(".gid").val();
	var gname=$(".gname").val();
	var gcount=$(".gcount").val();
	var gunit=$(".gunit").val();
	var ggrade=$(".ggrade").val();
	var gconsignee=$(".gconsignee").val();
	var greaddress=$(".greaddress").val();
	var grephone=$(".grephone").val();
	var gdescribe=$(".gdescribe").val();
	var gor1=$("#gor1").val();
	var gor2=$("#gor2").val();
	var gor3=$("#gor3").val();
	var gen1=$("#gen1").val();
	var gen2=$("#gen2").val();
	var gen3=$("#gen3").val();
	var gorigin=gor1+" "+gor2+" "+gor3;
	var gendpoint=gen1+" "+gen2+" "+gen3;
	var reg = /^0?1[3|4|5|8][0-9]\d{8}$/;
	if(gid == ''){
		return false;
	}else if(gname == ''){
		$('.mess1').html(message);
		return false;
	}else if(gcount == ''){
		$('.mess2').html(message);
		return false;
	}else if(gcount < 1){
		$('.mess2').html('*数值有误');
		return false;
	}else if(gunit == ''){
		$('.mess3').html(message);
		return false;
	}else if(ggrade == ''){
		$('.mess4').html(message);
		return false;
	}else if(gconsignee == ''){
		$('.mess5').html(message);
		return false;
	}else if(greaddress == ''){
		$('.mess6').html(message);
		return false;
	}else if(grephone == ''){
		$('.mess7').html(message);
		return false;
	}else if (!reg.test(grephone)) {
		$('.mess7').html('*号码有误');
		return false;
	}else if(gdescribe == ''){
		$('.mess8').html(message);
	}else if(sta==1){
		$.post("<%=path%>/goods/updateGood",{'gid':gid,'gname':gname,'gcount':gcount,'gunit':gunit,
		'ggrade':ggrade,'gconsignee':gconsignee,'greaddress':greaddress,'grephone':grephone,
		'gdescribe':gdescribe,'gorigin':gorigin,'gendpoint':gendpoint
		},function(index){
			blockAlt('修改成功！');
			closeEdit();
			mygoods(1);
		});
	}
}

/* 关闭编辑窗口 */
function closeEdit(){
	$("#updateGoods").hide(200);
}

function blockAlt(mess){
	$('#altMess').html(mess);
	$("#altMess").show(100);
	setTimeout("noneAlt()",1500);  
}

function noneAlt(){
	$("#altMess").hide(100);
}

$(document).ready(function() {
	$('#editTitle').mousedown(function(event) {
		$('#editTitle').css('cursor','all-scroll');
		var isMove = true;
		var abs_x = event.pageX - $('div#updateGoods').offset().left;
		var abs_y = event.pageY - $('div#updateGoods').offset().top;
		// alert(abs_x);
		// alert(event.pageX);
		$(document).mousemove(function(event) {
			// alert(555);
			if (isMove) {
			var obj = $('div#updateGoods');
				// alert(obj);
				obj.css({'left':event.pageX - abs_x, 'top':event.pageY - abs_y});
			};
		}).mouseup(function(event) {
			isMove = false;
			$('#editTitle').css('cursor','default');
		});
	}); 
});

function closeMess(){
	$("#leveMess").hide(100);
}

function openMess(){
	$("#leveMess").show(100);
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

.sp{color:blue;cursor:pointer;}
.sp:hover{color:red;text-decoration:underline;}

.s_province,.s_city,.s_county,
#s_province,#s_city,#s_county,
#location_p,#location_c,#location_a{
	margin:0px;
	width:70px;
	font-size:12px;
}
#updateGoods{
	width:67%; 
	height:450px;; 
	border: 1px solid #D4CD49; 
	position:fixed;
	right:17%;
	top:31%;
	background:#DFDDDE;
	display:none;
}
#editTitle{
	width:100%;
	height:25px;
	background:#224762;
	text-align:right;
}
#titmes{
	color:white;
	line-height:25px;
	font-size:15px;
	float:left;
	font-weight:bold;
}
#updateGoods input,select{
	width:70%;height:40px;border:none;
}
#altMess{
	width:280px;
	height:110px;
	position:fixed;
	left:41%;
	top:45%;
	display:none;
	background:#82ADF6;
	border-radius:10px;
	text-align:center;
	line-height:110px;
	font-size:25px;
	font-wieght:bold;
	color:white;
}

#altYesRoNo{
	width:290px;
	height:120px;
	position:fixed;
	left:41%;
	top:42%;
	display:none;
	background:#82ADF6;
	border-radius:10px;
	text-align:center;
	font-size:25px;
	font-wieght:bold;
	color:white;
}
.altBtn{
	display: block; 
	background:#DFDDDE;
	border-radius:5px;
	width:60px;
	height:35px;
	float:left;
	margin-left:55px;
	line-height:35px;
	font-size:19px;
	
}
.altBtn:hover{
	text-decoration:none;
	color:blue
}

#leveMess{
	width:450px;
	height:560px;
	text-align:center;
	border-radius:5px;
	position:fixed;
	left:28%;
	top:10%;
	background:#2F3627;
	overflow:auto;
    overflow-x:hidden;
    display:none;
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
				<td><a href="<%=path %>/customer/message" class="nav" >客户反馈</a></td>
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
		<td align="center" valign="top" width="920px">
			<table width="90%" border="0" cellspacing="0" cellpadding="0">
				<tr height="35">
					<td align="center" class="title1">我的货物订单</td>
				</tr>
			</table><br></br>
			<!-- jsp代码写在这里 -->
		<div class="box_2 autoScroll" style="height:430px;">
		   	<div class="tabBox_t">
		           <div class="tabBox">
		             <ul class="tabNav">
		               <li class="now" onclick="mygoods(1)">我的订单</li>
		               <li>添加订单</li>
		             </ul>
		             <div class="tabCont" style="display:block;padding-left: 0px;">
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
										<th class='td'>操作</th>
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
		             <div class="tabCont">
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
										<td align="right">货物重量：</td>
										<td align="left"><input name="gweight" type="text" id="gweight" placeholder="请输入货物重量(t)"><span class="message error4"></span></td>
									</tr>
									<tr height="60">
										<td align="right">货物体积：</td>
										<td align="left"><input name="gvolume" type="text" id="gvolume" placeholder="请输入货物体积(m³)"><span class="message error5"></span></td>
										<td align="right">货物尺寸：</td>
										<td align="left"><input name="gsize" type="text" id="gsize" placeholder="请输入货物尺寸(m)"><span class="message error6"></span></td>
									</tr>
									<tr>
										<td align="right">货物等级：</td>
										<td align="left">
											<select name="ggrade" id="ggrade">
												<option value="">- 请选择货物等级 -</option>
												<option value="1">等级 1</option>
												<option value="2">等级 2</option>
												<option value="3">等级 3</option>
												<option value="4">等级 4</option>
											</select>
											<span title="查看等级说明" onclick="openMess();"><img src="<%=path %>/images/question.png" style="width:20px;height:20px;cursor:pointer;"/></span>
											<span class="message error7"></span>
										</td>
										<td align="right">收货人：</td>
										<td align="left"><input name="gconsignee" type="text" id="gconsignee" placeholder="请输入收货人"><span class="message error8"></span></td>
									</tr>
									<tr height="60">
										<td align="right">收货地址：</td>
										<td align="left"><input name="greaddress" type="text" id="greaddress" placeholder="请输入收货地址"><span class="message error9"></span></td>
										<td align="right">收货电话：</td>
										<td align="left"><input name="grephone" type="text" id="grephone" placeholder="请输入收货电话"><span class="message error10"></span></td>
									</tr>
									<tr height="60">
										<td align="right">起始地点：</td><!-- <input name="gorigin" type="text" id="gorigin" placeholder="请输入起始地点"><span class="message error11"></span> -->
										<td align="left">
											<select name="location_p" id="location_p"></select>
										    <select name="location_c" id="location_c"></select>
										    <select name="location_a" id="location_a"></select>
										</td>
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
<div id="updateGoods">
	<div id="editTitle" title="修改订单信息">
		<div id="titmes">修改订单信息</div>
		<img src="<%=path %>/images/close1.png" alt="关闭" style="width:16px;margin:5px;cursor:pointer;" onclick="closeEdit();">
	</div>
	<input type="hidden" class="gid"/>
	<table style="width:100%;">
		<tr height="60">
			<td align="right">货物名称：</td>
			<td align="left"><input name="gname" type="text" class="gname" readonly><span class="message mess1"></span></td>
			<td align="right">货物数量：</td>
			<td align="left"><input name="gcount" type="number" class="gcount" placeholder="请输入货物数量"><span class="message mess2"></span></td>
		</tr>
		<tr height="60">
			<td align="right">货物单位：</td>
			<td align="left">
				<select name="gunit" class="gunit">
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
				<span class="message mess3"></span>
			</td>
			<td align="right">货物等级：</td>
			<td align="left">
				<select name="ggrade" class="ggrade">
					<option value="">- 请选择货物等级 -</option>
					<option value="1">等级 1</option>
					<option value="2">等级 2</option>
					<option value="3">等级 3</option>
					<option value="4">等级 4</option>
				</select>
				<span class="message mess4"></span>
			</td>
		</tr>
		<tr height="60">
			<td align="right">收货人：</td>
			<td align="left"><input name="gconsignee" type="text" class="gconsignee" placeholder="请输入收货人"><span class="message mess5"></span></td>
			<td align="right">收货地址：</td>
			<td align="left"><input name="greaddress" type="text" class="greaddress" placeholder="请输入收货地址"><span class="message mess6"></span></td>
		</tr>
		<tr height="60">
			<td align="right">收货电话：</td>
			<td align="left"><input name="grephone" type="text" class="grephone" placeholder="请输入收货电话"><span class="message mess7"></span></td>
			<td align="right">起始地点：</td><!-- <input name="gorigin" type="text" id="gorigin" placeholder="请输入起始地点"><span class="message error11"></span> -->
			<td align="left">
				<select name="location_p2" class="s_province" id="gor1"></select>
			    <select name="location_c2" class="s_city" id="gor2"></select>
			    <select name="location_a2" class="s_county" id="gor3"></select>
			</td>
		</tr>
		<tr height="60">
			<td align="right">到达地点：</td><!-- <input name="gendpoint" type="text" id="gendpoint" placeholder="请输入到达地点"> -->
			<td align="left">
				<select name="location_p3" class="s_province" id="gen1"></select>
			    <select name="location_c3" class="s_city" id="gen2"></select>
			    <select name="location_a3" class="s_county" id="gen3"></select>
			</td>
		</tr>
		<tr height="60">
			<td align="right">货物描述：</td>
			<td align="left" colspan=3>
				<textarea name="gdescribe" class="gdescribe" cols=97 rows=4 style="border:0px;"></textarea>
				<span class="message mess8"></span>
			</td>
		</tr>
		<tr align="center">
			<td colspan=2 align="center"><input type="submit" value="保存" class="subpage" onclick="return subUpGoods(1);"/></td>
			<td colspan=2 align="center"><input type="submit" value="取消" class="subpage" onclick="closeEdit();"/></td>
		</tr>
	</table>
</div>
<!-- 消息提示框 -->
<div id="altMess"></div>

<!-- 消息选择提示框 -->
<div id="altYesRoNo">
	<p id="message" style="margin:30px 0px 10px;">提示内容！</p>
	<a href="javascript:void(0)" id="isyes" class="altBtn">确认</a>  
	<a href="javascript:void(0)" id="isno" class="altBtn">取消</a>
</div>

<div id="leveMess">
	<div id="closeMess" style="width:20px;height:20px;float:right;cursor:pointer;" onclick="closeMess();">
		<img src="<%=path %>/images/close3.png" alt="关闭" style="width:20px;height:20px;"/>
	</div>
	<div style="margin-left:30px;padding-top:10px;">
		<h1>货物等级说明</h1>
		<div style="text-align:left;font-size:15px;color:#fff">
			<h5>选择货物等级前请详细阅读以下说明<br />大型物件，按其外形尺寸和重量(含包装和支承架)分成四级：</h5>
			<p>(一)一级大型物件是指达到下列标准之一者：<br />
			　　1、长度大于14米(含14米)小于20米;<br />
			　　2、体积大于147m³(含147m³)小于342m³;<br />
			　　3、重量大于20吨(含20吨)小于100吨。
			</p>
			<br />
			<p>(二)二级大型物件是指达到下列标准之一者：<br />
			　　1、长度大于20米(含20米)小于30米;<br />
			　　2、体积大于342m³(含342m³)小于726m³;<br />
			　　3、重量大于100吨(含100吨)小于200吨。
			</p>
			<br />
			<p>(三)三级大型物件是指达到下列标准之一者：<br />
			　　1、长度大于30米(含30米)小于40米;<br />
			　　2、宽度大于726m³(含726m³)小于1200m³;<br />
			　　3、重量大于200吨(含200吨)小于300吨。
			</p>
			<br />
			<p>(四)四级大型物件是指达到下列标准之一者：<br />
			　　1、长度在40米及以上;<br />
			　　2、宽度在1200m³及以上;<br />
			　　3、重量在300吨及以上。
			</p>
			<br />
			<p>大型物件的级别，按其长、体积、及重量三个条件中级别最高的确定。</p>
			<p>
				<span style="font-weight:bold;">保运通提示：</span>
				大件物流一定要找具有大件物流经营资格的公司进行办理，承运大型物件的级别要与批准营运的类别相符，否则发生事故，承运人需要承担全部的责任。</p>
		</div>
	</div>
</div>

<jsp:include flush="true" page="bottom.jsp"></jsp:include>
<script type="text/javascript">
	new PCAS('location_p', 'location_c', 'location_a', '', '', '');
	new PCAS('location_p1', 'location_c1', 'location_a1', '上海市', '', '');
</script>
</body>
</html>
