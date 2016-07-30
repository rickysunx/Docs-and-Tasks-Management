<%@ page language="java" pageEncoding="GBK"%>
<%@page import="com.pxl.pkb.biz.Pub"%>
<%@page import="com.pxl.pkb.vo.doc_cate"%>
<%@ page errorPage="ExceptionHandler.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
if(!Pub.isAdminUser(session)) {
	throw new Exception("�ǹ���Ա�û����޷����ʣ�");
}
%>
<%
DataManagerObject dmo=new DataManagerObject();
String method=request.getParameter("method");
doc_cate docCate=null;
int parentDocCate=0;
if(method!=null&&method.equals("update")){
	docCate=(doc_cate)request.getAttribute("docCate");
	parentDocCate=docCate.getParentDocCate();
}else{
	String type=request.getParameter("type");
	String docCateID=request.getParameter("docCateID");
	if(type.equals("0")){
		parentDocCate=Integer.parseInt(docCateID);
	}else{
		docCate=(doc_cate)dmo.queryByWhere(doc_cate.class,"DocCateID="+docCateID)[0];
		parentDocCate=docCate.getDocCateID();
	}
}
String strDocCateID = request.getParameter("doccateid");
int docCateID = (strDocCateID==null||strDocCateID.trim().length()==0)?0:Integer.parseInt(strDocCateID);
if(Pub.isUnCheckUser(session)) {
	throw new Exception("�����û���δͨ����ˣ����ܽ����½��ĵ���");
}
%>
<%@page import="com.pxl.pkb.framework.DataManagerObject"%>
<html>
	<head>
		<title>�½��ĵ����</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="Pragma" content="no-cache">
		<link href="main.css" rel="stylesheet" type="text/css">
		<link href="css/color.css" rel="stylesheet" type="text/css">
		<script type="text/javascript">
			function checkForm(){
				var docCateName=document.getElementById("docCateName").value;
				if(docCateName==null||docCateName==""){
					alert("�ĵ�������");
					return false;
				}else{
					return true;
				}
			}
		</script>
	</head>
	<body>
		<form id="frmDocCate" action="DocCate.do?method=<%=method%>" method="post" onsubmit="return checkForm();">
				<table width="1000" border="0" cellpadding="2" cellspacing="2" class="blockborder">
				<tr class="tableBackGround">
					<td colspan="3"><%if(method.equals("add")){out.print("�½��ĵ����");}else{out.print("�༭�ĵ����");} %>
					<input id="docCateID" name="docCateID" type="hidden" value="<%if(method!=null&&method.equals("update")){out.print(docCate.getDocCateID());}%>"/>
				</td></tr>
				<tr>
					<td>������ƣ�</td>
					<td>
						<input id="docCateName" name="docCateName" type="text"  value="<%if(method!=null&&method.equals("update")){out.print(docCate.getDocCateName());}%>"/>
					</td>
					<td class="helpRequired">�������������</td>
				</tr>
				<tr>
					<td>�ϼ��ڵ�</td>
					<td>
						<select id="parentDocCate" name="parentDocCate">
						<option value="0">-��ѡ�����-</option>
						<%
							out.println(Pub.getCateOption("doc_cate","DocCateID","DocCateName","ParentDocCate",docCateID));
						%>
						</select>
					</td>
					<td class="helpRequired">��ѡ��������ϼ��ڵ㣬��ѡ��Ĭ��Ϊ���ڵ�</td>
				</tr>
				<tr>
					<td>�Ƿ������ϴ��ĵ�</td>
					<td><%
						if(method!=null&&method.equals("update")){
							if(docCate.getCanPost().equals("1")){
								out.println("<input type='radio' id='canPost' name='canPost' value='1' checked='checked'/>����");
								out.println("<input type='radio' id='canPost' name='canPost' value='0'/>������");
							}else{
								out.println("<input type='radio' id='canPost' name='canPost' value='1'/>����");
								out.println("<input type='radio' id='canPost' name='canPost' value='0' checked='checked'/>������");
							}
						}else{
							out.println("<input type='radio' id='canPost' name='canPost' value='1'/>����");
							out.println("<input type='radio' id='canPost' name='canPost' value='0' checked='checked'/>������");
						}
					%>
					<td class="helpRequired">��ѡ�������Ƿ������ϴ��ĵ�</td>
				</tr>
				<tr>
					<td>�ĵ�����</td>
					<td><select id="docType" name="docType">
					<%
						if(method!=null&&method.equals("update")){
					%>
						<option value='0' <%if(docCate.getDocType().equals("0")){out.println("selected");}%>>֪ʶ��</option>
						<option value='1' <%if(docCate.getDocType().equals("1")){out.println("selected");}%>>��Ʒ��</option>
						<option value='2' <%if(docCate.getDocType().equals("2")){out.println("selected");}%>>��Ŀ��</option>
					<%
						}else{
					%>
						<option value='0' selected>֪ʶ��</option>
						<option value='1'>��Ʒ��</option>
						<option value='2'>��Ŀ��</option>
					<%		
						}
					%>
					</select></td>
					<td class="helpRequired">��ѡ�������ĵ����ĵ�����</td>
				</tr>
				<tr>
					<td></td>
					<td><input type="submit" value="ȷ��"/>&nbsp;&nbsp;<input value="����" type="button" onclick="window.history.back();"/></td>
				</tr>
			</table>
		</form>
		<input type="hidden" id="parentDocCateID" value="<%=parentDocCate%>"/>
		<script type="text/javascript">
			var parentDocCateID=document.getElementById("parentDocCateID").value;
			var options=document.getElementById('parentDocCate').options
			for(var i=0;i<options.length;i++){
				if(options[i].value==parentDocCateID){
					document.getElementById('parentDocCate').selectedIndex=i;
				}
			}
		</script>
	</body>
</html>
