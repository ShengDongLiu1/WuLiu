<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%String path=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>入库列表</title>
<link rel="stylesheet" href="<%=path %>/js/jquery-easyui/themes/default/easyui.css"/>
<link rel="stylesheet" href="<%=path %>/js/site_main.css"/>
<link rel="stylesheet" type="text/css" href="<%=path %>/js/jquery-easyui/themes/icon.css">
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=path %>/js/site_easyui.js"></script>
<style type="text/css">
body{margin:0px;padding:0px;}
.tdwidth{
	width:18%;text-align:right;font-size:15px;
}
.gxiangq{
	text-align:left;font-size:15px;
	border-bottom:1px dashed #FFE48D; 
}
.gxiangq span{
	font-size:16px;
	color:blue;
}
a:link {color:blue}
a:visited{color:#54287C}
a:active{color:yellow}
a:hover {color:#54287C} 

.easyui-textbox{width:10%;}
</style>
<script>
$(function(){
	//setPagination("list");
/**	$(document).bind('contextmenu',function(e){	//给网页绑定右键菜单
		e.preventDefault();		//阻止浏览器的默认右键菜单
		$("#mm").menu('show',{
			left:e.pageX,	//鼠标右键的x坐标
			top:e.pageY		//鼠标右键的y坐标
		});
	});
*/
	function setPagination(tableid){
		var op=$("#"+tableid).datagrid("getPager");	//分页组件
		$(op).pagination({
			pageList:[10,15,20,25,30],
			beforePageText:"第",
			afterPageText:"页	共{pages}页",
			displayMsg:"当前显示{from}-{to}条记录 	共{total}条记录",
			onBeforRefresh:function(){
				$(this).pagination("loading");
				$(this).pagination("loaded");
			}
		});
	}
	$(function(){
		setPagination("list");
	});
	
	$("#list").datagrid({
		onRowContextMenu:function(e,rowIndex,rowData){
			e.preventDefault();
			$("#mm").menu('show',{
				left:e.pageX,
				top:e.pageY	
			});
		}
	});
	
});


function customerName(value){
	return value.cname;
}

/* 货物名称 */
function goodsName(value){
	var btn="<a href='javascript:openGoodWin("+value.gid+")'>"+value.gname+"</a>";
	return btn;
}

function inventoryName(value){
	return value.loname;
}

function toUserName(value){
	return value.usertruename;
}

//显示图片
function toImage(value,rec){
	var btn="<img src='<%=path%>/storagebarcode/"+rec.storagebarcode+"' alt='条形码'>";
    return btn;
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

/* 将{"date":14,"day":3,"hours":19,"minutes"……}转换为Thu Mar 19 2015 12:00:00 GMT+0800 (中国标准时间) */
function toDate(obj){
	var date = new Date();
	 date.setTime(obj.time);
	 date.setHours(obj.hours);
	 date.setMinutes(obj.minutes);
	 date.setSeconds(obj.seconds);
	return formatDateTime(date);
}

function toSub(){
	var btn="<a href='javascript:void(0)' onclick=''>出库</a>";
	return btn;
}

/* 打开详情窗口 */
function openGoodWin(gid) {
	$.post("<%=path%>/goods/goodByid",{'gid':gid},function(index){
		fuzhi(index);
	},"json");
    
}

/* 给弹出的窗口赋值 */
function fuzhi(index){
	$("#gname").html(index.goods.gname);
	$("#gordernumber").html(index.goods.gordernumber);
	$("#gcount").html(index.goods.gcount + " "+index.goods.gunit);
	$("#gweight").html(index.goods.gweight + " 吨");
	$("#gvolume").html(index.goods.gvolume + " m<sup>3</sup>");
	$("#gsize").html(index.goods.gsize + " m");
	$("#ggrade").html(index.goods.ggrade);
	$("#gconsignee").html(index.goods.gconsignee);
	$("#greaddress").html(index.goods.greaddress);
	$("#grephone").html(index.goods.grephone);
	$("#gorigin").html(index.goods.gorigin);
	$("#gendpoint").html(index.goods.gendpoint);
	$("#gstate").html(lanshou(index.goods.gstate));
	$("#gorderstime").html(formatDateTime(new Date(index.goods.gorderstime)));
	$("#gdescribe").html(index.goods.gdescribe);
	$("#goodbyWin").dialog("open").dialog("setTitle", "客户订单详情");
}

/* 关闭窗口 */
function closeGoodWin(){
	$("#goodbyWin").dialog("close");
}

/* 搜索 */
function seachs(){
	var cname = $('#scname').textbox('getValue');
	var gname = $('#sgname').textbox('getValue');
	var loname = $('#sloname').textbox('getValue');
	var sbarcadeid = $('#ssbarcadeid').textbox('getValue');
	var username = $('#username').textbox('getValue');
	$('#list').datagrid('load',{  
		cname:cname,
		gname:gname,
		loname:loname,
		sbarcadeid:sbarcadeid,
		username:username
	}); 
}

function lanshou(state){
	var sta="";
	if(state=='1'){
		sta="待揽收"
	}else if(state=='2'){
		sta="已揽收"
	}
	return sta;
}

</script>
</head>
<body>
	<div>当前位置：</div>
	<table id="list" class="easyui-datagrid" toolbar="#kj" style="width:100%" data-options="
		url:'<%=path %>/storage/all',
		method:'get',
		rownumbers:true,	
		singleSelect:false,
		autoRowHeight:true,
		pagination:true,
		border:false,
		pageSize:10,
		fit:true
	">
		<thead data-options="frozen:true">
			<tr>
				<th field="sid" checkbox="true">编号</th>
				<th field="customer" width="7%" align="center" formatter="customerName">客户</th>
				<th field="goods" width="7%" align="center" formatter="goodsName">货物名称</th>
				<th field="inventory" width="7%" align="center" formatter="inventoryName">库位名称</th>
				<th field="storagemode" width="7%" align="center">入库类型</th>
				<th field="storagecount" width="5%" align="center">入库数量</th>
				<th field="storagebarcode" width="28%" align="center" formatter="toImage">条形码</th>
				<th field="sbarcadeid" width="12%" align="center">条形码编号</th>
				<th field="storagetime" width="9%" align="center" formatter="toDate">入库时间</th>
				<th field="user" width="7%" align="center" formatter="toUserName">操作员</th>
				<th field="null" width="8%" align="center" formatter="toSub">操作</th>
			</tr>
		</thead>
	</table>
	<div id="kj" style="padding: 2px;">
		客户：<input id="scname" class="easyui-validatebox easyui-textbox" name="cname" data-options="required:false" />&nbsp;
		货物：<input id="sgname" class="easyui-validatebox easyui-textbox" name="gname" data-options="required:false" />&nbsp;
		库位：<input id="sloname" class="easyui-validatebox easyui-textbox" name="loname" data-options="required:false" />&nbsp;
		条形码编号：<input id="ssbarcadeid" class="easyui-validatebox easyui-textbox" name="sbarcadeid" data-options="required:false" />&nbsp;
		操作员：<input id="username" class="easyui-validatebox easyui-textbox" name="username" data-options="required:false" />
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="seachs();">搜索</a>
	</div>
	
	<!-- 自定义窗口按钮 -->
	<div id="dlg-buttons">
	    <a href="javascript:closeGoodWin()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<div id="goodbyWin" class="easyui-dialog"  buttons="#dlg-buttons" data-options="closable:true, closed:true"  style="width:70%;height:420px;padding:5px;text-align:center;">
		<table style="width:100%;height:100%;">
			<tr>
				<td class="tdwidth">货物名称:</td>
				<td class="gxiangq"><span id="gname"></span></td>
				<td class="tdwidth">货物订单号:</td>
				<td class="gxiangq"><span id="gordernumber"></span></td>
			</tr>
			<tr align="center">
				<td class="tdwidth">货物数量:</td>
				<td class="gxiangq"><span id="gcount"></span></td>
				<td class="tdwidth">货物重量:</td>
				<td class="gxiangq"><span id="gweight"></span></td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">货物体积:</td>
				<td class="gxiangq"><span id="gvolume"></span></td>
				<td class="tdwidth">货物尺寸:</td>
				<td class="gxiangq"><span id="gsize"></span></td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">货物等级:</td>
				<td class="gxiangq"><span id="ggrade"></span></td>
				<td class="tdwidth">收货人:</td>
				<td class="gxiangq"><span id="gconsignee"></span></td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">收货地址:</td>
				<td class="gxiangq"><span id="greaddress"></span></td>
				<td class="tdwidth">收货电话:</td>
				<td class="gxiangq"><span id="grephone"></span></td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">起始地点:</td>
				<td class="gxiangq"><span id="gorigin"></span></td>
				<td class="tdwidth">到达地址:</td>
				<td class="gxiangq"><span id="gendpoint"></span></td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">货物状态:</td>
				<td class="gxiangq"><span id="gstate"></span></td>
				<td class="tdwidth">下单时间:</td>
				<td class="gxiangq"><span id="gorderstime"></span></td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">货物描述:</td>
				<td class="gxiangq" colspan="3"><span id="gdescribe"></span></td>
			</tr>
		</table>
	</div>
</body>
</html>