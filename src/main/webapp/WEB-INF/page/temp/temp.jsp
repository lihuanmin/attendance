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
<title>个人中心</title>
<style>
	div {
		box-sizing: border-box;
		margin: 20px auto;
		background: #D500F9;
		border-radius: 50px;
		width:120px;
		padding: 5px 0;
		color: #fff;
		text-align: center;
		cursor: pointer;
	}
	#person{
	}
	#atten{
	}
</style>
</head>
<body>
	<div id="person" >个人系统</div>
	<div id="atten" >打卡</div>
		
</body>
<script>
	$("#person").on("click",function(){
    	location.href = getUrl("home/home");
	});
	$("#atten").on("click",function(){
		$.ajax({
			url:getUrl("atten/atten"),
			success:function(data) {
				layer.msg(data.msg);
			}
		});
	});
	
</script>
</html>