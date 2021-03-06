<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%String path=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>收货单列表</title>
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
	border-bottom:1px dashed #5F6D88; 
}
.gxiangq span{
	font-size:16px;
	color:blue;
}
a:link {color:blue}
a:visited{color:#54287C}
a:active{color:yellow}
a:hover {color:#54287C} 

.wait{color:black;}

.failure{color:red;}

.success{color:green;}

.tui{color:grey;}

.easyui-textbox,.easyui-numberbox{width:10%;}
</style>
<script type="text/javascript">
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
		},
		rowStyler: function(index,row){
        	if(index%2==1){
        	    return 'background-color:#F4F4F4;color:#000;';
        	    //这就是1,3,5行一个颜色了
        	}
       	}
	});
	
});

/* 客户姓名 */
function customerName(value){
	var btn="<a href='javascript:onCustomer("+value.cid+")'>"+value.cname+"</a>";
	return btn;
}

/* 点击客户姓名查看货物信息 */
function onCustomer(cid){
	$(".gxiangq").css('border-bottom','1px dashed #5F6D88');
	$.post("<%=path%>/customer/cusByid",{'cid':cid},function(index){
		cusfuzhi(index);
		$("#cusbyWin").dialog("open").dialog("setTitle", "客户信息");
	},"json");
}

/* 货物名称 */
function goodsName(value){
	var btn="<a href='javascript:openGoodWin("+value.gid+")'>"+value.gname+"</a>";
	return btn;
}

function goodsNum(value,rec){
	return rec.goods.gordernumber;
}

function goodsCount(value,rec){
	return rec.goods.gcount;
}

function toUserName(value){
	return value.usertruename;
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

function toSub(value,obj){
	var btn='';
	if(obj.rstart == 1){
		btn="<span class='wait'>待检验</span>";
	}else if(obj.rstart == 2){
		btn="<a href='javascript:openNumWin("+obj.rid+","+obj.rcid+","+obj.rgid+","+obj.rreceivecount+","+obj.goods.gweight+","+obj.goods.gvolume+","+obj.goods.gsize+","+obj.goods.ggrade+")'>入库</a>";
	}else if(obj.rstart == 3){
		btn="<a href='javascript:openNextWin("+obj.rid+","+obj.rcid+","+obj.rgid+","+obj.rreceivecount+")' style='color:orange'>继续入库</a>";
	}else if(obj.rstart == 4){
		btn="<span class='failure'>质检失败</span>";
	}else if(obj.rstart == 5){
		btn="<span class='success'>已入库</span>";
	}else if(obj.rstart == 6){
		btn="<span class='tui'>待退回</span>";
	}else if(obj.rstart == 7){
		btn="<span>已退回</span>";
	}
	return btn;
}

/* 打开详情窗口 */
function openGoodWin(gid) {
	$.post("<%=path%>/goods/goodByid",{'gid':gid},function(index){
		fuzhi(index);
	},"json");
}

/* 给客户信息窗口赋值 */
function cusfuzhi(index){
	$("#cname").html(index.customer.cname);
	$("#ckhno").html(index.customer.ckhno);
	$("#ccompany").html(index.customer.ccompany);
	$("#cphone").html(index.customer.cphone);
	$("#cemail").html(index.customer.cemail);
	$("#ccredit").html(index.customer.ccredit);
	$("#caddress").html(index.customer.caddress);
}

/* 给弹出的窗口赋值 */
function fuzhi(index){
	$("#gname").html(index.goods.gname);
	$("#gordernumber").html(index.goods.gordernumber);
	$("#gcount").html(index.goods.gcount + " "+index.goods.gunit);
	$("#gweight").html(isNull(index.goods.gweight) + " 吨");
	$("#gvolume").html(isNull(index.goods.gvolume) + " m<sup>3</sup>");
	$("#gsize").html(isNull(index.goods.gsize) + " m");
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

/* 如果为空 */
function isNull(val){
	if(val == '' || val == null){
		return '未知';
	}else{
		return val;
	}
}

/* 关闭窗口 */
function closeGoodWin(){
	$("#goodbyWin").dialog("close");
	$("#receKuWin").dialog("close");
	$("#rkTypeWin").dialog("close");
	$("#good_xinxi").dialog("close");
	$("#cusbyWin").dialog("close");
}

/* 搜索 */
function seachs(){
	var cname = $('#scname').textbox('getValue');
	var gname = $('#sgname').textbox('getValue');
	var rstart = $('#srstart').combobox('getValue');
	var username = $('#username').textbox('getValue');
	var gordernumber = $('#sgordernumber').textbox('getValue');
	$('#list').datagrid('load',{  
		cname:cname,
		gname:gname,
		rstart:rstart,
		username:username,
		gordernumber:gordernumber
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

/* 打开选择入库方式窗口 */
function openNumWin(rid,cid,gid,count,gweight,gvolume,gsize,ggrade){
	$('#srid').val(rid);
	$('#srcid').val(cid);
	$('#srgid').val(gid);
	$('#xgid').val(gid);
	$('#rreceivecount').val(count);
	$('#xggrade').combobox('setValue',ggrade);
	$('#xgweight').numberbox('setValue',gweight);
	$('#xgvolume').numberbox('setValue',gvolume);
	$('#xgsize').numberbox('setValue',gsize);
	$('#storagecount').numberbox('setValue',count);
	$("#good_xinxi").dialog("open").dialog("setTitle", "确认货物占用信息");
}

/**
 * 继续入库
 */
function openNextWin(rid,cid,gid,count){
	$('#srid').val(rid);
	$('#srcid').val(cid);
	$('#srgid').val(gid);
	$('#rreceivecount').val(count);
	$('#storagecount').numberbox('setValue',count);
	getCheckVal();
	$("#rkTypeWin").dialog("open").dialog("setTitle", "入库类型");
}

/* 单选按钮选中的值 */
function getCheckVal(){
	var stor=document.getElementsByName("storagemode");
     for(var i=0;i<stor.length;i++)
     {
         if(stor[i].checked==true)
         {
             if(stor[i].value == '一次性入库'){
            	 var count=$('#rreceivecount').val();
            	 $('#storagecount').numberbox('setValue',count);
            	 $('#storagecount').numberbox('disable');
             }else{
            	 $('#storagecount').numberbox('enable');
             }
             return stor[i].value;
         }
     }
}

/* 提交入库方式 */
function subrukuType(){
	var count=$('#rreceivecount').val();
	var srid=$('#srid').val();
	var sgid=$('#srgid').val();
	var scid=$('#srcid').val();
	var stor=getCheckVal();
	var storagecount=count;
	if(stor == '一次性入库'){
		$.post("<%=path%>/receipt/byGood",{'srid':srid,'scid':scid,'sgid':sgid,'storagecount':storagecount,'storagemode':stor},function(index){},"json");
		$("#rkTypeWin").dialog("close");
		openKuWeiWin();
	}else{
    	storagecount = $('#storagecount').numberbox('getValue');
    	if(parseInt(storagecount)>parseInt(count)){
    		$.messager.alert('系统提示','入库数量超过货物数量！','info');
    	}else if(parseInt(storagecount)<= 0){
    		$.messager.alert('系统提示','请输入正确的入库数量！','info');
    	}else{
    		$.post("<%=path%>/receipt/byGood",{'srid':srid,'scid':scid,'sgid':sgid,'storagecount':storagecount,'storagemode':stor},function(index){},"json");
    		$("#rkTypeWin").dialog("close");
    		openKuWeiWin();
    	}
    }
}

/* 打开库位列表窗口 */
function openKuWeiWin(){
	$("#receKuWin").dialog("open").dialog("setTitle", "库位选择");
	$('#kuwei').datagrid('load'); 
}

/* 提交信息 */
function subRece(){
	var row=$("#kuwei").datagrid("getSelected");	//获取datagrid中选中的行
	if(row){
		$.post("<%=path%>/storage/add",{'ssbid':row.loid},function(index){
			$.messager.alert('提示',index.result,'info');
			$("#receKuWin").dialog("close");
			$('#list').datagrid('load'); 
		},"json");
		
	}else{
		$.messager.alert('提示','请选择需要库位','info');	//messager消息控件
	}
}

/* 提交货物大小 */
function addGoodSize(){
	var gid=$('#xgid').val();
	var gweight=$('#xgweight').numberbox('getValue');
	var gvolume=$('#xgvolume').numberbox('getValue');
	var gsize=$('#xgsize').numberbox('getValue');
	if(gweight == ''){
		$.messager.alert('提示','请填写货物重量！','info');
		return false;
	}else if(gvolume == ''){
		$.messager.alert('提示','请填写货物体积！','info');
		return false;
	}else if(gsize == ''){
		$.messager.alert('提示','请填写货物尺寸！','info');
		return false;
	}else if(checkLive()){
		return false;
	}else{
		var ggrade=$('#xggrade').combobox('getValue');
		$.post("<%=path%>/goods/updateGood",{'gid':gid,'gweight':gweight,'gvolume':gvolume,'gsize':gsize,'ggrade':ggrade},function(index){},"json");
		$("#good_xinxi").dialog("close");
		getCheckVal();
		$("#rkTypeWin").dialog("open").dialog("setTitle", "入库类型");
	}
}

/* 根据货物基本信息选择等级 */
function checkLive(){
	var gweight=$('#xgweight').numberbox('getValue');
	var gvolume=$('#xgvolume').numberbox('getValue');
	var gsize=$('#xgsize').numberbox('getValue');
	if(gweight != '' && gvolume != '' && gsize != ''){
		if(gweight>=300 || gvolume >= 1200 || gsize >= 40){
			$('#xggrade').combobox('setValue',4);
		}else if((gweight>=200 && gweight < 300) || (gvolume >= 726 && gvolume < 1200) || (gsize >= 30 && gsize < 40)){
			$('#xggrade').combobox('setValue',3);
		}else if((gweight>=100 && gweight < 200) || (gvolume >= 342 && gvolume < 726) || (gsize >= 20 && gsize < 30)){
			$('#xggrade').combobox('setValue',2);
		}else if((gweight>=20 && gweight < 100) || (gvolume >= 147 && gvolume < 342) || (gsize >= 14 && gsize < 20)){
			$('#xggrade').combobox('setValue',1);
		}else{
			$.messager.alert('提示','货物信息违反规定！','info');
			return true;
		}
		return false;
	}
	return true;
}

/* 打开等级说明窗口 */
function openMess(){
	$("#livegoodbyWin").dialog("open").dialog("setTitle", "货物等级说明");
}
/* 关闭等级说明窗口 */
function closeshuming(){
	$("#livegoodbyWin").dialog("close");
}

/* 返回到确认货物信息窗口 */
function ruBack(){
	$("#good_xinxi").dialog("open").dialog("setTitle", "确认货物占用信息");
	$("#rkTypeWin").dialog("close");
}

/* 返回到选择类型 */
function typeBack(){
	$("#rkTypeWin").dialog("open").dialog("setTitle", "入库类型");
	$("#receKuWin").dialog("close");
}
</script>

</head>
<body>
	<table id="list" class="easyui-datagrid" toolbar="#kj" style="width:100%" data-options="
		url:'<%=path%>/receipt/all',
		method:'get',
		rownumbers:true,	
		singleSelect:true,
		autoRowHeight:true,
		pagination:true,
		border:false,
		pageSize:20,
		fit:true
	">
		<thead data-options="frozen:true">
			<tr>
				<th field="rid" checkbox="true">编号</th>
				<th field="customer" width="10%" align="center" formatter="customerName">客户</th>
				<th field="goods" width="10%" align="center" formatter="goodsName">货物名称</th>
				<th field="goods1" width="12%" align="center" formatter="goodsNum">货物订单号</th>
				<th field="goods2" width="7%" align="center" formatter="goodsCount">货物总数量</th>
				<th field="rreceivecount" width="7%" align="center">剩余货物数量</th>
				<th field="rdamagedcount" width="7%" align="center" >破损数量</th>
				<th field="rshelvecount" width="7%" align="center">搁置数量</th>
				<th field="rtdgoodstime" width="13%" align="center" formatter="toDate">收货时间</th>
				<th field="user" width="10%" align="center" formatter="toUserName">收货员</th>
				<th field="null" width="12%" align="center" formatter="toSub">操作</th>
			</tr>
		</thead>
	</table>
	<div id="kj">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="window.print();">打印</a>&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-export1'" onclick="location.href='<%=path %>/export/receiptExcel'">导出</a>&nbsp;
		客户：<input id="scname" class="easyui-validatebox easyui-textbox" name="cname" data-options="required:false" />&nbsp;
		货物：<input id="sgname" class="easyui-validatebox easyui-textbox" name="gname" data-options="required:false" />&nbsp;
		状态：<select id="srstart" class="easyui-combobox" name="rstart" data-options="editable:false" style="width:10%">
			<option value=""></option>
			<option value="1">待检验</option>
			<option value="2">未入库</option>
			<option value="3">部分入库</option>
			<option value="4">检验失败</option>
			<option value="5">已入库</option>
			<option value="6">待退回</option>
			<option value="7">已退回</option>
		</select>&nbsp;
		订单号：<input id="sgordernumber" class="easyui-validatebox easyui-textbox" name="gordernumber" data-options="required:false" />&nbsp;
		收货员：<input id="username" class="easyui-validatebox easyui-textbox" name="username" data-options="required:false" />
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="seachs();">搜索</a>
	</div>
	
	<!-- 自定义窗口按钮 -->
	<div id="cus-buttons">
	    <a href="javascript:closeGoodWin()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<!-- 显示客户信息 -->
	<div id="cusbyWin" class="easyui-dialog"  buttons="#cus-buttons" data-options="closable:true, closed:true"  style="width:60%;height:350px;padding:5px;text-align:center;">
		<table style="width:100%;height:100%;">
			<tr>
				<td class="tdwidth">客户名称:</td>
				<td class="gxiangq"><span id="cname"></span></td>
				<td class="tdwidth">客户编号:</td>
				<td class="gxiangq"><span id="ckhno"></span></td>
			</tr>
			<tr align="center">
				<td class="tdwidth">公司名称:</td>
				<td class="gxiangq"><span id="ccompany"></span></td>
				<td class="tdwidth">联系电话:</td>
				<td class="gxiangq"><span id="cphone"></span></td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">客户邮箱:</td>
				<td class="gxiangq"><span id="cemail"></span></td>
				<td class="tdwidth">信用度:</td>
				<td class="gxiangq"><span id="ccredit"></span></td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">地址:</td>
				<td class="gxiangq" colspan="3"><span id="caddress"></span></td>
			</tr>
			
		</table>
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
	
	<!-- 自定义窗口按钮 -->
	<div id="ruku-buttons">
		<a href="javascript:typeBack()" class="easyui-linkbutton" iconCls="icon-back">返回</a>
		<a href="javascript:subRece()" class="easyui-linkbutton" iconCls="icon-ok">确认</a>
	    <a href="javascript:closeGoodWin()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<!-- 揽收窗口 -->
	<div id="receKuWin" class="easyui-dialog" buttons="#ruku-buttons" data-options="closable:true, closed:true"  style="width:45%;height:380px;padding:5px;text-align:center;">
		<table id="kuwei" class="easyui-datagrid" style="width:100%" data-options="
			url:'<%=path %>/receipt/kuweiList',
			method:'get', 
			rownumbers:false,
			singleSelect:true,
			autoRowHeight: true,
			pagination:true,
			border:false,
			pageSize:10,
			fit:true
		">
			<thead data-options="frozen:true">
				<tr>
					<th field="loid" checkbox="true">编号</th>
					<th field="loname" width="20%">库位名称</th>
					<th field="losize" width="18%">库位尺寸(m)</th>
					<th field="lovolume" width="18%">库位体积(m³)</th>
					<th field="loweight" width="18%">承受重量(t)</th>
					<th field="lolevel" width="18%">库位等级</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<!-- 自定义窗口按钮 -->
	<div id="subruku-buttons">
		<a href="javascript:ruBack()" class="easyui-linkbutton" iconCls="icon-back">返回</a>
		<a href="javascript:subrukuType()" class="easyui-linkbutton" iconCls="icon-ok">确认</a>
	    <a href="javascript:closeGoodWin()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<!-- 选择入库数量 -->
	<div id="rkTypeWin" class="easyui-dialog"  buttons="#subruku-buttons" data-options="closable:true, closed:true"  style="width:25%;height:180px;padding:5px;text-align:center;">
		<input type="hidden" id="rreceivecount">
		<input type="hidden" id="srid">
		<input type="hidden" id="srgid">
		<input type="hidden" id="srcid">
		<br />
		入库方式：<input type="radio" name="storagemode" checked="checked" value="一次性入库" onclick="getCheckVal()"/>一次性
               <input type="radio" name="storagemode" value="分批入库" onclick="getCheckVal()"/>分批<br /><br />
		入库数量：<input id="storagecount" class="easyui-validatebox easyui-numberbox" name="storagecount" data-options="required:false" />
	</div>
	
	<!-- 自定义窗口按钮 -->
	<div id="good-buttons">
		<a href="javascript:addGoodSize()" class="easyui-linkbutton" iconCls="icon-ok">确认</a>
	    <a href="javascript:closeGoodWin()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<!-- 确认货物占用信息 -->
	<div id="good_xinxi" class="easyui-dialog"  buttons="#good-buttons" data-options="closable:true, closed:true"  style="width:30%;height:240px;padding:5px;text-align:center;">
		<input type="hidden" id="xgid" />
		<br />
		货物重量：<input id="xgweight" class="easyui-validatebox easyui-numberbox" data-options="required:true" /><br /><br />
		货物体积：<input id="xgvolume" class="easyui-validatebox easyui-numberbox" data-options="required:true" /><br /><br />
		货物尺寸：<input id="xgsize" class="easyui-validatebox easyui-numberbox" data-options="required:true" /><br /><br />
		货物等级：<select id="xggrade" class="easyui-combobox" name="xggrade" data-options="editable:false" style="width:19%;">
			<option value="1">等级1</option>
			<option value="2">等级2</option>
			<option value="3">等级3</option>
			<option value="4">等级4</option>
		</select>
		<span onclick="checkLive()" style="color:blue;cursor:pointer;">检测</span>
		<span title="查看等级说明" onclick="openMess();"><img src="<%=path %>/images/question.png" style="width:20px;height:20px;cursor:pointer;vertical-align:middle;"/></span>
	</div>
	<!-- 自定义窗口按钮 -->
	<div id="live-buttons">
	    <a href="javascript:closeshuming()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<!-- 等级说明信息 -->
	<div id="livegoodbyWin" class="easyui-dialog"  buttons="#live-buttons" data-options="closable:true, closed:true"  style="width:40%;height:90%;padding:5px;text-align:center;">
		<h1 style="font-weight:bold;font-size:25px">货物等级说明</h1>
		<div style="text-align:left;font-size:20px;line-height:25px;">
			<h5>选择货物等级前请详细阅读以下说明<br />大型物件，按其外形尺寸和重量(含包装和支承架)分成四级：</h5>
			<p>(一)一级大型物件是指达到下列标准之一者：<br />
			　　1、长度大于14米(含14米)小于20米;<br />
			　　2、体积大于147m³(含147m³)小于342m³;<br />
			　　3、重量大于20吨(含20吨)小于100吨。
			</p>
			<p>(二)二级大型物件是指达到下列标准之一者：<br />
			　　1、长度大于20米(含20米)小于30米;<br />
			　　2、体积大于342m³(含342m³)小于726m³;<br />
			　　3、重量大于100吨(含100吨)小于200吨。
			</p>
			<p>(三)三级大型物件是指达到下列标准之一者：<br />
			　　1、长度大于30米(含30米)小于40米;<br />
			　　2、宽度大于726m³(含726m³)小于1200m³;<br />
			　　3、重量大于200吨(含200吨)小于300吨。
			</p>
			<p>(四)四级大型物件是指达到下列标准之一者：<br />
			　　1、长度在40米及以上;<br />
			　　2、宽度在1200m³及以上;<br />
			　　3、重量在300吨及以上。
			</p>
			<p>大型物件的级别，按其长、体积、及重量三个条件中级别最高的确定。</p>
			<p>
				<span style="font-weight:bold;">保运通提示：</span>
				大件物流一定要找具有大件物流经营资格的公司进行办理，承运大型物件的级别要与批准营运的类别相符，否则发生事故，承运人需要承担全部的责任。</p>
		</div>
	</div>
</body>
</html>