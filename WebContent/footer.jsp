<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%@page import="com.pxl.pkb.biz.Consts"%>
<table align="center" width="1024" border="0" bgcolor="white" id="footerTable">
	<tr>
		<td style="background-image: url('images/footer_back.gif')" height="28">&nbsp;&nbsp;
			<a class='foota' href='pxl_about.jsp'>����������</a>&nbsp;&nbsp;
			<a class='foota' href='pxl_hr.jsp'>������ʿ</a>&nbsp;&nbsp;
			<a class='foota' href='#'>��ϵ����</a>&nbsp;&nbsp;
			<a class='foota' href='#'>��Ȩ��Լ</a>&nbsp;&nbsp;
			<%
			if(session.getAttribute(Consts.PKB_USER_SESSION_NAME)!=null) {
			%>
			<a class='foota' href='pxl_setup.exe'>���ؿͻ���</a>&nbsp;&nbsp;
			<%
			}
			%>
		</td>
	</tr>
	<tr align="center">
		<td height="20"><a href="http://www.miibeian.gov.cn/" target="_blank">��ICP��10049567��</a></td>
	</tr>
</table>