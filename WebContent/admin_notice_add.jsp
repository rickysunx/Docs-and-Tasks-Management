<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.pxl.pkb.biz.Pub"%>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
if(!Pub.isAdminUser(session)) {
	throw new Exception("�ǹ���Ա�û����޷����ʣ�");
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link href="main.css" style="text/css" rel="stylesheet">
<link href="css/color.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
<title>�½�֪ͨ</title>
<script charset="utf-8" src="editor/kindeditor.js"></script>
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
		//var editor_data = CKEDITOR.instances.noticeContent.getData();
		
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
	<table border="0" cellpadding="2" cellspacing="2">
		<tr>
			<td>��̨����&gt;֪ͨ&gt;�½�֪ͨ</td>
		</tr>
	</table>
	<form action="NoticeAdd.do" method="post" onsubmit="return check();">
		<table cellpadding="2" cellspacing="2" class="blockborder">
			<tr class="tableBackGround">
				<td colspan="2"><b><span class="blocktitle">�½�֪ͨ</span></b></td>
			</tr>
			<tr>
				<td>
					<table border="0" cellpadding="5" cellspacing="5">
						<tr>
							<td>֪ͨ����</td>
							<td><input id="noticeTitle" name="noticeTitle" type="text" size="50"/></td>
							<td class="helpRequired">��������Ҫ���֪ͨ������</td>
						</tr>
						<tr>
							<td>֪ͨ����</td>
							<td>
								<textarea rows="10" cols="20" style="width:700px;height:300px;" id="noticeContent" name="noticeContent"></textarea>
<script>        
KE.show({                
	id : 'noticeContent',
	filterMode : false,
	imageUploadJson : '../../jsp/upload_json.jsp',
	fileManagerJson : '../../jsp/file_manager_json.jsp',
	allowFileManager : true     
});
</script>
							</td>
							<td class="helpRequired">��������Ҫ���֪ͨ������</td>
						</tr>
						<tr>
							<td>֪ͨ����</td>
							<td><select id="noticeType" name="noticeType" style="width: 152px;" onchange="noticeCateControl();"><option value="0">֪ͨ</option><option value="1">��˾�ƶ�</option></select></td>
							<td class="helpRequired">��������Ҫ���֪ͨ������</td>
						</tr>
						<tr>
							<td><span id="lblNoticeCate">�ƶ����</span></td>
							<td><input id="noticeCate" name="noticeCate" type="text" size="20"/></td>
							<td class="helpRequired"><span id="promptNoticeCate">��������Ҫ����ƶȵ����</span></td>
						</tr>
						<tr>
							<td colspan="2"><input type="submit" value="ȷ��"/>&nbsp;&nbsp;
							<input type="button" value="ȡ��" onclick="window.location.href='admin_notice_cate.jsp';"/></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>
