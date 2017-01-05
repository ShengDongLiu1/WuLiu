<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>出库质检管理</title>
		<link rel="stylesheet" type="text/css" href="<%=path %>/js/jquery-easyui/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=path %>/js/jquery-easyui/themes/icon.css">
		<script src="<%=path %>/js/jquery.min.js"></script>
		<script src="<%=path %>/js/jquery-easyui/jquery.easyui.min.js"></script>
		<script src="<%=path %>/js/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
		<script src="<%=path %>/js/hh/punish-Interaction.js"></script>
		<style type="text/css">
			body{margin:0px;padding:0px;}
			.tdwidth{
				width:15%;text-align:right;font-size:15px;
			}
			.gxiangq{
				text-align:left;font-size:15px;
				border-bottom:1px dashed #5F6D88; 
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
			
			.dai{color:green;}
			
			.yi{color:orange;}
			
			.ju{color:red;}
		</style>
		<script type="text/javascript">
			/* 员工姓名 */
			function sysuserName(value){
				return value.usertruename;
			}
			
			/* 货物名称 */
			function goodsName(value){
				return value.gname;
			}
			
			function recStatus(value){
				var status='';
				if(value.tstate=='4'){
					status="<span class='dai'>待检验</span>"
				}else if(value.tstate=='1'){
					status="<span class='yi'>检验通过</span>"
				}else if(value.tstate=='5'){
					status="<span class='ju'>检验失败</span>"
				}
				return status;
			}
			
			/* 搜索 */
			function seachs(){
				var gname = $('#gnameSearch').textbox('getValue');
				var usertruename = $('#usernameSearch').textbox('getValue');
				var rstart = $('#rstartSearch').combobox('getValue');
				$('#dg').datagrid('load',{  
					gname:gname,
					usertruename:usertruename,
					rstart:rstart
				}); 
			}
		</script>
	</head>
	<body>
		<table id="dg" class="easyui-datagrid" toolbar="#kj" style="width:100%" data-options="
		url:'<%=path %>/quality/queryAll2',
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
				<th field="eid" checkbox="true"></th>
				<th field="goods" width="15%" align="center" formatter="goodsName">货物名称</th>
				<th field="sysusers" width="15%" align="center" formatter="sysuserName">员工姓名</th>
				<th field="eresult" width="25%" align="center">检验结果</th>
				<th field="thelibrary" width="10%" align="center" formatter="recStatus">货物状态</th>
				<th field="edate" width="15%" align="center" formatter="toDate">检验时间</th>
				<th field="null" width="17%" align="center" formatter="toSub">操作</th>
			</tr>
		</thead>
	</table>
	</body>
	<script>
	var url;
	$(function() {
		setPagination("dg");
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
			if(obj == null){return '暂无';}
			var date = new Date();
			 date.setTime(obj.time);
			 date.setHours(obj.hours);
			 date.setMinutes(obj.minutes);
			 date.setSeconds(obj.seconds);
			return formatDateTime(date);
		}
		
		/* 表格按钮 */
		function toSub(value,obj){
			var btn="&nbsp;<a href='javascript:openGoodWin()'>详情</a>"
			btn+="&nbsp;<a href='javascript:openTrueWin()'>通过</a>";
			btn+="&nbsp;<a href='javascript:openFalseWin()'>失败</a>"
			return btn;
		}
		
		
		function getNowFormatDate(edate) {
		    var date = new Date();
		    var seperator1 = "-";
		    var seperator2 = ":";
		    var month = date.getMonth() + 1;
		    var strDate = date.getDate();
		    if (month >= 1 && month <= 9) {
		        month = "0" + month;
		    }
		    if (strDate >= 0 && strDate <= 9) {
		        strDate = "0" + strDate;
		    }
		    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
		            + " " + date.getHours() + seperator2 + date.getMinutes()
		            + seperator2 + date.getSeconds();
		    return currentdate;
		} 
		
		/* 打开详情窗口 */
		function openGoodWin(eid) {
			$.post("<%=path%>/quality/qualityByid",{'eid':eid},function(index){
				fuzhi(index);
			},"json");
		    
		}

		</script>
</html>