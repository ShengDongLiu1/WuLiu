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

function inventoryName(value,obj){
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

/* 打开移库窗口 */
function openInveWin(loid,loname,sid,gid) {
	$("#lonames").html(loname);
	$("#sids").val(sid);
	$("#ssbidzq").val(loid);//之前库位
	$("#hwgid").val(gid);//之前库位
	$.post("<%=path%>/receipt/byGood",{'sid':sid},function(index){
		
	},"json");
	$("#InvebyWin").dialog("open").dialog("setTitle", "货物移库详情");

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
	$("#gnames").html(index.goods.gname);
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
	$("#cusbyWin").dialog("close");
}

function closeInveWin(){
	$("#InvebyWin").dialog("close");
}

function okInve(){
	$("#Inve_easyui_addWin").window("open");
}
/* 选中库位提交 */
function okInvego(){
	 var selectedRows = $("#dgInve").datagrid("getSelections");
	 var kw= selectedRows[0];
	 if(kw.lostate=='0'){
		 $("#Inve_easyui_addWin").dialog("close");
		 $("#lonamesok").textbox("setValue",kw.loname);
		 $("#kwids").val(kw.loid);
	 }else{
		 $.messager.alert("系统提示", "库位当前状态为关闭，请联系管理员开启！");
	 }
	 
}

/* 选择库位筛选 */
function selectfiltrate(){
	var names=$('#gname').textbox('getValue');
	var loname=$('#loname').textbox('getValue');
	var lolevel=$('#lolevel').textbox('getValue');
	var lostate=$('#lostate').textbox('getValue');
	 $("#dgInve").datagrid("load",{gname:names,loname:loname,lolevel:lolevel,lostate:lostate});
	
	        $("#gname").textbox('setValue',"");
	        $("#loname").textbox('setValue',"");
	        $("#lolevel").textbox('setValue',"");
	        $("#lostate").textbox('setValue',"");
	    
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



function opentransport(){
	$("#stransport_list").datagrid("reload");
	$("#studentwin1").window("open");
}

function openUserModifyDialog() {
    var selectedRows = $("#list").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请选择一条要编辑的数据！");
        return;
    }
    var row = selectedRows[0];
    $("#addChuku").dialog("open").dialog("setTitle", "编辑出库单信息");
    $("#list").form("load", row);
    url = "${pageContext.request.contextPath}/thelibrary/add?tid=" + row.tid;
}

function closeUserDialog(){
	$("#addChuku").dialog("close");
}
function chuku() {
	 var row = $("#list").datagrid("getSelected");
	 if(row){
		$("#sid2").val(row.sid);
		$("#gid2").val(row.goods.gid);
		$("#sstock").val(row.sstock);
		$("#goodsName2").textbox('setValue',row.goods.gname);
		url = "${pageContext.request.contextPath}/thelibrary/add";
		$("#addChuku").dialog("open").dialog("setTitle", "添加出库单");
	 }else {
        $.messager.alert('提示', '请选中一行需要出库的记录', 'info');
    }
}
function doAdd() {
	var kucun = $("#sstock").val();
	var chuku = $("#tcount").val();
	if(parseInt(kucun) >= parseInt(chuku)){
        $("#addForm").form("submit", {
            url :"${pageContext.request.contextPath}/thelibrary/add",
            success : function(result) {
                var result = eval('(' + result + ')');
        		
	                if (result.success) {
	                    $.messager.alert("系统提示", "保存成功！");
	                    $("#addChuku").dialog("close");
	                    $("#list").datagrid("reload");
	                } 
	                else {
	                    $.messager.alert("系统提示", "保存失败！");
	                    return;
	                }
            	}
        });
    }else{
		$.messager.alert("系统提示", "没有那么多库存可以出！");
		return;
	}
}

function doUpdate() {
	var sid=$("#sids").val();
	var loid=$("#kwids").val();//选择的库位id
	var zqkwid=$("#ssbidzq").val();//没选择之前的库位id
	alert(loid);
	alert(zqkwid);
	var sgid=$("#hwgid").val();
	 $.post("<%=path%>/storage/updatekw",{'sid':sid,'loid':loid,'zqkwid':zqkwid,'sgid':sgid},function(index){
		 $("#InvebyWin").dialog("close");
         $("#list").datagrid("reload");
         $("#lonamesok").textbox('setValue','');
         $.messager.alert("系统提示", "移库成功！");
		},"json");
}
</script>
</head>
<body>
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
				<th field="sstock" width="5%" align="center">库存量</th>
				<th field="storagetime" width="9%" align="center" formatter="toDate">入库时间</th>
				<th field="user" width="7%" align="center" formatter="toUserName">操作员</th>
			</tr>
		</thead>
	</table>
	<div id="kj" style="padding: 2px;">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="window.print();">打印</a>&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-export1'" onclick="location.href='<%=path %>/export/storageExcel'">导出</a>&nbsp;
		客户：<input id="scname" class="easyui-validatebox easyui-textbox" name="cname" data-options="required:false" />&nbsp;
		货物：<input id="sgname" class="easyui-validatebox easyui-textbox" name="gname" data-options="required:false" />&nbsp;
		库位：<input id="sloname" class="easyui-validatebox easyui-textbox" name="loname" data-options="required:false" />&nbsp;
		条形码编号：<input id="ssbarcadeid" class="easyui-validatebox easyui-textbox" name="sbarcadeid" data-options="required:false" />&nbsp;
		操作员：<input id="username" class="easyui-validatebox easyui-textbox" name="username" data-options="required:false" />
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="seachs();">搜索</a>
	
	  <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="chuku();">出库</a>
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
				<td class="gxiangq"><span id="gnames"></span></td>
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
	
		<div id="InvebyWin" class="easyui-dialog"  buttons="#dlg-buttonInve" data-options="closable:true, closed:true"  style="width:70%;height:420px;padding:5px;text-align:center;">
		<table style="width:100%;height:100%;">
			<tr align="center">
				<td class="tdwidth">移库位之前:</td>
				<td class="gxiangq"><span id="lonames"></span><input id="sids" type=text style="display:none"><input id="kwids" type=text style="display:none">
				<input type="hidden" name="ssbidzq" id="ssbidzq">
				<input type="hidden" name="hwgid" id="hwgid">
				</td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">移库位之后:</td>
				<td class="gxiangq"><input class="easyui-validatebox easyui-textbox" id="lonamesok" name="lonames" data-options="required:false" />
				 <a href="javascript:okInve()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">选择库位</a>
				</td>
			</tr>
		</table>
	</div>
	
		<div id="dlg-buttonInve">
	    <a href="javascript:doUpdate()" class="easyui-linkbutton"
	        iconCls="icon-ok">保存</a> <a href="javascript:closeInveWin()"
	        class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<div id="dlg-buttons">
	    <a href="javascript:doAdd()" class="easyui-linkbutton"
	        iconCls="icon-ok">保存</a> <a href="javascript:closeUserDialog()"
	        class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<div id="addChuku" class="easyui-dialog"
            style="width: 400px;height:350px;padding:10px 10px;" closed="true"
            buttons="#dlg-buttons">
    <form id="addForm"  method="post">
    	<input type="hidden" name="tgid" id="gid2">
    	<input type="hidden" name="sstock" id="sstock"/>
    	<input type="hidden" name="sid" id="sid2"/>
        <table style="border: 2px;border-color: red; ">
            <tr>
                <td>货物名称:</td>
                <td><input class="easyui-textbox" id="goodsName2" style="width: 150px;"  
                      data-options="required:true,novalidate:true"  /></td>
            </tr>
            <tr>
                <td><br/>出库数量:</td>
                <td><br/><input class="easyui-numberbox" id="tcount" style="width: 150px;" name="tcount"
                               data-options="required:true,validType:'length[1,11]',novalidate:true"
                                style="width:150px"></td>
            </tr>
            <tr>
                <td><br/>出库类型:</td>
                <td><br/><select class="easyui-combobox"  style="width: 150px;" name="ttype" data-options="required:true">
                        <option value="预定出库">预定出库</option>
                        <option value="销售出库">销售出库</option>
                        <option value="退货出库">退货出库</option>
                        <option value="报废出库">报废出库</option>
                        <option value="调整出库">调整出库</option>
                    </select>
                </td>
            </tr>
            <tr>
            	<td><br/>出库时间:</td>
                <td><br/><input class="easyui-datebox" name="ttime" data-options="required:true"/></td>
            </tr>
            <tr>
                <td><br/>备注:</td>
                <td><br/>
                   <textarea rows="3" cols="25" name="remarks"></textarea>
                </td>
            </tr>
        </table>
    </form>
</div>

<div id="Inve_easyui_addWin" class="easyui-window" title="选择库位"
		data-options="iconCls:'icon-edit', closable:true, closed:true"
		style="width: 800px; height: 500px; padding: 5px;">
		<form id="Inve_easyui_addform">
			<table id="dgInve" class="easyui-datagrid" toolbar="#okInvesx" data-options="
		url:'<%=path %>/inventory/allInve',
		method:'get', 
		rownumbers:true,
		singleSelect:true,
		autoRowHeight: true,
		pagination:true,
		border:false,
		pageSize:10
	">
				<thead data-options="frozen:true">
					<tr>
						<th field="loid" checkbox="true">编号</th>
						<th field="loname" width="15%">库位名称</th>
						<th field="losize" width="15%">库位尺寸(m)</th>
						<th field="lovolume" width="15%">库位体积(m³)</th>
						<th field="loweight" width="15%">承受重量(t)</th>
						<th field="lolevel" width="15%">库位等级(数字越大等级越高)</th>
						<th field="lostate" width="15%">库位状态(0/开启,1关闭)</th>
					</tr>
				</thead>
			</table>
		</form>
		 
		<a href="javascript:okInvego()"  class="easyui-linkbutton" data-options="iconCls:'icon-search'">点击选择库位</a>
	</div>
	<!-- 菜单 -->
	<div id="okInvesx" style="padding: 2px;">
		<!-- 筛选 -->
		货物名称：<input id="gname" class="easyui-validatebox easyui-textbox" style="width:100px;"/>
		库位名称：<input id="loname" class="easyui-validatebox easyui-textbox" style="width:100px;"/>
		库位等级：<input id="lolevel" class="easyui-validatebox easyui-textbox" style="width:100px;"/>
		库位状态：<input id="lostate" class="easyui-validatebox easyui-textbox" style="width:100px;"/>
		<a href="javascript:selectfiltrate()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">筛选</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
</body>
</html>