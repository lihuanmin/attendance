<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link  href="/attendance/static/css/common.css" rel="stylesheet" type="text/css" />
<title>考勤系统</title>
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
		  <div class="main">
        <span style="font-size: 50px; font-weight: bold; font-family: 楷体;"><span id="SystemName_CH" class="Systext">Lee</span></span><br />
        <span style="font-size: 50px; font-weight: bold; font-family: 楷体;">欢迎进入</span><br /><br />
        <span style="font-size: 20px; font-weight: bold; font-family: 楷体;"><span id="Copyright_CH" class="Systext">你所经历的一切都是有意义的</span></span>
    </div> 
    	<div style="float:right;" id="github_iframe"></div>

		<script type="text/javascript" color="0,0,0" opacity='0.7' zIndex="-2" count="200" src="/attendance/static/js/canvas-nest.js"></script>
	</div>
</body>
</html>