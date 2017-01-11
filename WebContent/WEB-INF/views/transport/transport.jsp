<%@ page language="java" contentType="text/html; charset=UTF-8"
	 pageEncoding="UTF-8"%>
<% 
	String path = request.getContextPath(); 
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>承运车辆</title>
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
		url:'<%=path %>/transport/all', 
		method:'get', 
		rownumbers:true,
		autoRowHeight: true,
		singleSelect:true,
		pagination:true,
		border:false,
		pageSize:20,
		fit:true">
		<thead>
			<tr>
				<th data-options="field:'trid',checkbox:true,width:100" align="center">承运编号</th>
				<th data-options="field:'tdrivername',width:100" align="center">司机姓名</th>
				<th data-options="field:'tdriverphone',width:100" align="center">电话号码</th>
				<th data-options="field:'tvehicleid',width:100" align="center">车牌号码</th>
				<th data-options="field:'tvehicletype',width:100" align="center">车辆类型</th>
				<th data-options="field:'tvehiclecapacity',width:100" align="center">车辆容量</th>
				<th data-options="field:'idcard',width:150" align="center">身份证号码</th>
			</tr>
		</thead>
	</table>
	<!-- 菜单 -->
	<div id="tb" style="padding: 2px;">
		<a href="javascript:openTranAddDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >添加</a>
		<a href="javascript:openTranModifyDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" >编辑</a>
		<a href="javascript:deleteTran()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
		<!-- 筛选 --><br />
		司机姓名：<input id="tdrivername" class="easyui-validatebox easyui-textbox" style="width:100px;"/>
		电话号码：<input id="tdriverphone" class="easyui-validatebox easyui-textbox" style="width:100px;"/>
		车牌号码：<input id="tvehicleid" class="easyui-validatebox easyui-textbox" style="width:100px;"/>
		车辆类型：<input id="tvehicletype" class="easyui-validatebox easyui-textbox" style="width:100px;"/>
		车辆容量：<input id="tvehiclecapacity" class="easyui-validatebox easyui-textbox" style="width:100px;"/>
		身份证号码：<input id="idcard" class="easyui-validatebox easyui-textbox" style="width:100px;"/>
		<a href="javascript:selectfiltrateTran()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">筛选</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	<div id="dlg-buttons">
	    <a href="javascript:saveTran()" class="easyui-linkbutton"
	        iconCls="icon-ok">保存</a> <a href="javascript:closeTranDialog()"
	        class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<div id="dlg" class="easyui-dialog"
            style="width: 600px;height:280px;padding:10px 10px;" closed="true"
            buttons="#dlg-buttons">
            <form method="post" id="fm">
                <table cellspacing="8px;">
                    <tr>
                        <td>司机姓名：</td>
                        <td><input type="text" id="tdrivername" name="tdrivername"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>

                        <td>司机电话：</td>
                        <td><input type="text" id="tdriverphone" name="tdriverphone"
                            class="easyui-validatebox " data-options="required:true,validType:'mobile[this]'"/>&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td>车牌号：</td>
                        <td><input type="text" id="tvehicleid" name="tvehicleid"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                        
                        <td>车类型：</td>
                        <td><input type="text" id="tvehicletype" name="tvehicletype"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                    
                         <tr>
                        <td>容量：</td>
                        <td><input type="text" id="tvehiclecapacity" name="tvehiclecapacity"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                        
                        <td>身份证：</td>
                        <td><input type="text" id="idcard" name="idcard"
                            class="easyui-validatebox" data-options="required:true" />&nbsp;<span
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
		
		$.extend($.fn.validatebox.defaults.rules, { 
			mobile: {// 验证手机号码
		        validator: function (value) {
		            return /^(13|15|18)\d{9}$/i.test(value);
		        },
		        message: '手机号码格式不正确'
			},
			 idcared: {     
			        validator: function(value,param){    
			            var flag= isCardID(value);  
			            return flag==true?true:false;    
			        },     
			        message: '不是有效的身份证号码'    
			    },
		})
		
 
		
	    function openTranAddDialog() {
	        $("#dlg").dialog("open").dialog("setTitle", "添加承运车辆");
	        $("#fm").form("clear");
	        url = "${pageContext.request.contextPath}/transport/save.do";
	    }
	    
	    function openTranModifyDialog() {
	        var selectedRows = $("#dg").datagrid("getSelections");
	        if (selectedRows.length != 1) {
	            $.messager.alert("系统提示", "请选择一条要编辑的数据！");
	            return;
	        }
	        var row = selectedRows[0];
	        $("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
	        $("#fm").form("load", row);
	        url = "${pageContext.request.contextPath}/transport/save.do?trid=" + row.trid;
	    }
	    
	    function saveTran() {
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
	    
		 function deleteTran() {
		        var selectedRows = $("#dg").datagrid("getSelections");
		        if (selectedRows.length == 0) {
		            $.messager.alert("系统提示", "请选择要删除的数据！");
		            return;
		        }
		        
		        var strIds = [];
		        for ( var i = 0; i < selectedRows.length; i++) {
		            strIds.push(selectedRows[i].trid);
		        }
		        var ids = strIds.join(",");
		        $.messager.confirm("系统提示", "您确定要删除这<font color=red>"
		                + selectedRows.length + "</font>条数据吗？", function(r) {
		            if (r) {
		                $.post("${pageContext.request.contextPath}/transport/delete.do", {
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
	    
		  function closeTranDialog() {
		        $("#dlg").dialog("close");
		        resetValue();
		    }
		 
	    function resetValue() {
	        $("#tname").val("");
	        $("#tsex").val("");
	        $("#tmes").val("");
	        
	    }
	    
	    function tbsetValue() {
	        $("#tdrivername").textbox('setValue',"");
	        $("#tdriverphone").textbox('setValue',"");
	        $("#tvehicleid").textbox('setValue',"");
	        $("#tvehicletype").textbox('setValue',"");
	        $("#tvehiclecapacity").textbox('setValue',"");
	        $("#idcard").textbox('setValue',"");  
	    }
	    
	    function selectfiltrateTran(){
	    	var tdrivername=$('#tdrivername').textbox('getValue');
	    	var tdriverphone=$('#tdriverphone').textbox('getValue');
	    	var tvehicleid=$('#tvehicleid').textbox('getValue');
	    	var tvehicletype=$('#tvehicletype').textbox('getValue');
	    	var tvehiclecapacity=$('#tvehiclecapacity').textbox('getValue');
	    	var idcard=$('#idcard').textbox('getValue');	
	    	 $("#dg").datagrid("load",{tdrivername:tdrivername,tdriverphone:tdriverphone,tvehicleid:tvehicleid,
	    		 tvehicletype:tvehicletype,tvehiclecapacity:tvehiclecapacity,idcard:idcard});
	    	 tbsetValue();
	    }
	</script>
</body>
</html>