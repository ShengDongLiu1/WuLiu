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
</head>
<body>
	<div id="canvasDiv" style="margin:10% 0 0 10%;"></div>
	<script type="text/javascript">
	$(function(){
		var sta1='${sta1}';
		var sta2='${sta2}';
		var sta3='${sta3}';
		var sta4='${sta4}';
		var sta5='${sta5}';
		sta1 = Math.round(sta1*100)/100;
		sta2 = Math.round(sta2*100)/100;
		sta3 = Math.round(sta3*100)/100;
		sta4 = Math.round(sta4*100)/100;
		sta5 = Math.round(sta5*100)/100;
		var other=100-(sta1+sta2+sta3+sta4+sta5);
		other=Math.round(other*100)/100;
		var data = [
		        	{name : '一星级',value : sta1,color:'#FFB261'},
		        	{name : '二星级',value : sta2,color:'#18A15F'},
		        	{name : '三星级',value : sta3,color:'#DD5347'},
		        	{name : '四星级',value : sta4,color:'#80699b'},
		        	{name : '五星级',value : sta5,color:'#53CDFD'},
		        	{name : '其他',value : other,color:'#957F38'}
	        	];

    	
		var chart = new iChart.Pie3D({
			render : 'canvasDiv',
			data: data,
			title : {
				text : '客户星级分析',
				height:40,
				fontsize : 30,
				color : '#282828'
			},
			footnote : {
				text : '数据来源：客户管理',
				color : '#486c8f',
				fontsize : 12,
				padding : '0 38'
			},
			sub_option : {
				mini_label_threshold_angle : 40,//迷你label的阀值,单位:角度
				mini_label:{//迷你label配置项
					fontsize:12,
					fontweight:600,
					color : '#ffffff'
				},
				label : {
					background_color:null,
					sign:false,//设置禁用label的小图标
					padding:'0 4',
					border:{
						enable:false,
						color:'#666666'
					},
					fontsize:11,
					fontweight:600,
					color : '#4572a7'
				},
				border : {
					width : 2,
					color : '#ffffff'
				},
				listeners:{
					parseText:function(d, t){
						var lab=d.get('name');
						return lab+=d.get('value')+"%";//自定义label文本
					}
				} 
			},
			legend:{
				enable:true,
				padding:0,
				offsetx:120,
				offsety:50,
				color:'#3e576f',
				fontsize:20,//文本大小
				sign_size:20,//小图标大小
				line_height:28,//设置行高
				sign_space:10,//小图标与文本间距
				border:false,
				align:'left',
				background_color : null//透明背景
			},
			animation : true,//开启过渡动画
			animation_duration:800,//800ms完成动画 
			shadow : true,
			shadow_blur : 6,
			shadow_color : '#aaaaaa',
			shadow_offsetx : 0,
			shadow_offsety : 0,
			background_color:'#f1f1f1',
			align:'right',//右对齐
			offsetx:-100,//设置向x轴负方向偏移位置60px
			offset_angle:-90,//逆时针偏移120度
			width : 800,
			height : 400,
			radius:150
		});
		//利用自定义组件构造右侧说明文本
		chart.plugin(new iChart.Custom({
				drawFn:function(){
					//在右侧的位置，渲染说明文字
					chart.target.textAlign('start')
					.textBaseline('top')
					.textFont('600 20px Verdana')
					.fillText('分析每个星级客户所占的比例',120,80,false,'#be5985',false,24)
					.textFont('600 12px Verdana')
					.fillText('',120,160,false,'#999999');
				}
		}));
		
		chart.draw();
	});
	</script>
</body>
</html>