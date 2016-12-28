<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>宏图物流有限公司</title>
<link href="style/css.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="<%=path %>/css/service.css"/>
<script type="text/javascript" src="<%=path %>/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery.fixed.1.5.1.js"></script>
<style type="text/css">
body { font:13px/1.5 "Microsoft Yahei" }
a{ color:yellow;text-decoration:none;}
a:hover { text-decoration:none; color:red;}
.clearfix:after {visibility:hidden;display:block;font-size:0;content:" ";clear:both;height:0;}
.clearfix{*zoom:1;}

.demo { width:960px; margin:0 auto; padding:100px 50px 0; background-color:#f2f2f2; }
.qhd-desc h2 { margin-bottom:0.8em; }
.qhd-desc h3 { margin-bottom:0.6em; }
.qhd-desc p { margin-bottom:0.5em; }
.demo-copyright { margin-top:100px; text-align:center; }
</style>
<link rel="stylesheet" type="text/css" href="css/service.css"/>
<script type="text/javascript" src="<%=path %>/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery.fixed.1.5.1.js"></script>
<script language="javascript">
//must window loading,don't use the document loading
$(window).load(function(){
	
	//悬浮客服
	$("#fixedBox2").fix({
		position 		: "left",	//悬浮位置 - left或right
		horizontal  	: 0,		//水平方向的位置 - 默认为数字
		vertical    	: null,		//垂直方向的位置 - 默认为null
		halfTop     	: false,	//是否垂直居中位置
		minStatue 		: false,	//是否最小化
		hideCloseBtn 	: false,	//是否隐藏关闭按钮
		skin 			: "gray",	//皮肤
		showBtnWidth 	: 28,       //show_btn_width
		contentBoxWidth : 154, 		//side_content_width
		durationTime 	: 600		//完成时间
	});
	
	//悬浮客服
	$("#fixedBox").fix({
		position 		: "right",	//悬浮位置 - left或right
		horizontal  	: 0,		//水平方向的位置 - 默认为数字
		vertical    	: 100,      //垂直方向的位置 - 默认为null
		halfTop     	: true,	    //是否垂直居中位置
		minStatue 		: false,	//是否最小化
		hideCloseBtn 	: false,	//是否隐藏关闭按钮
		skin 			: "blue",	//皮肤
		showBtnWidth 	: 28,       //show_btn_width
		contentBoxWidth : 154, 		//side_content_width
		durationTime 	: 1000		//完成时间
	});
	
});
</script>
</head>

<body>

<table width="920" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td width="10">&nbsp;</td>
		<td width="449" valign="top">

			
					<table width="97%" border="0" cellspacing="0" cellpadding="0">
						<tr height="20">
							<td width="80" align="center" class="font1">公司简介</td>
							<td width="80" align="center" class="font2">About us</td>
							<td align="right" valign="bottom" class="line1"><a href="../../物流资料/hua/www.bbxmwl.com/info.asp~base_id=1.html" class="d1"></a></td>
						</tr>
					</table>

					
						<table width="93%" border="0" cellpadding="0" cellspacing="0" style="margin:20px 0 30px 0;">
							<tr>
								<td class="content1" style="padding-left:15px;">
									　　宏图物流有限公司是一家集国内、公路、铁路、水路、航空运输、仓储、包装、配送、信息处理于一身的专业化物流公司。
　　目前，公司已在济南、天津、北京、上海、沈阳、内蒙、西安和广州、设立了办事处，并在济南、哈尔滨、昆明、兰州、深圳等各大城市都拥有物流服务合作伙伴，已经形成了以安徽为中心，覆盖全国各大城市的完善的物流服务网络。公司一直致力于物流网络的建...								</td>
							</tr>
						</table>
					
					<table width="97%" border="0" cellspacing="0" cellpadding="0">
						<tr height="20">
							<td width="80" align="center" class="font1">物流车辆</td>
							<td width="80" align="center" class="font2">Logistics</td>
							<td align="right" valign="bottom" class="line1"><a href="" class="d1"></a></td>
						</tr>
					</table>

					
							<div id="demo1" style="overflow:hidden;width:439px;margin:20px 0 30px 0;">
                              <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td id="demo1_1"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                      <tr align="center" valign="top">
                                        <td style="padding: 0 5px;"><div><a href='' target="_blank"><img border='0' src='image/200712643680093.jpg' width='100' height='100' class='picBorder' /></a></div>
                                            <div style="padding-top:5px;"><a href='' target="_blank">物流车辆</a></div></td>
                                        <td style="padding: 0 5px;"><div><a href='' target="_blank"><img border='0' src='image/200712643671781.jpg' width='100' height='100' class='picBorder' /></a></div>
                                            <div style="padding-top:5px;"><a href='' target="_blank">物流车辆</a></div></td>
                                        <td style="padding: 0 5px;"><div><a href='' target="_blank"><img border='0' src='image/200712643663437.jpg' width='100' height='100' class='picBorder' /></a></div>
                                            <div style="padding-top:5px;"><a href='' target="_blank">物流车辆</a></div></td>
                                        <td style="padding: 0 5px;"><div><a href='' target="_blank"><img border='0' src='image/200712643653281.jpg' width='100' height='100' class='picBorder' /></a></div>
                                            <div style="padding-top:5px;"><a href='' target="_blank">物流车辆</a></div></td>
                                      </tr>
                                  </table></td>
                                  <td id="demo1_2"></td>
                                </tr>
                              </table>
		  </div>
							
					


			<!-- 联系信息 //-->
			<table width="97%" border="0" cellspacing="0" cellpadding="0" class="td3">
				<tr>
					<td width="120" align="center"><img src="image/title_contact.gif" width="86" height="109"></td>
					<td align="center" valign="top">
						<table width="90%" border="0" cellspacing="0" cellpadding="0">
							<tr height="10">
								<td></td>
							</tr>
							<tr style="line-height:22px;font-family:Arial;">
								<td><P>公司名称：<FONT face=Verdana>宏图物流有限公司</FONT> <BR>
								    联系电话：110&nbsp; 119 &nbsp;120<BR>
								    总部地址：赣州技师学院小红楼2单元302-1</P>
                                  <P>Q&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q：3838438</P>
                                  <P>手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 机：13838384384</P></td>
							</tr>
							<tr height="10">
								<td></td>
							</tr>
						</table>					</td>
				</tr>
			</table>
			<table width="97%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
				<tr>
					<td height="10"></td>
				</tr>
			</table>		</td>
		<td width="1" background="image/line_point1.gif"></td>
		<td align="right" valign="top">


			<table width="97%" border="0" cellspacing="0" cellpadding="0" class="td3">
				<form name="searchFrm" action="<%=basePath%>front/list" method="post" onSubmit="if (this.search.value == '') {this.search.focus();return false;}">

					<tr height="39">
						<td width="110" align="center"><img src="image/title_search.gif" width="96" height="38"></td>
						<td width="20">&nbsp;</td>
						<td width="120"><input name="search" type="text" class="input1" size="16" maxlength="30"></td>
						<td width="125">
							<select name="csid" style="width:120px;">
								
								
									<option value="1">车型信息</option>
								
									<option value="2">汽车详情</option>
								
									
							</select>						</td>
						<td><input type="submit" name="Submit" value="确定"></td>
					</tr>
			</table>
			<table width="97%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="30"></td>
				</tr>
			</table>

			
					<table width="97%" border="0" cellspacing="0" cellpadding="0">
						<tr height="20">
							<td width="80" align="center" class="font1">资质证书</td>
							<td width="80" align="center" class="font2">Honor</td>
							<td align="right" valign="bottom" class="line1"><a href="" class="d1"></a></td>
						</tr>
					</table>

					
							<table width="97%" border="0" cellspacing="0" cellpadding="0" style="margin:20px 0 10px 0;">
								<tr align='center' valign='top'>
									<td width="33.3333333333333%">
										<div><a href='' target="_blank"><img border='0' src='image/200712642198625.jpg' width='100' height='100' class='picBorder' /></a></div>
										<div style="padding-top:5px;"><a href='' target="_blank">营业执照</a></div>									</td>
								
									<td width="33.3333333333333%">
										<div><a href='' target="_blank"><img border='0' src='image/200712642174249.jpg' width='100' height='100' class='picBorder' /></a></div>
										<div style="padding-top:5px;"><a href='' target="_blank">税务登记证</a></div>									</td>
								
									<td width="33.3333333333333%">
										<div><a href='' target="_blank"><img border='0' src='image/200712642153641.jpg' width='100' height='100' class='picBorder' /></a></div>
										<div style="padding-top:5px;"><a href='' target="_blank">道路运输经营许..</a></div>									</td>
								</tr><tr height='20'><td colspan='3'></td></tr>
							</table>
					
					<table width="97%" border="0" cellspacing="0" cellpadding="0">
						<tr height="20">
							<td width="80" align="center" class="font1">经营范围</td>
							<td width="80" align="center" class="font2">Scope</td>
							<td align="right" valign="bottom" class="line1"><a href="" class="d1"></a></td>
						</tr>
					</table>

					
						<table width="97%" border="0" cellpadding="0" cellspacing="0" style="margin:20px 0 30px 0;">
							<tr>
								<td class="content1" style="padding:0 10px;">
									１.公路运输，水运，江海联运，代办铁路运输，集装箱运输，代办进出口货物运输，大型停车场，仓储；
　２.大件货物起重、安装、运输等一条龙服务；
　３.为司机提供停车、住宿，车辆中介、维修服务；
　４.代办新车上牌、入户、保险、年检、二级维护等业务；
　５.代开增值税发票、公路、内河运输业发票；
　６.代办驾驶证...								</td>
							</tr>
						</table>
					
					<table width="97%" border="0" cellspacing="0" cellpadding="0">
						<tr height="20">
							<td width="80" align="center" class="font1">服务网络</td>
							<td width="80" align="center" class="font2">Network</td>
							<td align="right" valign="bottom" class="line1"><a href="" class="d1"></a></td>
						</tr>
					</table>

					
						<table width="97%" border="0" cellpadding="0" cellspacing="0" style="margin:20px 0 30px 0;">
							<tr align="left">
								<td class="content1" style="padding:0 10px;">
									 天津、北京、河北省、东北三省、济南、郑州、西安、内蒙、湖南、湖北、广东省、江苏省、浙江省、整车、零担、往返、货物运输。
 全国各地整车零担货物运输业务。为客户提供快捷、准确的货运信息，根据所需车型合理配置，大大降低企业运输成本。欢迎各地新、旧车辆转入我公司挂户。								</td>
							</tr>
						</table>		</td>
		<td width="10">&nbsp;</td>
	</tr>
</table>
<div class="fixed_box" id="fixedBox">
    <div class="content_box">
        <div class="content_inner">
        	<div class="close_btn"><a title="关闭"><span>关闭</span></a></div>
            <div class="content_title"><span>客服中心</span></div>
            <div class="content_list">            	
                <div class="qqserver">
                    <p>                              
                        <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&amp;uin=1274603021&amp;site=qq&amp;menu=yes">
                          <img border="0" src="http://wpa.qq.com/pa?p=2:1274603021:41" alt="点击这里给我发消息" title="点击这里给我发消息">
                          <span>乐哥</span>
                    	</a>
                    </p>
                    <p>
                        <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=1223348320&site=qq&menu=yes">
                          <img border="0" src="http://wpa.qq.com/pa?p=2:1223348320:41" alt="点击这里给我发消息" title="点击这里给我发消息">
                          <span>猴子</span>
                    	</a>
                    </p>
                    <p>
                        <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=956450236&site=qq&menu=yes">
                          <img border="0" src="http://wpa.qq.com/pa?p=2:956450236:41" alt="点击这里给我发消息" title="点击这里给我发消息">
                          <span>狗蛋</span>
                    	</a>
                    </p>       
                    <p>                        
                        <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=2353432835&site=qq&menu=yes">
                          <img border="0" src="http://wpa.qq.com/pa?p=2:2353432835:41" alt="点击这里给我发消息" title="点击这里给我发消息">
                          <span>灰灰</span>
                    	</a>
                    </p>
                    <p>
                        <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=844661789&site=qq&menu=yes">
                          <img border="0" src="http://wpa.qq.com/pa?p=2:844661789:41" alt="点击这里给我发消息" title="点击这里给我发消息">
                          <span>豪傻</span>
                    	</a>
                    </p>
                    <p>
                        <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=1532722446&site=qq&menu=yes">
                          <img border="0" src="http://wpa.qq.com/pa?p=2:1532722446:41" alt="点击这里给我发消息" title="点击这里给我发消息">
                          <span>建叼</span>
                    	</a>
                    </p>
                     <p>
                    <a target="_blank" href="//shang.qq.com/wpa/qunwpa?idkey=43d842e0b7e25be0fc911c5e86365dd107d12bb2ced595e4371a7943b9341279"><img border="0" src="//pub.idqqimg.com/wpa/images/group.png" alt="人多人少气势不倒" title="人多人少气势不倒"></a>            
              		</p>
                </div>               
                <hr>
                <div class="phoneserver">
                    <h5>客户服务热线</h5>
                    <p>请直接QQ联系！</p>
                </div>
                <hr>
                <div class="msgserver">
                    <p><a href="<%=path %>/customer/message">给我们留言</a></p>
                </div>
            </div>
            <div class="content_bottom"></div>
        </div>
    </div>
    <div class="show_btn"><span>展开客服</span></div>
</div>
</body>
</html>
