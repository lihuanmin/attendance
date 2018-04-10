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
<title>个人中心</title>
</head>
<body onload="queryMenu()">
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
		<input type="text" name="roleName" placeholder="角色名字"/><br/>
		<input type="text" name="roleDetail" placeholder="角色详情"/><br/>
		<div id="menu"></div>
		<input type="button" onclick="subRole()" value="添加"/>
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
	function subRole() {
		
	}
	function test(event) {
		let target = event.target,
			childsInputs = Array.from(target.nextElementSibling.children),
			isChecked = target.checked;
		
		childsInputs.forEach(function(item) {
			item.checked = isChecked;
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