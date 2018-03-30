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
<body onload="getUserInfo()">
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
		<form id="userInfo" action="returen false">
			<input type="text" id="account" name="account" disabled="true"/>账号<br/>
			<input type="text" id="realName" name="realName" disabled="true"/>姓名<br/>
			<input type="text" id="registerTime" name="registerTIme" disabled="true"/>时间<br/>
			<select name="sex" id="sex"></select>性别<br/>
			<input type="text" id="email" name="email"/>邮箱<br/>
			<input type="text" id="phone" name="phone"/>电话<br/>
			<textarea name="introduce" id="introduce" rows="5" cols="10">
			</textarea><br/>
			<input type="button" onclick="updateUserInfo()" value="修改"/>
		</form>
	</div>
</body>
<script>
	function getUserInfo() {
		$.ajax({
			url:getUrl("userCenter/userInfo"),
			success: function(data) {
				if(data !== "" && data !== null){
					var user = JSON.parse(data);
					$('#account').val(user.account);
					$('#realName').val(user.realName);
					var opt = '';
					if(user.sex)
						opt += '<option value="1" selected>男</option><option value="0">女</option>';
					else
						opt += '<option value="1" >男</option><option value="0" selected>女</option>';
					$('#sex').html(opt);
					$('#email').val(user.email);
					$('#phone').val(user.phone);
					$('#introduce').val(user.introduce);
	                $('#registerTime').val(getDate(user.registerTime));
				}
			}
		});
	}
	function updateUserInfo() {
		$.ajax({
			url:getUrl("userCenter/updateUserInfo"),
			data:$('#userInfo').serialize(),
			success: function(data) {
				layer.msg(data.msg);
				if(data.success){
					window.location.href = getUrl("home/home");
				}
			}
		});
	}
</script>
</html>