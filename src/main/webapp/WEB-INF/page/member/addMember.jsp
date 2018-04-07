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
<body onload="query();">
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
		<form id="addMem" action="return false;">
			所属部门：<select id="dept" name="deptId">
						<option value="">请选择</option>
					</select><br/>
			员工姓名：<input type="text" id="userName" name="userName" onblur="setAccount()"/><br/>
			员工角色：<select id="role" name="role">
						<option value="">请选择角色</option>
					</select><br/>
			初始密码：<input type="text" value="123456" name="userPasswd" readonly="true"/><br/>
			员工账号: <input type="text" id="prefixAccount" name="prefixAccount" readonly="true"/>-<input type="text" id="suffixAccount" name="suffixAccount" readonly="true"/><br/>
			员工性别：<select name="sex">
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
						window.location.href = getUrl("home/home");
				}
			});
		}
	</script>
</html>