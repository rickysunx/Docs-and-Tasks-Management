<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="core" prefix="pxl"%>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%@page import="com.pxl.pkb.framework.*"%>
<%@page import="com.pxl.pkb.vo.*"%>
<%@page import="com.pxl.pkb.biz.Doc"%>
<%
ppm_project[] ppmprojects =(ppm_project[])request.getAttribute("ppmprojects");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Pragma" content="no-cache">
<title>��Ŀ</title>
<link href="main.css" rel="stylesheet" type="text/css">
<link href="css/color.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/checkOnlyOne.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
 function changeStatus(projectId){
 if(confirm("��ȷ��Ҫ��������Ŀ\n�����ʼ�������Ŀ�µ�������Ŀ��Ա")){
  var projectStatus = document.getElementById("status"+projectId).value;
  $.post("AJAXAction.do?method=statu&projectId="+projectId+"&projectStatus="+projectStatus,null,callback);
  }
  return false;
 }
function callback(data){
 if(null!=data&&''!=data&&data!='undefined'){
  if(data=='2'){
      alert("δ�ҵ����°汾");
      return false; 
  }
     var str = data.split(",");
     if(str[0]==1){
     document.getElementById("m"+str[1]).style.display='none';
     document.getElementById("m"+str[1]).style.visibility='hidden';
     document.getElementById("mm"+str[1]).style.display='';
     document.getElementById("mm"+str[1]).style.visibility='visible';
     document.getElementById("status"+str[1]).value ='1';
     document.getElementById("editTask"+str[1]).style.display='none';
     document.getElementById("editTask"+str[1]).style.visibility='hidden';
     document.getElementById("selTask"+str[1]).style.display='';
     document.getElementById("selTask"+str[1]).style.visibility='visible';
     }else{
       document.getElementById("m"+str[1]).style.display='';
      document.getElementById("m"+str[1]).style.visibility='visible';
      document.getElementById("mm"+str[1]).style.display='none';
     document.getElementById("mm"+str[1]).style.visibility='hidden';
     document.getElementById("status"+str[1]).value ='0'; 
     document.getElementById("editTask"+str[1]).style.display='';
     document.getElementById("editTask"+str[1]).style.visibility='visible';
     document.getElementById("selTask"+str[1]).style.display='none';
     document.getElementById("selTask"+str[1]).style.visibility='hidden';
     }
     
 }
}
function edit(projectId){
  var projectstatu = document.getElementById("status"+projectId).value
   if(null!=projectstatu&&''!=projectstatu&&projectstatu!='undefined'){
      if(projectstatu==1){
         alert("��Ŀ�ѷ��������ܱ༭");
         return false;
      }else{
        return true;
      }
   }

} 
function modifyStatus(projectId){
if(confirm("��ȷ��Ҫ�޶�����Ŀ\n�����ʼ�������Ŀ�µ�������Ŀ��Ա")){
 if(null!=projectId&&''!=projectId&&projectId!='undefined'){
    $.post("AJAXAction.do?method=modifyStatu&projectId="+projectId,null,callback);
 }
}
return false;
}
</script>
</head>
<body class="body">
<jsp:include flush="true" page="header.jsp"></jsp:include>
<table class="bodytable" align="center"><tr><td>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td height="30"><a href="index.jsp">��ҳ</a>&nbsp;&gt;&nbsp;<a href="PPMproject.do?method=list&refproject=list">��Ŀ</a> </td>
</tr>
</table>
<table width="900"  border="0" cellpadding="2" cellspacing="2" class="blockborder">
	  <tr>
		<td height="20" class="tableBackGround">&nbsp;<span class="blocktitle">��Ŀ</span></td>
	  </tr>
	  <tr>
		<td height="20"><input type="button" value="������Ŀ" onclick="window.location.href='OpenJsp.do?forword=openProject'" ></td>
	  </tr>
</table>
<br>
<table width="900"  border="0" cellpadding="0" cellspacing="0">
	  <tr>
		<td height="25" width="20" class="tab_blank">&nbsp;</td>
		<td class="tab_active" width="120">
		<span class="tab_text">��Ŀ�б�</span>
		</td>
		<td class="tab_blank">&nbsp;</td>
	  </tr>
</table>
<table width="900" border="0" cellspacing="2" cellpadding="0">
  <tr>
    <td width="370" height="25">��Ŀ���</td>
    <td width="100" height="25">��Ŀ����</td>
    <td width="70" height="25">״̬</td>
    <td width="270"><div align="center">����</div></td>
  </tr>

	<tr>
    	<td height="2" colspan="5"><div class="listdotline"></div></td>
  	</tr>
  	<caption></caption>
  	<% 
  	  if(null!=ppmprojects&&!"".equals(ppmprojects)){
  	  	
  	  	for(int i=0;i<ppmprojects.length;i++){
  	  		ppm_project ppmproject = ppmprojects[i];
  	  		%>
  	  		<tr>
  	  	<td height="25">
  	  	 <a href='PPMproject.do?method=select&projectId=<%=ppmproject.getProjectID()%>' target='_blank'><%=ppmproject.getProjectCode()%></a></td>
  	  	 <td><%=ppmproject.getProjectName()%></td>
  	  	<td>
         <input type="hidden" id="status<%=ppmproject.getProjectID()%>" name="status" value="<%=ppmproject.getProjectStatus()%>" >	
  	  	<%
  	  	     int projectstatus =ppmproject.getProjectStatus();
  	  		    if(projectstatus==0){
  	  		    	out.print("<font id='m"+ppmproject.getProjectID()+"'>�༭��</font><font id='mm"+ppmproject.getProjectID()+"' style='visibility: hidden;display: none;' >�ѷ���</font>");
  	  		    }
  	  		    if(projectstatus==1){
  	  		    out.print("<font id='mm"+ppmproject.getProjectID()+"'>�ѷ���</font><font id='m"+ppmproject.getProjectID()+"' style='visibility: hidden;display: none;' >�༭��</font>");
  	  		    
  	  	     }
  	  	
  	  	
  	  	%></td>
  	    <td><div align="center">
  	    <a href="PPMproject.do?method=delete&projectId=<%=ppmproject.getProjectID()%>" onclick="return confirm('��ȷ��Ҫɾ������Ŀ');">ɾ��</a>
  	    <a href='PPMproject.do?method=modify&projectId=<%=ppmproject.getProjectID()%>' onclick="return edit('<%=ppmproject.getProjectID()%>');">�༭</a>
  	    <a href='PPMMember.do?method=list&projectId=<%=ppmproject.getProjectID()%>'>��Ŀ��Ա</a>
  	    <a href='#' onclick="return changeStatus('<%=ppmproject.getProjectID()%>');" >����</a>
  	    <a href='#' onclick="return modifyStatus('<%=ppmproject.getProjectID()%>')" >�޶�</a>
  	      <%if(ppmproject.getProjectStatus()==0){
  	    	  out.print("<a id='editTask"+ppmproject.getProjectID()+"' href='ppm_task.jsp?projectID="+ppmproject.getProjectID()+"' onclick=return edit('"+ppmproject.getProjectID()+"');>�༭����</a>");
    	      out.print("<a id='selTask"+ppmproject.getProjectID()+"' href='ppm_task.jsp?projectID="+ppmproject.getProjectID()+"' style='visibility: hidden;display: none;'>�鿴����</a>");
     	   }
  	       if(ppmproject.getProjectStatus()==1){
  	    	  out.print("<a id='editTask"+ppmproject.getProjectID()+"' style='visibility: hidden;display: none;' href='ppm_task.jsp?projectID="+ppmproject.getProjectID()+"' onclick=return edit('"+ppmproject.getProjectID()+"');>�༭����</a>");
    	      out.print("<a id='selTask"+ppmproject.getProjectID()+"' href='ppm_task.jsp?projectID="+ppmproject.getProjectID()+"'>�鿴����</a>");

  	      }
  	    %> 
  	    </div></td>
  	    </tr>
  	  		<%
  	  	}
  	  }else{
  		 %>
		   <td height="25" colspan="5" align="center" ><font color="red">����Ŀ��Ա</font></td>
		   <%
  	  }

  	%>
</table>
<br>
</td></tr></table>
<%@ include file="footer.jsp" %>
</body>
</html>