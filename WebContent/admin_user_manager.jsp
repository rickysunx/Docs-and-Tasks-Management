<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%@page import="com.pxl.pkb.biz.Pub"%>
<%@page import="com.pxl.pkb.vo.bd_role"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
if(!Pub.isAdminUser(session)) {
	throw new Exception("�ǹ���Ա�û����޷����ʣ�");
}
%>
<%
DataManagerObject dmo = new DataManagerObject();
ValueObject [] uservos = dmo.queryByWhere(bd_user.class," 1=1 order by UserCode");
%>
<%@page import="com.pxl.pkb.framework.DataManagerObject"%>
<%@page import="com.pxl.pkb.framework.ValueObject"%>
<%@page import="com.pxl.pkb.vo.bd_user"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.pxl.pkb.biz.Consts"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Pragma" content="no-cache">
<title>�û�����</title>
<link href="main.css" rel="stylesheet" type="text/css">
<link href="css/color.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function doPassReset(userid) {
	var password = prompt('�������������룺','');
	if(password!=null) {
		if(password=='') {
			alert('����������');
			return;
		}
		frmPasswordReset.userID.value=userid;
		frmPasswordReset.password.value=password;
		frmPasswordReset.submit();
	}
}
</script>
</head>
<body>
<table border="0" cellpadding="2" cellspacing="2">
<tr><td>��̨���� &gt; �û� </td></tr>
</table>

<table width="550" border="0" cellpadding="2" cellspacing="2" class="blockborder">
<tr class="tableBackGround">
	<td height="20" width="100"><b>�û�����</b></td>
	<td height="20" width="100"><b>�û�����</b></td>
	<td height="20" width="100"><b>�û���ɫ</b></td>
	<td height="20" width="100"><b>�û�״̬</b></td>
	<td width="150" align="center"><b>����</b></td>
</tr>
<%
for(int i=0;i<uservos.length;i++){
	bd_user user = (bd_user)uservos[i];
%>
<tr bgcolor="<%=(i%2==0)?"#f9f9f9":"#f7f7f7" %>">
	<td height="20"><%=user.getUserCode()%></td>
	<td><%=user.getUserName()%></td>
	<td><%=Consts.ROLE_NAMES[Integer.parseInt(user.getIsAdmin())]%></td>
	<td><%=user.getErrorCount()<5?"δ����":"������"%></td>
	<td align="center">
		<a href='UserDelete.do?userid=<%=user.getUserID()%>' onclick="return confirm('���Ҫɾ�����û���');">ɾ��</a>
		<a href='admin_user_edit.jsp?userid=<%=user.getUserID()%>'>�༭</a>
		<a href='javascript:doPassReset(<%=user.getUserID()%>);'>��������</a>
	</td>
</tr>
<%}%>
</table>
<form id="frmPasswordReset" action="PasswordReset.do" method="post">
	<input id="userID" name="userID" type="hidden">
	<input id="password" name="password" type="hidden">
</form>

</body>
</html>