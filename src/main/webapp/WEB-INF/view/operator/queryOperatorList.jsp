<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>queryOperatorList</title>
<%@include file="../includes/commonHead.jsp" %>

<script type="text/javascript" >
var orgTree = null;
$(document).ready(function() {
	orgTree = $('#organizationTree').tree({
		url : '${contextPath}/organization/queryOrganizationPostTreeNodeListByAuth.action',
		idField : 'id',
		parentField : 'parentId',
		textField : 'name',
		iconField : function(item){
			if(item && item.type == 1){
				return 'group_group';
			}else{
				return 'folder_user';	
			}
		},
		fit : true,
		fitColumns : true,
		border : false,
		onClick : function(node){
			if(node['attributes'].type  == 0){
				$('#treeGrid').treegrid('load',{
					organizationId: node.id
				});
			}else{
				$('#treeGrid').treegrid('load',{
					parentPostId: node.id
				});
			}
		}
	});
});

</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'west',title:'组织结构',split:true,
		tools : [{ iconCls : 'database_refresh',handler : function() {refreshTree();} }]" 
		style="width:230px;">
		<ul id="organizationTree"></ul>
	</div> 
		
	<div data-options="region:'center'" style="padding:5px;background:#eee;">
		<div class="easyui-layout" data-options="fit : true,border : false">
			<div data-options="region:'north',title:'查询条件',border:false" 
				style="height: 125px; overflow: hidden;">
				<form method="post" id="creditProductForm" name="creditProductForm" class="form">
				<!-- query condition -->
				<div>
					<table>
						<tbody>
						<tr>
							<th class="narrow">登录名:</th>
							<td><input name="loginName" class="text" type="text" value=''/></td>
							<th class="narrow">用户编码:</th>
							<td>
								<input name="code" class="text" type="text" value=''/>
							</td>
						</tr>
						<tr>
							<th class="narrow">用户编码:</th>
							<td><input name="productName" class="text" type="text" value=''/></td>
							<th class="narrow">状态:</th>
							<td>
								<select name="productState" class="select">
									<optgroup label=""> 
										<option>--- 不限 ---</option>
										<option value="0">--- 禁用 ---</option>
										<option value="1">--- 有效 ---</option>
									</optgroup>
								</select>
							</td>
						</tr>
						<tr>
							<td colspan="4" class="button operRow">
								<a id="ajaxQueryBtn" href="#" class="easyui-linkbutton">查询</a>
							</td>
						</tr>
						</tbody>
					</table>
				</div>
				</form>
			</div>
			<div data-options="region:'center',border:false">
				<table id="dataGrid"></table>
			</div>
		</div>
		
		<div id="toolbar" style="display: none;">
			<c:if test="${false}">
				<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'">添加</a>
			</c:if>
			<a onclick="redo();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'resultset_next'">展开</a> 
			<a onclick="undo();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'resultset_previous'">折叠</a> 
			<a onclick="treeGrid.treegrid('reload');" href="javascript:void(0);" 
				class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
		</div>
	
		<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
			<c:if test="${true}">
				<div onclick="addFun();" data-options="iconCls:'pencil_add'">增加</div>
			</c:if>
			<c:if test="${true}">
				<div onclick="deleteFun();" data-options="iconCls:'pencil_delete'">删除</div>
			</c:if>
			<c:if test="${true}">
				<div onclick="editFun();" data-options="iconCls:'pencil'">编辑</div>
			</c:if>
		</div>
	
	</div> 
</body>