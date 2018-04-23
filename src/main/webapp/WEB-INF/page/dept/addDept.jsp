<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/attendance/static/js/commons/common.js" ></script>
<script type="text/javascript" src="/attendance/static/js/commons/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/attendance/static/js/layer-v3.1.1/layer/layer.js"></script>
<script type="text/javascript" src="/attendance/static/js/dict/pinyin_dict_notone.js"></script>
<script type="text/javascript" src="/attendance/static/js/dict/pinyin_dict_withtone.js"></script>
<script type="text/javascript" src="/attendance/static/js/dict/pinyinUtil.js"></script>
<script type="text/javascript" src="/attendance/static/js/dict/simple-input-method.js"></script>
<link href="/attendance/static/css/common.css" rel="stylesheet" type="text/css" />
<title>个人中心</title>
</head>
<body>
	<div class="nav-top">
		<img class="avatar" src="${userInfo.portrait}" title="${userInfo.realName}"/>
		<ul>
			<li>
				<a href="#">nav1</a>
			</li>
			<li>
				<a href="#">nav1</a>
			</li>
		</ul>
	</div>
	<div class="nav">
		<ul>
			<c:forEach var="dir" items="${menuList}">
				<c:choose>
					<c:when test="${dir.parentId==0}">
						<li class="nav-1"><span>${dir.menuName}</span></li>
						<c:forEach var="sonDir" items="${menuList}">
							<c:choose>
								<c:when test="${sonDir.parentId == dir.id}">
									<li class="nav-2"><span style="width:2px;">&nbsp;&nbsp;</span><a href="${sonDir.url}">${sonDir.menuName}</a></li>
								</c:when>
							</c:choose>
						</c:forEach>
					</c:when>
				</c:choose>
			</c:forEach>
		</ul>
	</div>
	<div class="content">
		<form id="userPasswd" action="returen false">
			<input type="text" name="deptName" id="deptName" placeholder="部门名字" onblur="checkName()"/><br/>
			<input type="text" name="deptCode" id="deptCode" placeholder="部门编号"/><br/>
			<input type="text" name="head" id="head" placeholder="部门主管" disabled/><br/>
			<textarea name="slogan" id="slogan" placeholder="部门口号">
			</textarea><br/>
			<input type="button" onclick="addDept()" value="添加"/>
		</form>
	</div>
</body>
<script type="text/javascript">
	function checkName() {
		var name = $("#deptName").val();
		if(name===""||name===null){
			layer.msg("部门不能为空");
			return;
		}else {
			$.ajax({
				url:getUrl("department/checkName"),
				data:{deptName:name},
				success:function(data){
					layer.msg(data.msg);
					if(data){
						getPinyin();
					}else {
						return;
					}
				}
			});
		}
	}
	function getPinyin()
	{
		var value = document.getElementById('deptName').value;
		var polyphone = null;
		var result = '';
		if(value)
			result = pinyinUtil.getFirstLetter(value, polyphone);
		$("#deptCode").val(result);
	}
	function addDept() {
		var deptName = $("#deptName").val();
		var deptCode = $("#deptCode").val();
		var slogan = $("#slogan").val();
		if(deptName===""||deptName===null||deptCode===""||deptCode===null||slogan===""||slogan===null)
			return;
		$.ajax({
			url:getUrl("department/addDept"),
			data:{deptName:deptName,deptCode:deptCode,slogan:slogan},
			success:function(data){
				layer.msg(data.msg);
				if(data){
					window.location.href = getUrl("department/deptManager");
				}else {
					return;
				}
			}
		});
		
		
	}
</script>

</html>