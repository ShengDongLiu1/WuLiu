<%@ page language="java" contentType="text/html; charset=UTF-8"
	 pageEncoding="UTF-8"%>
<% 
	String path = request.getContextPath(); 
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>已审批出货单</title>
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
	width:70px;
	border-bottom:1px dashed #5F6D88; 
}

.gxiangq2{
	width:70px;
	text-align:left;font-size:15px;
	border-bottom:1px dashed #5F6D88; 
}
.gxiangq span{
	font-size:16px;
	color:blue;
}
.gxiangq2 span{
	font-size:16px;
	color:blue;
}

.easyui-textbox{width:10%;}

.dai{color:green;}

.yishen{color:green;}

.shen{color:red;}

.yichu{color:blue;}


</style>
</head>
<body>
	<table id="list" class="easyui-datagrid" toolbar="#tb" data-options="
		url:'<%=path %>/track/list', 
		method:'get', 
		rownumbers:true,
		autoRowHeight: true,
		singleSelect: true,
		pagination:true,
		border:false,
		pageSize:20,
		fit:true">
		<thead>
			<tr>
				<th data-options="field:'customer',width:100" align="center" formatter="getcname">客户名称</th>
		        <th data-options="field:'tnumber',width:120" align="center">送货单号</th>
		        <th data-options="field:'ttype',width:100" align="center">出货类型</th>
		        <th data-options="field:'gorderstime1',width:150" align="center" formatter="toDate">下单日期</th>
		        <th data-options="field:'goods',width:100" align="center" formatter="goodsName">货物名称</th>
		        <th data-options="field:'tcount',width:100" align="center">实际送货量</th>
		        <th data-options="field:'receipt',width:100" align="center" formatter="getrreceivecount">收货数据量</th>
		        <th data-options="field:'tvehiclecapacity',width:100" align="center">状态</th>	
			</tr>
		</thead>
	</table>
	
		<div id="dlg-buttons">
	    <a href="javascript:doAdd()" class="easyui-linkbutton"
	        iconCls="icon-ok">保存</a> <a href="javascript:closeUserDialog()"
	        class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	
	<!-- 菜单 -->
	<div id="tb" style="padding: 2px;">
		客户姓名：<input id="cname1" class="easyui-validatebox easyui-textbox" name="cname" data-options="required:false" />&nbsp;
		货物名称：<input id="gname1" class="easyui-validatebox easyui-textbox" name="gname" data-options="required:false" />&nbsp;
		出货单号：<input id="tnumber1" class="easyui-validatebox easyui-textbox" name="tnumber" data-options="required:false" />&nbsp;
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="seachs();">搜索</a>
		<br/>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="window.print();">打印</a>&nbsp;
	</div>
	
	<script type="text/javascript">
	
	function getcname(value){
		return value.cname;
	}
	
	function getgorderstime(value){
		return toDate(value.gorderstime);
	}
	
	function getrreceivecount(value){
		return value.rreceivecount;
	}
	
	function goodsName(value){
		return value.gname;
	}
	
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
			
			
			
			/* 关闭窗口 */
			function closeGoodWin(){
				$("#goodbyWin").dialog("close");
			}
			
			
			<%-- //双击
			$("#list").datagrid({   
				//rowIndex 是序号 row是json数据
			 	onDblClickRow:function(rowIndex,row){
			 		$.post("<%=path%>/thelibrary/thelibraryByid",{'tid':row.tid},function(index){
			 			chakan(index);
					},"json");
			    }
			}); --%>
			
			
			
		/* 	 function closeUserDialog() {
				    $("#addChuku").dialog("close");
				    $("#list").datagrid("reload");
				}
			  */
			 
			 
			
			/* 搜索 */
			function seachs(){
				var cname = $('#cname1').textbox('getValue');
				var gname = $('#gname1').textbox('getValue');
				var tnumber = $("#tnumber1").textbox('getValue');
				$('#list').datagrid('load',{  
					cname:cname,
					gname:gname,
					tnumber:tnumber
				}); 
			}
			
		
			
	</script>
	
	
	
</body>
</html>