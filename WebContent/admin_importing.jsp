<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Pragma" content="no-cache">
<title>�������</title>
<link href="main.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
var docCount = 0;
function requestLoop() {
	var xmlHttp;
	
	xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	docCount++;
	if(docCount==7) {
		docCount=0;
	}
	
	var strDot = "";
	var i;
	for(i=0;i<docCount;i++) {
		strDot += "��";
	}
	
	document.getElementById("sDots").innerText=strDot;
	
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState==4) {
			if(xmlHttp.status==200) {
				var text = xmlHttp.responseText;
				eval(text);
				window.setTimeout("requestLoop();",1000);
			}
		}
	}
	
	xmlHttp.open("GET","admin_importing_js.jsp",true);
	xmlHttp.send(null);
	
}
</script>
</head>
<body onload="requestLoop();">
<table>
<tr>
<td>
	���ڵ����û�(<span id="sUserIndex">-</span>/<span id="sUserCount">-</span>)��
	�ļ�(<span id="sFileIndex">-</span>/<span id="sFileCount">-</span>)<span id="sDots">...</span><br>
	��ǰ��Ϣ��<span id="sCurrInfo"></span><br>
	<a href='InitBulkUpload.do'>������������������</a>
</td>
</tr>
</table>
</body>
</html>