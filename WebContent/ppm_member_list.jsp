<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="core" prefix="pxl"%>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%@page import="com.pxl.pkb.framework.*"%>
<%@page import="com.pxl.pkb.vo.*"%>
<%@page import="com.pxl.pkb.biz.Doc"%>
<%
 ppm_member[] ppmmembers =(ppm_member[])request.getAttribute("ppmmembers");
 ppm_project project =(ppm_project)request.getAttribute("project");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Pragma" content="no-cache">
<title>��Ŀ��Ա</title>
<link href="main.css" rel="stylesheet" type="text/css">
<link href="css/color.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body class="body">
<jsp:include flush="true" page="header.jsp"></jsp:include>
<%String projectId =(String)request.getAttribute("projectId"); %>
<table class="bodytable" align="center"><tr><td>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td height="30"><a href="index.jsp">��ҳ</a>&nbsp;&gt;&nbsp;<a href="PPMproject.do?method=list&refproject=list">��Ŀ</a>&nbsp;&gt;&nbsp;��Ŀ��Ա</td>
</tr>
</table>
<table width="900"  border="0" cellpadding="2" cellspacing="2" class="blockborder">
	  <tr>
		<td height="20" class="tableBackGround">&nbsp;<span class="blocktitle">��Ŀ��Ա</span></td>
	  </tr>
	  <%
	   if(project!=null){
		  if(project.getProjectStatus()==0){
	%>
	   <tr>
		<td height="20"><input type="button" value="������Ŀ��Ա" onclick="window.location.href='OpenJsp.do?forword=openMember&projectId=<%=projectId%>'" /></td>
	  </tr>
	
	<%  }
	   }
	  %>
	  
</table>
<br>
<table width="900"  border="0" cellpadding="0" cellspacing="0">
	  <tr>
		<td height="25" width="20" class="tab_blank">&nbsp;</td>
		<td class="tab_active" width="120">
		<span class="tab_text">��Ŀ��Ա�б�</span>
		</td>
		<td class="tab_blank">&nbsp;</td>
	  </tr>
</table>
<table width="900" border="0" cellspacing="2" cellpadding="0">
  <tr>
    <td width="670" height="25">��Ա����</td>
    <%
    if(project!=null){
		  if(project.getProjectStatus()==0){
    %>
    <td width="70"><div align="center">����</div></td>
    <%  }
	   }
	  %>
  </tr>

	<tr>
    	<td height="2" colspan="4"><div class="listdotline"></div></td>
  	</tr>
  	<caption></caption>
  	<% 
  	   if(null!=ppmmembers&&!"".equals(ppmmembers)){  
  		 for(int i=0;i<ppmmembers.length;i++){
  	  		  ppm_member ppmmember = ppmmembers[i];
  	  		%>
  	  		<tr>
  	  	<td height="25">
  	  	 <a href='PPMMember.do?method=select&memberId=<%=ppmmember.getMemberID()%>' target='_blank'><%=ppmmember.getUserName()%></a></td>
  	   <%
    if(project!=null){
		  if(project.getProjectStatus()==0){
    %>
           <td><div align="center">
  	    <a href='PPMMember.do?method=modify&memberId=<%=ppmmember.getMemberID()%>' >�༭</a>&nbsp;&nbsp;
  	    <a href="PPMMember.do?method=delete&memberId=<%=ppmmember.getMemberID()%>" onclick="return confirm('��ȷ��Ҫɾ������Ŀ��Ա��')">ɾ��</a>
  	    </div></td>
  	    <%  }
	   }
	  %>
  	    </tr>
  	  		<%
  	  	}
  	   }else{
  		   %>
  		   <td height="25" colspan="3" align="center" ><font color="red">����Ŀ��Ա</font></td>
  		   <%
  	   }
  	
  	%>
</table>
<br>
</td></tr></table>
<%@ include file="footer.jsp" %>
</body>
</html>