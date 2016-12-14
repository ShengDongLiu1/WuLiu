var homeTabTitle = '主页';

function addTab(title, url) {
	if ($('#tabs').tabs('exists', title)) {
		$('#tabs').tabs('select', title);
		var currTab = $('#tabs').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		if (url != undefined && currTab.panel('options').title != homeTabTitle) {
			$('#tabs').tabs('update', {
				tab : currTab,
				options : {
					content : createFrame(url)
				}
			})
		}
	} else {
		$('#tabs').tabs('add', {
			title : title,
			content : createFrame(url),
			border : false,
			closable : true
		});
	}
	tabClose();
}

function createFrame(url) {
	return '<iframe scrolling="auto" frameborder="0"  src="' + url
			+ '" style="width:100%;height:100%;"></iframe>';
}

function tabClose() {
	$(".tabs-inner").dblclick(function() {
		var subtitle = $(this).children(".tabs-closable").text();
		$('#tabs').tabs('close', subtitle);
	})
	$(".tabs-inner").bind('contextmenu', function(e) {
		$('#mm').menu('show', {
			left : e.pageX,
			top : e.pageY
		});

		var subtitle = $(this).children(".tabs-closable").text();

		$('#mm').data("currtab", subtitle);
		$('#tabs').tabs('select', subtitle);
		return false;
	});
}

function tabCloseEvent() {
	$('#mm-tabupdate').click(
			function() {
				var currTab = $('#tabs').tabs('getSelected');
				var url = $(currTab.panel('options').content).attr('src');
				if (url != undefined
						&& currTab.panel('options').title != homeTabTitle) {
					$('#tabs').tabs('update', {
						tab : currTab,
						options : {
							content : createFrame(url)
						}
					})
				}
			})
	$('#mm-tabclose').click(function() {
		var currtab_title = $('#mm').data("currtab");
		$('#tabs').tabs('close', currtab_title);
	})
	$('#mm-tabcloseall').click(function() {
		$('.tabs-inner span').each(function(i, n) {
			var t = $(n).text();
			if (t != homeTabTitle) {
				$('#tabs').tabs('close', t);
			}
		});
	});
	$('#mm-tabcloseother').click(function() {
		var prevall = $('.tabs-selected').prevAll();
		var nextall = $('.tabs-selected').nextAll();
		if (prevall.length > 0) {
			prevall.each(function(i, n) {
				var t = $('a:eq(0) span', $(n)).text();
				if (t != homeTabTitle) {
					$('#tabs').tabs('close', t);
				}
			});
		}
		if (nextall.length > 0) {
			nextall.each(function(i, n) {
				var t = $('a:eq(0) span', $(n)).text();
				if (t != homeTabTitle) {
					$('#tabs').tabs('close', t);
				}
			});
		}
		return false;
	});
	$('#mm-tabcloseright').click(function() {
		var nextall = $('.tabs-selected').nextAll();
		if (nextall.length == 0) {
			alert('后边没有啦~~');
			return false;
		}
		nextall.each(function(i, n) {
			var t = $('a:eq(0) span', $(n)).text();
			$('#tabs').tabs('close', t);
		});
		return false;
	});

	$('#mm-tabcloseleft').click(function() {
		var prevall = $('.tabs-selected').prevAll();
		if (prevall.length == 0) {
			alert('到头了，前边没有啦~~');
			return false;
		}
		prevall.each(function(i, n) {
			var t = $('a:eq(0) span', $(n)).text();
			$('#tabs').tabs('close', t);
		});
		return false;
	});

	$("#mm-exit").click(function() {
		$('#mm').menu('hide');
	})
}

$(function() {
	tabCloseEvent();
	$('.site-navi-tab').click(function() {
		var $this = $(this);
		var href = $this.attr('src');
		var title = $this.text();
		addTab(title, href);
	});
});

function setPagination(tableId) {
	var p = $(tableId).datagrid('getPager');
	$(p).pagination({
		pageSize : 20,
		pageList : [ 10, 15, 20, 25 ],
		beforePageText : '第',
		afterPageText : '页    共 {pages} 页',
		displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录',
		onBeforeRefresh : function() {
			$(this).pagination('loading');
			$(this).pagination('loaded');
		}
	});
}

function formatterDate(value) {
	if (value == undefined || value == null || value == '') {
		return "";
	} else {
		var date = new Date(value);
		var year = date.getFullYear().toString();
		var month = (date.getMonth() + 1);
		var day = date.getDate().toString();
		var hour = date.getHours().toString();
		var minutes = date.getMinutes().toString();
		var seconds = date.getSeconds().toString();
		if (month < 10) {
			month = "0" + month;
		}
		if (day < 10) {
			day = "0" + day;
		}
		if (hour < 10) {
			hour = "0" + hour;
		}
		if (minutes < 10) {
			minutes = "0" + minutes;
		}
		if (seconds < 10) {
			seconds = "0" + seconds;
		}
		return year + "-" + month + "-" + day + " " + hour + ":" + minutes
				+ ":" + seconds;
	}
}

function formatterRole(value) {
	if (value == 'super') {
		return "超级管理员";
	} else {
		return "普通管理员";
	}
}

function formatterStatus(value) {
	if (value == "Y") {
		return "可用";
	} else {
		return "不可用";
	}
}

function formatterOnline(value) {
	if (value == "Y") {
		return "在线";
	} else {
		return "离线";
	}
}

function formatterLong(value) {
	if (value != undefined && value != '' && value.length >= 35) {
		var abValue = value.substring(0, 34) + "...";
		return "<a href='javascript:void(0);' title='" + value
				+ "' class='easyui-tooltip'>" + abValue + "</a>";
	} else {
		return value;
	}
}

function openWin(id) {
	$("#" + id).window("open");
}

function openWinFitPos(id) {
	var top = ($(document.body).height() - $("#" + id).height()) / 2 - 28;
	var left = ($(document.body).width() - $("#" + id).width()) / 2 - 18;
	$("#" + id).window({
		top : top,
		left : left
	});
	openWin(id);
}

function closeWin(id) {
	$("#" + id).window("close");
}

function selectedRow(id) {
	return $("#" + id).datagrid("getSelected");
}

function dataGridReload(id) {
	$("#" + id).datagrid("reload");
}

function closeTab(title) {
	$('#tabs').tabs('close', title);
}

$(function() {
	$('.validatebox-text').bind('blur', function() {
		$(this).validatebox('enableValidation').validatebox('validate');
	});
})

function toValidate(formId) {
	$('#' + formId + ' .validatebox-text').validatebox('enableValidation')
			.validatebox('validate');
}

function validateForm(id) {
	return $("#" + id).form("validate");
}

function getQueryParams(dataGridId, formId) {
	var fields = $('#' + formId).serializeArray();
	var params = $("#" + dataGridId).datagrid('options').queryParams;
	$.each(fields, function(i, field) {
		params[field.name] = field.value;
	});
	return params;
}

function toPage(url) {
	window.location.href = url;
}

function checkFile(name, index, type, size) {
	var file = document.getElementsByName(name)[index].files[0];
	if (file != undefined) {
		var fileName = file.name;
		var fileType = fileName.substring(fileName.lastIndexOf('.'),
				fileName.length);
		var maxSize = size * 1024 * 1024;
		if (file.size >= maxSize) {
			$.messager.alert("提示", "文件大小最大为" + size + "MB", "info");
			return false;
		}
		if (type.indexOf(fileType) < 0) {
			$.messager.alert("提示", "文件后缀只能为" + type, "info");
			return false;
		}
	}
	return true;
}

$.extend($.fn.datagrid.methods, {
	            getExcelXml: function (jq, param) {
	                var worksheet = this.createWorksheet(jq, param);
	                 //alert($(jq).datagrid('getColumnFields'));
	                var totalWidth = 0;
	                 var cfs = $(jq).datagrid('getColumnFields');
	               for (var i = 1; i < cfs.length; i++) {
	                      totalWidth += $(jq).datagrid('getColumnOption', cfs[i]).width;
	                 }
	                  //var totalWidth = this.getColumnModel().getTotalWidth(includeHidden);
	                  return '<?xml version="1.0" encoding="utf-8"?>' +//xml申明有问题，以修正，注意是utf-8编码，如果是gb2312，需要修改动态页文件的写入编码
	              '<ss:Workbook xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:o="urn:schemas-microsoft-com:office:office">' +
	             '<o:DocumentProperties><o:Title>' + param.title + '</o:Title></o:DocumentProperties>' +
	              '<ss:ExcelWorkbook>' +
	             '<ss:WindowHeight>' + worksheet.height + '</ss:WindowHeight>' +
	            '<ss:WindowWidth>' + worksheet.width + '</ss:WindowWidth>' +
	             '<ss:ProtectStructure>False</ss:ProtectStructure>' +
	            '<ss:ProtectWindows>False</ss:ProtectWindows>' +
	             '</ss:ExcelWorkbook>' +
	            '<ss:Styles>' +
	             '<ss:Style ss:ID="Default">' +
	            '<ss:Alignment ss:Vertical="Top"  />' +
	             '<ss:Font ss:FontName="arial" ss:Size="10" />' +
	              '<ss:Borders>' +
	            '<ss:Border  ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Top" />' +
	             '<ss:Border  ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Bottom" />' +
	              '<ss:Border  ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Left" />' +
	             '<ss:Border ss:Weight="1" ss:LineStyle="Continuous" ss:Position="Right" />' +
	              '</ss:Borders>' +
	              '<ss:Interior />' +
           '<ss:NumberFormat />' +
	            '<ss:Protection />' +
	             '</ss:Style>' +
	             '<ss:Style ss:ID="title">' +
	             '<ss:Borders />' +
	              '<ss:Font />' +
	            '<ss:Alignment  ss:Vertical="Center" ss:Horizontal="Center" />' +
	           '<ss:NumberFormat ss:Format="@" />' +
	            '</ss:Style>' +
	              '<ss:Style ss:ID="headercell">' +
	            '<ss:Font ss:Bold="1" ss:Size="10" />' +
	             '<ss:Alignment  ss:Horizontal="Center" />' +
	             '<ss:Interior ss:Pattern="Solid"  />' +
	             '</ss:Style>' +
	             '<ss:Style ss:ID="even">' +
	              '<ss:Interior ss:Pattern="Solid"  />' +
	              '</ss:Style>' +
	              '<ss:Style ss:Parent="even" ss:ID="evendate">' +
	           '<ss:NumberFormat ss:Format="yyyy-mm-dd" />' +
	              '</ss:Style>' +
	              '<ss:Style ss:Parent="even" ss:ID="evenint">' +
	              '<ss:NumberFormat ss:Format="0" />' +
	             '</ss:Style>' +
	             '<ss:Style ss:Parent="even" ss:ID="evenfloat">' +
	              '<ss:NumberFormat ss:Format="0.00" />' +
	             '</ss:Style>' +
	              '<ss:Style ss:ID="odd">' +
	              '<ss:Interior ss:Pattern="Solid"  />' +
	              '</ss:Style>' +
	             '<ss:Style ss:Parent="odd" ss:ID="odddate">' +
	             '<ss:NumberFormat ss:Format="yyyy-mm-dd" />' +
	             '</ss:Style>' +
	            '<ss:Style ss:Parent="odd" ss:ID="oddint">' +
	              '<ss:NumberFormat ss:Format="0" />' +
	             '</ss:Style>' +
	              '<ss:Style ss:Parent="odd" ss:ID="oddfloat">' +
	              '<ss:NumberFormat ss:Format="0.00" />' +
	             '</ss:Style>' +
	            '</ss:Styles>' +
	            worksheet.xml +
	              '</ss:Workbook>';
	             },
	             createWorksheet: function (jq, param) {
	                  // Calculate cell data types and extra class names which affect formatting
	                  var cellType = [];
	                 var cellTypeClass = [];
	                //var cm = this.getColumnModel();
	                  var totalWidthInPixels = 0;
	                 var colXml = '';
	                 var headerXml = '';
	                 var visibleColumnCountReduction = 0;
	                var cfs = $(jq).datagrid('getColumnFields');
	                var colCount = cfs.length;
	                 for (var i = 1; i < colCount; i++) {
	                     if (cfs[i] != '') {
	                         var w = $(jq).datagrid('getColumnOption', cfs[i]).width;
	                         totalWidthInPixels += w;
	                          if (cfs[i] === "") {
	                             cellType.push("None");
	                            cellTypeClass.push("");
	                            ++visibleColumnCountReduction;
	                         }
	                       else {
	                            colXml += '<ss:Column ss:AutoFitWidth="1" ss:Width="130" />';
	                            headerXml += '<ss:Cell ss:StyleID="headercell">' +
	                       '<ss:Data ss:Type="String">' + $(jq).datagrid('getColumnOption', cfs[i]).title + '</ss:Data>' +
	                        '<ss:NamedCell ss:Name="Print_Titles" /></ss:Cell>';
	                             cellType.push("String");
	                           cellTypeClass.push("");
	                        }
	                    }
	                }
	                var visibleColumnCount = cellType.length - visibleColumnCountReduction;
	                var result = {
	                    height: 9000,
	                    width: Math.floor(totalWidthInPixels * 30) + 50
	                };
	                 var rows = $(jq).datagrid('getRows');
	                 // Generate worksheet header details.
	                 var t = '<ss:Worksheet ss:Name="' + param.title + '">' +
	            '<ss:Names>' +
	            '<ss:NamedRange ss:Name="Print_Titles" ss:RefersTo="=\'' + param.title + '\'!R1:R2" />' +
	            '</ss:Names>' +
	             '<ss:Table x:FullRows="1" x:FullColumns="1"' +
	           ' ss:ExpandedColumnCount="' + (visibleColumnCount + 2) +
	             '" ss:ExpandedRowCount="' + (rows.length + 2) + '">' +
	            colXml +
	             '<ss:Row ss:AutoFitHeight="1">' +
	             headerXml +
	            '</ss:Row>';
	                 // Generate the data rows from the data in the Store
	                 //for (var i = 0, it = this.store.data.items, l = it.length; i < l; i++) {
	                for (var i = 0, it = rows, l = it.length; i < l; i++) {
	                     t += '<ss:Row>';
	                   var cellClass = (i & 1) ? 'odd' : 'even';
	                     r = it[i];
	                     var k = 0;
	                     for (var j = 1; j < colCount; j++) {
	                        //if ((cm.getDataIndex(j) != '')
	                        if (cfs[j] != '') {
	                             //var v = r[cm.getDataIndex(j)];
	                            var v = r[cfs[j]];
	                            if (cellType[k] !== "None") {
	                                 t += '<ss:Cell ss:StyleID="' + cellClass + cellTypeClass[k] + '"><ss:Data ss:Type="' + cellType[k] + '">';
	                                if (cellType[k] == 'DateTime') {
	                                    t += v.format('Y-m-d');
                                } else {
	                                    t += v;
                                }
	                                t += '</ss:Data></ss:Cell>';
	                            }
	                            k++;
	                        }
	                   }
	                     t += '</ss:Row>';
	                }
	                result.xml = t + '</ss:Table>' +
             '<x:WorksheetOptions>' +
	             '<x:PageSetup>' +
	            '<x:Layout x:CenterHorizontal="1" x:Orientation="Landscape" />' +
	             '<x:Footer x:Data="Page &P of &N" x:Margin="0.5" />' +
	             '<x:PageMargins x:Top="0.5" x:Right="0.5" x:Left="0.5" x:Bottom="0.8" />' +
	             '</x:PageSetup>' +
	            '<x:FitToPage />' +
	             '<x:Print>' +
	            '<x:PrintErrors>Blank</x:PrintErrors>' +
	             '<x:FitWidth>1</x:FitWidth>' +
	             '<x:FitHeight>32767</x:FitHeight>' +
	             '<x:ValidPrinterInfo />' +
	            '<x:VerticalResolution>600</x:VerticalResolution>' +
	           '</x:Print>' +
	             '<x:Selected />' +
	             '<x:DoNotDisplayGridlines />' +
	            '<x:ProtectObjects>False</x:ProtectObjects>' +
	             '<x:ProtectScenarios>False</x:ProtectScenarios>' +
	           '</x:WorksheetOptions>' +
	            '</ss:Worksheet>';
                return result;
             }
         });
