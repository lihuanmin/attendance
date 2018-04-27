function getUrl(url) {
    var strPath = window.document.location.pathname; /* /finance/index.html */
    var postPath = strPath.substring(0, strPath.substring(1).indexOf("/")+1);
    return postPath+"/"+url;
}
function getDate(date){
	var time = new Date(parseInt(date))
	var result = time.getFullYear()+"-"+time.getMonth() +"-"+time.getDate()
	return result;
}
function timeParse(time) {
	if(time===null||time===""||time===undefined) {
		return "";
	}
	var timestamp4 = new Date(time);//直接用 new Date(时间戳) 格式转化获得当前时间
	return timestamp4.toLocaleDateString().replace(/\//g, "-") + " " + timestamp4.toTimeString().substr(0, 8); 
}
function timeParse2(time) {
	if(time===null||time===""||time===undefined) {
		return "";
	}
    var da = new Date(time);
    var year = da.getFullYear();
    var month = da.getMonth()+1;
    var date = da.getDate();
	return year+"-"+month+"-"+date;
}