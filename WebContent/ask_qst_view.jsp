<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page errorPage="ExceptionHandler.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.pxl.pkb.framework.*"%>
<%@page import="com.pxl.pkb.vo.*"%>
<%@page import="com.pxl.pkb.biz.*"%>
<%
String strQstStatus = request.getParameter("qststatus");
String strQstID = request.getParameter("qstid");
int qstStatus = (strQstStatus==null||strQstStatus.trim().length()==0)?0:Integer.parseInt(strQstStatus);
int qstid = (strQstID==null||strQstID.trim().length()==0)?0:Integer.parseInt(strQstID);
DataManagerObject dmo = new DataManagerObject();
dmo.updateBySQL("update ask_qst set ClickCount=ClickCount+1 where QstID="+qstid);
ValueObject[] askQsts = dmo.queryByWhere(ask_qst.class," QstID="+qstid);
ask_qst qst = null;
if(askQsts.length>0) {
	qst = (ask_qst)askQsts[0];
} else {
	out.println("δ�ҵ�ָ������");
	return;
}
ask_cate [] catePath = Ask.getAskCatePath(qst.getAskCateID());
bd_user addUser = User.findUser(qst.getAddUser());
ValueObject [] askAnswers = dmo.queryByWhere(ask_answer.class," AnswerID not in (select BestAnswerID from ask_qst where QstID="+qst.getQstID()+") and QstID="+qst.getQstID()+" order by AddTime desc");
ValueObject [] bestAnswers = dmo.queryByWhere(ask_answer.class," AnswerID in (select BestAnswerID from ask_qst where QstID="+qst.getQstID()+") and QstID="+qst.getQstID()+" order by AddTime desc");
ask_answer bestAnswer = null;
if(bestAnswers.length>0) {
	bestAnswer = (ask_answer)bestAnswers[0];
}
bd_user currUser = (bd_user) session.getAttribute(Consts.PKB_USER_SESSION_NAME);
int currUserID = currUser.getUserID();
%>

<%

Object[][] cates=dmo.querySQL("select askType from ask_qstcate,ask_cate where ask_qstcate.cateid=ask_cate.askcateid and qstid="+qst.getQstID());
Object[][] qstCates=dmo.querySQL("select askType from ask_cate where askcateid="+qst.getAskCateID());
int isProjectCate=0;
if(qstCates.length==1&&qstCates[0][0].equals("2")){
	isProjectCate=1;
}
for(int i=0;i<cates.length;i++){
	if(cates[i][0].toString().equals("2")){
		isProjectCate=1;
	}
}

int isProductCate=0;
if(qstCates.length==1&&qstCates[0][0].equals("1")){
	isProductCate=1;
}
for(int i=0;i<cates.length;i++){
	if(cates[i][0].toString().equals("1")){
		isProductCate=1;
	}
}

if(Pub.isUnCheckUser(session)) {
	out.println("�����û�δͨ����ˣ����ܲ鿴�ʴ���ϸ��");
	return;
}
if(isProjectCate==1&&(!(currUser.getIsAdmin().equals("0")||currUser.getIsAdmin().equals("1")))){
	out.println("�Բ�������Ȩ�鿴���ʴ���ϸ");
	return;
}
if(isProductCate==1&&(currUser.getIsAdmin().equals("4")||currUser.getIsAdmin().equals("3"))){
	out.println("�Բ�������Ȩ�鿴���ʴ���ϸ");
	return;
}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Pragma" content="no-cache">
<title>����</title>
<link href="main.css" rel="stylesheet" type="text/css">
<link href="css/color.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function showQstCommentDiv() {
	if(qstCommentDiv.style.display=='none') {
		qstAdditionDiv.style.display='none';
		qstCommentDiv.style.display='';
	} else {
		qstCommentDiv.style.display='none';
	}
}

function showAnswerCommentDiv(theCommentDiv,theUpdateDiv) {
	if(theCommentDiv.style.display=='none') {
		theUpdateDiv.style.display='none';
		theCommentDiv.style.display='';
	} else {
		theCommentDiv.style.display='none';
	}
}

function showAnswerUpdateDiv(theUpdateDiv,theCommentDiv) {
	if(theUpdateDiv.style.display=='none') {
		theCommentDiv.style.display='none';
		theUpdateDiv.style.display='';
	} else {
		theUpdateDiv.style.display='none';
	}
}

function showBestAnswerDiv() {
	if(bestAnswerCommentDiv.style.display=='none') {
		bestAnswerCommentDiv.style.display='';
	} else {
		bestAnswerCommentDiv.style.display='none';
	}
}

function showQstAdditionDiv() {
	if(qstAdditionDiv.style.display=='none') {
		qstAdditionDiv.style.display='';
		qstCommentDiv.style.display='none';
	} else {
		qstAdditionDiv.style.display='none';
	}
}

function onAdditionFormCheck(theForm) {
	if(theForm.qstAddition.value=='') {
		alert('����˵������Ϊ��');
		return false;
	}
	return true;
}

function onCommentFormCheck(theForm) {
	if(theForm.commentContent.value=='') {
		alert('���۲���Ϊ�գ�');
		return false;
	}
	return true;
}

function onUpdateFormCheck(theForm) {
	if(theForm.answerContent.value=='') {
		alert('�ش����ݲ���Ϊ��');
		return false;
	}
	return true;
}

var qsttime='';

function doQstRefresh(theid) {
	if(theid==<%=qstid%>) {
		location.reload();
	}
}

function qstRequestLoop() {
	var xmlHttp1;
	
	xmlHttp1=new ActiveXObject("Microsoft.XMLHTTP");
	
	xmlHttp1.onreadystatechange = function() {
		if(xmlHttp1.readyState==4) {
			if(xmlHttp1.status==200) {
				var text = xmlHttp1.responseText;
				var index = text.indexOf("|");
				qsttime = text.substring(0,index);
				var content = text.substring(index+1,text.length);
				if(content!='') {
					eval(content);
				}
				window.setTimeout("qstRequestLoop();",6000);
			}
		}
	}
	
	xmlHttp1.open("GET","NotifyGet.do?type=1"+((qsttime=='')?'':'&time='+qsttime),true);
	xmlHttp1.send(null);
	
}

window.setTimeout("qstRequestLoop();",3000);

</script>
</head>
<body class="body">
<%@ include file="header.jsp" %>
<table class="bodytable" align="center"><tr><td>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td height="30"><a href="index.jsp">��ҳ</a> &gt; <a href="ask_list.jsp?qststatus=<%=qstStatus %>">�ʴ�</a> <%
for(int i=0;i<catePath.length;i++) {
	out.print(" &gt; <a href=\"ask_list.jsp?askcateid="+catePath[i].getAskCateID()+"&qststatus="+qstStatus+"\">"+catePath[i].getAskCateName()+"</a> ");
}
%></td>
</tr>
</table>
<table width="900"  border="0" cellpadding="2" cellspacing="2" class="blockborder">
	  <tr>
		<td height="20" class="tableBackGround">
		<%if(qst.getQstStatus().equals("0")) {%>
		<img border=0 src='images/view_time.gif'>&nbsp;<span class="blocktitle">�����</span>
		<%} else { %>
		<img border=0 src='images/view_ok.gif'>&nbsp;<span class="blocktitle">�ѽ��</span>
		<%} %>
		</td>
	  </tr>
	  <tr>
		<td height="20">
		<table width="100%" border="0" cellpadding="2" cellspacing="2">
		<tr><td class="viewtitle"><%=qst.getQstTitle() %></td></tr>
		<tr><td class="viewheader">�����ߣ�<%=addUser!=null?addUser.getUserName():"" %> - <%=qst.getAddTime() %></td></tr>
		<tr><td><%
		out.println(qst.getQstContent());
		
		//���ⲹ��˵��
		if(qst.getQstAddition()!=null && qst.getQstAddition().trim().length()>0) {
			out.println("<br><br><table width='100%'><tr><td height=\"2\" colspan=\"2\"><div class=\"listdotline\">&nbsp;</div></td></tr></table>");
			out.println("<b>������Ĳ���˵����</b><br>"+Pub.text2html(qst.getQstAddition()));
		}
		
		//����ĸ���
		String attachLink = Attach.getAttachLinks("QST",qst.getQstID(),request);
		if(attachLink!=null && attachLink.trim().length()>0) {
			out.println("<br><br><table width='100%'><tr><td height=\"2\" colspan=\"2\"><div class=\"listdotline\">&nbsp;</div></td></tr></table>");
			out.println("<b>����ĸ�����</b><br>"+attachLink);
		}
		

		%></td></tr>
		<tr><td><%if(qst.getQstStatus().equals("0")&&currUserID!=qst.getAddUser()) {%><input type="button" value="�����ش�" onclick="frmAnswer.answerContent.focus();"><%} %>
				<%if(currUserID==qst.getAddUser()) { %>
					<%if(qst.getQstStatus().equals("0")) { %>
				<a href='ask_qst_update.jsp?qstid=<%=qstid %>'>�༭</a>
				    <%} %>
				    <%if(qst.getReplyCount()==0) { %>
				<a onclick="return confirm('���Ҫɾ�����������');" href='QstDelete.do?qstid=<%=qstid %>&askcateid=<%=qst.getAskCateID() %>'>ɾ��</a>
				    <%} %>
				<a href='javascript:showQstAdditionDiv();'>����˵��</a>
				<%} %>
				<a href="javascript:showQstCommentDiv();">����</a>
				<%=Comment.getCommentViewLink(0,qstid,null) %>
				
			</td></tr>
		</table>
		
		<div id="qstCommentDiv" style="display: none;">
		<form action="CommentAdd.do" method="post" onsubmit="return onCommentFormCheck(this);">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr><td colspan="2">������������Ϣ��</td></tr>
				<tr>
					<td valign="top" width="350px;">
						<input name="objID" value="<%=qstid %>" type="hidden">
						<input name="commentType" value="0" type="hidden">
						<input name="returnPage" value="ask_qst_view.jsp?qstid=<%=qstid %>&qststatus=<%=qstStatus %>" type="hidden">
						<textarea id="qstComment" name="commentContent" style="width: 300px;height:100px;font-size: 12px;"></textarea>
					</td>
					<td class="helpRequired">�������������������Ϣ�������������</td>
				</tr>
				<tr><td><input type="submit" value="��������"></td></tr>
			</table>
		</form>
		</div>
		
		<div id="qstAdditionDiv" style="display: none;">
		<form action="QstAdditionAdd.do" method="post" onsubmit="return onAdditionFormCheck(this);">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr><td colspan="2">�����벹��˵����</td></tr>
				<tr>
					<td valign="top" width="350px;">
						<input name="qstID" value="<%=qstid %>" type="hidden">
						<input name="returnPage" value="ask_qst_view.jsp?qstid=<%=qstid %>&qststatus=<%=qstStatus %>" type="hidden">
						<textarea id="qstAddition" name="qstAddition" style="width: 300px;height:100px;font-size: 12px;"><%=qst.getQstAddition()==null?"":qst.getQstAddition() %></textarea>
					</td>
					<td class="helpRequired">������������Ĳ���˵�������������˵��</td>
				</tr>
				<tr><td colspan="2"><input type="submit" value="������˵��"></td></tr>
			</table>
		</form>
		</div>
		
		</td>
	  </tr>
</table>
<%if(qst.getQstStatus().equals("0") && currUserID!=qst.getAddUser()) {%>
<script type="text/javascript">
function onAnswerCheck() {
	if(frmAnswer.answerContent.value.length==0) {
		alert('�ش����ݲ���Ϊ�գ�');
		return false;
	}
	return true;
}
</script>
<form id="frmAnswer" name='frmAnswer' action="AnswerAdd.do?qstid=<%=qst.getQstID() %>" method="post" onsubmit="return onAnswerCheck();">
<table width="900"  border="0" cellpadding="2" cellspacing="2" class="blockborder">
	  <tr>
		<td height="20">
		<table width="100%" border="0" cellpadding="2" cellspacing="2">
		<tr>
			<td valign="top" width="60">�����ش�</td>
			<td width="350px;"><textarea id="answerContent" name="answerContent" style="width: 400px;height: 100px;" onfocus="this.style.height='200px';"></textarea>
			</td>
			<td class="helpRequired">���������Ļش𣬵���ύ����</td>
		</tr>
		<tr>
			<td valign="top" height="20"></td>
			<td colspan="2">
				<input type="submit" value="�ύ�ش�">
			</td>
		</tr>
		</table>
		</td>
	  </tr>
</table>
</form>
<%} else { %>
<br>
<%} %>

<%if(bestAnswer!=null) { %>
<table width="900"  border="0" cellpadding="2" cellspacing="2" class="bestborder">
	  <tr>
		<td height="20" bgcolor="#FED6D2" colspan="2">
		<img border=0 src='images/view_best.gif'>&nbsp;<span class="blocktitle">��Ѵ�</span>
		</td>
	  </tr>
	  <tr>
	  	<td colspan="2">
	  	<%=Pub.text2html(bestAnswer.getAnswerContent()) %>
	  	</td>
	  	<tr>
		<td height="30" class="viewheader" valign="bottom">
		<a href='javascript:showBestAnswerDiv();' class='funca'>����</a>
		<%=Comment.getCommentViewLink(1,bestAnswer.getAnswerID(),"funca") %>
		</td>
		<td class="viewheader" align="right" valign="bottom">�ش��ߣ�<%
		bd_user replyUser = User.findUser(bestAnswer.getAddUser());
		out.print(replyUser.getUserName());
		%> - <%=bestAnswer.getAddTime() %></td>
		</tr>
		<tr>
			<td colspan="2">
		<div id="bestAnswerCommentDiv" style="display: none;">
			<form action="CommentAdd.do" method="post" onsubmit="return onCommentFormCheck(this);">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr><td>������������Ϣ��</td></tr>
					<tr>
						<td valign="top">
							<input name="objID" value="<%=bestAnswer.getAnswerID() %>" type="hidden">
							<input name="commentType" value="1" type="hidden">
							<input name="returnPage" value="ask_qst_view.jsp?qstid=<%=qstid %>&qststatus=<%=qstStatus %>" type="hidden">
							<textarea id="qstComment" name="commentContent" style="width: 300px;height:100px;font-size: 12px;"></textarea>
						</td>
					</tr>
					<tr><td><input type="submit" value="��������"></td></tr>
				</table>
			</form>
		</div>
			</td>
		</tr>
</table>
<br>
<%} %>
<%
if(askAnswers.length>0) {
%>
<table width="900"  border="0" cellpadding="2" cellspacing="2" class="blockborder">
	  <tr>
		<td height="20" class="tableBackGround">
		<img border=0 src='images/view_answer.gif'>&nbsp;<span class="blocktitle">�ش�</span>
		</td>
	  </tr>
	  <tr>
		<td height="20">
		
		<%
		for(int i=0;i<askAnswers.length;i++) {
			ask_answer answer = (ask_answer)askAnswers[i];
		%>
		<table width="100%" border="0" cellpadding="2" cellspacing="2">
		<tr><td colspan="2"><%=Pub.text2html(answer.getAnswerContent()) %></td></tr>
		<tr>
		<td height="30" class="viewheader" valign="bottom">
		<%if(currUserID==qst.getAddUser() && qst.getQstStatus().equals("0")) { %>
		<a onclick="return confirm('���Ҫ�������ش�����Ϊ��Ѵ���');" href='SetBestAnswer.do?answerid=<%=answer.getAnswerID()%>&qstid=<%=qst.getQstID() %>' class='funca'>��Ϊ��Ѵ�</a> 
		<%} %>
		<%if(currUserID==answer.getAddUser() && qst.getQstStatus().equals("0") ) { %>
		<a href='javascript:showAnswerUpdateDiv(answerUpdateDiv<%=i %>,answerCommentDiv<%=i %>);' class='funca'>�༭</a>
		<a onclick="return confirm('���Ҫɾ����������');" href='AnswerDelete.do?answerid=<%=answer.getAnswerID() %>&qstid=<%=qstid %>' class='funca'>ɾ��</a>
		<%} %>
		<a href='javascript:showAnswerCommentDiv(answerCommentDiv<%=i %>,answerUpdateDiv<%=i %>);' class='funca'>����</a>
		<%=Comment.getCommentViewLink(1,answer.getAnswerID(),"funca") %>
		</td>
		<td class="viewheader" align="right" valign="bottom">�ش��ߣ�<%
		bd_user replyUser = User.findUser(answer.getAddUser());
		out.print(replyUser.getUserName());
		%> - <%=answer.getAddTime() %></td>
		</tr>
		<tr>
			<td colspan="2">
		<div id="answerCommentDiv<%=i %>" style="display: none;">
			<form action="CommentAdd.do" method="post" onsubmit="return onCommentFormCheck(this);">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr><td>������������Ϣ��</td></tr>
					<tr>
						<td valign="top">
							<input name="objID" value="<%=answer.getAnswerID() %>" type="hidden">
							<input name="commentType" value="1" type="hidden">
							<input name="returnPage" value="ask_qst_view.jsp?qstid=<%=qstid %>&qststatus=<%=qstStatus %>" type="hidden">
							<textarea id="qstComment" name="commentContent" style="width: 300px;height:100px;font-size: 12px;"></textarea>
						</td>
					</tr>
					<tr><td><input type="submit" value="��������"></td></tr>
				</table>
			</form>
		</div>
		
		<div id="answerUpdateDiv<%=i %>" style="display: none;">
			<form action="AnswerUpdate.do" method="post" onsubmit="return onUpdateFormCheck(this);">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr><td>������𰸣�</td></tr>
					<tr>
						<td valign="top">
							<input name="answerID" value="<%=answer.getAnswerID() %>" type="hidden">
							<textarea id="answerContent" name="answerContent" style="width: 300px;height:100px;font-size: 12px;"><%=Pub.text2htmlNoBR(answer.getAnswerContent()) %></textarea>
						</td>
					</tr>
					<tr><td><input type="submit" value="���´�"></td></tr>
				</table>
			</form>
		</div>
			</td>
		</tr>
		<%
			if(i<askAnswers.length-1) {
		%>
		<tr>
    		<td height="2" colspan="2"><div class="listdotline">&nbsp;</div></td>
  		</tr>
		<%
			}
		%>
		</table>
		<%
		}
		%>
		</td>
	  </tr>
</table>
<%
}
%>
<br>
</td></tr></table>
<%@ include file="footer.jsp" %>
</body>
</html>