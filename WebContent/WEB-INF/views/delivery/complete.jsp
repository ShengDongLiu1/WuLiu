<%@ page language="java" contentType="text/html; charset=UTF-8"
	 pageEncoding="UTF-8"%>
<% 
	String path = request.getContextPath(); 
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>配送状态</title>
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
		url:'<%=path %>/delivery/lists2', 
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
				<th data-options="field:'tid',checkbox:true,width:100" align="center">出货编号</th>
				<th data-options="field:'customer',width:100" align="center" formatter="getcname">客户名称</th>
		        <th data-options="field:'tnumber',width:120" align="center">送货单号</th>
		        <th data-options="field:'ttype',width:100" align="center">出货类型</th>
		        <th data-options="field:'ttid',width:100" align="center" hidden="true">司机名称</th>
		        <th data-options="field:'gorderstime1',width:150" align="center" formatter="toDate">下单日期</th>
		        <th data-options="field:'goods',width:100" align="center" formatter="goodsName">货物名称</th>
		        <th data-options="field:'tcount',width:100" align="center">实际送货量</th>
		        <th data-options="field:'receipt',width:100" align="center" formatter="getrreceivecount">收货数据量</th>
		        <th data-options="field:'tstate',width:100" align="center" formatter="gettstate">状态</th>	
			</tr>
		</thead>
	</table>
	<!-- 自定义窗口按钮 -->
	<div id="dlg-buttons">
	    <a href="javascript:closeGoodWin()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<div id="wuliu" class="easyui-dialog"  buttons="#dlg-buttons" data-options="closable:true, closed:true"  style="width:50%;height:500px;padding:5px;text-align:center;">
		<table style="width: 500px;  border-collapse:eparate;border-spacing:20px;   ">
			<tr>
				<td class="gxiangq"><span id="cname">暂无物流信息</span></td>
			</tr>
		</table>
	</div>

	<div id="dlg-buttons">
	    <a href="javascript:peisong()" class="easyui-linkbutton"
	        iconCls="icon-ok">保存</a> <a href="javascript:closeUserDialog()"
	        class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	 <div id="addWin" title="填写行驶公里" class="easyui-dialog"
            style="width: 300px;height:200px;padding:10px 10px;" closed="true"
            buttons="#dlg-buttons">
		   <form id="addForm"  method="post">
    	<input type="hidden" name="shgid" id="shgid" />
		<input type="hidden" name="shtid" id="shtid" />
        <table style="border: 2px;border-color: red; ">
            <tr>
                <td><br/>行驶公里:</td>
                <td><br/><input class="easyui-numberbox" id="travel" precision='3'  style="width: 150px;" name="travel"
                               data-options="required:true,validType:'length[1,11]',novalidate:true"
                                style="width:150px"></td>
            </tr>
        </table>
    </form>
     </div>
        
        
	<!-- 菜单 -->
	<div id="tb" style="padding: 2px;">
		客户姓名：<input id="cname1" class="easyui-validatebox easyui-textbox" name="cname" data-options="required:false" />&nbsp;
		货物名称：<input id="gname1" class="easyui-validatebox easyui-textbox" name="gname" data-options="required:false" />&nbsp;
		出货单号：<input id="tnumber1" class="easyui-validatebox easyui-textbox" name="tnumber" data-options="required:false" />&nbsp;
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="seachs();">搜索</a>
		<br/>	
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="window.print();">打印</a>&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="open1();">配送完成</a>&nbsp;
	</div>
	
	<script type="text/javascript">
	
	
	function getsijiName(){
		return value.tdrivername;
	}
	
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
	
	function gettstate(value){
		if(value==1){
			return "<span class='shen'>未发货</span>";
		}else if(value==3){
			return "<a href='javascript:void(0)' onclick='openwuliu()'><span class='yishen'>待配送</span></a>";
		}else if(value==4){
			return "<a href='javascript:void(0)' onclick='openwuliu()'><span class='yichu'>正在配送</span></a>";
		}else if(value==5){
			return "<a href='javascript:void(0)' onclick='openwuliu()'><span class='yishen'>配送成功</span></a>";
		}else if(value==7){
			return "<span class='yichu'>已签收</span>"
		}
	}
	
	/* 关闭窗口 */
	function closeGoodWin(){
		$("#wuliu").dialog("close");
	}
	function openwuliu(){
		$("#wuliu").dialog("open").dialog("setTitle", "货物物流信息");
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
			
			
			function open1(){
				 $("#addWin").dialog("open");
			}
			function peisong(obj){
				 var row=$("#list").datagrid("getSelected");
					if(row){
						if(row.tstate!=5){
							$.post("<%=path %>/delivery/wanchengs",{'tid':row.tid},function(index){
					    		if(index.success ){
					    			var travel = $("#travel").val();
					    			$.post("<%=path %>/transportd/save",{'shgid':row.goods.gid,'shtid':row.ttid,'travel':travel},function(index){
							    		if(index.success ){
							    			$.messager.alert('提示','配送成功！','info');
							    			closeUserDialog();
							    			$("#list").datagrid("reload");
							    		}else{
							    			$.messager.alert('提示',"配送失败!",'info');
							    		}
							   		},"json");
					    		}else{
					    			$.messager.alert('提示',"配送失败!",'info');
					    		}
					   		},"json");
						}else{
							$.messager.alert('提示','该订单已经配送成功了','info');
						}
					}else{
						$.messager.alert('提示','请选中需要配送的出货','info');	//messager消息控件
					}
			}
			
			 function closeUserDialog() {
			    $("#addWin").dialog("close");
			    $("#list").datagrid("reload");
			 }
	</script>
</body>
</html>