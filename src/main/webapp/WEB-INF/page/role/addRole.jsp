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
<link href="/attendance/static/css/form.css" rel="stylesheet" type="text/css"/>
<title>添加角色</title>
</head>
<body onload="setInterval(nowtime,1000)">
	<div class="nav-top">
		<img class="avatar" src="${userInfo.portrait}" title="${userInfo.realName}" />
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
			            document.getElementById("t1").innerHTML = "&nbsp;&nbsp;" + nowTime;
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
                    document.getElementById("t1").innerHTML = "&nbsp;&nbsp;" + nowTime;
                    return nowTime;
                }
            </script>
		</div>
		
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
queryMenu();
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