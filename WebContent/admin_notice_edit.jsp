<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%@page import="com.pxl.pkb.biz.Pub"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
if(!Pub.isAdminUser(session)) {
	throw new Exception("�ǹ���Ա�û����޷����ʣ�");
}
%>
<%@ page import="com.pxl.pkb.vo.nt_notice" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link href="main.css" style="text/css" rel="stylesheet">
<link href="css/color.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
<script charset="utf-8" src="editor/kindeditor.js"></script>
<title>�༭֪ͨ</title>
<script type="text/javascript">
	function noticeCateControl(){
		var type=document.getElementById("noticeType").value;
		var lblNoticeCate=document.getElementById("lblNoticeCate");
		var txtNoticeCate=document.getElementById("noticeCate");
		var promptNoticeCate=document.getElementById("promptNoticeCate");
		if(type==0){
			lblNoticeCate.style.display="none";
			txtNoticeCate.style.display="none";
			promptNoticeCate.style.display="none";
		}else{
			lblNoticeCate.style.display="block";
			txtNoticeCate.style.display="block";
			promptNoticeCate.style.display="block";
		}
	}
	function check(){
		var _noticeTitle=document.getElementById("noticeTitle").value;
		var _noticeContent=document.getElementById("noticeContent").value;
		var noticeType=document.getElementById("noticeType").value;
		var _noticeCate=document.getElementById("noticeCate").value;
		
		var noticeTitle=_noticeTitle.replace(/\s/g,'');
		var noticeContent=_noticeContent.replace(/\s/g,'');
		var noticeCate=_noticeCate.replace(/\s/g,'');
		if(noticeTitle.length==0||noticeTitle==""){
			alert("֪ͨ�������");
			return false;
		}else if(noticeTitle.length>50){
			alert("֪ͨ�������С��50���ַ�");
			return false;
		}else if(_noticeContent.length==0||_noticeContent==""){
			alert("֪ͨ���ݱ���");
			return false;
		}else if(noticeType==1&&(noticeCate.length==0||noticeCate=="")){
			alert("�ƶ�������");
			return false;
		}else{
			return true;
		}
	}
</script>
</head>
<body onload="noticeCateControl();">
	<table>
		<tr>
			<td style="size: 12px;">��̨����&gt;֪ͨ&gt;�༭֪ͨ</td>
		</tr>
	</table>
	<%
		nt_notice notice=(nt_notice)request.getAttribute("notice");
		String check_0="";
		String check_1="";
		if(notice.getNoticeType()==0){
			check_0="selected";
		}
		else{
			check_1="selected";
		}
	%>
	<form action="NoticeEidt.do" method="post" onsubmit="return check();">
		<table border="0" cellpadding="2" cellspacing="2" class="blockborder">
			<tr class="tableBackGround">
				<td colspan="3"><b><span class="blocktitle">�༭֪ͨ</span></b>
					<input type="hidden" id="noticeID" name="noticeID" value="<%=notice.getNoticeID()%>"/>
					<input type="hidden" id="addUser" name="addUser" value="<%=notice.getAddUser()%>"/>
					<input type="hidden" id="addTime" name="addTime" value="<%=notice.getAddTime()%>"/>
				</td>
			</tr>
				
			<tr>
				<td width="80px;">֪ͨ����</td>
				<td>
					<input id="noticeTitle" name="noticeTitle" type="text" size="50" value="<%=notice.getNoticeTitle()%>"/>
				</td>
				<td class="helpRequired">������֪ͨ����</td>
			</tr>
			<tr>
				<td>֪ͨ����</td>
				<td><textarea id="noticeContent" name="noticeContent" style="width:700px;height:300px;" cols="20" rows="10"><%=notice.getNoticeContent()%></textarea></td>
				<td class="helpRequired">������֪ͨ����
<script>        
KE.show({                
id : 'noticeContent'        
});
</script>
				</td>
			</tr>
			<tr>
				<td>֪ͨ����</td>
				<td>
					<select id="noticeType" name="noticeType" style="width: 152px;" tabindex="<%=notice.getNoticeType()%>" onchange="noticeCateControl();">
						<option value="0" <%=check_0%>>֪ͨ</option>
						<option value="1" <%=check_1%>>��˾�ƶ�</option>
					</select>
				</td>
				<td class="helpRequired">��ѡ��֪ͨ����</td>
			</tr>
			<tr>
				<td><span id="lblNoticeCate">�ƶ����</span></td>
				<td><input id="noticeCate" name="noticeCate" type="text" size="20" value="<%=notice.getNoticeCate()%>"/></td>
				<td class="helpRequired"><span id="promptNoticeCate">����д�ƶ����</span></td>
			</tr>
			<tr>
				<td></td>
				<td colspan="2"><input type="submit" value="ȷ��"/>&nbsp;&nbsp;
				<input type="button" value="ȡ��" onclick="window.history.back();"/></td>
			</tr>
		</table>
	</form>
</body>

</html>
