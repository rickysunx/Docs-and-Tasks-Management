<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>�ͻ��˰�װ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Pragma" content="no-cache">
<link href="main.css" rel="stylesheet" type="text/css">
<link href="css/color.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function isClientInstalled() {
	try {
		var pxldesktop = new ActiveXObject("pxl4ie.PxlExtend");
		return true;
	} catch (e) {
		return false;
	}
}

function pxlRedirect() {
	if(isClientInstalled()) {
		window.location.href='index.jsp';
	}
}

pxlRedirect();
</script>
</head>
<body>
<table>
<tr>
<td>
����δ��װ�������ͻ��ˣ���װ�ͻ��˿��Ի�ü�ʱ����Ϣ��ʾ�����ӿ�ݵ�����֪ʶ��̬��<br>
<a href='pxl_setup.exe'>�����˴����ذ�װ�������ͻ��ˡ�</a><br>
<a href='index.jsp'>�������ת����������ҳ��</a>
</td>
</tr>
</table>
</body>
</html>