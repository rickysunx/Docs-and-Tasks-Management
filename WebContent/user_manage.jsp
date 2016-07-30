<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page errorPage="ExceptionHandler.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
bd_user loginUser = (bd_user)session.getAttribute(Consts.PKB_USER_SESSION_NAME);
bd_user user = User.findUser(loginUser.getUserID());
%>
<%@page import="com.pxl.pkb.biz.User"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Pragma" content="no-cache">
<title>�û���Ϣ����</title>
<link href="main.css" rel="stylesheet" type="text/css">
<link href="css/color.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/city.js"></script>
<script type="text/javascript" src="js/userinfo.js"></script>
<script type="text/javascript">
<%
Object objSaveInf = request.getAttribute("SaveInf");
if(objSaveInf!=null) {
	out.println("alert('"+objSaveInf+"');");
}
%>

	function onUserRegFormCheck(){
		var _passWord=document.getElementById("passWord").value;
		var _passWord2=document.getElementById("passWord2").value;
		var _userName=document.getElementById("userName").value;
		var _email=document.getElementById("email").value;
		var _companyList=document.getElementById("companyList").value;
		var _txtCompany=document.getElementById("txtCompany").value;
		var _jobList=document.getElementById("jobList").value;
		var _txtJob=document.getElementById("txtJob").value;
		
		var passWord=_passWord.replace(/\s/g,'');
		var passWord2=_passWord2.replace(/\s/g,'');
		var userName=_userName.replace(/\s/g,'');
		var email=_email.replace(/\s/g,'');
		var txtCompany=_txtCompany.replace(/\s/g,'');
		var txtJob=_txtJob.replace(/\s/g,'');
		
		var re_Password=/[a-z]|[A-Z]|([a-z,A-Z])/;
		var _rePassword=/\d/;
		
		var re_email=/^([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		
		if(_userName.length<=0){
			alert("��ʵ��������");
			return false;
		}else if(_userName.length!=userName.length){
			alert("��ʵ�����������пո�");
			return false;
		}else if(email.length==0||email==""){
			alert("�����ַ����");
			return false;
		}else if(re_email.test(email)==false){
			alert("�����ַ����ȷ");
			return false;
		}else if(_companyList=="����"&&_txtCompany.length==0){
			alert("����д������ְ��˾");
			return false;
		}else if(_companyList=="����"&&(_txtCompany.length!=txtCompany.length)){
			alert("��ְ��˾�������пո�");
			return false;
		}else if(_jobList=="����"&&_txtJob.length==0){
			alert("����д������ְ��λ");
			return false;
		}else if(_jobList=="����"&&(_txtJob.length!=_txtJob.length)){
			alert("��ְ��λ�������пո�");
			return false;
		}else{
			if(_companyList=="����"){
				document.getElementById("company").value=_txtCompany;
			}else{
				document.getElementById("company").value=document.getElementById("companyList").value;
			}
			if(_jobList=="����"){
				document.getElementById("job").value=_txtJob;
			}else{
				document.getElementById("job").value=document.getElementById("jobList").value;
			}
			return true;
		}
	}
</script>
</head>
<body class="body" onload="showUserInfo();">
<%@ include file="header.jsp" %>
<table class="bodytable" align="center"><tr><td>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td height="30"><a href="index.jsp">��ҳ</a> &gt; �û���Ϣ���� </td>
</tr>
</table>
<form id="frmUserManage" name="frmUserManage" action="UserManage.do" method="post" onsubmit="return onUserRegFormCheck();">
<input id="userID" name="userID" type="hidden" value="<%=user.getUserID() %>">
<table width="900" border="0" cellpadding="2" cellspacing="2" class="blockborder">
  <tr>
	<td height="20" class="tableBackGround" colspan="3">&nbsp;<span class="blocktitle">�û���Ϣ����</span></td>
  </tr>
  <tr>
  	<td height="20" width="60">��ʵ����</td>
  	<td><input id="userName" name="userName" type="text" class="logininput" value=<%=user.getUserName() %>></td>
  	<td class="helpRequired">������������ʵ����</td>
  </tr>
  <tr>
  	<td height="20">����</td>
  	<td><input id="passWord" name="passWord" type="password" class="logininput"></td>
  	<td class="helpRequired">���������������룬������ģ�������</td>
  </tr>
  <tr>
  	<td height="20">�ظ�����</td>
  	<td><input id="passWord2" name="passWord2" type="password" class="logininput"></td>
  	<td class="helpRequired">�ظ��������������һ��</td>
  </tr>
  <tr>
  	<td height="20">�Ա�</td>
  	<td><select id="sex" name="sex">
  	<option value="0"<%=user.getSex().equals("0")?" selected":"" %>>��</option>
  	<option value="1"<%=user.getSex().equals("1")?" selected":"" %>>Ů</option>
  	</select></td>
  	<td class="helpRequired">��ѡ�������Ա�</td>
  </tr>
  <tr>
  	<td height="20">����</td>
  	<td><input id="email" name="email" type="text" class="logininput" value="<%=user.getEMail()%>"></td>
  	<td class="helpRequired">��������������</td>
  </tr>
  <tr>
  	<td height="20">�绰</td>
  	<td><input id="phone" name="phone" type="text" class="logininput" value="<%=user.getPhone()%>"></td>
  	<td class="helpRequired">���������11λ�绰������ֻ����룬���û�пɲ���</td>
  </tr>
  <tr>
  	<td height="20">QQ</td>
  	<td><input id="qq" name="qq" type="text" class="logininput" value="<%=user.getQQ()%>"></td>
  	<td class="helpRequired">����������QQ���룬���û�У��ɲ���</td>
  </tr>
  <tr>
  	<td height="20">MSN</td>
  	<td><input id="msn" name="msn" type="text" class="logininput" value="<%=user.getMSN()%>"></td>
  	<td class="helpRequired">����������MSN���룬���û�У��ɲ���</td>
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
  	<td height="20">.</td>
  	<td colspan="2"><input type="submit" value=" ���� ">&nbsp;&nbsp;<input type="button" value=" ���� " onclick="window.location.href='index.jsp'"/></td>
  </tr>
</table>
</form>
<br>
</td></tr></table>
<script type="text/javascript">
	var companies=new Array("������","���Ѽ���","���ѷֹ�˾");
	var jobs=new Array("ʵʩ","����","����","����","��ά","��ǰ");
	function showUserInfo(){
		hidden();
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
			document.getElementById("companyList").selectedIndex=companyCount;
		}else{
			document.getElementById("companyList").selectedIndex=3;
			document.getElementById("txtCompany").value=company;
		}
		if(jobCount!=-1){
			document.getElementById("jobList").selectedIndex=jobCount;
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
<%@ include file="footer.jsp" %>
</body>
</html>