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
		url:'<%=path %>/complaints/allComplaints', 
		method:'get', 
		rownumbers:true,
		autoRowHeight: true,
		pagination:true,
		border:false,
		pageSize:20,
		fit:true">
		<thead>
			<tr>
				<th field="comid" checkbox="true">投诉编号</th>
				<th field="comtype" width="10%">移库类型</th>
				<th field="comcusid" width="10%">客户投诉人</th>
				<th field="comtitle" width="10%">投诉标题</th>
				<th field="comtime" width="10%" formatter="toDate">投诉时间</th>
				<th field="comlevel" width="10%">投诉程度</th>
				<th field="comsysuser" width="10%">投诉员工工号</th>
				<th field="comcontent" width="10%">投诉内容</th>
				<th field="comdescr" width="10%">期望结果</th>
				<th field="comexpect" width="10%">备注说明</th>
			</tr>
		</thead>
	</table>
	<!-- 菜单 -->
	<div id="tb" style="padding: 2px;">
		<!-- 筛选 -->
		投诉人：<input id="comsysuser" name="comsysuser" class="easyui-textbox" style="width:100px;"/>
		投诉类型：<select name="comtype" id="comtype" class="input2"  style="width:90px">
					<option value="" class="easyui-selectbox" selected = "selected">请选择</option>
					<option value="生产类投诉">生产类投诉</option>
					<option value="销售类投诉">销售类投诉</option>
					<option value="品质类投诉">品质类投诉</option>
					<option value="采购类投诉">采购类投诉</option>
					<option value="物流类投诉">物流类投诉</option>
					<option value="其他投诉">其他投诉</option>
				</select>
		投诉员工工号：<input id="comcusid" name="comcusid" class="easyui-textbox" style="width:100px;"/>
		投诉标题：<input id="comtitle" name="comtitle" class="easyui-textbox" style="width:100px;"/>
		投诉程度：<select name="comlevel" id="comlevel" class="input2"  style="width:90px">
					<option value="" selected = "selected">请选择</option>
					<option value="普通">普通</option>
					<option value="紧急">紧急</option>
					<option value="非常紧急">非常紧急</option>
				</select>
		投诉时间：<input id="comtime" name="comtime" class="easyui-datetimebox easyui-textbox" style="width:100px;"/>-
				<input id="comtime1" name="comtime1" class="easyui-datetimebox easyui-textbox" style="width:100px;"/>
		<a href="javascript:selectfiltrateComplaints()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">筛选</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	<div id="dlg-buttons">
	    <a href="javascript:saveTransfer()" class="easyui-linkbutton"
	        iconCls="icon-ok">保存</a> <a href="javascript:closeTransferDialog()"
	        class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
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
		
	    
	    function openTransferModifyDialog() {
	        var selectedRows = $("#dg").datagrid("getSelections");
	        if (selectedRows.length != 1) {
	            $.messager.alert("系统提示", "请选择一条要编辑的数据！");
	            return;
	        }
	        var row = selectedRows[0];
	        $("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
	        $("#fm").form("load", row);
	        url = "${pageContext.request.contextPath}/transfer/save.do?comid=" + row.comid;
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
	        $("#comsysuser").textbox('setValue',"");
	        $("#comtype").prop("selected", 'selected');
	        $("#comcusid").textbox('setValue',"");
	        $("#comtitle").textbox('setValue',"");
	        $("#comlevel").prop("selected", 'selected');
	        $("#comtime").textbox('setValue',"");
	        $("#comtime1").textbox('setValue',"");
	       
	    }
	    
	    function selectfiltrateComplaints(){
	    	
	    	var comsysuser=$('#comsysuser').textbox('getValue');
	    	var comtype=$('#comtype').val();
	    	var comcusid=$('#comcusid').textbox('getValue');
	    	var comtitle=$('#comtitle').textbox('getValue');
	    	var comlevel=$('#comlevel').val();
	    	var comtime=$('#comtime').textbox('getValue');
	    	var comtime1=$('#comtime1').textbox('getValue');
	    	 $("#dg").datagrid("load",{comsysuser:comsysuser,comtype:comtype,comcusid:comcusid,
	    		 comtitle:comtitle,comlevel:comlevel,comtime:comtime,comtime1:comtime1});
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