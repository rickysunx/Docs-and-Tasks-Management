<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%@page import="com.pxl.pkb.vo.ppm_project"%>
<%@page import="com.pxl.pkb.biz.Pub"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
if(Pub.isUnCheckUser(session)) {
	throw new Exception("�����û���δͨ����ˣ����ܽ����½��ĵ���");
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Pragma" content="no-cache">
<title>�༭��Ŀ</title>
<link href="main.css" rel="stylesheet" type="text/css">
<link href="css/color.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="upload.js"></script>
<link href="xtree/xtree.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="xtree/xtree.js"></script>
<script type="text/javascript" src="xtree/webfxcheckboxtreeitem.js"></script>
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
<script type="text/javascript">
  function check(){
    var projectCode = document.getElementById("projectCode").value;
    var projectName = document.getElementById("projectName").value;
     var projectstatu = document.getElementById("projectstatu").value;
    if(projectCode!=null&&projectCode!=''&&projectCode!='undefined'){
           if(projectName!=null&&projectName!=''&&projectName!='undefined'){
                  if(projectstatu!=null&&projectstatu!=''&&projectstatu!='undefined'){
                      if(projectstatu=='0'){
                            return true;
                        }else{
                           alert("����Ŀ�ѷ������޷��༭");
                             return false;
                        }
                  }else{
                     return false;
                  }
           }else{
               document.getElementById("checkName").style.display='';
               document.getElementById("checkName").style.visibility='visible';
               return false;
           }
    
    }else{
             document.getElementById("checkCode").style.display='';
             document.getElementById("checkCode").style.visibility='visible';
             return false;
    }
 } 

function ongoFormOk(codename){
   if(codename=='projectCode'){
     var projectCode = document.getElementById("projectCode").value;
     if(projectCode!=null&&projectCode!=''&&projectCode!='undefined'){
         document.getElementById("checkCode").style.display='none';
       document.getElementById("checkCode").style.visibility='hidden';
     }
   }
   if(codename=='projectName'){
     var projectName = document.getElementById("projectName").value;
     if(projectName!=null&&projectName!=''&&projectName!='undefined'){
         document.getElementById("checkName").style.display='none';
       document.getElementById("checkName").style.visibility='hidden';
     }
   }
}
</script>
</head>
<body class="body">
<%@ include file="header.jsp" %>
<%ppm_project ppmproject=(ppm_project)request.getAttribute("ppmproject"); %>
<table class="bodytable" align="center">
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="30"><a href="index.jsp">��ҳ</a>&nbsp;&gt;&nbsp;<a href="PPMproject.do?method=list&refproject=list">��Ŀ</a>&nbsp;&gt;&nbsp;�༭��Ŀ </td>
				</tr>
			</table>
			
			<form id="frmDocAdd" name="frmDocAdd" action="PPMproject.do?method=update" method="post">
				<table width="900" border="0" cellpadding="2" cellspacing="2" class="blockborder">
					<tr>
						<td height="20" class="tableBackGround" colspan="2">&nbsp;<span class="blocktitle">�༭��Ŀ</span></td>
				  	</tr>
			  		<tr>
			  			<td>
			  				<table border="0" cellpadding="0" cellspacing="0">
			  					<tr>
			  						<td rowspan="2" valign="top">
			  							<table>
			  							     
			  								<tr>
												<td height="20" align="center">��Ŀ����</td>
												<td height="20">
												<input type="hidden"  value="<%=ppmproject.getProjectID()%>" name="projectID" id="projectID"/>
												<input type="hidden" name="projectCode" id="projectCode" value="<%=ppmproject.getProjectCode()%>" />
												<input type="text"  value="<%=ppmproject.getProjectCode()%>"  style="width: 300px;height: 15px;" disabled="disabled" >
												<span id="checkCode" style="display: none;visibility:hidden;" ><font color="red">��Ŀ���벻��Ϊ��</font></span>
												<span id="codeCheck" style="display: none;visibility:hidden;"><font color="red">�˱����Ѵ���</font><input type="hidden" name="codevalue" value="0" id="codevalue"></span>
												<input type="hidden" name="projectstatu" id="projectstatu" value="<%=ppmproject.getProjectStatus()%>" />
												</td>
										  	</tr>
										  	<tr>
												<td height="20" align="center">��Ŀ����</td>
												<td height="20"><input id="projectName" type="text" name="projectName" value="<%=ppmproject.getProjectName()%>"  style="width: 300px;height: 15px;" onblur="javaScript:ongoFormOk('projectName');" >
												<span id="checkName" style="display: none;visibility:hidden;" ><font color="red">��Ŀ���Ʋ���Ϊ��</font></span>
												</td>
										  	</tr>
										  	<tr>
												<td height="20" align="center">��Ŀ����</td>
												<td height="20"><input type="text" disabled="disabled"  value="<%=ppmproject.ProjectValue%>"  /></td>
										  	</tr>
										  	<tr>
												<td height="20" align="center" valign="top"></td>
												<td height="20"><input type="submit" value="�ύ��Ŀ" onclick="return check();"  ></td>
										  	</tr>  
			  							</table>
			  						</td>
			  					</tr>
			  				</table>
			  			</td>
			  		</tr>
				</table>
			</form>
		</td>
	</tr>
</table>
<%@ include file="footer.jsp" %>
</body>
</html>