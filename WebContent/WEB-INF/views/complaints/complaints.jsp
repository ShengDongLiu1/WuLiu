<%@ page language="java" contentType="text/html; charset=UTF-8"
	 pageEncoding="UTF-8"%>
<% 
	String path = request.getContextPath(); 
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>投诉管理</title>
<link rel="stylesheet" href="<%=path %>/js/jquery-easyui/themes/default/easyui.css"/>
<link rel="stylesheet" href="<%=path %>/js/site_main.css"/>
<link rel="stylesheet" type="text/css" href="<%=path %>/js/jquery-easyui/themes/icon.css">
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=path %>/js/site_easyui.js"></script>
<style type="text/css">
	.gxiangq{
	text-align:left;font-size:15px;
	border-bottom:1px dashed #FFE48D; 
}

.textareas{
	
}
</style>
</head>

<body>
	<table id="dg" class="easyui-datagrid" toolbar="#tb" data-options="
		url:'<%=path %>/complaints/allComplaints', 
		method:'get', 
		rownumbers:true,
		autoRowHeight: true,
		pagination:true,
		singleSelect:true,
		border:false,
		pageSize:20,
		fit:true">
		<thead>
			<tr>
				<th field="comid" checkbox="true">投诉编号</th>
				<th field="comtype" width="8%">投诉类型</th>
				<th field="comcusid" width="8%">客户投诉人</th>
				<th field="comtitle" width="8%">投诉标题</th>
				<th field="comtime" width="10%" formatter="toDate">投诉时间</th>
				<th field="comlevel" width="8%">投诉程度</th>
				<th field="comsysuser" width="8%">投诉员工工号</th>
				<th field="comcontent" width="8%">投诉内容</th>
				<th field="comdescr" width="8%">期望结果</th>
				<th field="comexpect" width="8%">备注说明</th>
				<th field="comdisposetype" width="8%">部门跟进</th>
				<th field="comdisposesysuser" width="8%">处理人</th>
				<th field="comdisposemethod" width="8%">处理方法</th>
			</tr>
		</thead>
	</table>
	<!-- 菜单 -->
	<div id="tb" style="padding: 2px;">
		<!-- 筛选 -->
		投诉人：<input id="comsysuser" name="comsysuser" class="easyui-textbox" style="width:100px;"/>
		投诉类型：<select name="comtype" id="comtype" class="easyui-combobox" data-options="editable:false" style="width:90px">
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
		投诉程度：<select name="comlevel" id="comlevel" class="easyui-combobox" data-options="editable:false" style="width:90px">
					<option value="" selected = "selected">请选择</option>
					<option value="普通">普通</option>
					<option value="紧急">紧急</option>
					<option value="非常紧急">非常紧急</option>
				</select>
		投诉时间：<input id="comtime" name="comtime" class="easyui-datetimebox easyui-textbox" style="width:100px;"/>-
				<input id="comtime1" name="comtime1" class="easyui-datetimebox easyui-textbox" style="width:100px;"/>
		部门跟进：<select name="comdisposetype" id="comdisposetype" class="easyui-combobox" data-options="editable:false" style="width:90px">
					<option value="" selected = "selected">请选择</option>
					<option value="未启动">未启动</option>
					<option value="已结案">已结案</option>
					<option value="不实施">不实施</option>
				</select>
		<a href="javascript:selectfiltrateComplaints()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">筛选</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:handleComplaintComplaints()" class="easyui-linkbutton">处理投诉</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	
	<div id="dlg" class="easyui-dialog"
            style="width: 600px;height:280px;padding:10px 10px;" closed="true"
            buttons="#dlg-buttons">
            <form method="post" id="fm">
                <table cellspacing="8px;">
                    <tr>
                        <td>投诉标题：</td>
                        <td class="gxiangq"><input id="comtype" name="comtype"
                           type="text" style="border: none;" readonly="readonly"/>&nbsp;
					</tr>
					 <tr>
                        <td>投诉程度：</td>
                        <td class="gxiangq"><input id="comlevel" name="comlevel"
                           type="text" style="border: none;" readonly="readonly"/>&nbsp;
					</tr>
                    <tr>
                       <td>投诉内容：</td>
                       <td class="gxiangq"><textarea  cols=70 rows=5 id="comcontent" name="comcontent"
                           style="border: none;" readonly="readonly"></textarea>&nbsp;
                    </tr>
                    <tr>
                       <td>期望结果：</td>
                       <td class="gxiangq"><textarea  cols=70 rows=5  id="comexpect" name="comexpect"
                           style="border: none;" readonly="readonly"/></textarea>&nbsp;
                        </td>
                    </tr>
                      <tr>
                       <td>备注说明：</td>
                       <td class="gxiangq"><textarea  cols=70 rows=5  id="comdescr" name="comdescr"
                           style="border: none;" readonly="readonly"/></textarea>&nbsp;
                        </td>
                    </tr>
                    <tr>
                       <td>部门跟进：</td>
                       <td class="gxiangq"><input id="comdisposetype" name="comdisposetype"
                           type="text" style="border: none;" readonly="readonly"/>&nbsp;
                        </td>
                    </tr>
                    <tr>
                       <td>处理人：</td>
                       <td class="gxiangq"><input id="comdisposesysuser" name="comdisposesysuser"
                           type="text" style="border: none;" readonly="readonly"/>&nbsp;
                        </td>
                    </tr>
                    <tr>
                       <td>处理方法：</td>
                       <td class="gxiangq"><textarea id="comdisposemethod" name="comdisposemethod"
                           style="border: none;" readonly="readonly"></textarea>&nbsp;
                        </td>
                    </tr>
                </table>
            </form>
            <a href="javascript:ClickhandleComplaintComplaints()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">点击处理投诉</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </div>
        
        <div id="dlg-s" class="easyui-dialog"
            style="width: 600px;height:280px;padding:10px 10px;" closed="true"
            buttons="#dlg-buttons">
            <form method="post" id="fm">
                <table cellspacing="8px;">
                    
                    <tr>
                       <td>客户期望的结果：</td>
                       <td class="gxiangq"><textarea  cols=70 rows=5  id="comexpects" name="comexpects"
                           style="border: none;" readonly="readonly"/></textarea>&nbsp;
                        </td>
                    </tr>
                      
                    <tr>
                       <td>处理人：</td>
                       <td class="gxiangq"><input id="comdisposesysusers" name="comdisposesysusers"
                           value="${user.usertruename }" type="text" style="border: none;" readonly="readonly"/>&nbsp;
                          	<input type="hidden" id="tsid" name="tsid"/>
                        	<input type="hidden" value="${user.ujobnumber }" id="comdisposesysuserss" name="comdisposesysuserss"/>
                        </td>
                    </tr>
                    <tr>
                       <td>您的处理方法：</td>
                       <td class="gxiangq"><textarea id="comdisposemethods" name="comdisposemethods" cols=70 rows=5 
                           style="border: none;"></textarea>&nbsp;
                        </td>
                    </tr>
                </table>
            </form>
            <a href="javascript:overComplaints()" class="easyui-linkbutton">结案</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        	<a href="javascript:nooverComplaints()" class="easyui-linkbutton">不实施</a>
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
		
	    
	    function handleComplaintComplaints() {
	        var selectedRows = $("#dg").datagrid("getSelections");
	        if (selectedRows.length != 1) {
	            $.messager.alert("系统提示", "请选择一条要处理的数据！");
	            return;
	        }
	        var row = selectedRows[0];
	        if(row.comdisposetype=='未启动'){
	        	$("#tsid").val(row.comid);
	        	$("#dlg").dialog("open").dialog("setTitle", "处理投诉信息");
	 	        $("#fm").form("load", row);
	        }else{
	        	$.messager.alert("系统提示", "你所选择的投诉已被处理！");
	        }
	       
	        
	    }
	    
	    function ClickhandleComplaintComplaints(){
	    	//关闭查看投诉窗口，获取期望结果，弹出窗口，显示用户期望的结果，和自己对客户的处理结果，修改投诉状态
	    	$("#dlg").dialog("close");
	    	var comexpect=$("#comexpect").val();
	    	$("#comexpects").val(comexpect);
	    	 $("#dlg-s").dialog("open").dialog("setTitle", "处理投诉信息");
	    }
	    
	    function overComplaints(){
	    	var comdisposesysuserss=$("#comdisposesysuserss").val();
	    	var comdisposemethods=$("#comdisposemethods").val();	
	    	var tsid=$("#tsid").val();
	    	var sta='已结案';
	    	 $.post("${pageContext.request.contextPath}/complaints/updatestate.do", {
	    		 sta:sta, tsid : tsid,comdisposesysuserss:comdisposesysuserss,comdisposemethods:comdisposemethods
	            }, function(result) {
	                if (result.success) {
	                    $.messager.alert("系统提示", "投诉已结案！");
	                    $("#dlg-s").dialog("close");
	                    $("#dg").datagrid("load");
	                } else {
	                    $.messager.alert("系统提示", "投诉结案失败，请联系系统管理员！");
	                }
	            }, "json");
	    }
 		function nooverComplaints(){
 			var comdisposesysuserss=$("#comdisposesysuserss").val();
	    	var comdisposemethods=$("#comdisposemethods").val();	
	    	var tsid=$("#tsid").val();
	    	var sta='不实施';
	    	 $.post("${pageContext.request.contextPath}/complaints/updatestate.do", {
	    	 sta : sta, tsid : tsid,comdisposesysuserss:comdisposesysuserss,comdisposemethods:comdisposemethods
	            }, function(result) {
	                if (result.success) {
	                    $.messager.alert("系统提示", "投诉不实施！");
	                    $("#dlg-s").dialog("close");
	                    $("#dg").datagrid("load");
	                } else {
	                    $.messager.alert("系统提示", "投诉不实施，请联系系统管理员！");
	                }
	            }, "json");
	    }

	    
	    function goodsName(value){
	    	return value.gname;
	    }
	    function sysuserName(value){
	    	return value.username;
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

	    function toUser(value){
	 	    	return value.sysuser.usertruename;
	    }
	    
	    /* 将{"date":14,"day":3,"hours":19,"minutes"……}转换为Thu Mar 19 2015 12:00:00 GMT+0800 (中国标准时间) */
	    function toDate(obj){
	    	var date = new Date();
	    	 date.setTime(obj.time);
	    	 date.setHours(obj.hours);
	    	 date.setMinutes(obj.minutes);
	    	 date.setSeconds(obj.seconds);
	    	return formatDateTime(date);
	    }

	</script>
</body>
</html>