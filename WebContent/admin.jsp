<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%
if(!Pub.isAdminUser(session)) {
	throw new Exception("�ǹ���Ա�û����޷����ʣ�");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.pxl.pkb.biz.Pub"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Pragma" content="no-cache">
<title>��̨����</title>
<link href="main.css" rel="stylesheet" type="text/css">
</head>

<frameset id="fraRoot" rows="*" frameborder="no" border="0" framespacing="0" cols="150,*">
	<frame name="fraLeft" scrolling="auto" src="admin_func.jsp">
	<frame name="fraMain" scrolling="auto" src="admin_main.jsp">
</frameset>

<noframes>
	<body>
	�����������֧�ֿ��
	</body>
</noframes>

</html>