<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心</title>
<style>
	/*common*/
	* {
		box-sizing: border-box;
		margin: 0;
		padding: 0;
		border: none;
	}
	a {
		color: #fff;
		text-decoration: none;
	}
	ul {
		list-style: none;
	}
	input, textarea, input[type=button] {
		outline: none;
	}
	input[type=text], textarea {
		width: 300px;
		padding: 5px 10px;
		border: 1px solid #ddd;
		border-radius: 5px;
	}
	input[type=text]:hover, textarea:hover {
		border-color: #7E57C2;
	}
	textarea {
		min-height: 80px;
		padding: 10px;
		resize: vertical;
		overflow: hidden;
	}
	input[type=button] {
		border: none;
		padding: 5px 30px;
		border-radius: 5px;
		background-color: #7E57C2;
		color: #fff;
		cursor: pointer;
	}
	input[type=button]:hover {
		background-color: #673AB7;
	}
	table {
		border: 1px solid #ddd;
		border-collapse:collapse;
	}
	table th, table td {
		padding: 5px 40px;
	}
	table tr:nth-child(odd) {
		background-color: #eee;
	}
	table a {
		color: #7E57C2;
	}
	.ul-list > li {
		margin: 10px 0;
	}
	
	/*this page*/
	.nav-top {
		padding: 10px 20px;
		background-color: #7E57C2;
		color: #fff;
		overflow: hidden;
	}
	.nav-top > ul {
	    margin-top: 5px;
		float: left;
		margin-left: 40px;
	}
	.nav-top > ul > li {
		float: left;
		padding: 3px 20px;
		margin-right: 20px;
	}
	.nav-top > ul > li:hover {
		background: rgba(255, 255, 255, .1);
	}
	.avatar {
		float: left;
		width: 40px;
		height: 40px;
		border-radius: 40px;
		cursor: pointer;
	}
	.nav {
		float: left;
		background: #7E57C2;
		color: #fff;
	}
	.nav > ul {
		padding: 20px 0;
	}
	.nav > ul > li {
		padding: 5px 30px;
		
	}
	.nav a {
		color: #eee;
	}
	.nav-1 {
		background: rgba(255, 255, 255, .2);
	}
	.nav-2:hover {
		background: rgba(255, 255, 255, .1);
	}
	
	.content {
		float: left;
		padding: 20px;
	}
</style>
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
		<input type="text" placeholder="input...">
		<textarea placeholder="input..."></textarea>
		<input type="button" value="submit">
		<table border="0">
			<tr>
				<th>th</th>
				<th>th</th>
				<th>opreation</th>
			</tr>
			<tr>
				<td>td</td>
				<td>td</td>
				<th><a href="#">aaaaa</a></th>
			</tr>
			<tr>
				<td>td</td>
				<td>td</td>
				<th><a href="#">aaaaa</a></th>
			</tr>
		</table>
		<ul class="ul-list">
			<li>输入框：<input type="text" placeholder="input..."></li>
			<li>输入框：<input type="text" placeholder="input..."></li>
			<li>输入框：<input type="text" placeholder="input..."></li>
			<li>输入框：<input type="text" placeholder="input..."></li>
		</ul>
	</div>
</body>
</html>