<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Crazy</title>
<link type="text/css" rel="stylesheet" href="<%=path %>/css/index.css" />
<script type="text/javascript" src="<%=path %>/js/ichart.1.2.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
$(function(){
	var yi = new Array();
	var ju = new Array();
    yi = "${yi}".replace('[','').replace(']','').split(',');
    ju = "${ju}".replace('[','').replace(']','').split(',');
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
			labels:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
			title : '2017年度每月揽收情况',
			subtitle : '',
			footnote : '数据来源：入库管理',
			width : 950,
			height : 350,
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
<body style="text-align:center">
	<span style="font-size:18px;font-weight:bold">订单情况预览</span>
	<div id="ring" style="width:450px;height:164px;"></div>
	<div id="canvasDiv" style="margin-left: 5%;"></div>
	<script type="text/javascript" src="<%=path %>/js/echarts.min.js"></script>
	<script type="text/javascript">
		//环状图
		var success=parseInt('${success}');
		var fial=parseInt('${fial}');
		var tuihui=parseInt('${tuihui}');
		var ring = echarts.init(document.getElementById('ring'));
		var labelTop = {
		    normal : {
		        label : {
		            show : true,
		            position : 'center',
		            formatter : '{b}',
		            textStyle: {
		                baseline : 'bottom'
		            }
		        },
		        labelLine : {
		            show : false
		        }
		    }
		};
	
		var labelFromatter = {
		    normal : {
		        label : {
		            formatter : function (params){
		                return 100 - params.value + '%'
		            },
		            textStyle: {
		                baseline : 'top'
		            }
		        }
		    },
		}
		var labelBottom = {
		    normal : {
		        color: '#ccc',
		        label : {
		            show : true,
		            position : 'center'
		        },
		        labelLine : {
		            show : false
		        }
		    },
		    emphasis: {
		        color: 'rgba(0,0,0,0)'
		    }
		};
		var radius = [40, 55];
		ring.setOption({
		    color:["#33bb9f","#ffa259","#4cbbe6"],
		    series : [
		        {
		            type : 'pie',
		            center : ['15%', '58%'],
		            radius : radius,
		            x: '0%', // for funnel
		            itemStyle : labelFromatter,
		            data : [
		                {name:'other', value:100-success, itemStyle : labelBottom},
		                {name:'已揽收', value:success,itemStyle : labelTop}
		            ]
		        },
		        {
		            type : 'pie',
		            center : ['45%', '58%'],
		            radius : radius,
		            x:'20%', // for funnel
		            itemStyle : labelFromatter,
		            data : [
		                {name:'other', value:100-fial, itemStyle : labelBottom},
		                {name:'已拒收', value:fial,itemStyle : labelTop}
		            ]
		        },
		        {
		            type : 'pie',
		            center : ['75%', '58%'],
		            radius : radius,
		            x:'40%', // for funnel
		            itemStyle : labelFromatter,
		            data : [
		                {name:'other', value:100-tuihui, itemStyle : labelBottom},
		                {name:'已取消', value:tuihui,itemStyle : labelTop}
		            ]
		        }
		    ]
		}) ;
	</script>
</body>
</html>