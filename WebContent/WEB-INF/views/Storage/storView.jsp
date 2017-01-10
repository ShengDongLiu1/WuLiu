<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Crazy</title>
<link type="text/css" rel="stylesheet" href="<%=path %>/css/index.css" />
<script type="text/javascript" src="<%=path %>/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/echarts.min.js"></script>
</head>
<body style="text-align:center">
	<span style="font-size:18px;font-weight:bold">上周货物入库情况</span>
	<div id="line" style="width:90%;height:492px;"></div>
	<script type="text/javascript">
		//折线图
		var list = new Array();
		var weekDate = new Array();
    	list = "${list}".replace('[','').replace(']','').split(',');
    	weekDate = "${weekDate}".replace('[','').replace(']','').split(',');
		var line = echarts.init(document.getElementById('line'));
		line.setOption({
		    color:["#32d2c9"],
		    title: {
		        x: 'left',
		        text: '入库统计',
		        textStyle: {
		            fontSize: '18',
		            color: '#4c4c4c',
		            fontWeight: 'bolder'
		        }
		    },
		    tooltip: {
		        trigger: 'axis'
		    },
		    toolbox: {
		        show: true,
		        feature: {
		            dataZoom: {
		                yAxisIndex: 'none'
		            },
		            dataView: {readOnly: false},
		            magicType: {type: ['line', 'bar']}
		        }
		    },
		    xAxis:  {
		        type: 'category',
		        boundaryGap: false,
		        data: weekDate,
		        axisLabel: {
		            interval:0
		        }
		    },
		    yAxis: {
		        type: 'value',
		    },
		    series: [
		        {
		            name:'入库量',
		            type:'line',
		            data:list,
		            markLine: {data: [{type: 'average', name: '平均值'}]}
		        }
		    ]
		}) ;
	</script>
</body>
</html>