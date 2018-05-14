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
<body onload="setInterval(nowtime,1000)">
	<div class="nav-top">
		<img class="avatar" src="${userInfo.portrait}" title="${userInfo.realName}" />
		<ul>
				<div class="divtime">
				<script type="text/javascript">
                today = new Date();
                function initArray() {
                    this.length = initArray.arguments.length
                    for (var i = 0; i < this.length; i++)
                        this[i + 1] = initArray.arguments[i]
                }
                var d = new initArray(
                "星期日",
                "星期一",
                "星期二",
                "星期三",
                "星期四",
                "星期五",
                "星期六");
                document.write(
                "",
                today.getFullYear(), "年",
                today.getMonth() + 1, "月",
                today.getDate(), "日   ",
                d[today.getDay() + 1],
                "");
            </script>
					&nbsp;&nbsp;
					 <span id="t1" style="font-family: 'Arial'; font-size: 16px; font-weight: bold; color: black; width: 60px;">
					<script type="text/javascript">
			            todaytime = new Date();
			            var hour = todaytime.getHours();
			            var minute = todaytime.getMinutes();
			            var second = todaytime.getSeconds();
			            var nowTime = "";
			            if (hour < 10) {
			                nowTime += "0";
			            }
			            nowTime += hour + ":";
			            if (minute < 10) {
			                nowTime += "0";
			            }
			            nowTime += minute + ":";
			            if (second < 10) {
			                nowTime += "0";
			            }
			            nowTime += second;
			            document.getElementById("t1").innerHTML = nowTime;
        		</script>
				</span>
				<script type="text/javascript">
	                function nowtime() {
	                    todaytime = new Date();
	                    var hour = todaytime.getHours();
	                    var minute = todaytime.getMinutes();
	                    var second = todaytime.getSeconds();
	                    var nowTime = "";
	                    if (hour < 10) {
	                        nowTime += "0";
	                    }
	                    nowTime += hour + ":";
	                    if (minute < 10) {
	                        nowTime += "0";
	                    }
	                    nowTime += minute + ":";
	                    if (second < 10) {
	                        nowTime += "0";
	                    }
	                    nowTime += second;
	                    document.getElementById("t1").innerHTML = nowTime;
	                    return nowTime;
	                }
            </script>
				</div>
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
									<li class="nav-2"><span><img width="10px"
											height="10px" src="/attendance/static/img/right.jpg" />&nbsp;&nbsp;</span><a
										href="${sonDir.url}">${sonDir.menuName}</a></li>
								</c:when>
							</c:choose>
						</c:forEach>
					</c:when>
				</c:choose>
			</c:forEach>
		</ul>
	</div>
	<div class="content" >
		<form action="return false" id="role">
			角色ID：<input type="text" name="roleId" id="roleId" value="${roleMenuInfo.id}"/><br/>
			角色姓名：<input type="text" name="roleName" value="${roleMenuInfo.roleName}"/><br/>
			角色详情：<input type="text" name="roleDetail" value="${roleMenuInfo.roleDetail}"/><br/>
			角色菜单:<div id="menu"></div>
			<input type="button" onclick="update()" value="修改"/><br/>
		</form>
	</div>
</body>
<script>
queryMenu();
function queryMenu() {
	$.ajax({
		url:getUrl("role/queryMenu"),
		success:function(data){
			console.log(data);
			var roleId = $("#roleId").val();
			$.ajax({
				url:getUrl("role/roleMenu"),
				data:{"roleId":roleId},
				success:function(datas) {
					var allDatas = jQuery.parseJSON(data);
					var sonDatas = jQuery.parseJSON(datas);
					var str = "";
					for(var i = 0; i < allDatas.length; i++) {
						if(allDatas[i].parentId===0||allDatas[i].parentId==='0') {
							var sonStr = "";
							for(var k = 0; k < sonDatas.length; k++) {
								if(allDatas[i].id===sonDatas[k].id) {
									sonStr = '<div><input name="menu" checked="checked" onclick="test(event)" type="checkbox"  value="'+allDatas[i].id+'"/>'+allDatas[i].menuName+'<div onclick=selectChild(event)>';
								}
							}
							if(sonStr===null || sonStr.length<=0){
								sonStr = '<div><input name="menu" onclick="test(event)" type="checkbox"  value="'+allDatas[i].id+'"/>'+allDatas[i].menuName+'<div onclick=selectChild(event)>';
							}
							str +=  sonStr;
							
							for(var j = 0; j < allDatas.length; j++) 
								if(allDatas[j].parentId === allDatas[i].id) {
									var ssStr = ""; 
									
									for(var m = 0; m < sonDatas.length; m++) {
										if (allDatas[j].id===sonDatas[m].id) {
											ssStr = '&nbsp;&nbsp;<input checked="checked" name="menu" type="checkbox" value="'+allDatas[j].id+'"/>'+allDatas[j].menuName;
										}
									}
									if(ssStr===null||ssStr.length<=0) {
										ssStr= '&nbsp;&nbsp;<input name="menu" type="checkbox" value="'+allDatas[j].id+'"/>'+allDatas[j].menuName;
									}
									str += ssStr;
								}
									
							str +='</div></div>';
						}
					}
					$("#menu").append(str);
				}
			});
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
function update() {
	$.ajax({
		url:getUrl("role/roleUpdate"),
		data:$('#role').serialize(),
		success:function(data) {
			if(data.success) {
				window.location.href = getUrl("role/role");
			}
		}
	});
}
</script>
</html>