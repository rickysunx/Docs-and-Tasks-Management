<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="com.pxl.pkb.vo.ppm_workdetail,java.util.List,com.pxl.pkb.vo.bd_user,com.pxl.pkb.extendvo.ppm_problemon,com.pxl.pkb.vo.ppm_output,com.pxl.ppm.framework.BeanFactory,com.pxl.ppm.itfs.IMember"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Pragma" content="no-cache">
<title>����</title>
<link href="main.css" rel="stylesheet" type="text/css">
<link href="css/color.css" rel="stylesheet" type="text/css">
</head>
<%
ppm_workdetail[] workdetails =(ppm_workdetail[])request.getAttribute("workdetail");
List  problemlist =(List)request.getAttribute("problemlist");
List outputlist =(List)request.getAttribute("outputlist");
%>
<body>
<font size="2" >[��ϸ��������]</font>
<br>
<table width='100%' class="ppm_task_table" border="0" cellpadding="2" cellspacing="1" id="mainTaskTable">
	<tr class="ppm_task_header" height="20px">
	    <td width="" >��д��</td>
       <td width="50px" align="center">�������</td>
		<td width="400px">��ϸ��������</td>
		<td width="150px" align="center">�����ص�</td>
		
	</tr>
	<%
	if(workdetails!=null){
		int personnum=0;
		for(int i=0;i<workdetails.length;i++){
			ppm_workdetail workdetail =workdetails[i];
			IMember mdom =(IMember)BeanFactory.getBean("Member");
			bd_user user = mdom.queryUserByID(workdetail.getUserID());  
			if(workdetail.getUserID()!=personnum){
				%>
				<tr class="ppm_task_rows" height="20px">
		        <td width="50px" align="center" colspan="4" ><%=user.getUserName()%></td>
	            </tr>	
				<%
			}
			personnum = workdetail.getUserID();
			%>
		<tr class="ppm_task_rows" height="20px">
		<td width="50px" align="center"></td>
		<td width="50px" align="center"><%=workdetail.getSeqNum()%></td>
		<td width="400px"><%=workdetail.getDetailContent()%></td>
		<td width="100px" align="center"><%=workdetail.getWorkAddress()%></td>
	    </tr>	
			<%
	   }
	}
	 
	
	%>			
</table>
<font size="2" >[������]</font>
<br>
<table width='100%' class="ppm_task_table" border="0" cellpadding="2" cellspacing="1" id="mainTaskTable">
	<tr class="ppm_task_header" height="20px">
       <td width="50px" align="center">���������</td>
		<td width="400px">����������</td>
		<td width="150px" align="center">����</td>
	</tr>
	<%
	if(outputlist!=null){
		for(int i=0;i<outputlist.size();i++){
			ppm_output output =(ppm_output)outputlist.get(i);
			%>
		<tr class="ppm_task_rows" height="20px">
		<td width="100px" align="center"><%=output.getSeqNum()%></td>
		<td width="300px"><%=output.getOutputName()%></td>
		<td width="100px" align="center">����</td>
	</tr>	
			<%
	   }
	}
	 
	
	%>			
</table>
<font size="2" >[�������⼰��������]</font>
<br>
<table width='100%' class="ppm_task_table" border="0" cellpadding="2" cellspacing="1" id="mainTaskTable">
	<tr class="ppm_task_header" height="20px">
       <td width="100px" align="center">����������</td>
		<td width="100px">˵��</td>
		<td width="100px">�������</td>
		<td width="100px">������</td>
		<td width="100px">�����</td>
		<td width="100px">Ԥ�ƽ��ʱ��</td>
		<td width="50px">���״̬</td>
	</tr>
	<%
	if(problemlist!=null){
		for(int i=0;i<problemlist.size();i++){
			ppm_problemon problemon =(ppm_problemon)problemlist.get(i);
			%>
		<tr class="ppm_task_rows" height="20px">
		 <td width="50px" align="center"><%=problemon.getProblemCode()%></td>
		<td width="200px"><%=problemon.getDescription()%></td>
		<td width="200px"><%=problemon.getPlan()%></td>
		<td width="100px"><%=problemon.getChargerName()%></td>
		<td width="100px"><%String[] useroper=problemon.getUseroper();
		 for(int j=0;j<useroper.length;j++){
			 if(j==(useroper.length-1)){
				 out.print(useroper[j]);
			 }else{
				 out.print(useroper[j]+",");
			 }
		 }
		%></td>
		<td width="100px"><%=problemon.getPlanTime()%></td>
		<td width="50px"><%
		int status = problemon.getProblemStatus();
		 if(status==0){
			 out.println("�ѽ��");
		 }else{
			 out.println("δ���");
		 }
		%></td>
	   </tr>	
			<%
	   }
	}
	 
	
	%>			
</table>
</body>
</html>