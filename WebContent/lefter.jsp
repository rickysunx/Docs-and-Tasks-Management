<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%@page import="com.pxl.pkb.biz.Consts"%>
<form action="Search.do" method="get">
	<table width="100%" align="center">
		<tr align="center">
			<td height="70" valign="middle" width="250">
				<input name="keyword" id="keyword" type="text" size="16"/>&nbsp;
				<select id="searchType" name="searchType">
					<option value="0">ȫ��</option>
					<option value="1">�ʴ�</option>
					<option value="2">�ĵ�</option>
				</select>
			</td>
		</tr>
		<tr align="center">
	    	<td height="30">
	    		<%if(session.getAttribute(Consts.PKB_USER_SESSION_NAME)!=null){ %>
	    		<input type="image" alt="��Ҫ��֪" src="images/knowledge_ico.gif"/>&nbsp;&nbsp;&nbsp;
	    		<input type="image" alt="��Ҫ��֪" src="images/knowledge_button.png"/>
	    		<%}else{%>
	    		<img src="images/knowledge_ico.gif" alt="��Ҫ��֪" onclick="alert('����δ��½�����ȵ�½')"/>&nbsp;&nbsp;&nbsp;
	    		<img src="images/knowledge_button.png" alt="��Ҫ��֪" onclick="alert('����δ��½�����ȵ�½')"/>
	    		<%}%>
	    	</td>
		</tr>
		<tr align="center">
			<td height="2">
				<table width="170"><tr><td><div class="listdotline"></div></td></tr></table>
			</td>
		</tr>
		<tr align="center">
			<td height="30">
				<%if(session.getAttribute(Consts.PKB_USER_SESSION_NAME)!=null){ %>
				<img src="images/qst_ico.gif" alt="��������" style="cursor: hand;" onclick="window.location.href='ask_qst_add.jsp'"/>&nbsp;&nbsp;&nbsp;
				<img src="images/qst_button.png" alt="��������" style="cursor: hand;" onclick="window.location.href='ask_qst_add.jsp'"/>
				<%}else{%>
				<img src="images/qst_ico.gif" alt="��������" onclick="alert('����δ��½�����ȵ�½');"/>&nbsp;&nbsp;&nbsp;
				<img src="images/qst_button.png" alt="��������" onclick="alert('����δ��½�����ȵ�½');"/>
				<%}%>
			</td>
		</tr>
		<tr align="center">
			<td height="2">
				<table width="170"><tr><td><div class="listdotline"></div></td></tr></table>
			</td>
		</tr>
		<tr align="center">
			<td height="30">
				<%if(session.getAttribute(Consts.PKB_USER_SESSION_NAME)!=null){ %>
				<img src="images/doc_ico.gif" style="cursor: hand;" alt="�Ҵ��ĵ�" onclick="window.location.href='doc_add.jsp'"/>&nbsp;&nbsp;&nbsp;
				<img src="images/doc_button.png" style="cursor: hand;" alt="�Ҵ��ĵ�" onclick="window.location.href='doc_add.jsp'"/>
				<%}else{%>
				<img src="images/doc_ico.gif" alt="�Ҵ��ĵ�" onclick="alert('����δ��½�����ȵ�½');"/>&nbsp;&nbsp;&nbsp;
				<img src="images/doc_button.png" alt="�Ҵ��ĵ�" onclick="alert('����δ��½�����ȵ�½');"/>
				<%}%>
			</td>
		</tr>
		<tr align="center">
			<td height="2">
				<table width="170"><tr><td><div class="listdotline"></div></td></tr></table>
			</td>
		</tr>
	</table>
</form>