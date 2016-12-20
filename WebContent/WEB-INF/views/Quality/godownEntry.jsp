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
		<style type="text/css">
			body{margin:0px;padding:0px;}
			.tdwidth{
				width:20%;text-align:right;font-size:15px;
			}
			.gxiangq{
				text-align:left;font-size:15px;
				border-bottom:1px dashed #FFE48D; 
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
		<table id="dg" class="easyui-datagrid" toolbar="#kj" style="width:100%" data-options="
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
				<th field="egid" width="15%" align="center">货物编号</th>
				<th field="euserid" width="15%" align="center">员工编号</th>
				<th field="eresult" width="35%" align="center">检验结果</th>
				<th field="edate" width="15%" align="center" formatter="toDate">检验时间</th>
				<th field="null" width="17%" align="center" formatter="toSub">操作</th>
			</tr>
		</thead>
	</table>
	<!-- 菜单 -->
	<div id="kj" style="padding: 2px;">
		<a href="javascript:openQualityAdd()" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >添加</a>
		<a href="javascript:openQualityModifyDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" >编辑</a>
		<a href="javascript:deleteTest()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" >删除</a>
		订单号：<input id="sgordernumber" class="easyui-validatebox easyui-textbox" name="gordernumber" data-options="required:false" />
		员工：<input id="sgordernumber" class="easyui-validatebox easyui-textbox" name="gordernumber" data-options="required:false" />
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="seachs();">搜索</a>
	</div>
	<div id="qualityByWin" class="easyui-dialog"  buttons="#dlg-buttons" data-options="closable:true, closed:true"  style="width:50%;height:580px;padding:5px;text-align:center;">
		<table style="width:90%;height:100%;" id="gooded" align="center">
			<tr>
				<td class="tdwidth">员工姓名:</td>
				<td class="gxiangq"><span id="USERTRUENAME1"></span></td>
			</tr>
			<tr>
				<td class="tdwidth">员工职位:</td>
				<td class="gxiangq"><span id="uposition1"></span></td>
			</tr>
			<tr>
				<td class="tdwidth">货物订单号:</td>
				<td class="gxiangq"><span id="gordernumber1"></span></td>
			</tr>
			<tr>
				<td class="tdwidth">货物名称:</td>
				<td class="gxiangq"><span id="gname1"></span></td>
			</tr>
			<tr>
				<td class="tdwidth">货物等级:</td>
				<td class="gxiangq"><span id="ggrade"></span></td>
			</tr>
			<tr>
				<td class="tdwidth">货物描述:</td>
				<td class="gxiangq"><span id="gdescribe1"></span></td>
			</tr>
			<tr>
				<td class="tdwidth">货物状态:</td>
				<td class="gxiangq"><span id="gstate1"></span></td>
			</tr>
			<tr>
				<td class="tdwidth">检验结果:</td>
				<td class="gxiangq"><span id="eresult1"></span></td>
			</tr>
			<tr>
				<td class="tdwidth">检验时间:</td>
				<td class="gxiangq"><span id="edate1"></span></td>
			</tr>
		</table>
	</div>
	<div id="dlg-buttons">
	    <a href="javascript:QualityAdd()" class="easyui-linkbutton"
	        iconCls="icon-ok">保存</a> <a href="javascript:closeQualityAdd()"
	        class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<!-- 添加质检 -->
	<div id="dlg" class="easyui-dialog"
            style="width: 600px;height:280px;padding:10px 10px;" closed="true"
            buttons="#dlg-buttons">
            <form method="post" id="fm">
                <table cellspacing="8px;" align="center">
                    <tr>
                        <td>货物编号：</td>
                        <td><input type="text" id="egid" name="egid"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                    <tr>
                    	<td>员工编号：</td>
                        <td><input type="text" id="euserid" name="euserid"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td>检验结果：</td>
                        <td><input type="text" id="eresult" name="eresult"
                            class="easyui-validatebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                    <tr>
                    	<td>检验时间：</td>
                        <td><input id="edate" name="edate"
                            class="easyui-datebox" required="true" />&nbsp;<span
                            style="color: red">*</span>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
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
			var date = new Date();
			 date.setTime(obj.time);
			 date.setHours(obj.hours);
			 date.setMinutes(obj.minutes);
			 date.setSeconds(obj.seconds);
			return formatDateTime(date);
		}
		
		function resetValue() {
	        $("#egid").val("");
	        $("#euserid").val("");
	        $("#eresult").val("");
	        $("#edate").val("");
	    }
		
		/* 表格按钮 */
		function toSub(value,rec){
			var btn="<a href='javascript:openQualityWin("+rec.eid+")'>???</a>";
			btn+="&nbsp;&nbsp;<a href='#' onclick=''>???</a>";
			return btn;
		}
		
<%-- 		/* 打开详情窗口 */
		function openQualityWin(eid) {
			$.post("<%=path%>/quality/qualityByid",{'eid':eid},function(index){
				fuzhi(index);
			},"json");
		    
		}

		/* 给弹出的详情窗口赋值 */
		function fuzhi(index){
			$("#USERTRUENAME1").html(index.quality.employee.USERTRUENAME);
			$("#uposition1").html(index.quality.employee.uposition);
			$("#gordernumber1").html(index.quality.goods.gordernumber);
			$("#gname1").html(index.quality.goods.gname);
			$("#ggrade1").html(index.quality.goods.ggrade);
			$("#gdescribe1").html(index.quality.goods.gdescribe);
			$("#gstate1").html(index.quality.goods.gstate);
			$("#eresult1").html(index.quality.eresult);
			$("#edate1").html(formatDateTime(new Date(index.quality.edate)));
			$("#qualityByWin").dialog("open").dialog("setTitle", "入库质检详情");
		} --%>
		
		/* 删除 */
		function deleteTest() {
	        var selectedRows = $("#dg").datagrid("getSelections");
	        if (selectedRows.length == 0) {
	            $.messager.alert("系统提示", "请选择要删除的数据！");
	            return;
	        }
	        var strIds = [];
	        for ( var i = 0; i < selectedRows.length; i++) {
	            strIds.push(selectedRows[i].eid);
	        }
	        var ids = strIds.join(",");
	        $.messager.confirm("系统提示", "您确定要删除这<font color=red>"
	                + selectedRows.length + "</font>条数据吗？", function(r) {
	            if (r) {
	                $.post("${pageContext.request.contextPath}/quality/delete.do", {
	                    ids : ids
	                }, function(result) {
	                    if (result.success) {
	                        $.messager.alert("系统提示", "数据已成功删除！");
	                        $("#dg").datagrid("reload");
	                    } else {
	                        $.messager.alert("系统提示", "数据删除失败，请联系系统管理员！");
	                    }
	                }, "json");
	            }
	        });
	    }
		
		/* 添加 */
		function openQualityAdd() {
		    $("#dlg").dialog("open").dialog("setTitle", "添加质检");
		    url = "${pageContext.request.contextPath}/quality/save";
		}
		
		function QualityAdd() {
	        $("#fm").form("submit", {
	            url : url,
	            success : function(result) {
	                var result = eval('(' + result + ')');
	                if (result.success) {
	                    $.messager.alert("系统提示", "保存成功！");
	                    resetValue();
	                    $("#dlg").dialog("close");
	                    $("#dg").datagrid("reload");
	                } else {
	                    $.messager.alert("系统提示", "保存失败！");
	                    return;
	                }
	            }
	        });
		}
		
	    /* 修改 */
	    function openQualityModifyDialog() {
	        var selectedRows = $("#dg").datagrid("getSelections");
	        if (selectedRows.length != 1) {
	            $.messager.alert("系统提示", "请选择一条要编辑的数据！");
	            return;
	        }
	        var row = selectedRows[0];
	        row.edate = toDate(row.edate);
	        $("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
	        $("#fm").form("load", row);
	        url = "${pageContext.request.contextPath}/quality/save.do?eid=" + row.eid;
	    }
	    
		function closeQualityAdd() {	
		    $("#dlg").dialog("close");
		    resetValue();
		}
		</script>
</html>