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
<title>极速物流服务有限公司</title>
<link href="style/css.css" rel="stylesheet" type="text/css" />
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
									　　极速物流服务有限公司是一家集国内、公路、铁路、水路、航空运输、仓储、包装、配送、信息处理于一身的专业化物流公司。
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
								<td><P>公司名称：<FONT face=Verdana>极速物流服务有限公司</FONT> <BR>
								    联系电话：0732-8888888&nbsp; 6666666 &nbsp;&nbsp;9999999<BR>
								    总部地址：车站路100-200号</P>
                                  <P>传&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;真：0732-88888888</P>
                                  <P>手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 机：13888888888</P></td>
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
</body>
</html>
