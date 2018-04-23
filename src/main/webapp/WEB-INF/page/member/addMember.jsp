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
<body onload="query();">
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
		<form id="addMem" action="return false;">
			<select id="dept" name="deptId">
						<option value="">请选择</option>
					</select><br/>
			<input type="text" id="userName" name="userName" placeholder="员工姓名" onblur="setAccount()"/><br/>
			<select id="role" name="role">
						<option value="">请选择角色</option>
					</select><br/>
			<input type="text" value="123456" name="userPasswd" readonly="true"/><br/>
			<input id="number" type="text" name="number" readonly="true"/><br/>
			<input type="text" id="prefixAccount" name="prefixAccount" readonly="true"/>-<input type="text" id="suffixAccount" name="suffixAccount" readonly="true"/><br/>
			<select name="sex">
						<option value="0">女</option>
						<option value="1">男</option>
					</select><br/>
			<input type="button" onclick="addMem()" value="添加"/>
		</form>
	</div>
</body>
<script type="text/javascript">
		function query() {
			$.ajax({
				url:getUrl("member/queryDept"),
				success:function(data) {
					var datas = jQuery.parseJSON(data);
					var str = "";
					for(var i = 0; i < datas.length; i++) {
						str += '<option value="'+datas[i].deptId+'">'+datas[i].deptName+'</option>';
					}
					$("#dept").append(str);
				}
			});
		}
		queryRole();
		function queryRole() {
			$.ajax({
				url:getUrl("member/queryRole"),
				success:function(data) {
					var datas = jQuery.parseJSON(data);
					var str = "";
					for(var i = 0; i < datas.length; i++) {
						str += '<option value="'+datas[i].id+'">'+datas[i].roleName+'</option>';
					}
					$("#role").append(str);
				}
			});
		}
		queryCount();
		function queryCount(){
			$.ajax({
				url:getUrl("member/queryCount"),
				success:function(data) {
					$("#number").val(data);
				}
			});
		}
		function getPinyin(value)
		{
			var polyphone = null;
			var result = '';
			if(value)
				result = pinyinUtil.getFirstLetter(value, polyphone);
			return result;
		}
		var v = $("#dept option:selected").text();
		$("#dept").change(function(){  
			var v = $("#dept option:selected").text();
			$("#prefixAccount").val(getPinyin(v));
		}) 
		function setAccount() {
			var name = $("#userName").val();
			if(name===""||name===null){
				layer.msg("名字不能为空");
				return;
			}
			console.log(name)
			$("#suffixAccount").val(getPinyin(name));
		}
		function addMem() {
			//??判断为空的为题
			$.ajax({
				url:getUrl("member/addMem"),
				data:$("#addMem").serialize(),
				success:function(data) {
					layer.msg(data.msg);
					if(data.success) 
						window.location.href = getUrl("member/memberListPage");
				}
			});
		}
	</script>
</html>