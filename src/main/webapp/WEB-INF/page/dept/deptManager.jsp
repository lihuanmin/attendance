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

		<table>
			<tr>
				<td>id</td>
				<td>名称</td>
				<td>编号</td>
				<td>口号</td>
				<td>主管</td>
				<td>操作</td>
			</tr>
			<c:choose>
				<c:when test="${list!=null&&fn:length(list)>0}">
					<!--如果 -->
					<c:forEach var="dir" items="${list}">
						<tr>
							<td>${dir.deptId}</td>
							<td>${dir.deptCode}</td>
							<td>${dir.deptName}</td>
							<td>${dir.head}</td>
							<td>${dir.slogan}</td>
							<td><a href="/attendance/department/queryDept?deptId=${dir.deptId}">编辑</a></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					${list}
  			    </c:otherwise>
			</c:choose>
		</table>
	</div>
<script type="text/javascript">

</script>
</body>
</html>