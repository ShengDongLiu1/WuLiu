<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%String path=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>库位列表</title>
<link rel="stylesheet" href="<%=path %>/js/jquery-easyui/themes/default/easyui.css"/>
<link rel="stylesheet" href="<%=path %>/js/site_main.css"/>
<link rel="stylesheet" type="text/css" href="<%=path %>/js/jquery-easyui/themes/icon.css">
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=path %>/js/site_easyui.js"></script>
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
var url;
$(function() {
	setPagination("list");
});
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

function saveInventory() {
    $("#fm").form("submit", {
        url : url,
        success : function(result) {
            var result = eval('(' + result + ')');
            if (result.success) {
                $.messager.alert("系统提示", "保存成功！");
                $("#dlg").dialog("close");
                $("#dg").datagrid("load");
                resetValue();
                
            } else {
                $.messager.alert("系统提示", "保存失败！");
                return;
            }
        }
    });
}

function deleteInventory() {
    var selectedRows = $("#dg").datagrid("getSelections");
    if (selectedRows.length == 0) {
        $.messager.alert("系统提示", "请选择要删除的数据！");
        return;
    }
    var strIds = [];
    for ( var i = 0; i < selectedRows.length; i++) {
        strIds.push(selectedRows[i].loid);
    }
    var ids = strIds.join(",");
    $.messager.confirm("系统提示", "您确定要删除这<font color=red>"
            + selectedRows.length + "</font>条数据吗？", function(r) {
        if (r) {
            $.post("${pageContext.request.contextPath}/inventory/delete.do", {
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

function openInventoryModifyDialog() {
    var selectedRows = $("#dg").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请选择一条要编辑的数据！");
        return;
    }
    var row = selectedRows[0];
    $("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
    $("#fm").form("load", row);
    url = "${pageContext.request.contextPath}/inventory/save.do?loid=" + row.loid;
}

function openInventoryAddDialog() {
    $("#dlg").dialog("open").dialog("setTitle", "添加用户");
    $("#fm").form("clear");
    url = "${pageContext.request.contextPath}/inventory/save.do";
}

function closeInventoryDialog() {
    $("#dlg").dialog("close");
    resetValue();
}

function goodsName(value){
	return value.gname;
}

</script>
<style>
	body{margin:0px;padding:0px;}
</style>
</head>
<body>
	<div>当前位置：</div>
	<table id="dg" class="easyui-datagrid" toolbar="#tb" style="width:100%" data-options="
		url:'<%=path %>/inventory/allInve',
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
				<th field="loid" checkbox="true">编号</th>
				<th field="goods" width="10%" formatter="goodsName">货物名称</th>
				<th field="loname" width="10%">库位名称</th>
				<th field="losize" width="15%">库位尺寸</th>
				<th field="lovolume" width="15%">库位体积</th>
				<th field="loweight" width="15%">承受重量</th>
				<th field="lolevel" width="15%">库位等级</th>
				<th field="lostate" width="15%">库位状态</th>
			</tr>
		</thead>
	</table>
	<!-- 菜单 -->
	<div id="tb" style="padding: 2px;">
		<a href="javascript:openInventoryAddDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >添加</a>
		<a href="javascript:openInventoryModifyDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" >编辑</a>
		<a href="javascript:deleteInventory()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" >删除</a>
	</div>
	
	<div id="dlg-buttons">
	    <a href="javascript:saveInventory()" class="easyui-linkbutton"
	        iconCls="icon-ok">保存</a> <a href="javascript:closeInventoryDialog()"
	        class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<div id="dlg" class="easyui-dialog"
            style="width: 730px;height:280px;padding:10px 10px;" closed="true"
            buttons="#dlg-buttons">
            <form method="post" id="fm">
                <table cellspacing="8px;">
                    <tr>
                        <td>库位名称：</td>
                        <td><input type="text" id="loname" name="loname"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>库位尺寸 ：</td>
                        <td><input type="text" id="losize" name="losize"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td>库位体积 ：</td>
                        <td><input type="text" id="lovolume" name="lovolume"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>承受重量：</td>
                        <td><input type="text" id="loweight" name="loweight"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td>库位等级：</td>
                        <td><input type="text" id="lolevel" name="lolevel"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
</body>
</html>