<%@ page language="java" contentType="text/html;charset=GBK" pageEncoding="GBK"%>
<%@ page import="java.util.List,com.pxl.pkb.extendvo.ppm_taskon,com.pxl.ppm.itfs.IProject,com.pxl.ppm.framework.BeanFactory,com.pxl.pkb.vo.ppm_project" %>
<%@ page import="com.pxl.pkb.biz.Pub,java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Pragma" content="no-cache">
<title>��Ŀ</title>
<link href="main.css" rel="stylesheet" type="text/css">
<link href="css/color.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
.tab{
	cellSpacing:expression(this.cellSpacing=0);   
	cellPadding:expression(this.cellPadding=0);
	margin-top: 5px;
	border: 1px solid #D5D5D5;
	border-bottom:1px solid #D5D5D5;
	border-left:1px solid #D5D5D5;
	border-collapse:collapse;
	text-align:center
}
.tab td {
	margin:2px;
	height:25px;
	border-bottom: 1px solid #D5D5D5;
	border-left: 1px solid #D5D5D5;
}
.TableHeader {
	BACKGROUND: #D5D5D5;
	font-weight: bold;
	height:28px;
}
</style>
<script type="text/javascript">
function showDialog(url,cwidth,cheight)
{  
    var date = new Date();
    url = url+"&date="+date;
 	canshu="dialogHeight:400px; dialogWidth:500px; center:yes; resizable:yes; status:no";
	 url = encodeURI(url);    
     url = encodeURI(url);
     window.showModalDialog(url,window,canshu); 
}

function opendiv(taskId){
  if(null!=taskId&&''!=taskId&&taskId!='undefined'){
      document.getElementById('div'+taskId).style.display='';
      document.getElementById('div'+taskId).style.visibility='visible';
      document.getElementById('imgopen'+taskId).style.display='none';
      document.getElementById('imgopen'+taskId).style.visibility='hidden';
      document.getElementById('imgclose'+taskId).style.display='';
      document.getElementById('imgclose'+taskId).style.visibility='visible';
  }
}
function closediv(taskId){
  if(null!=taskId&&''!=taskId&&taskId!='undefined'){
   document.getElementById('div'+taskId).style.display='none';
   document.getElementById('div'+taskId).style.visibility='hidden';
    document.getElementById('imgopen'+taskId).style.display='';
   document.getElementById('imgopen'+taskId).style.visibility='visible';
   document.getElementById('imgclose'+taskId).style.display='none';
   document.getElementById('imgclose'+taskId).style.visibility='hidden';
  }
}

function addproject(proresult){
  if(proresult!=null&&''!=proresult&&proresult!='undefined'){
     document.getElementById("projectselid").value=proresult.selids;
     document.getElementById("projectselname").value=proresult.selnames;
    }
}
function addmember(proresult){
  if(proresult!=null&&''!=proresult&&proresult!='undefined'){
     document.getElementById("memberselid").value=proresult.selids;
     document.getElementById("memberselname").value=proresult.selnames;
    }
}

function checkTerm(){
	var projectselid = document.getElementById("projectselid").value;
	var memberselid = document.getElementById("memberselid").value;
	var startdate = document.getElementById("startdate").value;
	var enddate = document.getElementById("enddate").value;
	if((projectselid==''||projectselid==null||projectselid=='undefined')&&(memberselid==''||memberselid==null||memberselid=='undefined')&&(startdate==''||startdate==null||startdate=='undefined')&&(enddate==''||enddate==null||enddate=='undefined')){
            alert("��ѡ������");
			return false;
	}else{
	     if((startdate==''||startdate==null||startdate=='undefined')&&(enddate!=''&&enddate!=null&&enddate!='undefined')){
	             alert("��ѡ��ʼ����");
	        return false;
	     }else 
	     if((startdate!=''&&startdate!=null&&startdate!='undefined')&&(enddate==''||enddate==null||enddate=='undefined')){
	             alert("��ѡ���������");
	        return false;
	     }
	 window.location.href="PPMTask.do?method=querylist&projectselid="+projectselid+"&memberselid="+memberselid+"&startdate="+startdate+"&enddate="+enddate;
	}
} 
</script>
</head>
<body class="body" >
<jsp:include flush="true" page="header.jsp"></jsp:include>
<table class="bodytable" align="center">
<tr><td>
<table border="0" cellpadding="0" cellspacing="0">
<tr>
<td height="30"><a href="index.jsp">��ҳ</a>&nbsp;&gt;&nbsp;������־��ѯ</td>
</tr>
</table>
<table  width="100%" border="0" cellpadding="2" cellspacing="2" class="blockborder">
	  <tr>
		<td height="20" class="tableBackGround">&nbsp;<span class="blocktitle">������־</span></td>
	  </tr>
      <tr>
		<td height="20">&nbsp;<span>
		��Ŀ���ƣ�
		<input type="text" readonly="readonly" id="projectselname" name="projectselname" size="10" onfocus="showDialog('PPMproject.do?method=list&refproject=sele','620','290')"/>
		&nbsp;��ʼ���ڣ�<input type='text' name='startdate' id='startdate' size="10" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
		&nbsp;�������ڣ�<input type='text' name='enddate' id='enddate' size="10" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
		&nbsp;��Ŀ��Ա��<input type='text' name='memberselname' readonly="readonly" id='memberselname' size="10" onfocus="showDialog('PPMMember.do?method=choseUser&tag=worklogs','620','290')" />
		&nbsp;&nbsp;<input type='button' value="��ѯ" onclick="return checkTerm(this);" />
		<input type="hidden" id="projectselid" name="projectselid" size="10"/>
		<input type="hidden" id="memberselid" name="memberselid" size="10"/>
		</span></td>
	  </tr>
</table>
<br>
<%List taskonlist = (List)request.getAttribute("taskonlist");
  ppm_taskon[] taskons =(ppm_taskon[])request.getAttribute("taskons");
  String[][] usernames =(String[][])request.getAttribute("usernames");
  String userId = (String)request.getAttribute("userId");
%>
<table class="ppm_task_table" border="0" cellpadding="2" cellspacing="1" id="mainTaskTable">
	<tr class="ppm_task_header" height="20px">
	
		<td width="50px" align="center">��������</td>
		<td width="380px">��������</td>
		<td width="100px" align="center">��������</td>
		<td width="120px" align="center">��ʼʱ��</td>
		<td width="120px" align="center">����ʱ��</td>
		<td width="60px" align="center">����</td>
		<td width="50px" align="center">������</td>
		<td width="70px" align="center">�ڲ�������</td>
		<td width="80px" align="center">�����</td>
		<td width="80px" align="center">ǰ������</td>
	</tr>		
<%
       int projectId =0;
       int countIndex = 0;
       for(int i=0;i<taskonlist.size();i++){
    	     ppm_taskon taskon =(ppm_taskon)taskonlist.get(i);
    	   if(taskon.getParentTaskID()==0&&taskon.getProjectID()!=projectId){
    		   IProject pdom =(IProject)BeanFactory.getBean("Project");
    		   ppm_project project = pdom.queryByID(taskon.getProjectID());  
            %>
    	       <tr class="ppm_task_rows" height="20px">
    	         <td width="50px" align="center"><%=project.getProjectName()%></td>
    	         <td width="150px" colspan="9"></td>
    	       </tr>
    	    <%
    	    }
    	    projectId = taskon.getProjectID();
            %>
    	    <tr class="ppm_task_rows" height="20px">
    	    <td></td>
                 <%
  	 boolean flag =Pub.getTaskon3(taskons,taskon.getTaskID());
     if(flag==true){
  		 %>
  		  <td >
  		  <% 
  		  if(taskon.getParentTaskID()!=0){
  		   for(int j=0;j<countIndex;j++){
  			 %>
  			    &nbsp;
  		   	 <%
  		      }
  		  }else{
  			countIndex=0;
  			%>
  			<img src="images/xtree/root.gif" />
  			<%
  		  }
  		  %>
  		  <img src="images/xtree/Tplus.png" id="imgopen<%=taskon.getTaskID()%>" style="cursor: hand;" onclick="javaScript:opendiv('<%=taskon.getTaskID()%>');" />
          <img src="images/xtree/Tminus.png" id="imgclose<%=taskon.getTaskID()%>"  style="visibility: hidden;display: none;cursor: hand" onclick="javaScript:closediv('<%=taskon.getTaskID()%>');" >	
	      <%=taskon.getTaskTitle()%>
	   </td>
  		 <%
  	 }else{
  		 %>
  		 <td>
  		 <%
  		 if(taskon.getParentTaskID()==0){
  			countIndex=0;
  			 %>
	        <img src="images/xtree/root.gif" /><%=taskon.getTaskTitle()%>
	      <%
  		 }
  		 for(int j=0;j<countIndex;j++){
  			 if(j+1==countIndex){
  				 %>
  				<img src="images/xtree/Tminus.png">
  				 <%
  				   out.print(taskon.getTaskTitle());
  			 }else{ %>
  			    &nbsp;
  			 <%
  			 }
  		 }
  		 countIndex++;
  		 %>
  		 </td>
  		 <%
  	 }
  		 %>
		         <td width="100px" align="center"><%=taskon.getTaskType()%></td>
		         <td width="120px" align="center"><%=taskon.getStartTime()%></td>
		         <td width="120px" align="center"><%=taskon.getEndTime()%></td>
		         <td width="60px" align="center"><%=taskon.getTimeSpan()%></td>
		         <td width="50px" align="center"><%=taskon.getChargename()%></td>
		         <td width="70px" align="center"><%=taskon.getPxlUsername()%></td>
		         <td width="80px" align="center"> <%
		if(usernames!=null&&usernames.length!=0){
			List userlist = new ArrayList();
			 for(int m=0;m<usernames[i].length;m++){

		    	   String username = usernames[i][m];
		    		   if(null!=username&&!"".equals(username)){
		    			userlist.add(username);
		    	       }
		       }
		       for(int n=0;n<userlist.size();n++){
		    	      if(n==userlist.size()-1){
		    	    	  out.print(userlist.get(n));
		    	      }else{
		    	    	  out.print(userlist.get(n)+",");
		    	      }
		    		
				}
		     if(usernames[i]==null||usernames[i].length==0){
		    	 out.println("&nbsp;");
		     }
		}else{
			out.println("&nbsp;");
		}
      
       %> </td>
       <td width="80px" align="center">&nbsp;</td>
       </tr>   
    	   <%
    	   if(flag==true){
    		   %>
    	   <tr class="ppm_task_rows"><td>&nbsp;</td>
    	    <td colspan="8">
    	     <div style="display: none;visibility: hidden" id="div<%=taskon.getTaskID()%>">
    	      <%
    	     for(int j=0;j<countIndex;j++){
      			 %>
      			 &nbsp;
      		   	 <%
      		      }
    	    	  %>
    	     <iframe id="worklogquery<%=taskon.getTaskID()%>" name="worklogquery"  src="PPMTask.do?method=queryworklog&userId=<%=userId%>&taskId=<%=taskon.getTaskID()%>" frameborder=0  style="width:100%; height:300px;top:0px; " scrolling=yes></iframe>
    	    </div>
    	   </td>
    	   <td>&nbsp;</td>
    	   </tr>
    		   <%
    	   }
       }
%>
		
</table>
<table border="0">
<tr>
	<td height="300px;">&nbsp;</td>
</tr>
</table>

</body>
<jsp:include flush="true" page="footer.jsp"></jsp:include>
</html>