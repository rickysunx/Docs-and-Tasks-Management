<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.pxl.ppm.itfs.ITask"%>
<%@page import="com.pxl.ppm.framework.BeanFactory"%>
<%@page import="com.pxl.pkb.vo.ppm_task"%>
<%@page import="com.pxl.ppm.itfs.IMember"%>
<%@page import="com.pxl.pkb.vo.ppm_member"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.pxl.pkb.biz.TaskUtils"%>
<%@page import="com.pxl.pkb.vo.ppm_project"%>
<%@page import="com.pxl.ppm.itfs.IProject"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String strProjectID = request.getParameter("projectID");
int projectID = Integer.parseInt(strProjectID);
IProject projectService = (IProject) BeanFactory.getBean("Project");
ppm_project project = projectService.queryByID(projectID);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Pragma" content="no-cache">
<title>����</title>
<link href="main.css" rel="stylesheet" type="text/css">
<link href="css/color.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
var projectID = <%=projectID%>;
var taskEditable = <%=(project.getProjectStatus()==0)?"true":"false"%>;

function tt_init_data(tt) {

	var o;
<%
	ITask taskService = (ITask) BeanFactory.getBean("Task");
	IMember memberService = (IMember) BeanFactory.getBean("Member");
	
	ppm_member [] members = memberService.queryMemberByProject(projectID);
	HashMap hmMember = new HashMap();
	
	for(int i=0;i<members.length;i++) {
		hmMember.put(new Integer(members[i].getMemberID()),members[i].getUserName());
	}
	
	ppm_task [] tasks = taskService.queryTaskByProject(projectID);
	for(int i=0;i<tasks.length;i++) {
		ppm_task t = tasks[i];
		String [] assist = taskService.queryAssistsByTaskID(t.getTaskID());
%>
	o = new Object();
	o.oid=-1;
	o.selected = false;
	o.taskID = <%=t.getTaskID()%>;
	o.seqNum = <%=t.getSeqNum()%>;
	o.parentTaskID = <%=t.getParentTaskID()%>;
	o.taskTitle = '<%=t.getTaskTitle()%>';
	o.taskType = <%=t.getTaskType()%>;
	o.taskTypeName = '<%=TaskUtils.getTaskTypeNameByID(t.getTaskType())%>';
	o.startTime = '<%=t.getStartTime()%>';
	o.endTime = '<%=t.getEndTime()%>';
	o.timeSpan = '<%= new Double(t.getTimeSpan()).toString()%>';
	o.charger = <%=t.getCharger()%>;
	o.chargerName = '<%=hmMember.get(new Integer(t.getCharger()))%>';
	o.pxlCharger = <%=t.getPxlCharger()%>;
	o.pxlChargerName = '<%=hmMember.get(new Integer(t.getPxlCharger()))%>';
	o.assist = '<%=assist[0]%>';
	o.assistName = '<%=assist[1]%>';
	o.preTaskID = <%=t.getPreTaskID()%>;
	o.notes = '<%=t.getNotes()==null?"":t.getNotes()%>';
	tt_addRow(getTaskTable(),o);
<%
	}
%>
	tt_refreshLevel(getTaskTable());
	tt_refreshPreTask(getTaskTable());
}

</script>
<script type="text/javascript" src="js/dateandtime.js"></script>
<script type="text/javascript" src="ppm_task.js"></script>
</head>
<body class="body" onload="onBodyLoad();">
<%@ include file="header.jsp" %>
<iframe name="task_iframe" style="display: none;"></iframe>
<table class="bodytable1" align="center"><tr><td>
<textarea id="debugInfo" style="display: none;"></textarea>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td height="30"><a href="index.jsp">��ҳ</a>&nbsp;&gt;&nbsp;<a href='PPMproject.do?method=list&refproject=list'>��Ŀ</a>&nbsp;&gt;&nbsp;����
		</td>
	</tr>
</table>

<table width="900"  border="0" cellpadding="2" cellspacing="2" class="blockborder">
	<tr>
		<td height="20" class="tableBackGround">&nbsp;<span class="blocktitle">�������</span></td>
	</tr>
	<tr>
		<td>
		<input id='btn0' disabled type="button" value="������" onclick="on_addRow();">
		<input id='btn1' disabled type="button" value="������" onclick="on_insertRow();">
		<input id='btn2' disabled type="button" value="ɾ����" onclick="on_deleteRow();">
		<input id='btn3' disabled type="button" value="����" onclick="on_ttSave(getTaskTable());">
		<input id='btn4' disabled type="button" value="����" onclick="on_ttBack();">
		<input id='btn5' disabled type="button" value="����" onclick="on_ttLevelUp(getTaskTable());";>
		<input id='btn6' disabled type="button" value="����" onclick="on_ttLevelDown(getTaskTable());">
		<input id='btn7' disabled type="button" value="��������" onclick="on_ttLinkTask(getTaskTable());">
		<input id='btn8' disabled type="button" value="ȡ������" onclick="on_ttUnLinkTask(getTaskTable());">
		</td>
	</tr>
</table>
<br>
<form id="frmTask" action="PPMTaskSave.do" target="task_iframe" method="post">
<input id="oidCount" name="oidCount" style="display: none;" value="">
<input id="lineDRs" name="lineDRs" style="display: none;" value="">
<input name="projectID" style="display: none;" value="<%=projectID %>">
<table width='100%' class="ppm_task_table" border="0" cellpadding="2" cellspacing="1" id="mainTaskTable">
	<tr class="ppm_task_header" height="20px">
		<td width="40px" align="center">���</td>
		<td width="400px">��������</td>
		<td width="100px" align="center">��������</td>
		<td width="120px" align="center">��ʼʱ��</td>
		<td width="120px" align="center">����ʱ��</td>
		<td width="60px" align="center">����</td>
		<td width="50px" align="center">������</td>
		<td width="70px" align="center">�ڲ�������</td>
		<td width="80px" align="center">�����</td>
		<td width="80px" align="center">ǰ������</td>
		<td width="80px" align="center">��ע</td>
	</tr>
</table>
</form>
<table border="0">
<tr>
	<td height="300px;"></td>
</tr>
</table>
</td></tr></table>


<%@ include file="footer.jsp" %>
</body>
</html>