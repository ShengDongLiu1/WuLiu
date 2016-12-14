<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%String path=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>入库列表</title>
<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.5/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.5/themes/icon.css">
<script src="<%=path %>/jquery-easyui-1.5/jquery.min.js"></script>
<script src="<%=path %>/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script src="<%=path %>/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
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
	
	$("#news").click(function(){
		$.messager.alert("提示","新建菜单","info");
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

function goodsName(value){
	return value.gname;
}

function inventoryName(value){
	return value.loname;
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

</script>
<style>
	body{margin:0px;padding:0px;}
</style>
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
		pageSize:10
	">
		<thead data-options="frozen:true">
			<tr>
				<th field="sid" checkbox="true">编号</th>
				<th field="customer" width="10%" formatter="customerName">客户</th>
				<th field="goods" width="10%" formatter="goodsName">货物名称</th>
				<th field="inventory" width="7%" formatter="inventoryName">库位名称</th>
				<th field="storagemode" width="10%">入库类型</th>
				<th field="storagecount" width="7%">入库数量</th>
				<th field="storagebarcode" width="28%" align="center" formatter="toImage">条形码</th>
				<th field="sbarcadeid" width="15%">条形码编号</th>
				<th field="storagetime" width="10%" align="center" formatter="toDate">入库时间</th>
			</tr>
		</thead>
	</table>
	
</body>
</html>