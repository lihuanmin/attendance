<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset='utf-8'>
<script type="text/javascript" src="/attendance/static/js/commons/common.js" ></script>
<script type="text/javascript" src="/attendance/static/js/commons/jquery-3.2.1.min.js"></script>
<link href="/attendance/static/css/common.css" rel="stylesheet" type="text/css" />
<link href="/attendance/static/css/form.css" rel="stylesheet" type="text/css" />
<link href="/attendance/static/css/table.css" rel="stylesheet" type="text/css"/>
<title>员工列表</title>
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
	<div class="search">
		<form action="return false">
		  <input type="text" id="textInput" name="realName" placeholder="用户姓名"/>&nbsp;
		  <input type="text" id="textInput2" name="dept" placeholder="部门信息"/>&nbsp;
		  <input id = "queryButton" class="btn btn-primary" type="button" value="查询">
	   </form>
	</div>
	<div class="list">
<table id='tableResult' border="1" class="t1">
    <thead>
        <tr>
            <th>用户名</th>
            <th>用户账号</th>
            <th>性别</th>
            <th>注册时间</th>
            <th>邮箱</th>
            <th>电话</th>
            <th>角色名</th>
            <th>部门名</th>
            <th>操作</th>
        </tr>
    </thead>
    <tbody id="tableBody">
    </tbody>
</table>
 <table id="page">
				<tr>
					<td><div id="barcon" name="barcon"></div></td>
				</tr>
</table>
</div>
</div>
   
</body> 
<script>
var PAGESIZE = 10;
 //获取当前项目的路径
function  parjsoneval (result) {
  return eval('(' + result + ')');
};        
function goPage(realName, dept, pageNumber, pageSize){
  var url =  getUrl("member/memberList"); 
  realName = $("#textInput").val();
  dept = $("#textInput2").val();
  if(dept.length===0){
      dept = null;
  }
  if(realName.length===0) {
	  realName = null;
  }
  var reqParams = {'realName':realName, 'dept':dept, 'pageNumber':(pageNumber-1)*10,'pageSize':pageSize};
  $(function () {
         $.ajax({
          type:"POST",
          url:url,
          data:reqParams,
          async:false,
          dataType:"json",
          success: function(data){
       		 var datas = JSON.parse(data);
            //总记录数
            var totalRecord = datas.totalRecord;
           
            //总页数
            var totalPage = 0;
            if(totalRecord/pageSize > parseInt(totalRecord/pageSize)) {
                 totalPage = parseInt(totalRecord/pageSize)+1;
            } else {
                totalPage = parseInt(totalRecord/pageSize);
            }
            var currentPage = pageNumber ;
            //数据集合
            var dataList = datas.dataList;
             $("#tableBody").empty();//清空表格
             if (dataList.length > 0 ) {
             $(dataList).each(function(){//重新生成
                $("#tableBody").append('<tr>');
                $("#tableBody").append('<td>' + this.realName+ '</td>');
                $("#tableBody").append('<td>' + this.account + '</td>');
                $("#tableBody").append('<td>' + getSex(this.sex) +'</td>');
                $("#tableBody").append('<td>' + timeParse3(this.registerTime)+ '</td>');
                $("#tableBody").append('<td>' + this.email + '</td>');
                $("#tableBody").append('<td>' + this.phone+ '</td>');
                $("#tableBody").append('<td>' + this.roleName + '</td>');
                $("#tableBody").append('<td>' + this.deptName + '</td>');
                $("#tableBody").append('<td><button style="" onclick="del('+this.id+')">删除</button> </td>');
                $("#tableBody").append('</tr>');
                });  
            } else {                                
                $("#tableBody").append('<tr><th colspan ="5"><center>查询无数据</center></th></tr>');
            }
            var tempStr = "总共"+datas.totalRecord+"条记录|总共"+totalPage+"页|当前第"+currentPage+"页";
            if(currentPage>1){
                pageNumber=1;
                tempStr += "<a href=\"#\" onClick=\"goPage("+realName+","+dept+","+pageNumber+","+pageSize+")\">首页</a>";
                pageNumber = currentPage-1;
                tempStr += "<a href=\"#\" onClick=\"goPage("+realName+","+dept+","+pageNumber+","+pageSize+")\"><上一页</a>"
             }else{
                tempStr += "首页";
                tempStr += "<上一页";    
             }
             if(currentPage<totalPage){
                pageNumber = currentPage+1;
                tempStr += "<a href=\"#\" onClick=\"goPage("+realName+","+dept+","+pageNumber+","+pageSize+")\">下一页></a>";
                pageNumber = totalPage
                tempStr += "<a href=\"#\" onClick=\"goPage("+realName+","+dept+","+pageNumber+","+pageSize+")\">尾页</a>";
            }else{
                tempStr += "下一页>";
                tempStr += "尾页";    
            }
                    document.getElementById("barcon").innerHTML = tempStr;
          },
          error: function(e){
          console.log("查询失败");
        }
         });
  });
    
}
$(function() {
    goPage("", "",1,PAGESIZE);
    $("#queryButton").bind("click",function(){
    var realName = $("#textInput").val();   
    var dept = $("textInput2").val();
    goPage(realName,dept,1,PAGESIZE);
    });
});
function  getSex(sex) {
	if(sex)
		return '男';
	else
		return '女';
}
function del(userId) {
	$.ajax({
		url:getUrl("member/delUser"),
		data:{"userId":userId},
		success:function(data) {
			if(data.success)
				window.location.href=getUrl("member/memberListPage");
		}
	});
}
function timeParse3(t) {
	var da = new Date(t);
	var year = da.getFullYear();
	var month = da.getMonth()+1;
	var day = da.getDate();
	return year+'-'+month+'-'+day;
}
</script>
</html>