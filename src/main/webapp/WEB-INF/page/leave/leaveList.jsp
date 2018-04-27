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
	<form action="return false" id="atten">
		<div class="box">
			<div class="demo2">
				<h3>开始时间</h3>
				<input placeholder="请输入日期" name="start" class="laydate-icon" onClick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
			</div>
			<div class="demo2">
				<h3>结束时间</h3>
				<input placeholder="请输入日期" name="end" class="laydate-icon" onClick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
			</div>
			<div>
				<textarea name="reason"></textarea>
			</div>
			<div>
				<input type="button" onclick="atten()" value="请假"/>
			</div>
		</div>
		
	</form>
	</div>
</body>
<script>
	function atten() {
		$.ajax({
			url:getUrl("leave/leave"),
			data:$("#atten").serialize(),
			success:function (data) {
				layer.msg(data.msg);
				if(data.success)
					window.location.href = getUrl("home/home");
			}
		});
	}
</script>
<script type="text/javascript">
!function(){
	laydate.skin('molv');//切换皮肤，请查看skins下面皮肤库
	laydate({elem: '#demo'});//绑定元素
}();
//日期范围限制
var start = {
    elem: '#start',
    format: 'YYYY-MM-DD',
    min: laydate.now(), //设定最小日期为当前日期
    max: '2099-06-16', //最大日期
    istime: true,
    istoday: false,
    choose: function(datas){
         end.min = datas; //开始日选好后，重置结束日的最小日期
         end.start = datas //将结束日的初始值设定为开始日
    }
};
var end = {
    elem: '#end',
    format: 'YYYY-MM-DD',
    min: laydate.now(),
    max: '2099-06-16',
    istime: true,
    istoday: false,
    choose: function(datas){
        start.max = datas; //结束日选好后，充值开始日的最大日期
    }
};
</script>
</html>