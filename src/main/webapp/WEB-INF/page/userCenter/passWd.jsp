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
<title>个人中心</title>
</head>
<body>
	<div style="border: 1px solid pink; width: 100px; height: 100px;">
		<div>${userInfo.realName}</div>
		<span> <img src="${userInfo.portrait}" width="60px"
			height="60px" />
		</span>
	</div>
	<div style="border: 1px solid pink; width: 200px; height: 600px; float: left;">
		<ul>
			<c:forEach var="dir" items="${menuList}">
				<c:choose>
					<c:when test="${dir.parentId==0}">
						<li><span style="background-color: pink;">${dir.menuName}</span></li>
						<c:forEach var="sonDir" items="${menuList}">
							<c:choose>
								<c:when test="${sonDir.parentId == dir.id}">
									<li><span style="width:2px;">&nbsp;&nbsp;</span><a href="${sonDir.url}">${sonDir.menuName}</a></li>
								</c:when>
							</c:choose>
						</c:forEach>
					</c:when>
				</c:choose>
			</c:forEach>
		</ul>
	</div>
	<div style="border: 1px solid pink; float:left;">
		<form id="userPasswd" action="returen false">
			<input type="text" name="oldPassword" placeholder="旧密码"/><br/>
			<input type="text" name="newPassword" placeholder="新密码"/><br/>
			<input type="text" name="confirmPassword" placeholder="确认密码"/><br/>
			<input type="button" onclick="updateUserPasswd()" value="修改"/>
		</form>
	</div>
</body>
<script>
	function updateUserPasswd() {
		var oldP = $("input[name='oldPassword']").val();
		var newP = $("input[name='newPassword']").val();
		var conP = $("input[name='confirmPassword']").val();
		if(oldP === ""||oldP ===null||newP===""||newP===null||conP===""||conP===null){
			layer.msg("输入信息不能为空");
			return;
		}
			
		
		$.ajax({
			url:getUrl("userCenter/updatePassword"),
			data: $('#userPasswd').serialize(),
			success: function (data) {
				alert(data.msg);
				if(data.success) 
					window.location.href = getUrl("userCenter/passwd");
			}
		});
	}
</script>
</html>