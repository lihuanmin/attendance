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
<script type="text/javascript" src="/attendance/static/js/time/laydate.js"></script>
<link rel="stylesheet" type="text/css" href="/attendance/static/js/layer-v3.1.1/layer/mobile/need/layer.css">
<link href="/attendance/static/css/common.css" rel="stylesheet" type="text/css" />

<style type="text/css">
* {
	margin: 0;
	padding: 0;
	list-style: none;
}
html {
	background-color: #E3E3E3;
	font-size: 14px;
	color: #000;
	font-family: '微软雅黑'
}
h2 {
	line-height: 30px;
	font-size: 20px;
}
a, a:hover {
	text-decoration: none;
}
pre {
	font-family: '微软雅黑'
}
.box {
	width: 970px;
	padding: 10px 20px;
	background-color: #fff;
	margin: 10px auto;
}
.box a {
	padding-right: 20px;
}
.demo1, .demo2, .demo3, .demo4, .demo5, .demo6 {
	margin: 25px 0;
}
h3 {
	margin: 10px 0;
}
.layinput {
	height: 22px;
	line-height: 22px;
	width: 150px;
	margin: 0;
}
</style>
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
		<table>
			<tr>
				<td>编号</td>
				<td>请假日期</td>
				<td>请假开始时间</td>
				<td>请假结束时间</td>
				<td>请假原因</td>
				<td>审批结果</td>
			</tr>
		
		<c:forEach var="dir" items="${listLeave}">
		<tr>
			<td>${dir.id}</td>
			<td><fmt:formatDate value="${dir.leaveTime}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
			<td><fmt:formatDate value="${dir.startTime}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
			<td><fmt:formatDate value="${dir.endTime}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
			<td>${dir.reason}</td>
			<td>
			${dir.examResult}
			</td>
		</tr>
		</c:forEach>
		</table>
	</div>
</body>
<script>
	
</script>
</html>