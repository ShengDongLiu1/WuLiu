<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%String path=request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="<%=path %>/js/jquery-easyui/themes/default/easyui.css"/>
<link rel="stylesheet" href="<%=path %>/js/site_main.css"/>
<link rel="stylesheet" type="text/css" href="<%=path %>/js/jquery-easyui/themes/icon.css">
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=path %>/js/site_easyui.js"></script>
<script type="text/javascript">
 
 var url;

 function searchCustomer(){
	 $("#dg").datagrid('load',{
		"ckhno":$("#s_khno").val(),
		"cname":$("#s_name").val()
	 });
 }
 
 function openCustomerAddDialog(){
	 resetValue();
	 $("#dlg").dialog("open").dialog("setTitle","添加客户信息");
	 url="${pageContext.request.contextPath}/customer/save";
 }
 
 function openCustomerModifyDialog(){
	 var selectedRows=$("#dg").datagrid("getSelections");
	 if(selectedRows.length!=1){
		 $.messager.alert("系统提示","请选择一条要编辑的数据！");
		 return;
	 }
	 var row=selectedRows[0];
	 $("#dlg").dialog("open").dialog("setTitle","编辑客户信息");
	 $("#fm").form("load",row);
	 url="${pageContext.request.contextPath}/customer/save?cid="+row.cid;
 }
 
 function saveCustomer(){
	 $("#fm").form("submit",{
		url:url,
		onSubmit:function(){
			if($("#ccredit").combobox("getValue")==""){
				$.messager.alert("系统提示","请选择客户信用度！");
				return false;
			}
			var reg=/^1[3,5,8]\d{9}$/;
			var obj=document.getElementById("cphone");
			if(!reg.test(obj.value)){
				$.messager.alert("系统提示","请输入正确的手机号码！");
				return false;
			}
			var reg1=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			var obj1=document.getElementById("cemail");
			if(!reg1.test(obj1.value)){
				$.messager.alert("系统提示","请输入正确的邮箱！");
				return false;
			}
		 return $(this).form("validate");
		},
		success:function(result){
			var result=eval('('+result+')');
			if(result.success){
				$.messager.alert("系统提示","保存成功！");
				$("#dlg").dialog("close");
				$("#dg").datagrid("reload");
			}else{
				$.messager.alert("系统提示","保存失败！");
				return;
			}
		}
	 });
 }

 /* 清空表单输入框数据 */
 function resetValue(){
	 $("#cname").textbox('setValue',"");
	 $("#ckhno").textbox("setValue",'');
	 $("#ccompany").textbox("setValue",'');
	 $("#cphone").textbox("setValue",'');
	 $("#cemail").textbox("setValue",'');
	 $("#caddress").textbox("setValue",'');
	 $("#ccredit").combobox("setValue","");
 }
 
 function closeCustomerDialog(){
	 $("#dlg").dialog("close");
 }
 
 function deleteCustomer(){
	 var selectedRows=$("#dg").datagrid("getSelections");
	 if(selectedRows.length==0){
		 $.messager.alert("系统提示","请选择要删除的数据！");
		 return;
	 }
	 var strIds=[];
	 for(var i=0;i<selectedRows.length;i++){
		 strIds.push(selectedRows[i].cid);
	 }
	 var ids=strIds.join(",");
	 $.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
		if(r){
			$.post("${pageContext.request.contextPath}/customer/delete",{ids:ids},function(result){
				if(result.success){
					 $.messager.alert("系统提示","数据已成功删除！");
					 $("#dg").datagrid("reload");
				}else{
					$.messager.alert("系统提示","数据删除失败，请联系统管理员！");
				}
			},"json");
		} 
	 });
 }

</script>
<title>客户信息</title>
</head>
<body style="margin: 1px">
 <table id="dg" title="客户信息查询" class="easyui-datagrid"
    pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/customer/list" fit="true" toolbar="#tb">
   <thead data-options="frozen:true">
		<tr>
			<!-- hidden="true" 隐藏域-->
			<th field="cid" checkbox="true" align="center"></th>
	 		<th field="ckhno" width="150" align="center">客户编号</th>
	 		<th field="cname" width="150" align="center">客户名称</th>
	 		<th field="ccompany" width="150" align="center">客户公司</th>
	 		<th field="cphone" width="150" align="center">客户电话</th>
	 		<th field="cemail" width="150" align="center">客户邮箱</th>
	 		<th field="ccredit" width="150" align="center">客户等级</th>
	 		<th field="caddress" width="150" align="center">客户地址</th>
		</tr>
	</thead>
 </table>
 <div id="tb">
 	<div>
 		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-export1'" onclick="location.href='<%=path %>/export/customerExcel'">导出</a>
 		<a href="javascript:openCustomerAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">创建</a>
 		<a href="javascript:openCustomerModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
 		<a href="javascript:deleteCustomer()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 	</div>
 	<div>
 		&nbsp;客户编号：&nbsp;<input type="text" class="easyui-textbox" id="s_khno" size="20" onkeydown="if(event.keyCode==13) searchCustomer()"/>
 		&nbsp;客户名称：&nbsp;<input type="text" class="easyui-textbox" id="s_name" size="20" onkeydown="if(event.keyCode==13) searchCustomer()"/>
 		<a href="javascript:searchCustomer()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 	</div>
 </div>
  <div id="dlg" class="easyui-dialog" style="width:680px;height:300px;padding: 10px 20px"
   closed="true" buttons="#dlg-buttons">
   
   <form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>客户名称：</td>
   			<td><input id="cname" name="cname" class="easyui-textbox" required="true"/>&nbsp;<font color="red">*</font></td>
   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   			<td>客户信用度</td>
   			<td>
   				<select class="easyui-combobox easyui-textbox" id="ccredit" name="ccredit" style="width: 154px" editable="false" panelHeight="auto">
   					<option value="">请选择...</option>
   					<option value="★☆☆☆☆">★☆☆☆☆</option>	
					<option value="★★☆☆☆">★★☆☆☆</option>	
					<option value="★★★☆☆">★★★☆☆</option>	
					<option value="★★★★☆">★★★★☆</option>		
					<option value="★★★★★">★★★★★</option>				
                </select>&nbsp;<font color="red">*</font>
   			</td>
   		</tr>
   		<tr>
   			<td>客户公司：</td>
   			<td>
   				<input type="text" id="ccompany" name="ccompany" class="easyui-textbox" required="true"/>&nbsp;<font color="red">*</font></font>
   			</td>
   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   			<td>客户电话：</td>
   			<td>
   				<input type="text" id="cphone" name="cphone" class="easyui-textbox" required="true" data-options="events:{blur:check2}"/>&nbsp;<font color="red">*</font></font>
   			</td>
   		</tr>
   		<tr>
   			<td>客户邮箱：</td>
   			<td><input type="text" id="cemail" name="cemail" class="easyui-textbox"  required="true" data-options="events:{blur:check1}"/>&nbsp;<font color="red">*</font></td>
   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   		</tr>
   		<tr>
   			<td>客户地址</td>
   			<td colspan="4">
   				<input type="text" id="caddress" name="caddress" style="width: 400px" class="easyui-textbox" required="true"/>&nbsp;<font color="red">*</font>
   			</td>
   		</tr>
   	</table>
   </form>
 </div>
 
 <div id="dlg-buttons">
 	<a href="javascript:saveCustomer()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeCustomerDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
</body>
<script type="text/javascript">
function check1(){
	var cemail = $("#cemail").val();
	$.post("${pageContext.request.contextPath}/customer/checkEmail",{cemail:cemail},function(result1){
		if(!result1.success){
			$.messager.alert("系统提示","该邮箱已存在！");
			$("#cemail").textbox("setValue",'');
			return false;
		}
	},"json");
}

/* 手机验证匹配 */
 function check2(){
	var cphone = $("#cphone").val();
	$.post("${pageContext.request.contextPath}/customer/checkCphone",{cphone:cphone},function(result2){
		if(!result2.success){
			$.messager.alert("系统提示","该联系人已存在！");
			$("#cphone").textbox("setValue",'');
			return false;
		}
	},"json");
}
</script>
</html>