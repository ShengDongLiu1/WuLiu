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
			
			$("#list").datagrid({
				onRowContextMenu:function(e,rowIndex,rowData){
					e.preventDefault();
					$("#mm").menu('show',{
						left:e.pageX,
						top:e.pageY	
					});
				}
			});
			
			//双击
			$("#list").datagrid({   
				//rowIndex 是序号 row是json数据
			 	onDblClickRow:function(rowIndex,row){
			 		$.post("<%=path%>/quality/qualityByid",{'eid':row.eid},function(index){
			 			fuzhi(index);
					},"json");
			    }
			})
			
		});
		
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
		
		/* 表格按钮 */
		function toSub(value,rec){
			var btn="<a href='javascript:openQualityWin("+rec.eid+")'>详情</a>";
			btn+="&nbsp;&nbsp;<a href='#' onclick=''>批准</a>";
			return btn;
		}
		
		/* 打开详情窗口 */
		function openQualityWin(eid) {
			alert(eid);
			$.post("<%=path%>/quality/qualityByid",{'eid':eid},function(index){
				fuzhi(index);
			},"json");
		    
		}

		/* 给弹出的窗口赋值 */
		function fuzhi(index){
			$("#qualityByWin").dialog("open").dialog("setTitle", "入库质检详情");
		}

		
		/* 员工姓名 */
		function employeeName(value){
			return value.ename;
		}
		
		/* 订单号 */
		function goodsNumber(value){
			return value.gordernumber;
		}
		</script>
	</head>
	<body>
		<table id="list" class="easyui-datagrid" toolbar="#kj" style="width:100%" data-options="
		url:'<%=path %>/quality/queryAll',
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
				<th field="goods" width="15%" align="center" formatter="goodsNumber">货物订单号</th>
				<th field="employee" width="15%" align="center" formatter="employeeName">员工姓名</th>
				<th field="eresult" width="35%" align="center">检验结果</th>
				<th field="edate" width="15%" align="center" formatter="toDate">检验时间</th>
				<th field="null" width="17%" align="center" formatter="toSub">操作</th>
			</tr>
		</thead>
	</table>
	<!-- 菜单 -->
	<div id="kj" style="padding: 2px;">
		订单号：<input id="sgordernumber" class="easyui-validatebox easyui-textbox" name="gordernumber" data-options="required:false" />
		员工：<input id="sgordernumber" class="easyui-validatebox easyui-textbox" name="gordernumber" data-options="required:false" />
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="seachs();">搜索</a>
		<br />
		<a href="javascript:openUserAddDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >添加</a>
		<a href="javascript:openUserModifyDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" >编辑</a>
		<a href="javascript:deleteTest()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" >删除</a>
	</div>
	<div id="qualityByWin" class="easyui-dialog"  buttons="#dlg-buttons" data-options="closable:true, closed:true"  style="width:50%;height:580px;padding:5px;text-align:center;">
	</div>
		
	</body>
</html>