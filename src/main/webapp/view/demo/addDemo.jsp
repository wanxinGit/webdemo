<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>add demo</title>
<link rel="stylesheet" type="text/css" href="/webdemo/css/default/om-default.css" />
<style type="text/css">
html,body,div{
	margin:0px;
	border:0px;
	height: 100%
}
</style>

<script type="text/javascript" src="/webdemo/js/jquery.min.js"></script>
<script type="text/javascript" src="/webdemo/js/operamasks-ui.min.js"></script>

<script type="text/javascript" >
$(document).ready(function() {
	$("#bodyDiv").omPanel({
		header:false,
        width: 'fit',
        height: 'fit',
        title: 'webdemo mainframe',
        collapsed: false,//组件创建后为收起状态
        collapsible: false,//渲染收起与展开按钮
        closable: false //渲染关闭按钮
    });
	
	$('input[name=createDate]').omCalendar({
		editable : false,
		showTime : true
	});

	 $('#submitButton').omButton({});
});
</script>
</head>
<body>
<form id="demo" action="/demo/addDemo1" method="post">
<div id="bodyDiv">
	<table>
		<tr>
			<td>username</td>
			<td><input type="text" name="username"/></td>
		</tr>
		<tr>
			<td>password</td>
			<td><input type="password" name="password"/></td>
		</tr>
		<tr>
			<td>email</td>
			<td><input type="text" name="email"/></td>
		</tr>
		<tr>
			<td>createDate</td>
			<td><input type="text" name="createDate"/></td>
		</tr>
	</table>
	<input type="submit" id="submitButton" value="提交">
</div>
</form>
</body>
</html>