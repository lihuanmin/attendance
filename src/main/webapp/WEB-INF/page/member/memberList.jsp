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
		<form action="">
  <input type="text" id="textInput" name="realName" placeholder="用户姓名"/>&nbsp;
  <input type="text" id="textInput2" name="dept" placeholder="部门信息"/>&nbsp;
  <input id = "queryButton" class="btn btn-primary" type="button" value="查询">
</form>
<table class="table table-bordered" id = 'tableResult'>
    <caption>查询用户结果</caption>
    <thead>
        <tr>
            <th>序号</th>
            <th>用户名</th>
            <th>用户账号</th>
            <th>性别</th>
            <th>注册时间</th>
            <th>邮箱</th>
            <th>电话</th>
            <th>角色名</th>
            <th>部门名</th>
            <th colspan="2">操作</th>
        </tr>
    </thead>
    <tbody id="tableBody">
    </tbody>
</table>
 <table width="60%" align="right">
        <tr><td><div id="barcon" name="barcon"></div></td></tr>
</table>
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
  var reqParams = {'realName':realName, 'dept':dept, 'pageNumber':pageNumber,'pageSize':pageSize};
  $(function () {
         $.ajax({
          type:"POST",
          url:url,
          data:reqParams,
          async:false,
          dataType:"json",
          success: function(data){
           console.log(data);
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
            var currentPage = pageNumber;
            //数据集合
            var dataList = datas.dataList;
            console.log(dataList);
             $("#tableBody").empty();//清空表格
             if (dataList.length > 0 ) {
             $(dataList).each(function(){//重新生成
                $("#tableBody").append('<tr>');
                $("#tableBody").append('<td>' + this.id + '</td>');
                $("#tableBody").append('<td>' + this.realName+ '</td>');
                $("#tableBody").append('<td>' + this.account + '</td>');
                $("#tableBody").append('<td>' + getSex(this.sex) +'</td>');
                $("#tableBody").append('<td>' + timeParse(this.registerTime)+ '</td>');
                $("#tableBody").append('<td>' + this.email + '</td>');
                $("#tableBody").append('<td>' + this.phone+ '</td>');
                $("#tableBody").append('<td>' + this.roleName + '</td>');
                $("#tableBody").append('<td>' + this.deptName + '</td>');
                $("#tableBody").append('<td><a href="#">删除</a> </td>');
                $("#tableBody").append('<td><a href="#">修改 </a></td>');
                $("#tableBody").append('</tr>');
                });  
            } else {                                
                $("#tableBody").append('<tr><th colspan ="4"><center>查询无数据</center></th></tr>');
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
    goPage("", "",0,PAGESIZE);
    $("#queryButton").bind("click",function(){
    var realName = $("#textInput").val();   
    var dept = $("textInput2").val();
    goPage(realName,dept,0,PAGESIZE);
    });
});
function  getSex(sex) {
	if(sex)
		return '男';
	else
		return '女';
}
function timeParse(time) {
	var timestamp4 = new Date(1472048779952);//直接用 new Date(时间戳) 格式转化获得当前时间
	return timestamp4.toLocaleDateString().replace(/\//g, "-") + " " + timestamp4.toTimeString().substr(0, 8); 
}
</script>
</html>