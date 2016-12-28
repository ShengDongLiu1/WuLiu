<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%String path=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>入库列表</title>
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

.dai{color:green;}

.yi{color:orange;}

.ju{color:red;}
</style>
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
});

/*打开新增窗口*/
function openaddWin(){
	$("#acid").val('');
	$('#acname').textbox('setValue','');
	$('#acprice').numberbox('setValue','');
	$("#addCosttype").dialog("open").dialog("setTitle", "添加费用类型");
}

/*打开编辑窗口*/
function openeditWin(){
	var row = $('#list').datagrid('getSelected');
	if (row){
		$("#acid").val(row.cid);
		$('#acname').textbox('setValue',row.cname);
		$('#acprice').numberbox('setValue',row.cprice);
		$("#addCosttype").dialog("open").dialog("setTitle", "编辑费用类型");
	}else{
		$.messager.alert('系统提示','请选择要编辑的信息！','info');
	}
}

/*提交信息*/
function subRece(){
	var cid=$("#acid").val();
	var cname=$('#acname').textbox('getValue');
	var cprice=$('#acprice').numberbox('getValue');
	if(cname == ''){
		$.messager.alert('提示','请输入类型名称！','info');
		return false;
	}else if(cprice == ''){
		$.messager.alert('提示','请输入类型费用！','info');
		return false;
	}else{
		$.post("<%=path%>/costtype/addAndUpdate",{'cid':cid,'cname':cname,'cprice':cprice},function(index){
	    	$.messager.alert('提示',index.result,'info');
	    	closeGoodWin();
	    	$("#list").datagrid("reload");	//刷新表格
	    },"json");
	}
}

/* 删除费用类型 */
function deleteCost(){
	var row = $('#list').datagrid('getSelected');
	if (row){
		$.messager.confirm('提示','你确定要删除  '+row.cname+' 吗？',function(con){
			if(con){
				$.post("<%=path%>/costtype/deleteCost",{'cid':row.cid},function(index){
					$.messager.alert('系统提示',index.result,'info');
					$("#list").datagrid("reload");	//刷新表格
				},"json");
			}
		});
	}else{
		$.messager.alert('系统提示','请选择要删除的信息！','info');
	}
}

/* 关闭窗口 */
function closeGoodWin(){
	$("#addCosttype").dialog("close");
}
</script>
</head>
<body>
	<table id="list" class="easyui-datagrid" toolbar="#kj" style="width:100%" data-options="
		url:'<%=path %>/costtype/all',
		method:'get',
		rownumbers:true,	
		singleSelect:true,
		autoRowHeight:true,
		pagination:true,
		border:false,
		pageSize:10,
		fit:true
	">
		<thead data-options="frozen:true">
			<tr>
				<th field="cid" checkbox="true">编号</th>
				<th field="cname" width="30%" align="center">类型名称</th>
				<th field="cprice" width="30%" align="center">价格(￥)</th>
			</tr>
		</thead>
	</table>
	
	<!-- 菜单 -->
	<div id="kj" style="padding: 2px;">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="openaddWin();">添加</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="openeditWin();">编辑</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="deleteCost();">删除</a>
		名称：<input id="cname" class="easyui-validatebox easyui-textbox" name="cname" data-options="required:false" />&nbsp;
		货物：<input id="cprice" class="easyui-validatebox easyui-textbox" name="cprice" data-options="required:false" />&nbsp;
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="seachs();">搜索</a>
	</div>
	
	<!-- 自定义窗口按钮 -->
	<div id="ls-buttons">
		<a href="javascript:subRece()" class="easyui-linkbutton" iconCls="icon-ok">确认</a>
	    <a href="javascript:closeGoodWin()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<!-- 揽收窗口 -->
	<div id="addCosttype" class="easyui-dialog"  buttons="#ls-buttons" data-options="closable:true, closed:true"  style="width:25%;height:180px;padding:5px;text-align:center;">
			<input type="hidden" id="acid">
		<br />
		名称：<input id="acname" class="easyui-validatebox easyui-textbox" data-options="required:true" /><br /><br />
		费用：<input id="acprice" class="easyui-validatebox easyui-numberbox" data-options="required:true" />
	</div>
	
</body>
</html>