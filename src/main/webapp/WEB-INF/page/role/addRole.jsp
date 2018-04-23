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
<body onload="queryMenu()">
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
	<form id="addRole" action="/attendance/role/addNewRole">
		<input type="text" name="roleName" placeholder="角色名字"/><br/>
		<input type="text" name="roleDetail" placeholder="角色详情"/><br/>
		角色功能
		<div id="menu"></div>
		<input type="button" onclick="addRole()" value="添加"/>
	</form>
	</div>
</body>
<script type="text/javascript">
	function queryMenu() {
		$.ajax({
			url:getUrl("role/queryMenu"),
			success:function(data){
				console.log(data);
				var datas = jQuery.parseJSON(data);
				var str = "";
				for(var i = 0; i < datas.length; i++) {
					if(datas[i].parentId===0||datas[i].parentId==='0') {
						str += '<div><input name="menu" onclick="test(event)" type="checkbox"  value="'+datas[i].id+'"/>'+datas[i].menuName+'<div onclick=selectChild(event)>';
						
						for(var j = 0; j < datas.length; j++) 
							if(datas[j].parentId === datas[i].id) 
								str += '&nbsp;&nbsp;<input name="menu" type="checkbox" value="'+datas[j].id+'"/>'+datas[j].menuName;
						str +='</div></div>';
					}
					
				}
				$("#menu").append(str);
			}
		});
	}
	function test(event) {
		let target = event.target,
			childsInputs = Array.from(target.nextElementSibling.children),
			isChecked = target.checked;
		
		childsInputs.forEach(function(item) {
			item.checked = isChecked;
		});
	}
	function addRole() {
		$.ajax({
			url:getUrl("role/addNewRole"),
			data:$('#addRole').serialize(),
			success:function(data) {
				window.location.href = getUrl("role/role");
			}
		});
	}
	function selectChild(event) {
		let target = event.target;
		if (target.nodeName === "INPUT") {
			let span = event.currentTarget,
				childsInputs = Array.from(span.children),
				isChecked = target.checked,
				isAllSelect = childsInputs.every(function(item) {
					return item.checked === isChecked ? true : false;
				});
			span.previousElementSibling.checked = !isAllSelect ? false : isChecked;
		}
	}
</script>

</html>