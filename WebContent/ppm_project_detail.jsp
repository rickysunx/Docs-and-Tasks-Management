<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%@ page import="com.pxl.pkb.vo.ppm_project,com.pxl.pkb.vo.ppm_member"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Pragma" content="no-cache">
<title>��Ŀ��ϸҳ</title>
<link href="main.css" rel="stylesheet" type="text/css">
<link href="css/color.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
<script type="text/javascript">
function edit(projectstatu){
   if(null!=projectstatu&&''!=projectstatu&&projectstatu!='undefined'){
      if(projectstatu==1){
         alert("��Ŀ�ѷ��������ܱ༭");
         return false;
      }else{
        return true;
      }
   }

}
</script>
</head>
<body class="body">
<jsp:include flush="true" page="header.jsp" />
<table class="bodytable" align="center"><tr><td>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td height="30"><a href="index.jsp">��ҳ</a>&nbsp;&gt;&nbsp;<a href="PPMproject.do?method=list&refproject=list">��Ŀ</a>&nbsp;&gt;&nbsp;��Ŀ��ϸҳ</td>
</tr>
</table>
<%
 ppm_project ppmproject =(ppm_project)request.getAttribute("ppmproject");
ppm_member[] members =(ppm_member[])request.getAttribute("members");
%>
<table width="900" border="0" cellpadding="2" cellspacing="2" class="blockborder">
	  <tr>
		<td height="20" class="tableBackGround">
		<input id="fileName" type="hidden" value="<%=ppmproject.getProjectID()%>"/>
		<span class="blocktitle">��Ŀ��ϸ��Ϣ</span>
		</td>
	  </tr>
	  <tr>
		<td>
		<table width="100%" border="0" cellpadding="3" cellspacing="1">
		<tr>
			<td width="70" bgcolor="#ECF7DF" align="center" >��Ŀ����</td>
			<td bgcolor="#ECF7DF"><%=ppmproject.getProjectCode()%></td>
		</tr>
		<tr>
			<td bgcolor="#ECF7DF" align="center" valign="top">��Ŀ����</td>
			<td bgcolor="#ECF7DF"><%=ppmproject.getProjectName()%></td>
		</tr>
		<tr>
			<td bgcolor="#ECF7DF" align="center" valign="top">��Ŀ����</td>
			<td bgcolor="#ECF7DF"><%=ppmproject.getProjectValue()%></td>
		</tr>
		<tr>
			<td bgcolor="#ECF7DF" align="center">��ǰ�汾</td>
			<td bgcolor="#ECF7DF"><%=request.getAttribute("vername")%></td>
		</tr>
		<tr>
			<td bgcolor="#ECF7DF" align="center">����</td>
			<td bgcolor="#ECF7DF">
				<a href='PPMproject.do?method=modify&projectId=<%=ppmproject.getProjectID()%>' onclick="return edit('<%=ppmproject.getProjectStatus()%>');">�༭</a>
				<a href="PPMproject.do?method=delete&projectId=<%=ppmproject.getProjectID()%>" onclick="return confirm('��ȷ��Ҫɾ������Ŀ');">ɾ��</a>
			</td>
		</tr>
		</table>
		</td>
	  </tr>
</table><br/>
<table width="900" border="0" cellpadding="2" cellspacing="2" class="blockborder">
	  <tr>
		<td height="20" class="tableBackGround">
		<img src="images/filetype/allfile.png"> <span class="blocktitle">��Ŀ��Ա�б�</span>
		</td>
	  </tr>
	  <tr>
		<td>
		<table width="100%" border="0" cellpadding="2" cellspacing="1">
		<tr>
			<td width="200" align="left">��Ա���</td>
			<td align="right">����</td>
			<td width="100" align="center" >��λ</td>
			<td width="100" align="center" >ְ��</td>
			<td width="100" align="center">�ͻ���Ŀ��ɫ</td>
			<td width="100" align="center">������Ŀ��ɫ</td>
		</tr>
		<tr>
    		<td height="4" colspan="6"><div class="listdotline"></div></td>
  		</tr>
  		<%
  		if(members!=null&&members.length!=0){
  			for(int i=0;i<members.length;i++){
  				ppm_member member = members[i];
  				
  		%>
  		<tr>
			<td  width="200" align="left"><%=member.getMemberID()%></td>
			<td align="right"><%=member.getUserName()%></td>
			<td width="100" align="center" ><%=member.getUnit()%></td>
			<td width="100" align="center" ><%
			if(member.getPosition()!=null){
				out.println(member.getPosition());
			}%></td>
			<td width="100" align="center"><%
			if(member.getPosition()!=null){
				out.println(member.getCustRole());
			}%></td>
			<td width="100" align="center"><%=member.getUfidaRole()%></td>
		</tr>
  		<%	
  		 }
  		} else{
  		 %>
  			<tr>
			<td  colspan="6" ><font color="red" >û����Ŀ��Ա</font></td>
	        </tr>
  			<%
  			
  		}
  		%>
		
		</table>
		</td>
	  </tr>
</table>
</td></tr></table>
<%@ include file="footer.jsp" %>
</body>
</html>