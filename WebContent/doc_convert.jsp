<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.pxl.pkb.biz.Doc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String strDocID = request.getParameter("docid");
Exception ex = null;
int docid = Integer.parseInt(strDocID);
try {
	Doc.convertDocToSwf(docid);
} catch (Exception e) {
	ex = e;
}
%>

<%@page import="com.pxl.pkb.biz.Pub"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>ת���ĵ�</title>
<script type="text/javascript">

var oSpan = parent.document.getElementById("docConvert");
<%
	if(ex==null) {
		if(Pub.isSwfFileExists(docid)) {
			out.println("oSpan.innerHTML=\"<a href='doc_read.jsp?docid="+docid+"' target='_blank'>�Ķ�</a>\";");
		} else {
			out.println("oSpan.innerHTML='�Ķ���ת��ʧ�ܣ���ˢ�º����ԣ���';");
		}
	} else {
		out.println("oSpan.innerHTML='�Ķ���ת��ʧ�ܣ���ˢ�º����ԣ���';");
		out.println("alert(\"ת��ʧ�ܣ�������Ϣ��"+ex.getMessage()+"\");");
	}

%>
</script>
</head>
<body>
<%
if(ex!=null) {
	out.println("����"+ex.getMessage());
} else {
	out.println("�Ѿ�����ת������");
}
%>
</body>
</html>