<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%@page import="com.pxl.pkb.biz.Pub"%>
<%@page import="com.pxl.pkb.framework.DataManagerObject"%>
<%@page import="com.pxl.pkb.vo.bd_user"%>
<%@page import="com.pxl.pkb.framework.ValueObject"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
if(!Pub.isAdminUser(session)) {
	throw new Exception("�ǹ���Ա�û����޷����ʣ�");
}
DataManagerObject dmo=new DataManagerObject();
Object[][] mails= dmo.querySQL("select mailuserid,failedreason,senddate,userid,mailsubject from bd_mailuser,bd_mail where bd_mailuser.mailId=bd_mail.mailid and failedcount>=5 and issuccess=0 order by senddate desc");
%>
<html>
  	<head>    
   	 	<title>����ʧ���ʼ�</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="Pragma" content="no-cache">
		<link href="main.css" rel="stylesheet" type="text/css">
		<link href="css/color.css" rel="stylesheet" type="text/css">
  	</head>
  	<body>
		<table width="700" border="0" cellpadding="2" cellspacing="2" class="blockborder">
			<tr class="tableBackGround" align="center">
				<td height="20" width="200"><b>�ʼ�����</b></td>
				<td height="20" width="100"><b>������</b></td>
				<td height="20" width="200"><b>ʧ��ԭ��</b></td>
				<td height="20" width="100"><b>����ʱ��</b></td>
				<td height="20" width="100" align="center"><b>����</b></td>
			</tr>
			<%
				for(int i=0;i<mails.length;i++){
			%>
			<tr bgcolor="<%=(i%2==0)?"#f9f9f9":"#f7f7f7"%>">
				<td><%=mails[i][4]%></td>
				<td><%
					ValueObject[] uservos= dmo.queryByWhere(bd_user.class,"userid="+mails[i][3]);
					if(uservos.length==1){
						bd_user user=(bd_user)uservos[0];
						out.println(user.getUserName());
					}
				%></td>
				<td><%=mails[i][1]%></td>
				<td><%=mails[i][2]%></td>
				<td align="center"><a href="ReSendMail.do?mailUserID=<%=mails[i][0]%>">���·���</a></td>
			</tr>
			<%
				}
			%>
			</table>
	</body>
</html>
