<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>周报告列表</title>
<link rel="stylesheet" type="text/css"
	href="easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="easyui/css/demo.css">
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="easyui/js/validateExtends.js"></script>
<script type="text/javascript">
	$(function() {	
		//datagrid初始化 
	    $('#dataList').datagrid({ 
	        title:'周报告列表', 
	        iconCls:'icon-more',//图标 
	        border: true, 
	        collapsible: false,//是否可折叠的 
	        fit: true,//自动大小 
	        method: "post",
	        url:"ReportServlet?method=getReportList&t="+new Date().getTime(),
	        idField:'id', 
	        singleSelect: true,//是否单选 
	        pagination: true,//分页控件 
	        rownumbers: true,//行号 
	        sortName: 'id',
	        sortOrder: 'DESC', 
	        remoteSort: false,
	        columns: [[  
				{field:'chk',checkbox: true,width:50},
 		        {field:'id',title:'ID',width:50, sortable: true},  
 		        {field:'name',title:'学生',width:200, sortable: true},
 		        {field:'reportname',title:'周报告名称',width:200},
 		        {field:'score',title:'分数',width:50},
 		        {field:'info',title:'评语',width:200, 
},
	 		]], 
	        toolbar: "#toolbar"
	    }); 
	    //设置分页控件 
	    var p = $('#dataList').datagrid('getPager'); 
	    $(p).pagination({ 
	        pageSize: 10,//每页显示的记录条数，默认为10 
	        pageList: [10,20,30,50,100],//可以设置每页记录条数的列表 
	        beforePageText: '第',//页数文本框前显示的汉字 
	        afterPageText: '页    共 {pages} 页', 
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
	    });
	    //设置工具类按钮
	    $("#add").click(function(){
	    	$("#addDialog").dialog("open");
	    });
	    //删除
	    $("#delete").click(function(){
	    	var selectRow = $("#dataList").datagrid("getSelected");
        	if(selectRow == null){
            	$.messager.alert("消息提醒", "请选择数据进行删除!", "warning");
            } else{
            	var reportid = selectRow.id;
            	$.messager.confirm("消息提醒", "将删除该份周报告，确认继续？", function(r){
            		if(r){
            			$.ajax({
							type: "post",
							url: "ReportServlet?method=DeleteReport",
							data: {reportid: reportid},
							success: function(msg){
								if(msg == "success"){
									$.messager.alert("消息提醒","删除成功!","info");
									//刷新表格
									$("#dataList").datagrid("reload");
								} else{
									$.messager.alert("消息提醒","删除失败!","warning");
									return;
								}
							}
						});
            		}
            	});
            }
	    });
	    
	    
	  	
	  	//设置添加周报告窗口
	    $("#addDialog").dialog({
	    	title: "新建周报告",
	    	width: 700,
	    	height: 600,
	    	iconCls: "icon-book-add",
	    	modal: true,
	    	collapsible: false,
	    	minimizable: false,
	    	maximizable: false,
	    	draggable: true,
	    	closed: true,
	    	buttons: [
	    		{
					text:'提交',
					plain: true,
					iconCls:'icon-book-add',
					handler:function(){
						var validate = $("#addForm").form("validate");
						if(!validate){
							$.messager.alert("消息提醒","请检查你输入的数据!","warning");
							return;
						} else{
							//var gradeid = $("#add_gradeList").combobox("getValue");
							$.ajax({
								type: "post",
								url: "ReportServlet?method=AddReport",
								data: $("#addForm").serialize(),
								success: function(msg){
									if(msg == "success"){
										$.messager.alert("消息提醒","提交成功!","info");
										//关闭窗口
										$("#addDialog").dialog("close");
										//清空原表格数据
										$("#add_name").textbox('setValue', "");
										$("#add_reportname").textbox('setValue', "");
										$("#add_info1").val("");
										$("#add_info2").val("");
										$("#add_info3").val("");
										$("#add_score").textbox('setValue', "");
										$("#info").val("");
										//重新刷新页面数据
							  			$('#dataList').datagrid("reload");
										
									} else{
										$.messager.alert("消息提醒","提交失败!","warning");
										return;
									}
								}
							});
						}
					}
				},
				{
					text:'重置',
					plain: true,
					iconCls:'icon-reload',
					handler:function(){
						$("#add_name").textbox('setValue', "");
						$("#add_reportname").textbox('setValue', "");
						$("#add_info1").val("");
						$("#add_info2").val("");
						$("#add_info3").val("");
						$("#add_score").textbox('setValue', "");
						$("#info").val("");
					}
				},
			]
	    });
	  	
	  	
	  //修改按钮监听事件
	  	$("#edit-btn").click(function(){
	  		var selectRow = $("#dataList").datagrid("getSelected");
        	if(selectRow == null){
            	$.messager.alert("消息提醒", "请选择数据进行修改!", "warning");
            	return;
            }
        	$("#editDialog").dialog("open");
	  	});
	  
	  //设置查看编辑周报告窗口
	    $("#editDialog").dialog({
	    	title: "查看周报告",
	    	width: 700,
	    	height: 600,
	    	iconCls: "icon-book-open",
	    	modal: true,
	    	collapsible: false,
	    	minimizable: false,
	    	maximizable: false,
	    	draggable: true,
	    	closed: true,
	    	buttons: [
	    		{
					text:'确定',
					plain: true,
					iconCls:'icon-book-open',
					handler:function(){
						var validate = $("#editForm").form("validate");
						if(!validate){
							$.messager.alert("消息提醒","请检查你输入的数据!","warning");
							return;
						} else{
							$.ajax({
								type: "post",
								url: "ReportServlet?method=EditReport",
								data: $("#editForm").serialize(),
								success: function(msg){
									if(msg == "success"){
										$.messager.alert("消息提醒","提交成功!","info");
										//关闭窗口
										$("#editDialog").dialog("close");
										//清空原表格数据
										$("#edit_name").textbox('setValue', "");
										$("#edit_reportname").textbox('setValue', "");
										$("#edit_info1").val("");
										$("#edit_info2").val("");
										$("#edit_info3").val("");
										$("#edit_score").textbox('setValue', "");
										$("#edit_info").val("");
										//重新刷新页面数据
							  			$('#dataList').datagrid("reload");
										
									} else{
										$.messager.alert("消息提醒","提交失败!","warning");
										return;
									}
								}
							});
						}
					}
				},
				{
					text:'重置',
					plain: true,
					iconCls:'icon-reload',
					handler:function(){
						$("#edit_score").textbox('setValue', "");
						$("#edit_info").val("");
					}
				},
			],
			onBeforeOpen: function(){
				var selectRow = $("#dataList").datagrid("getSelected");
				//设置值
				$("#edit_name").textbox('setValue', selectRow.name);
				$("#edit_reportname").textbox('setValue', selectRow.reportname);
				$("#edit_info1").val(selectRow.info1);
				$("#edit_info2").val(selectRow.info2);
				$("#edit_info3").val(selectRow.info3);
				$("#edit_score").textbox('setValue', selectRow.score);
				$("#edit_info").val(selectRow.info);
				$("#edit-id").val(selectRow.id);
			}
	    });
	  
	});
	</script>
</head>
<body>
	<!-- 数据列表 -->
	<table id="dataList" cellspacing="0" cellpadding="0">
	</table>

	<!-- 工具栏 -->
	<div id="toolbar">
		<div style="float: left;">
			<a id="add" href="javascript:;" class="easyui-linkbutton"
				data-options="iconCls:'icon-book-add',plain:true">提交</a>
		</div>
		<div style="float: left;" class="datagrid-btn-separator"></div>
		<div style="float: left;">
			<a id="edit-btn" href="javascript:;" class="easyui-linkbutton"
				data-options="iconCls:'icon-book-open',plain:true">查看</a>
		</div>
		<div style="float: left;" class="datagrid-btn-separator"></div>
		<div>
			<a id="delete" href="javascript:;" class="easyui-linkbutton"
				data-options="iconCls:'icon-some-delete',plain:true">删除</a>
		</div>
	</div>

	<!-- 添加窗口 -->
	<div id="addDialog" style="padding: 10px">
		<form id="addForm" method="post">
			<table cellpadding="8">
				<tr>
					<td>学生:</td>
					<td><input id="add_name" style="width: 200px; height: 30px;"
						class="easyui-textbox" type="text" name="name"
						data-options="required:true, missingMessage:'不能为空'" /></td>
				</tr>
				<tr>
					<td>周报告名称:</td>
					<td><input id="add_reportname" style="width: 200px; height: 30px;"
						class="easyui-textbox" type="text" name="reportname"
						data-options="required:true, missingMessage:'不能为空'" /></td>
				</tr>
				<tr>
					<td>本周事项:</td>
					<td><textarea id="info1" name="info1"
							style="width: 500px; height: 60px;" class=""></textarea></td>
				</tr>
				<tr>
					<td>本周问题:</td>
					<td><textarea id="info2" name="info2"
							style="width: 500px; height: 60px;" class=""></textarea></td>
				</tr>
				<tr>
					<td>下周计划:</td>
					<td><textarea id="info3" name="info3"
							style="width: 500px; height: 60px;" class=""></textarea></td>
				</tr>
				<tr>
					<td>分数:</td>
					<td><input id="add_score" style="width: 200px; height: 30px;"
						class="easyui-textbox" type="text" name="score" readonly="readonly"/>
						&nbsp;<font color="red">导师填写</font></td>
				</tr>
				<tr>
					<td>评语:</td>
					<td><textarea id="info" name="info"
							style="width: 500px; height: 60px;" class="" readonly="readonly"/></textarea>
						&nbsp;<font color="red">导师填写</font></td>
				</tr>
				<tr>
						<td><input type="file" name="file" size="20" /></td>
				</tr>
			
			</table>
		</form>
	</div>

	<!-- 编辑窗口 -->
	<div id="editDialog" style="padding: 10px">
		<form id="editForm" method="post">
			<input type="hidden" id="edit-id" name="id">
			<table cellpadding="8">
					<tr>
					<td>学生:</td>
					<td><input id="edit_name" style="width: 200px; height: 30px;"
						class="easyui-textbox" type="text" name="name" value="readonly" readonly
						data-options="required:true, missingMessage:'不能为空'" /></td>
				</tr>
				<tr>
					<td>周报告名称:</td>
					<td><input id="edit_reportname" style="width: 200px; height: 30px;"
						class="easyui-textbox" type="text" name="reportname" value="readonly" readonly
						data-options="required:true, missingMessage:'不能为空'" /></td>
				</tr>
				<tr>
					<td>本周事项:</td>
					<td><textarea id="edit_info1" name="info1"
							style="width: 500px; height: 60px;" class=""
							 value="readonly" readonly></textarea></td>
				</tr>
				<tr>
					<td>本周问题:</td>
					<td><textarea id="edit_info2" name="info2"
							style="width: 500px; height: 60px;" class=""
							value="readonly" readonly></textarea></td>
				</tr>
				<tr>
					<td>下周计划:</td>
					<td><textarea id="edit_info3" name="info3"
							style="width: 500px; height: 60px;" class=""
							value="readonly" readonly></textarea></td>
				</tr>
				<tr>
					<td>分数:</td>
					<td><input id="edit_score" style="width: 200px; height: 30px;"
						class="easyui-textbox" type="text" name="score"/></td>
				</tr>
				<tr>
					<td>评语:</td>
					<td><textarea id="edit_info" name="info"
							style="width: 500px; height: 60px;" class=""></textarea></td>
				</tr>
			
			</table>
		</form>
	</div>

</body>
</html>