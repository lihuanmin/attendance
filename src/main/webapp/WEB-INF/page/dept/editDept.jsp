<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/attendance/static/js/commons/common.js"></script>
<script type="text/javascript" src="/attendance/static/js/commons/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/attendance/static/js/layer-v3.1.1/layer/layer.js"></script>
<script type="text/javascript" src="/attendance/static/js/dict/pinyin_dict_notone.js"></script>
<script type="text/javascript" src="/attendance/static/js/dict/pinyin_dict_withtone.js"></script>
<script type="text/javascript" src="/attendance/static/js/dict/pinyinUtil.js"></script>
<script type="text/javascript" src="/attendance/static/js/dict/simple-input-method.js"></script>
<link rel="stylesheet" type="text/css" href="/attendance/static/js/layer-v3.1.1/layer/mobile/need/layer.css">
<title>个人中心</title>
</head>
<body>
	<div style="border: 1px solid pink; width: 100px; height: 100px;">
		<div>${userInfo.realName}</div>
		<span> <img src="${userInfo.portrait}" width="60px"
			height="60px" />
		</span>
	</div>
	<div
		style="border: 1px solid pink; width: 200px; height: 600px; float: left;">
		<ul>
			<c:forEach var="dir" items="${menuList}">
				<c:choose>
					<c:when test="${dir.parentId==0}">
						<li><span style="background-color: pink;">${dir.menuName}</span></li>
						<c:forEach var="sonDir" items="${menuList}">
							<c:choose>
								<c:when test="${sonDir.parentId == dir.id}">
									<li><span style="width: 2px;">&nbsp;&nbsp;</span><a
										href="${sonDir.url}">${sonDir.menuName}</a></li>
								</c:when>
							</c:choose>
						</c:forEach>
					</c:when>
				</c:choose>
			</c:forEach>
		</ul>
	</div>
	<div style="border: 1px solid pink; float: left;">
		<form id="uDept"action="return false">
			<input type="text" name="deptId" value="${dept.deptId}" /><br/>
			<input type="text" id="deptName" name="deptName" value="${dept.deptName}" onblur="checkName()"/><br/>
			<input type="text" id="deptCode" name="deptCode" value="${dept.deptCode}"/><br/>
			<input type="text" id="head" name="head" value="${dept.head}"/><br/>
			<input type="text" id="slogan" name="slogan" value="${dept.slogan}"/><br/>
			<input type="button" onclick="update()" value="修改"/>
		</form>
	</div>
<script type="text/javascript">
function checkName() {
	var name = $("#deptName").val();
	if(name===""||name===null){
		layer.msg("部门不能为空");
		return;
	}else {
		$.ajax({
			url:getUrl("department/checkName"),//前端验证还得改成不走名字验证，用户是否存在
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
function update() {
	$.ajax({
		url:getUrl("department/updateDept"),
		data:$("#uDept").serialize(),
		success:function(data) {
			alert(data.msg);
		}
	});
}
</script>
</body>
</html>