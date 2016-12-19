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

.dai{color:green;}

.yi{color:orange;}

.ju{color:red;}
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
	
	//双击
	$("#list").datagrid({   
		//rowIndex 是序号 row是json数据
	 	onDblClickRow:function(rowIndex,row){
	 		$.post("<%=path%>/goods/goodByid",{'gid':row.gid},function(index){
	 			fuzhi(index);
			},"json");
	    }
	})
	
});


/* 客户姓名 */
function customerName(value){
	return value.cname;
}

function goState(value,obj){
	var state='';
	if(obj.gstate=='1'){
		state="<span class='dai'>待揽收</span>"
	}else if(obj.gstate=='2'){
		state="<span class='yi'>已揽收</span>"
	}else if(obj.gstate=='3'){
		state="<span class='ju'>已拒收</span>"
	}
	return state;
}

function lanshou(state){
	var sta='';
	if(state=='1'){
		sta='待揽收'
		$("#becase").remove();
	}else if(state=='2'){
		sta='已揽收'
		$("#becase").remove();
	}else if(state=='3'){
		sta='已拒收'
		$("#gooded").append(
		"<tr align='center' id='becase'>"+
			"<td class='tdwidth'>拒收原因:</td>"+
			"<td class='gxiangq' colspan='3'><span id='gocause'></span></td>"+
		"</tr>"
		);
	}
	return sta;
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

/* 表格按钮 */
function toSub(value,obj){
	var btn="<a href='javascript:openGoodWin("+obj.gid+")'>详情</a>";
	if(obj.gstate=='1'){
		btn+="&nbsp;<a href='javascript:openLSWin("+obj.gid+","+obj.gcid+","+obj.gcount+")'>揽收</a>";
		btn+="&nbsp;<a href='javascript:openJSWin("+obj.gid+")'>拒收</a>";
	}
	return btn;
}

/* 打开拒收窗口 */
function openJSWin(gid){
	$("#jgid").val(gid);
	$("#goodJSWin").dialog("open").dialog("setTitle", "拒收原因");
}

/* 打开揽收窗口 */
 function openLSWin(gid,gcid,gcount){
	$("#lgid").val(gid);
	$("#lgcid").val(gcid);
	$("#lgcount").val(gcount);
	$("#goodLSWin").dialog("open").dialog("setTitle", "揽收货物");
}

/* 提交收货单数据 */
function subRece(){
	var gid=$("#lgid").val();
	var gcid=$("#lgcid").val();
	var gcount=$("#lgcount").val();
	var lrdamagedcount = $('#lrdamagedcount').numberbox('getValue');
	var lrshelvecount = $('#lrshelvecount').numberbox('getValue');
	if(gcount<(parseInt(lrdamagedcount)+parseInt(lrshelvecount))){
		$.messager.alert('系统提示','破损和搁置数量超过了货物数量！','info');
	}else{
		if(lrdamagedcount==''){
			lrdamagedcount=0
		}if(lrshelvecount==''){
			lrshelvecount=0
		}
		$.post("<%=path%>/receipt/addRece",{'rgid':gid,'rcid':gcid,'rreceivecount':gcount,'rdamagedcount':lrdamagedcount,'rshelvecount':lrshelvecount},function(index){
			$.messager.alert("系统提示", index.result,'info');
			closeGoodWin();
			$("#list").datagrid("reload");	//刷新表格
		},"json");
	}
}

/* 提交拒收原因 */
function subGocause(){
	var gid=$("#jgid").val();
	var gocause = $('#jgocause').textbox('getValue');
	if(gocause==''){
		$.messager.alert("系统提示", '请填写拒收原因！','info');
	}else{
		$.post("<%=path%>/goods/goodCause",{'gid':gid,'gocause':gocause},function(index){
			$.messager.alert("系统提示", index.result,'info');
			closeGoodWin();
			$("#list").datagrid("reload");	//刷新表格
		},"json");
	}
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
	$("#gocause").html(index.goods.gocause);
	$("#goodbyWin").dialog("open").dialog("setTitle", "客户订单详情");
}


/* 关闭窗口 */
function closeGoodWin(){
	$("#goodbyWin").dialog("close");
	$("#goodLSWin").dialog("close");
	$("#goodJSWin").dialog("close");
}

/* 搜索 */
function seachs(){
	var cname = $('#scname').textbox('getValue');
	var gname = $('#sgname').textbox('getValue');
	var gstate = $('#sgstate').textbox('getValue');
	var gordernumber = $('#sgordernumber').textbox('getValue');
	$('#list').datagrid('load',{  
		cname:cname,
		gname:gname,
		gstate:gstate,
		gordernumber:gordernumber
	}); 
}

</script>
</head>
<body>
	<table id="list" class="easyui-datagrid" toolbar="#kj" style="width:100%" data-options="
		url:'<%=path %>/goods/all',
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
				<th field="customer" width="10%" align="center" formatter="customerName">客户</th>
				<th field="gname" width="10%" align="center">货物名称</th>
				<th field="gordernumber" width="12%" align="center">订单号</th>
				<th field="gcount" width="10%" align="center">货物数量</th>
				<th field="gunit" width="8%" align="center">单位</th>
				<th field="ggrade" width="8%" align="center">货物等级</th>
				<th field="gstate" width="12%" align="center" formatter="goState">货物状态</th>
				<th field="gorderstime" width="12%" align="center" formatter="toDate">入库时间</th>
				<th field="null" width="13%" align="center" formatter="toSub">操作</th>
			</tr>
		</thead>
	</table>
	
	<!-- 菜单 -->
	<div id="kj" style="padding: 2px;">
		<a href="javascript:openUserAddDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >添加</a>
		<a href="javascript:openUserModifyDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" >编辑</a>
		<a href="javascript:deleteTest()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" >删除</a>
		<br />
		客户：<input id="scname" class="easyui-validatebox easyui-textbox" name="cname" data-options="required:false" />&nbsp;
		货物：<input id="sgname" class="easyui-validatebox easyui-textbox" name="gname" data-options="required:false" />&nbsp;
		状态：<input id="sgstate" class="easyui-validatebox easyui-textbox" name="gstate" data-options="required:false" />&nbsp;
		订单号：<input id="sgordernumber" class="easyui-validatebox easyui-textbox" name="gordernumber" data-options="required:false" />
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="seachs();">搜索</a>
	</div>
	
	<!-- 自定义窗口按钮 -->
	<div id="ls-buttons">
		<a href="javascript:subRece()" class="easyui-linkbutton" iconCls="icon-ok">确认</a>
	    <a href="javascript:closeGoodWin()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<!-- 揽收窗口 -->
	<div id="goodLSWin" class="easyui-dialog"  buttons="#ls-buttons" data-options="closable:true, closed:true"  style="width:25%;height:180px;padding:5px;text-align:center;">
			<input type="hidden" id="lgid">
			<input type="hidden" id="lgcid">
			<input type="hidden" id="lgcount">
		<br />
		破损数量：<input id="lrdamagedcount" class="easyui-validatebox easyui-numberbox" name="lrdamagedcount" data-options="required:false" /><br /><br />
		搁置数量：<input id="lrshelvecount" class="easyui-validatebox easyui-numberbox" name="lrshelvecount" data-options="required:false" />
	</div>
	
	<!-- 自定义窗口按钮 -->
	<div id="js-buttons">
		<a href="javascript:subGocause()" class="easyui-linkbutton" iconCls="icon-ok">确认</a>
	    <a href="javascript:closeGoodWin()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<!-- 拒收窗口 -->
	<div id="goodJSWin" class="easyui-dialog"  buttons="#js-buttons" data-options="closable:true, closed:true"  style="width:32%;height:230px;padding:5px;text-align:left;">
			<input type="hidden" id="jgid">
		<br />
		拒收原因：
		<input id="jgocause" class="easyui-textbox" data-options="multiline:true" style="width:100%;height:70%">
	</div>
	
	<!-- 自定义窗口按钮 -->
	<div id="dlg-buttons">
	    <a href="javascript:closeGoodWin()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<div id="goodbyWin" class="easyui-dialog"  buttons="#dlg-buttons" data-options="closable:true, closed:true"  style="width:70%;height:420px;padding:5px;text-align:center;">
		<table style="width:100%;height:100%;" id="gooded">
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