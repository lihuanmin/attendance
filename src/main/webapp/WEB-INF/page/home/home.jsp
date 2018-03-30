<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心</title>
</head>
<body>
	<div style="border: 1px solid pink; width: 100px; height: 100px;">
		<div>${userInfo.realName}</div>
		<span> <img src="${userInfo.portrait}" width="60px"
			height="60px" />
		</span>
	</div>
	<div style="border: 1px solid pink; width: 200px; height: 600px;">
		<ul>
			<c:forEach var="dir" items="${menuList}">
				<li><a href="${dir.url}">${dir.menuName}</a></li>
			</c:forEach>
		</ul>
	</div>
</body>
</html>