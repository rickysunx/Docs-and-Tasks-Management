<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%@page import="com.pxl.pkb.biz.Pub"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
if(!Pub.isAdminUser(session)) {
	throw new Exception("�ǹ���Ա�û����޷����ʣ�");
}
%>
<%
String strUserID = request.getParameter("userid");
int userid = Integer.parseInt(strUserID);
bd_user user = User.findUser(userid);
%>
<%@page import="com.pxl.pkb.vo.bd_user"%>
<%@page import="com.pxl.pkb.biz.User"%>
<%@page import="com.pxl.pkb.biz.Consts"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Pragma" content="no-cache">
<title>�û��༭</title>
<link href="main.css" rel="stylesheet" type="text/css">
<link href="css/color.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/city.js"></script>
<script type="text/javascript" src="js/userinfo.js"></script>
<script type="text/javascript">
	function lock(){
		setValues();
		frmUserManage.errorCount.value=5;
		frmUserManage.submit();
	};
	function unLock(){
		setValues();
		frmUserManage.errorCount.value=0;
		frmUserManage.submit();
	};
	function setValues(){
		var companyList=document.getElementById("companyList").value;
		var jobList=document.getElementById("jobList").value;
		var txtJob=document.getElementById("txtJob").value;
		var txtCompany=document.getElementById("txtCompany").value;
		if(companyList=="����"){
			document.getElementById("company").value=txtCompany;
		}else{
			document.getElementById("company").value=document.getElementById("companyList").value;
		}
		if(jobList=="����"){
			document.getElementById("job").value=txtJob;
		}else{
			document.getElementById("job").value=document.getElementById("jobList").value;
		}
	}
	function updateUser(){
		setValues();
		frmUserManage.submit();
	}
</script>
</head>
<body onload="showUserInfo();">
<table border="0" cellpadding="2" cellspacing="2">
<tr><td>��̨���� &gt; �û��༭ </td></tr>
</table>

<form id="frmUserManage" name="frmUserManage" action="UserManage.do?userType=admin" method="post" onsubmit="updateUser();">
<input id="userID" name="userID" type="hidden" value="<%=user.getUserID() %>">
<input id="returnPage" name="returnPage" type="hidden" value="admin_user_manager.jsp">
<table width="600" border="0" cellpadding="2" cellspacing="2" class="blockborder">
  <tr>
	<td height="20" class="tableBackGround" colspan="3">&nbsp;<span class="blocktitle">�û���Ϣ����</span></td>
  </tr>
  <tr>
  	<td height="20" width="60">��ʵ����</td>
  	<td width="300"><input id="userName" name="userName" type="text" class="logininput" value=<%=user.getUserName() %>></td>
  	<td class="helpRequired">����д���û�����ʵ����</td>
  </tr>
  <tr>
  	<td height="20">�Ա�</td>
  	<td><select id="sex" name="sex">
  	<option value="0"<%=user.getSex().equals("0")?" selected":"" %>>��</option>
  	<option value="1"<%=user.getSex().equals("1")?" selected":"" %>>Ů</option>
  	</select></td>
  	<td class="helpRequired">����д���û����Ա�</td>
  </tr>
  <tr>
  	<td height="20">����</td>
  	<td><input id="email" name="email" type="text" class="logininput" value="<%=user.getEMail()%>"></td>
  	<td class="helpRequired">����д���û������䣬���û�У��ɲ���</td>
  </tr>
  <tr>
  	<td height="20">�绰</td>
  	<td><input id="phone" name="phone" type="text" class="logininput" value="<%=user.getPhone()%>"></td>
  	<td class="helpRequired">����д���û���11λ�绰������ֻ����룬�ɲ���</td>
  </tr>
  <tr>
  	<td height="20">QQ</td>
  	<td><input id="qq" name="qq" type="text" class="logininput" value="<%=user.getQQ()%>"></td>
  	<td class="helpRequired">����д���û���QQ����</td>
  </tr>
  <tr>
  	<td height="20">MSN</td>
  	<td><input id="msn" name="msn" type="text" class="logininput" value="<%=user.getMSN()%>"></td>
  	<td class="helpRequired">����д���û���MSN����</td>
  </tr>
  <tr>
  	<td height="20">�û���ɫ</td>
  	<td><select id="isAdmin" name="isAdmin">
  	<%for(int i=0;i<Consts.ROLE_NAMES.length;i++) { 
  		out.println("<option value=\""+i+"\""+
  				(user.getIsAdmin().equals((""+i))?" selected":"")+">"+
  				Consts.ROLE_NAMES[i]+"</option>");
  	} %>
  	</select></td>
  	<td class="helpRequired">��ѡ����û����û���ɫ</td>
  </tr>
    <tr>
  	<td height="20">��ְ��˾</td>
  	<td height="20">
  		<select id="companyList" name="companyList" onchange="controlCompany();">
  			<option value="������">������</option>
  			<option value="���Ѽ���">���Ѽ���</option>
  			<option value="���ѷֹ�˾">���ѷֹ�˾</option>
  			<option value="����">����</option>
  		</select><br><span id="lblCompany">����д������ְ��˾��<input type="text" id="txtCompany"></span>
  		<input type="hidden" id="company" name="company" value="<%=user.getCompany()%>"/>
  	</td>
  	<td class="helpRequired">��ѡ��������ְ��˾������</td>
  </tr>
  <tr>
  	<td height="20">��ְ����</td>
  	<td height="20">
  		<select id="province" name="province" onchange="getCity(this.options[this.selectedIndex].value)">
  			<option value="������">������</option> 
	        <option value="�Ϻ���">�Ϻ���</option> 
	        <option value="�����">�����</option> 
	        <option value="������">������</option> 
	        <option value="�ӱ�ʡ">�ӱ�ʡ</option> 
	        <option value="ɽ��ʡ">ɽ��ʡ</option> 
	        <option value="���ɹ�������">���ɹ�������</option> 
	        <option value="����ʡ">����ʡ</option> 
	        <option value="����ʡ">����ʡ</option> 
	        <option value="������ʡ">������ʡ</option> 
	        <option value="����ʡ">����ʡ</option>
	        <option value="�㽭ʡ">�㽭ʡ</option>
	        <option value="����ʡ">����ʡ</option> 
	        <option value="����ʡ">����ʡ</option> 
	        <option value="����ʡ">����ʡ</option> 
	        <option value="ɽ��ʡ">ɽ��ʡ</option> 
	        <option value="����ʡ">����ʡ</option> 
	        <option value="����ʡ">����ʡ</option> 
	        <option value="����ʡ">����ʡ</option> 
	        <option value="�㶫ʡ">�㶫ʡ</option> 
	        <option value="����׳��������">����׳��������</option> 
	        <option value="����ʡ">����ʡ</option> 
	        <option value="�Ĵ�ʡ">�Ĵ�ʡ</option> 
	        <option value="����ʡ">����ʡ</option> 
	        <option value="����ʡ">����ʡ</option> 
	        <option value="����������">����������</option> 
	        <option value="����ʡ">����ʡ</option> 
	        <option value="����ʡ">����ʡ</option> 
	        <option value="���Ļ���������">���Ļ���������</option> 
	        <option value="�ຣʡ">�ຣʡ</option> 
	        <option value="�½�ά�����������">�½�ά�����������</option> 
	        <option value="����ر�������">����ر�������</option> 
	        <option value="�����ر�������">�����ر�������</option> 
	        <option value="̨��ʡ">̨��ʡ</option> 
  		</select>
  		<select id="city" name="city"></select>
  	</td>
  	<td class="helpRequired">��ѡ�����ĵ���ְ����������</td>
  </tr>
  <tr>
  	<td height="20">��ְ��λ</td>
  	<td height="20">
  		<select id="jobList" name="jobList" onchange="controlJob();">
  			<option value="ʵʩ">ʵʩ</option>
			<option value="����">����</option>
			<option value="����">����</option>
			<option value="����">����</option>
			<option value="��ά">��ά</option>
			<option value="��ǰ">��ǰ</option>
			<option value="����">����</option>
  		</select><br>
		<span id="lblJob">������������ְ��λ��<input type="text" id="txtJob"></span>	
		<input type="hidden" id="job" name="job" value="<%=user.getJob()%>"/>	
  	</td>
  	<td class="helpRequired">��ѡ�������ְ��λ������</td>
  </tr>
  <tr>
  	<td height="20">״̬</td>
  	<td>
  	<input type="hidden" id="errorCount" name="errorCount"/>
  	<%=user.getErrorCount()<5?"δ����&nbsp;&nbsp;<input type='button' value='����' onclick='lock();'/>":"������&nbsp;&nbsp;<input type='button' onclick='unLock();' value='����'/>"%>
  	</td>
  	<td class="helpRequired">�������/�������û��˺�</td>
  </tr>
  <tr>
  	<td height="20"></td>
  	<td>
  	<input type="submit" value=" ���� ">
  	<input type="button" value=" ���� " onclick="window.history.back();">
  	</td>
  </tr>
</table>
<script type="text/javascript">
	var companies=new Array("������","���Ѽ���","���ѷֹ�˾");
	var jobs=new Array("ʵʩ","����","����","����","��ά","��ǰ");
	function showUserInfo(){
		hidden();
		var companyList=document.getElementById("companyList").value;
		var company=document.getElementById("company").value;
		var province=document.getElementById("province").options;
		var city=document.getElementById("city").options;
		var job=document.getElementById("job").value;
		var companyCount=-1;
		var jobCount=-1;
		var provinceCount=-1;
		var cityCount=-1;
		for(var provinceIndex=0;provinceIndex<province.length;provinceIndex++){
			if(province[provinceIndex].text=="<%=user.getProvince()%>"){
				provinceCount=provinceIndex;
			}
		}
		for(var index=0;index<companies.length;index++){
			if(companies[index]==company){
				companyCount=index;
			}
		}
		for(var index=0;index<jobs.length;index++){
			if(jobs[index]==job){
				jobCount=index;
			}
		}
		if(companyCount!=-1){
			document.getElementById("companyList").selectedIndex=companyCount
		}else{
			document.getElementById("companyList").selectedIndex=3;
			document.getElementById("txtCompany").value=company;
		}
		if(jobCount!=-1){
			document.getElementById("jobList").selectedIndex=jobCount
		}else{
			document.getElementById("jobList").selectedIndex=6;
			document.getElementById("txtJob").value=job;
		}
		controlCompany();
		controlJob();
		if(provinceCount!=-1){
			document.getElementById("province").selectedIndex=provinceCount;
			getCity(document.getElementById("province").options[document.getElementById("province").selectedIndex].value);
			for(var cityIndex=0;cityIndex<city.length;cityIndex++){
				if(city[cityIndex].text=="<%=user.getCity()%>"){
					cityCount=cityIndex;
				}
			}
			if(cityCount!=-1){
				document.getElementById("city").selectedIndex=cityCount;
			}
		}
	}
</script>
</form>
</body>
</html>