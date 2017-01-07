<%@ page language="java" contentType="text/html; charset=UTF-8"
	 pageEncoding="UTF-8"%>
<% 
	String path = request.getContextPath(); 
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出库单</title>
<link rel="stylesheet" href="<%=path %>/js/jquery-easyui/themes/default/easyui.css"/>
<link rel="stylesheet" href="<%=path %>/js/site_main.css"/>
<link rel="stylesheet" type="text/css" href="<%=path %>/js/jquery-easyui/themes/icon.css">
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=path %>/js/site_easyui.js"></script>
<style type="text/css">

body{margin:0px;padding:0px;}
.td width{
	width:18%;text-align:right;font-size:15px;
}

.easyui-textbox{width:10%;}

.dai{color:green;}

.yishen{color:green;}

.shen{color:red;}
</style>

</head>
<body>
	<table id="list" class="easyui-datagrid" toolbar="#tb" data-options="
		url:'<%=path %>/thelibrary/all?query=1', 
		method:'get', 
		rownumbers:true,
		autoRowHeight: true,
		pagination:true,
		border:false,
		pageSize:20,
		fit:true">
		<thead>
			<tr>
				<th data-options="field:'tid',checkbox:true,width:100" align="center">出货编号</th>
				<th data-options="field:'goods',width:100" align="center" formatter="goodsName">货物名称</th>
				<th data-options="field:'tcount',width:100" align="center">出库数量</th>
				<th data-options="field:'ttype',width:100" align="center">出库类型</th>
				<th data-options="field:'tstate',width:100" align="center" formatter="state1">状态</th>
				<th data-options="field:'remarks',width:100" align="center">备注</th>
				<th data-options="field:'ttime',width:100" align="center" formatter="toDate">出库时间</th>
			</tr>
		</thead>
	</table>
	<!-- 菜单 -->
	<div id="tb" style="padding: 2px;">
		<a href="javascript:tongguo()" class="easyui-linkbutton" data-options="iconCls:'icon-sum'" >通过审批</a>
		货物名称：<input id="sgname2" class="easyui-validatebox easyui-textbox" name="gname" data-options="required:false" />&nbsp;
		出货类型：<select class="easyui-combobox"  style="width: 150px;" name="ttype" id="ttype2" data-options="required:true" >
                    <option draggable="false" value="">请选择类型</option>
                     <option value="预定出库">预定出库</option>
                     <option value="销售出库">销售出库</option>
                     <option value="退货出库">退货出库</option>
                     <option value="报废出库">报废出库</option>
                     <option value="调整出库">调整出库</option>
              	 </select>&nbsp;
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="seachs();">搜索</a>
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
			
			
			function tongguo() {
				 var row = $("#list").datagrid("getSelected");
				 if(row){
					  $.post("${pageContext.request.contextPath}/thelibrary/add", {
		                    tid : row.tid,tstate : 2
		                }, function(result) {
		                    if (result.success) {
		                        $.messager.alert("系统提示", "审批成功！");
		                        $("#list").datagrid("reload");
		                    } else {
		                        $.messager.alert("系统提示", "审批失败！");
		                    }
		                }, "json");
				 }else {
			        $.messager.alert('提示', '请选中一行需要出库的记录', 'info');
			    }
			}
			
			function goodsName(value){
				return value.gname;
			}
			function state1(value){
				if(value==1){
					return "<span class='shen'>未审批</span>";
				}else if(value==2 || value==3){
					return "<span class='yishen'>已审批</span>";
				}
			}
			
			
			/* 搜索 */
			function seachs(){
				var gname = $('#sgname2').textbox('getValue');
				var ttype = $('#ttype2').combobox('getValue');
				$('#list').datagrid('load',{  
					gname:gname,
					ttype:ttype
				}); 
			}
	</script>
</body>
</html>