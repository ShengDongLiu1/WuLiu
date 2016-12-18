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

<style>
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
</head>
<body>

	<table id="dg" class="easyui-datagrid" toolbar="#tb" style="width:100%" data-options="
		url:'<%=path %>/inventory/allInve',
		method:'get', 
		rownumbers:true,
		autoRowHeight: true,
		pagination:true,
		border:false,
		pageSize:10,
		fit:true
	">
		<thead data-options="frozen:true">
			<tr>
				<th field="loid" checkbox="true">编号</th>
				<th field="goods" width="10%" formatter="goodsName">货物名称</th>
				<th field="loname" width="10%">库位名称</th>
				<th field="losize" width="10%">库位尺寸(m)</th>
				<th field="lovolume" width="10%">库位体积(m³)</th>
				<th field="loweight" width="10%">承受重量(t)</th>
				<th field="lolevel" width="15%">库位等级(数字越大等级越高)</th>
				<th field="lostate" width="15%">库位状态(0/开启,1关闭)</th>
				<th field="null" width="18%" align="center" formatter="toSub">操作</th>
			</tr>
		</thead>
	</table>
	<!-- 菜单 -->
	<div id="tb" style="padding: 2px;">
		<a href="javascript:openInventoryAddDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >添加</a>
		<a href="javascript:openInventoryModifyDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" >编辑</a>
		<a href="javascript:deleteInventory()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" >删除</a>
		
		<!-- 筛选 -->
		货物名称：<input id="gname" class="easyui-validatebox easyui-textbox" style="width:100px;" data-options="iconCls:'icon-search'" />
		库位名称：<input id="loname" class="easyui-validatebox easyui-textbox" style="width:100px;" data-options="iconCls:'icon-search'" />
		库位等级：<input id="lolevel" class="easyui-validatebox easyui-textbox" style="width:100px;" data-options="iconCls:'icon-search'" />
		库位状态：<input id="lostate" class="easyui-validatebox easyui-textbox" style="width:100px;" data-options="iconCls:'icon-search'" />
		<a href="javascript:selectfiltrate()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">筛选</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	
	<div id="dlg-buttons">
	    <a href="javascript:saveInventory()" class="easyui-linkbutton"
	        iconCls="icon-ok">保存</a> <a href="javascript:closeInventoryDialog()"
	        class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<div id="dlg-buttons2">
	    <a href="javascript:closeInventoryDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
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
        <!-- 查看库位货物窗口-->
        <div id="InvebyWin" class="easyui-dialog"  buttons="#dlg-buttons2" data-options="closable:true, closed:true"  style="width:70%;height:420px;padding:5px;text-align:center;">
		<table style="width:100%;height:100%;">
			<tr>
				<td class="tdwidth">库位名称:</td>
				<td class="gxiangq"><input type="text" id="loname1" style="border: 0px;" readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="tdwidth">货物名称:</td>
				<td class="gxiangq"><input id="gname1" type="text" style="border: 0px;" readonly="readonly" ></input></td>
				<td class="tdwidth">货物订单号:</td>
				<td class="gxiangq"><input id="gordernumber1" type="text" style="border: 0px;" readonly="readonly"></input></td>
				<td class="tdwidth">货物重量:</td>
				<td class="gxiangq"><input id="gweight1" type="text" style="border: 0px;" readonly="readonly"></input ></td>
			</tr>
		</table>
		</div>
<script type="text/javascript">
var url;
$(function() {
	setPagination("dg");
});
// 显示数据
function setPagination(tableId) {
	var p = $("#"+tableId).datagrid("getPager"); // 获取由tableId指定的datagrid控件的分页组件
	$(p).pagination({
		pageList:[10,15,20,25,30],
		beforePageText:"第",
		afterPageText:"页     共{pages}页",
		displayMsg:"当前显示{from} - {to} 条记录    共{total}条记录",
		onBeforeRefresh:function() {
			$(this).pagination("loading");
			$(this).pagination("loaded");
		}
	});
}
	
function saveInventory() {
    $("#fm").form("submit", {
        url : url,
        success : function(result) {
            var result = eval('(' + result + ')');
            if (result.success) {
                $.messager.alert("系统提示", "保存成功！");
                $("#dlg").dialog("close");
                
                resetValue();
                $("#dg").datagrid("load");
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

function selectfiltrate(){
	var names=$('#gname').textbox('getValue');
	var loname=$('#loname').textbox('getValue');
	var lolevel=$('#lolevel').textbox('getValue');
	var lostate=$('#lostate').textbox('getValue');
	 $("#dg").datagrid("load",{gname:names,loname:loname,lolevel:lolevel,lostate:lostate});
	
}

/* 表格按钮 */
function toSub(value,rec){
	var btn="<a href='javascript:openInveWin("+rec.loid+")' onclick=''>库位存放情况</a>";
	btn+="&nbsp;&nbsp;<a href='javascript:NOInveWin("+rec.loid+")' onclick=''>开启/关闭</a>";
	return btn;
}

/* 打开详情窗口 */
function openInveWin(loid) {
	$.post("<%=path%>/inventory/invenOpen",{'loid':loid},function(index){
		fuzhi(index);
	},"json");
    
}
/* 给库位关闭开启 */
function NOInveWin(loid){
	$.post("<%=path%>/inventory/NOInveWin",{'loid':loid},function(index){
		alert(index);
		 $("#dg").datagrid("load");
	},"json");
}
/* 给弹出的窗口赋值 */
function fuzhi(index){
	
	for(var i=0;i<index.inventory.length;i++){ 
		$("#loname1").val(index.inventory[i].loname);
		$("#gname1").val(a2+index.inventory[i].goods.gname);
		$("#gordernumber1").val(index.inventory[i].goods.gordernumber);
		$("#gweight1").val(index.inventory[i].goods.gweight);
	}
	$("#InvebyWin").dialog("open").dialog("setTitle", "库位货物详情");
	
}
function closeInventoryDialog() {	
    $("#InvebyWin").dialog("close");
    resetValue();
}

function goodsName(value){
	return value.gname;
}

</script>
        
</body>
</html>