<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Crazy</title>
<script type="text/javascript" src="<%=path %>/js/ichart.1.2.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
$(function(){
	var yi = new Array();
	var ju = new Array();
    yi = "${yi}".replace('[','').replace(']','').split(',');
    ju = "${ju}".replace('[','').replace(']','').split(',');
	var val=[0, 2, 1, 1, 1, 1];
	var data = [
	         	{
	         		name : '揽收',
	         		value:yi,
	         		color:'#1385a5'
	         	},
	         	{
	         		name : '拒收',
	         		value:ju,
	         		color:'#c56966'
	         	}
	         ];
	var chart = new iChart.ColumnMulti2D({
			render : 'canvasDiv',
			data: data,
			labels:["一月","二月","三月","四月","五月","六月","七月","八月","九月"],
			title : '2017年度每月揽收情况',
			subtitle : '',
			footnote : '数据来源：入库管理',
			width : 950,
			height : 500,
			background_color : '#ffffff',
			legend:{
				enable:true,
				background_color : null,
				border : {
					enable : false
				}
			},
			coordinate:{
				background_color : '#f1f1f1',
				scale:[{
					 position:'left',	
					 start_scale:0,
					 end_scale:100,
					 scale_space:15
				}],
				width:800,
				height:300
			}
	});
	chart.draw();
});
</script>
</head>
<body>
	<div id="canvasDiv" style="margin-left: 5%;"></div>
</body>
</html>