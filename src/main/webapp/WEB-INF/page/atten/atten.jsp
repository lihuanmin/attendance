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
		<form name="date">  
		  <select name="year" onchange="selectYear(this.value)">  
		    <option value="">选择 年</option>  
		  </select>  
		  <select name="month" onchange="selectMonth(this.value)">  
		    <option value="">选择 月</option>  
		  </select>  
		  <select name="day">  
		    <option value="">选择 日</option>  
		  </select>  
		</form>  
	</div>
</body>
<script language="JavaScript">    
   function dateStart()     
   {     
       //月份对应天数  
       MonHead = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];     
      
       //给年下拉框赋内容     
       var y  = new Date().getFullYear();     
       for (var i = (y-50); i < (y+50); i++) //以今年为准，前50年，后50年     
           document.date.year.options.add(new Option(" "+ i +" 年", i));     
      
       //给月下拉框赋内容     
       for (var i = 1; i < 13; i++)     
           document.date.month.options.add(new Option(" " + i + " 月", i));  
     
       document.date.year.value = y;     
       document.date.month.value = new Date().getMonth() + 1;     
       var n = MonHead[new Date().getMonth()];     
       if (  new Date().getMonth() ==1 && IsPinYear(yearvalue)  )   
           n++;     
       writeDay(n); //赋日期下拉框     
       document.date.day.value = new Date().getDate();     
   }   
    
   if(document.attachEvent)     
       window.attachEvent("onload", dateStart);     
   else     
       window.addEventListener('load', dateStart, false);     
  
   function selectYear(str) //年发生变化时日期发生变化(主要是判断闰平年)     
   {     
       var monthvalue = document.date.month.options[document.date.month.selectedIndex].value;     
       if (monthvalue == "")  
       {  
           var e = document.date.day;  
           optionsClear(e);  
           return;  
       }     
       var n = MonHead[monthvalue - 1];     
       if (  monthvalue ==2 && IsPinYear(str)  )   
           n++;     
       writeDay(n);     
   }     
  
   function selectMonth(str)   //月发生变化时日期联动     
   {     
        var yearvalue = document.date.year.options[document.date.year.selectedIndex].value;     
        if (yearvalue == "")  
        {   
            var e = document.date.day;   
            optionsClear(e);  
            return;  
        }     
        var n = MonHead[str - 1];     
        if (  str ==2 && IsPinYear(yearvalue)  )   
            n++;     
            writeDay(n);    
        }     
  
   function writeDay(n)   //据条件写日期的下拉框     
   {     
       var e = document.date.day; optionsClear(e);  
       e.options.add(new Option("null"));
       for (var i=1; i<(n+1); i++)     
           e.options.add(new Option(" "+ i + " 日", i));   
       
   }     
  
   function IsPinYear(year)//判断是否闰平年     
   {       
       return(  0 == year%4 && ( year%100 !=0 || year%400 == 0 )  );  
   }  
  
   function optionsClear(e)   
   {   
       e.options.length = 1;   
   }  
</script>  
</html>