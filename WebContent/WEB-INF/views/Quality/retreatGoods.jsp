<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>货物退回管理</title>
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
			
			.cheng{color:black;}
			
			.tui{color:grey;}
		</style>
		<script type="text/javascript">
			/* 员工姓名 */
			function sysuserName(value){
				return value.usertruename;
			}
			
			/* 货物名称 */
			function goodsName(value, exm){
				return exm.goods.gname;
			}
			
			/* 货物订单 */
			function goodsNumber(value, exm){
				return exm.goods.gordernumber;
			}
			
			/* 货物数量 */
			function goodsCount(value, exm){
				return exm.goods.gcount;
			}
			
			/* 货物等级 */
			function goodsGrade(value, exm){
				return exm.goods.ggrade;
			}
			
			/* 货物描述 */
			function goodsDescribe(value, exm){
				return exm.goods.gdescribe;
			}
			
			/* 退回时间 */
			function receiptDate(value){
				return value.rtbgoodstime;
			}
			
			function recStatus(value){
				var status='';
				if(value.rstart=='6'){
					status="<span class='tui'>待退回</span>"
				}else if(value.rstart=='7'){
					status="<span class='cheng'>成功退回</span>"
				}
				return status;
			}
			
			/* 搜索 */
			function seachs(){
				var gordernumber = $('#gordernumberSearch').textbox('getValue');
				var gname = $('#gnameSearch').textbox('getValue');
				var usertruename = $('#usernameSearch').textbox('getValue');
				var rstart = $('#rstartSearch').combobox('getValue');
				$('#dg').datagrid('load',{  
					gordernumber:gordernumber,
					gname:gname,
					usertruename:usertruename,
					rstart:rstart
				}); 
			}
		</script>
	</head>
	<body>
		<table id="dg" class="easyui-datagrid" toolbar="#kj" style="width:100%" data-options="
		url:'<%=path %>/quality/queryAll3',
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
				<th field="goods" width="9%" align="center" formatter="goodsNumber">货物订单号</th>
				<th field="goods1" width="9%" align="center" formatter="goodsName">货物名称</th>
				<th field="goods2" width="9%" align="center" formatter="goodsCount">货物数量</th>
				<th field="goods3" width="9%" align="center" formatter="goodsGrade">货物等级</th>
				<th field="goods4" width="9%" align="center" formatter="goodsDescribe">货物描述</th>
				<th field="sysusers" width="7%" align="center" formatter="sysuserName">质检员工</th>
				<th field="eresult" width="15%" align="center">退回原因</th>
				<th field="receipt" width="10%"  align="center" formatter="recStatus">货物状态</th>
				<th field="edate" align="center" formatter="toDate">退回时间</th>
				<th field="null" width="11%" align="center" formatter="toSub">操作</th>
			</tr>
		</thead>
	</table>
	<!-- 菜单 -->
	<div id="kj" style="padding: 2px;">
		<a href="javascript:tuihui()" class="easyui-linkbutton" data-options="iconCls:'icon-sum'" >退回货物</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="window.print();">打印</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-export1'" onclick="location.href='<%=path %>/export/qualityExcel'">导出</a>
		<a href="javascript:deleteTest()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" >删除</a>
		订单号：<input id="gordernumberSearch" class="easyui-validatebox easyui-textbox" name="gordernumber1" data-options="required:false" />
		货物：<input id="gnameSearch" class="easyui-validatebox easyui-textbox" name="gname1" data-options="required:false" />
		员工：<input id="usernameSearch" class="easyui-validatebox easyui-textbox" name="usertruename1" data-options="required:false" />
		状态：<select id="rstartSearch" class="easyui-combobox" name="rstart1" data-options="editable:false" style="width:10%">
				<option  draggable="false" value="">请选择状态</option>
				<option value="6">待退回</option>
				<option value="7">已退回</option>
			  </select>&nbsp;
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="seachs();">搜索</a>
	</div>
	<div id="goodQualityWin" class="easyui-dialog"  buttons="#dlg-buttons" data-options="closable:true, closed:true"  style="width:70%;height:420px;padding:5px;text-align:center;">
        	<table style="width:100%;height:100%;" id="gooded">
        		<tr align="center">
        			<td class="tdwidth">质检编号：</td>
        			<td class="gxiangq"><span class="eid1"></span></td>
        			<td class="tdwidth">货物编号：</td>
        			<td class="gxiangq"><span class="egid1"></span></td>
        		</tr>
        		<tr align="center">
        			<td class="tdwidth">订单号：</td>
        			<td class="gxiangq"><span class="gordernumber1"></span></td>
        			<td class="tdwidth">货物名称：</td>
        			<td class="gxiangq"><span class="gname1"></span></td>
        		</tr>
        		<tr align="center">
        			<td class="tdwidth">货物等级：</td>
        			<td class="gxiangq"><span class="ggrade1"></span></td>
        			<td class="tdwidth">货物描述：</td>
        			<td class="gxiangq"><span class="gdescribe1"></span></td>
        		</tr>
        		<tr align="center">
        			<td class="tdwidth">货物状态：</td>
        			<td class="gxiangq"><span class="gstate1"></span></td>
        			<td class="tdwidth">货物数量：</td>
        			<td class="gxiangq"><span class="gcount1"></span></td>
        		</tr>
        		<tr align="center">
        			<td class="tdwidth">接收数量：</td>
        			<td class="gxiangq"><span class="rreceivecount1"></span></td>
        			<td class="tdwidth">破损数量：</td>
        			<td class="gxiangq"><span class="rdamagedcount1"></span></td>
        		</tr>
        		<tr align="center">
        			<td class="tdwidth">搁置数量：</td>
        			<td class="gxiangq"><span class="rshelvecount1"></span></td>
        			<td class="tdwidth">员工姓名：</td>
        			<td class="gxiangq"><span class="ename1"></span></td>
        		</tr>
        		<tr align="center">
        			<td class="tdwidth">退回原因：</td>
        			<td class="gxiangq"><span class="eresult1"></span></td>
        			<td class="tdwidth">检验时间：</td>
        			<td class="gxiangq"><span class="edate1"></span></td>
        		</tr>
        	</table>
        </div>
	</body>
	<script>
	var url;
	$(function() {
		setPaginat9ion("dg");
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
			var btn="&nbsp;<a href='javascript:openGoodWin("+obj.eid+")'>详情</a>"
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

		/* 给弹出的窗口赋值 */
		function fuzhi(index){
			$(".eid1").html(index.quality.eid);//质检编号
			$(".egid1").html(index.quality.egid);//货物编号
			$(".gordernumber1").html(index.quality.goods.gordernumber);//订单号
			$(".gname1").html(index.quality.goods.gname);//货物名称
			$(".ggrade1").html(index.quality.goods.ggrade);//货物等级
			$(".gdescribe1").html(index.quality.goods.gdescribe);//货物描述
			$(".gstate1").html(index.quality.goods.gstate);//货物状态
			$(".gcount1").html(index.quality.goods.gcount);//货物数量
			$(".rreceivecount1").html(index.quality.receipt.rreceivecount);//接收数量
			$(".rdamagedcount1").html(index.quality.receipt.rdamagedcount);//破损数量
			$(".rshelvecount1").html(index.quality.receipt.rshelvecount);//搁置数量
			$(".ename1").html(index.quality.sysusers.usertruename);//员工姓名
			$(".eresult1").html(index.quality.eresult);//检验结果
			$(".edate1").html(getNowFormatDate(index.quality.edate));//检验时间
			$("#goodQualityWin").dialog("open").dialog("setTitle", "货物质检详情");
		}
		
		/* 货物退回 */
		function tuihui() {
			$.messager.confirm('消息提示', '是否退回该货物？', function(r){
				if (r){
					var selectedRows = $("#dg").datagrid("getSelections");
					var row = selectedRows[0];
					if(row.receipt.rstart = 7){
						$.messager.alert('消息提示','退货库已无该货物或货物已退回!');
					}else{
						$.post("<%=path %>/quality/save3",{'rid':row.receipt.rid,'rstart':7},function(index){
							if(index.success){
							  $.messager.alert('消息提示','退回成功!');
				         	  $("#dg").datagrid("load");
				    		}else{
				    		  $.messager.alert('消息提示','退回失败!');
				    		}
				   		},"json");
					}
				}else{
					return false;
				}
			});
		}
		
		</script>
</html>