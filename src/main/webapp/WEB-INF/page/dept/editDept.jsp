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
<link rel="stylesheet" type="text/css" href="/attendance/static/js/layer-v3.1.1/layer/mobile/need/layer.css">
<link href="/attendance/static/css/common.css" rel="stylesheet" type="text/css" />
<style type="text/css">  
        .search  
        {  
            left: 0;  
            position: relative;  
        }  
        #auto_div  
        {  
            display: none;  
            width: 300px;  
            border: 1px #74c0f9 solid;  
            background: #FFF;  
            position: absolute;  
            top: 24px;  
            left: 0;  
            color: #323232;  
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
		<form id="uDept"action="return false">
			<input type="text" id="deptId" name="deptId" value="${dept.deptId}" /><br/>
			<input type="text" id="deptName" name="deptName" value="${dept.deptName}" onblur="checkName()"/><br/>
			<input type="text" id="deptCode" name="deptCode" value="${dept.deptCode}"/><br/>
			<div class="search">  
        		<input type="text" id="head" name="head" value="${dept.head}"/><br/>
	        	<div id="auto_div">  
	        	</div>  
    		</div>  
			
			<input type="text" id="slogan" name="slogan" value="${dept.slogan}"/><br/>
			<input type="button" onclick="update()" value="修改"/>
		</form>
	</div>
<script type="text/javascript">
function checkName() {
	var name = $("#deptName").val();
	if(name===""||name===null){
		layer.msg("部门不能为空");
		return;
	}else {
		$.ajax({
			url:getUrl("department/checkName"),//前端验证还得改成不走名字验证，用户是否存在
			data:{deptName:name},
			success:function(data){
				layer.msg(data.msg);
				if(data){
					getPinyin();
				}else {
					return;
				}
			}
		});
	}
}
function getPinyin()
{
	var value = document.getElementById('deptName').value;
	var polyphone = null;
	var result = '';
	if(value)
		result = pinyinUtil.getFirstLetter(value, polyphone);
	$("#deptCode").val(result);
}
function update() {
	$.ajax({
		url:getUrl("department/updateDept"),
		data:$("#uDept").serialize(),
		success:function(data) {
			layer.msg(data.msg);
			if(data.success){
				window.location.href = getUrl("department/deptManager");
			}
			else{
				
			}
				
		}
	});
}
</script>
<script type="text/javascript">  
        //测试用的数据，这里可以用AJAX获取服务器数据  
        var test_list = "";
        var deptId = $("#deptId").val();
        $.ajax({
        	url:getUrl("department/search"),
        	data:{"deptId":deptId},
        	success:function(data) {
        		test_list =  JSON.parse(data)
        	}
        })
        var old_value = "";  
        var highlightindex = -1;   //高亮  
        //自动完成  
        function AutoComplete(auto, search, mylist) {  
            if ($("#" + search).val() != old_value || old_value == "") {  
                var autoNode = $("#" + auto);   //缓存对象（弹出框）  
                var carlist = new Array();  
                var n = 0;  
                old_value = $("#" + search).val();  
                for (i in mylist) {  
                    if (mylist[i].indexOf(old_value) >= 0) {  
                        carlist[n++] = mylist[i];  
                    }  
                }  
                if (carlist.length == 0) {  
                    autoNode.hide();  
                    return;  
                }  
                autoNode.empty();  //清空上次的记录  
                for (i in carlist) {  
                    var wordNode = carlist[i];   //弹出框里的每一条内容  
                    var newDivNode = $("<div>").attr("id", i);    //设置每个节点的id值  
                    newDivNode.attr("style", "font:14px/25px arial;height:25px;padding:0 8px;cursor: pointer;");  
                    newDivNode.html(wordNode).appendTo(autoNode);  //追加到弹出框  
                    //鼠标移入高亮，移开不高亮  
                    newDivNode.mouseover(function () {  
                        if (highlightindex != -1) {        //原来高亮的节点要取消高亮（是-1就不需要了）  
                            autoNode.children("div").eq(highlightindex).css("background-color", "white");  
                        }  
                        //记录新的高亮节点索引  
                        highlightindex = $(this).attr("id");  
                        $(this).css("background-color", "#ebebeb");  
                    });  
                    newDivNode.mouseout(function () {  
                        $(this).css("background-color", "white");  
                    });  
                    //鼠标点击文字上屏  
                    newDivNode.click(function () {  
                        //取出高亮节点的文本内容  
                        var comText = autoNode.hide().children("div").eq(highlightindex).text();  
                        highlightindex = -1;  
                        //文本框中的内容变成高亮节点的内容  
                        $("#" + search).val(comText);  
                    })  
                    if (carlist.length > 0) {    //如果返回值有内容就显示出来  
                        autoNode.show();  
                    } else {               //服务器端无内容返回 那么隐藏弹出框  
                        autoNode.hide();  
                        //弹出框隐藏的同时，高亮节点索引值也变成-1  
                        highlightindex = -1;  
                    }  
                }  
            }  
            //点击页面隐藏自动补全提示框  
            document.onclick = function (e) {  
                var e = e ? e : window.event;  
                var tar = e.srcElement || e.target;  
                if (tar.id != search) {  
                    if ($("#" + auto).is(":visible")) {  
                        $("#" + auto).css("display", "none")  
                    }  
                }  
            }  
        }  
        $(function () {  
            old_value = $("#head").val();  
            $("#head").focus(function () {  
                if ($("#head").val() == "") {  
                    AutoComplete("auto_div", "head", test_list);  
                }  
            });  
            $("#head").keyup(function () {  
                AutoComplete("auto_div", "head", test_list);  
            });  
        });  
    </script>  
</body>
</html>