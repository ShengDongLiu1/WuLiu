<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>入库质检管理</title>
		<link rel="stylesheet" type="text/css" href="<%=path %>/js/jquery-easyui/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=path %>/js/jquery-easyui/themes/icon.css">
		<script src="<%=path %>/js/jquery.min.js"></script>
		<script src="<%=path %>/js/jquery-easyui/jquery.easyui.min.js"></script>
		<script src="<%=path %>/js/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
		<script src="<%=path %>/js/hh/punish-Interaction.js"></script>
		<script type="text/javascript">
		$(function(){
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
		</script>
	</head>
	<body>
		<table id="punish_list" class="easyui-datagrid" width="100%" toolbar="#kj" data-options="
			url:'<%=path %>/quality',
			method:'post',
			rownumbers:true,	
			singleSelect:true,
			autoRowHeight:true,
			pagination:true,
			border:false,
			pageSize:10
		">
			<thead data-options="frozen:true">
				<tr>
					<th field="eid" checkbox="true"></th>
					<th field="egid" width="20%">货物名称</th>
					<th field="eeid" width="20%">员工姓名</th>
					<th field="eresult" width="35%">检验结果</th>
					<th field="edate" width="25%">检验时间</th>
				</tr>
			</thead>
		</table>
		<div id="kj">
			<a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="add();">添加</a>
			<!-- 链接按钮控件 -->
			<a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="edit();">修改</a>
			<a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="removeRow();">移除</a>
		</div>
	</body>
</html>