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
<link href="/attendance/static/css/common.css" rel="stylesheet" type="text/css" />
<link href="/attendance/static/css/form.css" rel="stylesheet" type="text/css"/>
<title>个人信息</title>
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
		<form id="userInfo" action="returen false">
			<input type="text" id="account" name="account" readonly="readonly"/><br/>
			<input type="text" id="realName" name="realName" readonly="readonly"/><br/>
			<input type="text" id="registerTime" name="registerTIme" readonly="readonly"/><br/>
			<select name="sex" id="sex"></select><br/>
			<input type="text" id="email" name="email" placeholder="email"/><br/>
			<input type="text" id="phone" name="phone" placeholder="phone"/><br/>
			<textarea name="introduce" id="introduce" rows="5" cols="10">
			</textarea><br/>
			
			<input type="button" onclick="updateUserInfo()" value="修改"/>
		</form>
	</div>
</body>
<script>
getUserInfo();
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