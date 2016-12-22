<%@ page language="java" contentType="text/html; charset=UTF-8"
	 pageEncoding="UTF-8"%>
<% 
	String path = request.getContextPath(); 
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>移库</title>
<link rel="stylesheet" href="<%=path %>/js/jquery-easyui/themes/default/easyui.css"/>
<link rel="stylesheet" href="<%=path %>/js/site_main.css"/>
<link rel="stylesheet" type="text/css" href="<%=path %>/js/jquery-easyui/themes/icon.css">
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=path %>/js/site_easyui.js"></script>
</head>
<body>
	<table id="dg" class="easyui-datagrid" toolbar="#tb" data-options="
		url:'<%=path %>/transfer/allTransfer', 
		method:'get', 
		rownumbers:true,
		autoRowHeight: true,
		pagination:true,
		border:false,
		pageSize:20,
		fit:true">
		<thead>
			<tr>
				<th field="tid" checkbox="true">编号</th>
				<th field="goods" width="10%" formatter="goodsName">货物名称</th>
				<th field="sys" width="10%" formatter="sysuserName">员工名字</th>
				<th field="treason" width="10%">移库原因</th>
				<th field="tdate" width="10%" formatter="toDate">移库时间</th>
			</tr>
		</thead>
	</table>
	<!-- 菜单 -->
	<div id="tb" style="padding: 2px;">
		<!-- 筛选 -->
		货物名称：<input id="gname" class="easyui-validatebox easyui-textbox" style="width:100px;"/>
		员工名字：<input id="username" class="easyui-validatebox easyui-textbox" style="width:100px;"/>
		移库原因：<input id="treason" class="easyui-validatebox easyui-textbox" style="width:100px;"/>
		移库时间：<input id="tdate" class="easyui-datetimebox easyui-textbox" style="width:100px;"/>-
				<input id="tdates" class="easyui-datetimebox easyui-textbox" style="width:100px;"/>
		<a href="javascript:selectfiltrateTransfer()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">筛选</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	<div id="dlg-buttons">
	    <a href="javascript:saveTransfer()" class="easyui-linkbutton"
	        iconCls="icon-ok">保存</a> <a href="javascript:closeTransferDialog()"
	        class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<div id="dlg" class="easyui-dialog"
            style="width: 600px;height:280px;padding:10px 10px;" closed="true"
            buttons="#dlg-buttons">
            <form method="post" id="fm">
                <table cellspacing="8px;">
                    <tr>
                        <td>货物名称：</td>
                        <td><input id="tdrivername" name="tdrivername"
                            class="easyui-textbox" required="true" readonly/>&nbsp;<span
                            style="color: red">*</span>
                            <input type="button" onclick="add_goods();" value="点击选择货物" style="width:100px;"/>
                        </td>
					</tr>
					<tr>
                        <td>员工名字：</td>
                        <td><input id="tdriverphone" name="tdriverphone"
                            class="easyui-textbox" required="true" readonly/>&nbsp;<span
                            style="color: red">*</span>
                            <input type="button" onclick="add_sysuser();" value="点击选择员工" style="width:100px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td>移库原因：</td>
                        <td><input id="tvehicleid" name="tvehicleid"
                            class="easyui-textbox " required="true" data-options="multiline:true" style="width:100%;height:70px"/>&nbsp;<span
                            style="color: red">*</span>
                        </td>
                        </tr>
                        <tr>
                        <td> 移库时间：</td>
                        <td><input id="tvehicletype" name="tvehicletype"
                            class="easyui-datetimebox" required="true" data-options="multiline:true"/>&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                    
                </table>
            </form>
        </div>

	<div id="goods_easyui_addWin" class="easyui-window" title="添加货物" data-options="iconCls:'icon-add', closable:true, closed:true"  style="width:100%;height:500px;padding:5px;text-align:center;">
		<form id="goods_easyui_addform">
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
		</form>
	</div>
	<script type="text/javascript">
		var url;
		$(function() {
			setPagination("list");
		});
		// 显示数据
		function setPagination(tableId) {
			var p = $("#" + tableId).datagrid("getPager"); // 获取由tableId指定的datagrid控件的分页组件
			$(p).pagination({
				pageSize:20,
				pageList:[20,30,40],
				beforePageText:"第",
				afterPageText:"页    共{pages}页",
				displayMsg:"当前显示{from} - {to} 条记录    共{total}条记录",
				onBeforeRefresh:function() {
					$(this).pagination("loading");
					$(this).pagination("loaded");
				}
			});
		}
		

	    function openTransferAddDialog() {
	        $("#dlg").dialog("open").dialog("setTitle", "添加承运车辆");
	        $("#fm").form("clear");
	        url = "${pageContext.request.contextPath}/transfer/save.do";
	    }
	    
	    function openTransferModifyDialog() {
	        var selectedRows = $("#dg").datagrid("getSelections");
	        if (selectedRows.length != 1) {
	            $.messager.alert("系统提示", "请选择一条要编辑的数据！");
	            return;
	        }
	        var row = selectedRows[0];
	        $("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
	        $("#fm").form("load", row);
	        url = "${pageContext.request.contextPath}/transfer/save.do?tid=" + row.tid;
	    }
	    
	    function saveTransfer() {
	        $("#fm").form("submit", {
	            url : url,
	            success : function(result) {
	                var result = eval('(' + result + ')');
	                if (result.success) {
	                    $.messager.alert("系统提示", "保存成功！");
	                    resetValue();
	                    $("#dlg").dialog("close");
	                    $("#dg").datagrid("load");
	                } else {
	                    $.messager.alert("系统提示", "保存失败！");
	                    return;
	                }
	            }
	        });
	    }
	    
	    function goodsName(value){
	    	return value.gname;
	    }
	    function sysuserName(value){
	    	return value.username;
	    }
	    
		 function deleteTransfer() {
		        var selectedRows = $("#dg").datagrid("getSelections");
		        if (selectedRows.length == 0) {
		            $.messager.alert("系统提示", "请选择要删除的数据！");
		            return;
		        }
		        
		        var strIds = [];
		        for ( var i = 0; i < selectedRows.length; i++) {
		            strIds.push(selectedRows[i].tid);
		        }
		        var ids = strIds.join(",");
		        $.messager.confirm("系统提示", "您确定要删除这<font color=red>"
		                + selectedRows.length + "</font>条数据吗？", function(r) {
		            if (r) {
		                $.post("${pageContext.request.contextPath}/transfer/delete.do", {
		                    ids : ids
		                }, function(result) {
		                    if (result.success) {
		                        $.messager.alert("系统提示", "数据已成功删除！");
		                        $("#dg").datagrid("load");
		                    } else {
		                        $.messager.alert("系统提示", "数据删除失败，请联系系统管理员！");
		                    }
		                }, "json");
		            }
		        });
		    }
	    
		  function closeTransferDialog() {
		        $("#dlg").dialog("close");
		        resetValue();
		    }
		 
	    function resetValue() {
	        $("#tname").val("");
	        $("#tsex").val("");
	        $("#tmes").val("");
	        
	    }
	    
	    function tbsetValue() {
	        $("#gname").textbox('setValue',"");
	        $("#username").textbox('setValue',"");
	        $("#treason").textbox('setValue',"");
	        $("#tdate").textbox('setValue',"");
	        $("#tdates").textbox('setValue',""); 
	    }
	    
	    function selectfiltrateTransfer(){
	    	var gname=$('#gname').textbox('getValue');
	    	var username=$('#username').textbox('getValue');
	    	var treason=$('#treason').textbox('getValue');
	    	var tdate=$('#tdate').textbox('getValue');
	    	var tdates=$('#tdates').textbox('getValue');	
	    	 $("#dg").datagrid("load",{gname:gname,username:username,treason:treason,
	    		 tdate:tdate,tdates:tdates});
	    	 tbsetValue();
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
	    
		function add_goods(){	
			$("#goods_easyui_addWin").window("open");
		}
	</script>
</body>
</html>