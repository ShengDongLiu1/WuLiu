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
.gxiangq input{
	width:190px;
	height:25px;
	border-radius:5px;
	border:1px #95B8E7 solid;
	outline:none;
	font-size:15px;
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
	 		$.post("<%=path%>/goods/goodByid",{'gid':row.gid},function(index){
	 			fuzhi(index);
	 			$("#goodbyWin").dialog("open").dialog("setTitle", "客户订单详情");
			},"json");
	    }
	});
	
	/* 禁用复选框 */
	$('#list').datagrid({
		onLoadSuccess: function(data){//加载完毕后获取所有的checkbox遍历
            if (data.rows.length > 0) {
                //循环判断操作为新增的不能选择
                for (var i = 0; i < data.rows.length; i++) {
                    //根据operate让某些行不可选
                    if (data.rows[i].gstate != "1") {
                        $("input[type='checkbox']")[i + 1].disabled = true;
                    }
                }
            }
        },
        onClickRow: function(rowIndex, rowData){
            //加载完毕后获取所有的checkbox遍历
            $("input[type='checkbox']").each(function(index, el){
                //如果当前的复选框不可选，则不让其选中
                if (el.disabled == true) {
                    $('#list').datagrid('unselectRow', index - 1);
                }
            })
        },
        onCheckAll:function(rows){ 
            //加载完毕后获取所有的checkbox遍历 
             $("input[type='checkbox']").each(function(index, el){ 
                 //如果当前的复选框不可选，则不让其选中 
                 if (el.disabled == true) { 
                	 $('#list').datagrid('unselectRow', index - 1); 
                 } 
             }) 
         },
         rowStyler: function(index,row){
        	if(index%2==1){
        	    return 'background-color:#F4F4F4;color:#000;';
        	    //这就是1,3,5行一个颜色了
        	}
       	}
	});
	
});

/* 客户姓名 */
function customerName(value){
	var btn="<a href='javascript:onCustomer("+value.cid+")'>"+value.cname+"</a>";
	return btn;
}

/* 点击客户姓名查看货物信息 */
function onCustomer(cid){
	$(".gxiangq").css('border-bottom','1px dashed #5F6D88');
	$.post("<%=path%>/customer/cusByid",{'cid':cid},function(index){
		cusfuzhi(index);
		$("#cusbyWin").dialog("open").dialog("setTitle", "客户信息");
	},"json");
}

function goState(value,obj){
	var state='';
	if(obj.gstate=='1'){
		state="<span class='dai'>待揽收</span>"
	}else if(obj.gstate=='2'){
		state="<span class='yi'>已揽收</span>"
	}else if(obj.gstate=='3'){
		state="<span class='ju'>已拒收</span>"
	}
	return state;
}

function lanshou(state){
	var sta='';
	if(state=='1'){
		sta='待揽收'
		$("#becase").remove();
	}else if(state=='2'){
		sta='已揽收'
		$("#becase").remove();
	}else if(state=='3'){
		sta='已拒收'
		$("#gooded").append(
		"<tr align='center' id='becase'>"+
			"<td class='tdwidth'>拒收原因:</td>"+
			"<td class='gxiangq' colspan='3'><span class='gocause'></span></td>"+
		"</tr>"
		);
	}
	return sta;
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

/* 表格按钮 */
function toSub(value,obj){
	var btn="<a href='javascript:openGoodWin("+obj.gid+")'>详情</a>";
	btn+="&nbsp;<a href='javascript:updateGoodWin("+obj.gid+")'>修改</a>";
	if(obj.gstate=='1'){
		btn+="&nbsp;<a href='javascript:openLSWin("+obj.gid+","+obj.gcid+","+obj.gcount+")'>揽收</a>";
		btn+="&nbsp;<a href='javascript:openJSWin("+obj.gid+")'>拒收</a>";
	}
	return btn;
}

/* 打开拒收窗口 */
function openJSWin(gid){
	$("#jgid").val(gid);
	$('#jgocause').textbox('setValue','');
	$("#goodJSWin").dialog("open").dialog("setTitle", "拒收原因");
}

/* 打开揽收窗口 */
 function openLSWin(gid,gcid,gcount){
	$("#lgid").val(gid);
	$("#lgcid").val(gcid);
	$("#lgcount").val(gcount);
	$('#lrdamagedcount').numberbox('setValue','');
	$('#lrshelvecount').numberbox('setValue','');
	$("#goodLSWin").dialog("open").dialog("setTitle", "揽收货物");
}

/* 提交收货单数据 */
function subRece(){
	var gid=$("#lgid").val();
	var gcid=$("#lgcid").val();
	var gcount=$("#lgcount").val();
	var lrdamagedcount = $('#lrdamagedcount').numberbox('getValue');
	var lrshelvecount = $('#lrshelvecount').numberbox('getValue');
	if(lrdamagedcount < 0){
		$.messager.alert('系统提示','破损数量不能为负！','info');
	}else if(lrshelvecount < 0){
		$.messager.alert('系统提示','搁置数量不能为负！','info');
	}else if(gcount<(parseInt(lrdamagedcount)+parseInt(lrshelvecount))){
		$.messager.alert('系统提示','破损和搁置数量超过了货物数量！','info');
	}else{
		if(lrdamagedcount==''){
			lrdamagedcount=0
		}if(lrshelvecount==''){
			lrshelvecount=0
		}
		$.post("<%=path%>/receipt/addRece",{'rgid':gid,'rcid':gcid,'rreceivecount':gcount,'rdamagedcount':lrdamagedcount,'rshelvecount':lrshelvecount},function(index){
			$.messager.alert("系统提示", index.result,'info');
			closeGoodWin();
			$("#list").datagrid("reload");	//刷新表格
		},"json");
	}
}

/* 提交拒收原因 */
function subGocause(){
	var gid=$("#jgid").val();
	var gocause = $('#jgocause').textbox('getValue');
	if(gocause==''){
		$.messager.alert("系统提示", '请填写拒收原因！','info');
	}else{
		$.post("<%=path%>/goods/goodCause",{'gid':gid,'gocause':gocause},function(index){
			$.messager.alert("系统提示", index.result,'info');
			closeGoodWin();
			$("#list").datagrid("reload");	//刷新表格
		},"json");
	}
}

/* 打开修改货物信息窗口 */
function updateGoodWin(gid) {
	/* 去掉下划虚线 */
	$(".gxiangq").css('border-bottom','0px');
	$.post("<%=path%>/goods/goodByid",{'gid':gid},function(index){
		updatefuzhi(index);
		$("#UpgoodbyWin").dialog("open").dialog("setTitle", "修改订单信息");
	},"json");
}

/* 打开详情窗口 */
function openGoodWin(gid) {
	$(".gxiangq").css('border-bottom','1px dashed #5F6D88');
	$.post("<%=path%>/goods/goodByid",{'gid':gid},function(index){
		fuzhi(index);
		$("#goodbyWin").dialog("open").dialog("setTitle", "客户订单详情");
	},"json");
    
}

/* 给客户信息窗口赋值 */
function cusfuzhi(index){
	$("#cname").html(index.customer.cname);
	$("#ckhno").html(index.customer.ckhno);
	$("#ccompany").html(index.customer.ccompany);
	$("#cphone").html(index.customer.cphone);
	$("#cemail").html(index.customer.cemail);
	$("#ccredit").html(index.customer.ccredit);
	$("#caddress").html(index.customer.caddress);
}

/* 给弹出的窗口赋值 */
function fuzhi(index){
	$(".gname").html(index.goods.gname);
	$(".gordernumber").html(index.goods.gordernumber);
	$(".gcount").html(index.goods.gcount + " "+index.goods.gunit);
	$(".gweight").html(isNull(index.goods.gweight) + " 吨");
	$(".gvolume").html(isNull(index.goods.gvolume) + " m<sup>3</sup>");
	$(".gsize").html(isNull(index.goods.gsize) + " m");
	$(".ggrade").html(index.goods.ggrade);
	$(".gconsignee").html(index.goods.gconsignee);
	$(".greaddress").html(index.goods.greaddress);
	$(".grephone").html(index.goods.grephone);
	$(".gorigin").html(index.goods.gorigin);
	$(".gendpoint").html(index.goods.gendpoint);
	$(".gstate").html(lanshou(index.goods.gstate));
	$(".gorderstime").html(formatDateTime(new Date(index.goods.gorderstime)));
	$(".gdescribe").html(index.goods.gdescribe);
	$(".gocause").html(index.goods.gocause);
}

/* 给弹出的窗口赋值 */
function updatefuzhi(index){
	$("#hgid").val(index.goods.gid);
	$(".gname").html(index.goods.gname);
	$(".gordernumber").html(index.goods.gordernumber);
	$("#gcount").val(index.goods.gcount);
	$("#gunit ").combobox('select',index.goods.gunit);
	$("#gweight").val(isHave(index.goods.gweight));
	$("#gvolume").val(isHave(index.goods.gvolume));
	$("#gsize").val(isHave(index.goods.gsize));
	$("#ggrade").combobox('select',index.goods.ggrade);
	$("#gconsignee").val(index.goods.gconsignee);
	$("#greaddress").val(index.goods.greaddress);
	$("#grephone").val(index.goods.grephone);
	$("#gorigin").val(index.goods.gorigin);
	$("#gendpoint").val(index.goods.gendpoint);
	$("#gdescribe").val(index.goods.gdescribe);
}

/* 如果为空 */
function isNull(val){
	if(val == '' || val == null){
		return '未知';
	}else{
		return val;
	}
}

/* 如果为空 */
function isHave(val){
	if(val == '' || val == null){
		return 0;
	}else{
		return val;
	}
}


/* 关闭窗口 */
function closeGoodWin(){
	$("#goodbyWin").dialog("close");
	$("#goodLSWin").dialog("close");
	$("#goodJSWin").dialog("close");
	$("#UpgoodbyWin").dialog("close");
	$("#cusbyWin").dialog("close");
}

/* 搜索 */
function seachs(){
	var cname = $('#scname').textbox('getValue');
	var gname = $('#sgname').textbox('getValue');
	var gstate = $('#sgstate').combobox('getValue');
	var gordernumber = $('#sgordernumber').textbox('getValue');
	$('#list').datagrid('load',{  
		cname:cname,
		gname:gname,
		gstate:gstate,
		gordernumber:gordernumber
	}); 
}

/* 批量揽收 */
function bulkGoods(){
	var row=$("#list").datagrid("getSelections");	//获取datagrid中选中的行
	if(row.length>0){
		var rcids = [];//客户id
		var rgids = [];//货物id
		var rreceivecounts = [];//货物数量
        for ( var i = 0; i < row.length; i++) {
        	rcids.push(row[i].gcid);
        	rgids.push(row[i].gid);
        	rreceivecounts.push(row[i].gcount);
        }
        var cids = rcids.join(",");
        var gids = rgids.join(",");
        var counts = rreceivecounts.join(",");
        $.post("<%=path%>/receipt/bulkGoods",{'rcids':cids,'rgids':gids,'rreceivecounts':counts},function(index){
        	$.messager.alert('提示',index.result,'info');
        	$("#list").datagrid("reload");	//刷新表格
        },"json");
	}else{
		$.messager.alert('提示','请选择需要揽收的货物','info');	//messager消息控件
	}
}

function getVal(){
	var grid = $('#list');  
	var options = grid.datagrid('getPager').data("pagination").options;  
	var pager = options.pageNumber;  
	var total = options.total;  
	var count = Math.ceil(total/options.pageSize);
	var data=$('#list').datagrid('getData');
	alert('总数据量:'+data.total)//注意你的数据源一定要定义了total，要不会为undefined，datagrid分页就是靠这个total定义
	alert('当前页数据量:'+data.rows.length)
	alert("当前页："+pager+"总条数"+total+"总页数："+count+"一页显示的个数"+options.pageSize);
	
}

/* 提交前检验信息 */
function checkSubGoods(){
	var gcount=$("#gcount").val();
	var gweight=$("#gweight").val();
	var gvolume=$("#gvolume").val();
	var gsize=$("#gsize").val();
	var gconsignee=$("#gconsignee").val();
	var greaddress=$("#greaddress").val();
	var grephone=$("#grephone").val();
	var gorigin=$("#gorigin").val();
	var gendpoint=$("#gendpoint").val();
	var re=/^(13[0-9]{9})|(15[89][0-9]{8})$/;
	if(gcount == ''){
		 $.messager.alert("系统提示", "请填写货物数量！",'info');
		 return false;
	}else if(gweight == ''){
		 $.messager.alert("系统提示", "请填写货物重量！",'info');
		 return false;
	}else if(parseInt(gweight)<0){
		 $.messager.alert("系统提示", "货物重量有误！",'info');
		 return false;
	}else if(gvolume == ''){
		 $.messager.alert("系统提示", "请填写货物体积！",'info');
		 return false;
	}else if(parseInt(gvolume)<0){
		 $.messager.alert("系统提示", "货物体积有误！",'info');
		 return false;
	}else if(parseInt(gsize)<0){
		 $.messager.alert("系统提示", "货物尺寸有误！",'info');
		 return false;
	}else if(gsize == ''){
		 $.messager.alert("系统提示", "请填写货物尺寸！",'info');
		 return false;
	}else if(gconsignee == ''){
		 $.messager.alert("系统提示", "请填写收货人！",'info');
		 return false;
	}else if(greaddress == ''){
		 $.messager.alert("系统提示", "请填写收货地址！",'info');
		 return false;
	}else if(grephone == ''){
		 $.messager.alert("系统提示", "请填写收货电话！",'info');
		 return false;
	}else if(!re.test(grephone)){
		 $.messager.alert("系统提示", "电话号码有误！",'info');
		 return false;
	}else if(gorigin == ''){
		 $.messager.alert("系统提示", "请填写起始地点！",'info');
		 return false;
	}else if(gendpoint == ''){
		 $.messager.alert("系统提示", "请填写到达地点！",'info');
		 return false;
	}else{
		saveGoods();
	}
}

/* 提交修改的信息 */
function saveGoods() {
    $("#subGoods").form("submit", {
        url : '<%=path%>/goods/updateGood',
        success : function(result) {
        	var result = eval('(' + result + ')');
        	if (result.success) {
                $.messager.alert("系统提示", "修改成功！",'info');
                $("#UpgoodbyWin").dialog("close");
            } else {
                $.messager.alert("系统提示", "修改失败！",'info');
                return;
            }
        }
    });
}

</script>
</head>
<body>
	<table id="list" class="easyui-datagrid" toolbar="#kj" style="width:100%" data-options="
		url:'<%=path %>/goods/all',
		method:'get',
		rownumbers:true,	
		singleSelect:false,
		autoRowHeight:true,
		pagination:true,
		border:false,
		pageSize:20,
		fit:true
	">
		<thead data-options="frozen:true">
			<tr>
				<th field="sid" checkbox="true">编号</th>
				<th field="customer" width="10%" align="center" formatter="customerName">客户</th>
				<th field="gname" width="10%" align="center">货物名称</th>
				<th field="gordernumber" width="12%" align="center">订单号</th>
				<th field="gcount" width="10%" align="center">货物数量</th>
				<th field="gunit" width="8%" align="center">单位</th>
				<th field="ggrade" width="8%" align="center">货物等级</th>
				<th field="gstate" width="12%" align="center" formatter="goState">货物状态</th>
				<th field="gorderstime" width="12%" align="center" formatter="toDate">下单时间</th>
				<th field="null" width="15%" align="center" formatter="toSub">操作</th>
			</tr>
		</thead>
	</table>
	
	<!-- 菜单 -->
	<div id="kj" style="padding: 2px;">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="window.print();">打印</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-export1'" onclick="location.href='<%=path %>/export/goodsExcel'">导出</a>
		<a href="javascript:bulkGoods()" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >批量揽收</a>&nbsp;
		客户：<input id="scname" class="easyui-validatebox easyui-textbox" name="cname" data-options="required:false" />&nbsp;
		货物：<input id="sgname" class="easyui-validatebox easyui-textbox" name="gname" data-options="required:false" />&nbsp;
		状态：<select id="sgstate" class="easyui-combobox" name="sgstate" data-options="editable:false" style="width:10%">
			<option value=""></option>
			<option value="1">未揽收</option>
			<option value="2">已揽收</option>
		</select>&nbsp;
		订单号：<input id="sgordernumber" class="easyui-validatebox easyui-textbox" name="gordernumber" data-options="required:false" />
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="seachs();">搜索</a>
	</div>
	
	<!-- 自定义窗口按钮 -->
	<div id="ls-buttons">
		<a href="javascript:subRece()" class="easyui-linkbutton" iconCls="icon-ok">确认</a>
	    <a href="javascript:closeGoodWin()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<!-- 揽收窗口 -->
	<div id="goodLSWin" class="easyui-dialog"  buttons="#ls-buttons" data-options="closable:true, closed:true"  style="width:25%;height:180px;padding:5px;text-align:center;">
			<input type="hidden" id="lgid">
			<input type="hidden" id="lgcid">
			<input type="hidden" id="lgcount">
		<br />
		破损数量：<input id="lrdamagedcount" class="easyui-validatebox easyui-numberbox" name="lrdamagedcount" data-options="required:false" /><br /><br />
		搁置数量：<input id="lrshelvecount" class="easyui-validatebox easyui-numberbox" name="lrshelvecount" data-options="required:false" />
	</div>
	
	<!-- 自定义窗口按钮 -->
	<div id="js-buttons">
		<a href="javascript:subGocause()" class="easyui-linkbutton" iconCls="icon-ok">确认</a>
	    <a href="javascript:closeGoodWin()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<!-- 拒收窗口 -->
	<div id="goodJSWin" class="easyui-dialog"  buttons="#js-buttons" data-options="closable:true, closed:true"  style="width:32%;height:230px;padding:5px;text-align:left;">
			<input type="hidden" id="jgid">
		<br />
		拒收原因：
		<input id="jgocause" class="easyui-textbox" data-options="multiline:true" style="width:100%;height:70%">
	</div>
	
	<!-- 自定义窗口按钮 -->
	<div id="cus-buttons">
	    <a href="javascript:closeGoodWin()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<!-- 显示客户信息 -->
	<div id="cusbyWin" class="easyui-dialog"  buttons="#cus-buttons" data-options="closable:true, closed:true"  style="width:60%;height:350px;padding:5px;text-align:center;">
		<table style="width:100%;height:100%;">
			<tr>
				<td class="tdwidth">客户名称:</td>
				<td class="gxiangq"><span id="cname"></span></td>
				<td class="tdwidth">客户编号:</td>
				<td class="gxiangq"><span id="ckhno"></span></td>
			</tr>
			<tr align="center">
				<td class="tdwidth">公司名称:</td>
				<td class="gxiangq"><span id="ccompany"></span></td>
				<td class="tdwidth">联系电话:</td>
				<td class="gxiangq"><span id="cphone"></span></td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">客户邮箱:</td>
				<td class="gxiangq"><span id="cemail"></span></td>
				<td class="tdwidth">信用度:</td>
				<td class="gxiangq"><span id="ccredit"></span></td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">地址:</td>
				<td class="gxiangq" colspan="3"><span id="caddress"></span></td>
			</tr>
			
		</table>
	</div>
	
	<!-- 自定义窗口按钮 -->
	<div id="dlg-buttons">
	    <a href="javascript:closeGoodWin()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<!-- 显示货物信息 -->
	<div id="goodbyWin" class="easyui-dialog"  buttons="#dlg-buttons" data-options="closable:true, closed:true"  style="width:70%;height:420px;padding:5px;text-align:center;">
		<table style="width:100%;height:100%;" id="gooded">
			<tr>
				<td class="tdwidth">货物名称:</td>
				<td class="gxiangq"><span class="gname"></span></td>
				<td class="tdwidth">货物订单号:</td>
				<td class="gxiangq"><span class="gordernumber"></span></td>
			</tr>
			<tr align="center">
				<td class="tdwidth">货物数量:</td>
				<td class="gxiangq"><span class="gcount"></span></td>
				<td class="tdwidth">货物重量:</td>
				<td class="gxiangq"><span class="gweight"></span></td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">货物体积:</td>
				<td class="gxiangq"><span class="gvolume"></span></td>
				<td class="tdwidth">货物尺寸:</td>
				<td class="gxiangq"><span class="gsize"></span></td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">货物等级:</td>
				<td class="gxiangq"><span class="ggrade"></span></td>
				<td class="tdwidth">收货人:</td>
				<td class="gxiangq"><span class="gconsignee"></span></td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">收货地址:</td>
				<td class="gxiangq"><span class="greaddress"></span></td>
				<td class="tdwidth">收货电话:</td>
				<td class="gxiangq"><span class="grephone"></span></td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">起始地点:</td>
				<td class="gxiangq"><span class="gorigin"></span></td>
				<td class="tdwidth">到达地点:</td>
				<td class="gxiangq"><span class="gendpoint"></span></td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">货物状态:</td>
				<td class="gxiangq"><span class="gstate"></span></td>
				<td class="tdwidth">下单时间:</td>
				<td class="gxiangq"><span class="gorderstime"></span></td>
			</tr>
			
			<tr align="center">
				<td class="tdwidth">货物描述:</td>
				<td class="gxiangq" colspan="3"><span class="gdescribe"></span></td>
			</tr>
		</table>
	</div>
	
	<!-- 自定义窗口按钮 -->
	<div id="update-buttons">
		<a href="javascript:checkSubGoods()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>	
	    <a href="javascript:closeGoodWin()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<!-- 修改货物信息 -->
	<div id="UpgoodbyWin" class="easyui-dialog"  buttons="#update-buttons" data-options="closable:true, closed:true"  style="width:70%;height:400px;padding:5px;text-align:center;">
		<form action="" method="post" id="subGoods">
			<input type="hidden" id="hgid" name="gid">
			<table style="width:100%;height:300px;">
				<tr>
					<td class="tdwidth">货物名称:</td>
					<td class="gxiangq"><span class="gname"></span></td>
					<td class="tdwidth">货物订单号:</td>
					<td class="gxiangq"><span class="gordernumber"></span></td>
				</tr>
				<tr align="center">
					<td class="tdwidth">货物数量:</td>
					<td class="gxiangq"><input type="number" id="gcount" name="gcount" maxlength="7" style="width:60px;"/>&nbsp;
						单位：<select id="gunit" class="easyui-combobox" name="gunit" data-options="editable:false" style="width:60px;height:30px;">
						<option value="箱">箱</option>
						<option value="个">个</option>
						<option value="条">条</option>
						<option value="袋">袋</option>
						<option value="盒">盒</option>
						<option value="包">包</option>
						<option value="瓶">瓶</option>
						<option value="罐">罐</option>
						<option value="辆">辆</option>
						<option value="只">只</option>
						<option value="套">套</option>
						<option value="尊">尊</option>
						<option value="块">块</option>
						<option value="其它">其它</option>
					</select></td>
					<td class="tdwidth">货物重量:</td>
					<td class="gxiangq"><input type="number" id="gweight" name="gweight"/> 吨</td>
				</tr>
				
				<tr align="center">
					<td class="tdwidth">货物体积:</td>
					<td class="gxiangq"><input type="number" id="gvolume" name="gvolume"/> m³</td>
					<td class="tdwidth">货物尺寸:</td>
					<td class="gxiangq"><input type="number" id="gsize" name="gsize"/> m</td>
				</tr>
				
				<tr align="center">
					<td class="tdwidth">货物等级:</td>
					<td class="gxiangq">
						<select id="ggrade" class="easyui-combobox" name="ggrade" data-options="editable:false" style="width:190px;height:30px;">
							<option value="1">等级 1</option>
							<option value="2">等级 2</option>
							<option value="3">等级 3</option>
							<option value="4">等级 4</option>
							<option value="5">等级 5</option>
						</select>
					</td>
					<td class="tdwidth">收货人:</td>
					<td class="gxiangq"><input type="text" id="gconsignee" name="gconsignee"/></td>
				</tr>
				
				<tr align="center">
					<td class="tdwidth">收货地址:</td>
					<td class="gxiangq"><input type="text" id="greaddress" name="greaddress"/></td>
					<td class="tdwidth">收货电话:</td>
					<td class="gxiangq"><input type="text" id="grephone" name="grephone"/></td>
				</tr>
				
				<tr align="center">
					<td class="tdwidth">起始地点:</td>
					<td class="gxiangq"><input type="text" id="gorigin" name="gorigin"/></td>
					<td class="tdwidth">到达地点:</td>
					<td class="gxiangq"><input type="text" id="gendpoint" name="gendpoint"/></td>
				</tr>
			</table>
		</form>
	</div>
	
</body>
</html>