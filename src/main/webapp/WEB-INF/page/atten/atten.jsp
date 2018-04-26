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
<script type="text/javascript" src="/attendance/static/js/dict/simple-input-method.js"></script>
<script type="text/javascript" src="/attendance/static/js/time/laydate.js"></script>
<link rel="stylesheet" type="text/css" href="/attendance/static/js/layer-v3.1.1/layer/mobile/need/layer.css">
<link href="/attendance/static/css/common.css" rel="stylesheet" type="text/css" />
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
	<div class="box">
			<div class="demo2">
			<form>
				<input placeholder="开始日期" id="startTime" name="startTime" class="laydate-icon" onClick="laydate({istime: true, format: 'YYYY-MM-DD'})">
				<input placeholder="结束日期" id="endTime" name="endTime" class="laydate-icon" onClick="laydate({istime: true, format: 'YYYY-MM-DD'})">
				<input id = "queryButton" class="btn btn-primary" type="button" value="查询">
			</form>
			</div>
		</div>
		<table class="table table-bordered" id='tableResult'>
    	<caption>查询用户结果</caption>
	    <thead>
	        <tr>
	            <th>序号</th>
	            <th>上午考勤</th>
	            <th>上午状态</th>
	            <th>下午考勤</th>
	            <th>下午状态</th>
	            <th>考勤日期</th>
	        </tr>
	    </thead>
	    <tbody id="tableBody"></tbody>
</table>
<table width="60%" align="right">
        <tr><td><div id="barcon" name="barcon"></div></td></tr>
</table>
	</div>
</body>
<script language="JavaScript">
var PAGESIZE = 10;
 //获取当前项目的路径
function  parjsoneval (result) {
  return eval('(' + result + ')');
};        
function goPage(startTime, endTime, pageNumber, pageSize){
  var url =  getUrl("atten/listAtten"); 
  startTime = $("#startTime").val();
  endTime = $("#endTime").val();
  if(startTime.length===0){
	  startTime = null;
  }
  if(endTime.length===0) {
	  endTime = null;
  }
  var reqParams = {'startTime':startTime, 'endTime':endTime, 'pageNumber':(pageNumber-1)*10,'pageSize':pageSize};
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
                $("#tableBody").append('<td>' + timeParse(this.workTime) + '</td>');
                $("#tableBody").append('<td>' + getStatus(this.amStatus) + '</td>');
                $("#tableBody").append('<td>' + timeParse(this.endTime) +'</td>');
                $("#tableBody").append('<td>' + getStatus(this.pmStatus) + '</td>');
                $("#tableBody").append('<td>' + timeParse2(this.reference) + '</td>');
                $("#tableBody").append('</tr>');
                });  
            } else {                                
                $("#tableBody").append('<tr><th colspan ="4"><center>查询无数据</center></th></tr>');
            }
            var tempStr = "总共"+datas.totalRecord+"条记录|总共"+totalPage+"页|当前第"+currentPage+"页";
           
           
            if(currentPage>1){
                pageNumber=1;
                tempStr += "<a href=\"#\" onClick=\"goPage("+startTime+","+endTime+","+pageNumber+","+pageSize+")\">首页</a>";
                pageNumber = currentPage-1;
                tempStr += "<a href=\"#\" onClick=\"goPage("+startTime+","+endTime+","+pageNumber+","+pageSize+")\"><上一页</a>"
             }else{
                tempStr += "首页";
                tempStr += "<上一页";    
             }
             if(currentPage<totalPage){
                pageNumber = currentPage+1;
                tempStr += "<a href=\"#\" onClick=\"goPage("+startTime+","+endTime+","+pageNumber+","+pageSize+")\">下一页></a>";
                pageNumber = totalPage
                tempStr += "<a href=\"#\" onClick=\"goPage("+startTime+","+endTime+","+pageNumber+","+pageSize+")\">尾页</a>";
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
    var realName = $("#startTime").val();   
    var dept = $("endTime").val();
    goPage(realName,dept,0,PAGESIZE);
    });
});
function timeParse(time) {
	var timestamp4 = new Date(time);//直接用 new Date(时间戳) 格式转化获得当前时间
	return timestamp4.toLocaleDateString().replace(/\//g, "-") + " " + timestamp4.toTimeString().substr(0, 8); 
}
function timeParse2(time) {
    var da = new Date(time);
    var year = da.getFullYear();
    var month = da.getMonth()+1;
    var date = da.getDate();
	return year+"-"+month+"-"+date;
}
function getStatus(status) {
	if(status===0) {
		return "旷工";
	}else if(status === 1){
		return "迟到";
	}else {
		return "签到成功";
	}
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