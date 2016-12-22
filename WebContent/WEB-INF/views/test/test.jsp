<%@ page language="java" contentType="text/html; charset=UTF-8"
	 pageEncoding="UTF-8"%>
<% 
	String path = request.getContextPath(); 
	String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试</title>
<link rel="stylesheet" href="<%=path %>/js/jquery-easyui/themes/default/easyui.css"/>
<link rel="stylesheet" href="<%=path %>/js/site_main.css"/>
<link rel="stylesheet" type="text/css" href="<%=path %>/js/jquery-easyui/themes/icon.css">
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=path %>/js/site_easyui.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>assets/jslib/bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>assets/css/theme.css">
</head>
<body>
	
	<table id="dg" class="easyui-datagrid" toolbar="#tb" data-options="
		url:'<%=path %>/test/queryAll', 
		method:'get', 
		rownumbers:true,
		autoRowHeight: true,
		pagination:true,
		border:false,
		fit:true">
		<thead>
			<tr>
				<th data-options="field:'tid',checkbox:true,width:100" align="center">编号</th>
				<th data-options="field:'tname',width:100" align="center">姓名</th>
				<th data-options="field:'tsex',width:100" align="center">性别</th>
				<th data-options="field:'tmes',width:100" align="center">绰号</th>
				<th data-options="field:'tdate',width:120" align="center" formatter="toDate">时间</th>
			</tr>
		</thead>
	</table>
	<!-- 菜单 -->
	<div id="tb" style="padding: 2px;">
		<div class="header">
			<h1 class="page-title">
				测试
			</h1>
		</div>
		<a href="javascript:openUserAddDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >添加</a>
		<a href="javascript:openUserModifyDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" >编辑</a>
		<a href="javascript:deleteTest()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" >删除</a>
		<a href="javascript:daochuTest()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" >导出</a>
	</div>

	<div id="dlg-buttons">
	    <a href="javascript:saveUser()" class="easyui-linkbutton"
	        iconCls="icon-ok">保存</a> <a href="javascript:closeUserDialog()"
	        class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<div id="dlg" class="easyui-dialog"
            style="width: 730px;height:280px;padding:10px 10px;" closed="true"
            buttons="#dlg-buttons">
            <form method="post" id="fm">
                <table cellspacing="8px;">
                    <tr>
                        <td>姓名：</td>
                        <td><input id="tname" name="tname"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>性别：</td>
                        <td><input id="tsex" name="tsex"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td>绰号：</td>
                        <td><input id="tmes" name="tmes"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>时间：</td>
                        <td><input id="tdate" name="tdate"
                            class="easyui-datetimebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
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
				pageSize:10,
				pageList:[10,20,30],
				beforePageText:"第",
				afterPageText:"页    共{pages}页",
				displayMsg:"当前显示{from} - {to} 条记录    共{total}条记录",
				onBeforeRefresh:function() {
					$(this).pagination("loading");
					$(this).pagination("loaded");
				}
			});
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

	    function openUserAddDialog() {
	        $("#dlg").dialog("open").dialog("setTitle", "添加用户");
	        url = "${pageContext.request.contextPath}/test/save.do";
	    }
	    
	    function openUserModifyDialog() {
	        var selectedRows = $("#dg").datagrid("getSelections");
	        if (selectedRows.length != 1) {
	            $.messager.alert("系统提示", "请选择一条要编辑的数据！");
	            return;
	        }
	        var row = selectedRows[0];
	        $("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
	        $("#fm").form("load", row);
	        url = "${pageContext.request.contextPath}/test/save.do?tid=" + row.tid;
	    }
	    
	    function saveUser() {
	        $("#fm").form("submit", {
	            url : url,
	            success : function(result) {
	                var result = eval('(' + result + ')');
	                if (result.success) {
	                    $.messager.alert("系统提示", "保存成功！");
	                    resetValue();
	                    $("#dlg").dialog("close");
	                    $("#dg").datagrid("reload");
	                } else {
	                    $.messager.alert("系统提示", "保存失败！");
	                    return;
	                }
	            }
	        });
	    }
	    
	    function resetValue() {
	        $("#tname").val("");
	        $("#tsex").val("");
	        $("#tmes").val("");
	        $("#tdate").datetimebox("setValue","");
	    }
	    
	    function closeUserDialog() {
	        $("#dlg").dialog("close");
	        resetValue();
	    }

		 function deleteTest() {
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
		                $.post("${pageContext.request.contextPath}/test/delete.do", {
		                    ids : ids
		                }, function(result) {
		                    if (result.success) {
		                        $.messager.alert("系统提示", "数据已成功删除！");
		                        $("#dg").datagrid("reload");
		                    } else {
		                        $.messager.alert("系统提示", "数据删除失败，请联系系统管理员！");
		                    }
		                }, "json");
		            }
		        });
		    }
		    
		    function daochuTest() {
		    	window.location.href='<%=path %>/test/daochu.do?page=1&rows=100';
		    	$.messager.alert('提示', '导出成功', 'info');
		    }
	</script>
</body>
</html>