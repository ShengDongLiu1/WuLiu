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
		url:'<%=path %>/thelibrary/all?query=2', 
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
				<th data-options="field:'transport',width:100" align="center" formatter="gettdrivername">司机姓名</th>
				<th data-options="field:'tstate',width:100" align="center" formatter="state1">状态</th>
				<th data-options="field:'remarks',width:100" align="center">备注</th>
				<th data-options="field:'ttime',width:100" align="center" formatter="toDate">出库时间</th>
			</tr>
		</thead>
	</table>
	
		<div id="dlg-buttons">
	    <a href="javascript:doAdd()" class="easyui-linkbutton"
	        iconCls="icon-ok">保存</a> <a href="javascript:closeUserDialog()"
	        class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<div id="addChuku" class="easyui-dialog"
            style="width: 400px;height:350px;padding:10px 10px;" closed="true"
            buttons="#dlg-buttons">
    <form id="addForm"  method="post">
    	<input type="hidden" name="tgid" id="gid2">
    	<input type="hidden" name="tid" id="tid2"/>
    	<input type="hidden" name="sid" id="sid2"/>
        <table style="border: 2px;border-color: red; ">
            <tr>
                <td>货物名称:</td>
                <td><input class="easyui-textbox" id="goodsName2" style="width: 150px;"  
                      data-options="required:true,novalidate:true" readonly="readonly"  /></td>
            </tr>
            <tr>
                <td><br/>出库数量:</td>
                <td><br/><input class="easyui-numberbox" id="tcount" style="width: 150px;" name="tcount"
                               data-options="required:true,validType:'length[1,11]',novalidate:true"
                                style="width:150px" readonly="readonly"></td>
            </tr>
            <tr>
                <td><br/>出库类型:</td>
                <td><br/><select class="easyui-combobox"  style="width: 150px;" name="ttype" id="ttype" data-options="required:true" readonly="readonly">
                        <option value="预定出库">预定出库</option>
                        <option value="销售出库">销售出库</option>
                        <option value="退货出库">退货出库</option>
                        <option value="报废出库">报废出库</option>
                        <option value="调整出库">调整出库</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>选择车辆:</td>
                <td><br/>
                    	<div style="float: left;">
	                    	<input class="easyui-combobox" data-options="required:true" id="addtransport" name="thelibrary.transport.trid"/><br/><br/>
	             		</div>
	               		<div style="float: left;">
							&nbsp;<a href="javascript:(0);" class="easyui-linkbutton" data-options="iconCls:'icon-ok'"   onclick="opentransport();">选择车辆</a>
						</div>
						<p style="clear: both;"></p>
                    </td>
            </tr>
            
            <tr>
            	<td>出库时间:</td>
                <td><input class="easyui-datebox" name="ttime" id="ttime" readonly="readonly" /></td>
            </tr>
            <tr>
                <td><br/>备注:</td>
                <td><br/>
                   <textarea rows="3" cols="25" name="remarks" id="remarks" readonly="readonly" ></textarea>
                </td>
            </tr>
        </table>
    </form>
</div>
	
	
	<!-- 菜单 -->
	<div id="tb" style="padding: 2px;">
		司机姓名：<input id="sjname" class="easyui-validatebox easyui-textbox" name="tdrivername" data-options="required:false" />&nbsp;
		货物名称：<input id="sgname2" class="easyui-validatebox easyui-textbox" name="gname" data-options="required:false" />&nbsp;
		出货类型：<select class="easyui-combobox"  style="width: 150px;" name="ttype" id="ttype2" data-options="required:true" >
                     <option value="预定出库">预定出库</option>
                     <option value="销售出库">销售出库</option>
                     <option value="退货出库">退货出库</option>
                     <option value="报废出库">报废出库</option>
                     <option value="调整出库">调整出库</option>
              	 </select>&nbsp;
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="seachs();">搜索</a>
		<br/>
		&nbsp;&nbsp;&nbsp;<a href="javascript:chuhuo()" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" >确认出货</a>
	</div>
	<div id="transport1" class="easyui-window" title="选择车辆"
		data-options="iconCls:'icon-edit', closable:true, closed:true"
		style="width: 800px; height: 500px; padding: 5px;">
		<form id="xuanForm1" enctype="multipart/form-data">
			<table id="student_list" class="easyui-datagrid"
				data-options=" 
				toolbar:'#tc',
				url:'<%=path%>/transport/queryAll', 
				method:'get', 
				rownumbers:true,
				singleSelect:true,
				autoRowHeight: true,
				pagination:true,
				border:false
				">
				<thead>
					<tr>
						<th data-options="field:'tid',checkbox:true,width:100" align="center">承运编号</th>
				        <th data-options="field:'tdrivername',width:100" align="center">司机姓名</th>
				        <th data-options="field:'tdriverphone',width:100" align="center">司机电话</th>
				        <th data-options="field:'tvehicleid',width:50" align="center">车牌号</th>
				        <th data-options="field:'tvehicletype',width:50" align="center">车辆类型</th>
				        <th data-options="field:'tvehiclecapacity',width:100" align="center">容量</th>
					</tr>
				</thead>
			</table>
			<a href="javascript:;" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'" onclick="transport_xuan();">确定选择</a>
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
				}
				return "<span class='yishen'>已审批</span>";
			}
			
			function gettdrivername(value){
				if(value.trid==-1){
					return  "<span class='shen'>未选车辆</span>";
				}
				return "<span class='shen'>value.tdrivername</span>";
			}
			
			 function chuhuo(){
				 var row=$("#list").datagrid("getSelected");
					if(row){
				        $("#addtransport").combobox("setValue", row.transport.tdrivername);
				        $("#addtransport").combobox('select', row.transport.trid);
				         /* $("#updatestuid").combobox("setValue", row.intenname);
				         $("#updatestuid").combobox('select', row.intenid); */
				         	$("#tid2").val(row.tid);
							$("#gid2").val(row.goods.gid);
							$("#goodsName2").textbox('setValue',row.goods.gname);
							$("#tcount").textbox('setValue',row.tcount);
							$("#ttype").combobox("setValue", row.ttype);
							$("#ttime").datebox('setValue',toDate(row.ttime));
							$("#remarks").val(row.remarks);
						 	$("#addChuku").dialog("open").dialog("setTitle", "客户出货单详情");
					}else{
						$.messager.alert('提示','需要出货的出货单','info');	//messager消息控件
					}
				 
			 }
			
			 function closeUserDialog() {
				    $("#addChuku").dialog("close");
				    $("#list").datagrid("reload");
				}
			 
			 function opentransport(){
					$("#list").datagrid("reload");
					$("#classid").combobox({
			            url: "<%=path%>/rawpun/tjls",
			            method: 'get',
			            valueField: 'id',
			            textField: 'name',
			            panelHeight: 'auto',
			            onLoadSuccess: function () { //数据加载完毕事件
			                var data = $('#classid').combobox('getData');
			                if (data.length > 0) {
			                    $("#classid").combobox('select', data[0].id);
			                }
			            }
			        });
					$("#transport1").window("open");
				}
			 
			 
			function transport_xuan(){
				var row=$("#stransport_list").datagrid("getSelected");	//获取datagrid中选中的行
				if(row){
			         $("#addtransport").combobox("setValue", row.tdrivername);
			         $("#addtransport").combobox('select', row.tid);
			         
			         /* $("#updatestuid").combobox("setValue", row.intenname);
			         $("#updatestuid").combobox('select', row.intenid); */
					 $("#studentwin1").window("close");
				}else{
					$.messager.alert('提示','请选择学生','info');	//messager消息控件
				}
			}
			
			/* 搜索 */
			function seachs(){
				var tdrivername = $('#sjname').textbox('getValue');
				var gname = $('#sgname2').textbox('getValue');
				var ttype = $('#ttype2').combobox('getValue');
				$('#list').datagrid('load',{  
					tdrivername:tdrivername,
					gname:gname,
					ttype:ttype
				}); 
			}
	</script>
	
	
	
</body>
</html>