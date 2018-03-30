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