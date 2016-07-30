<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page errorPage="ExceptionHandler.jsp" %>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.pxl.pkb.biz.Pub"%>
<%@ taglib prefix="pxl" uri="core"%>
<%@ page errorPage="ExceptionHandler.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
if(!Pub.isAdminUser(session)) {
	throw new Exception("�ǹ���Ա�û����޷����ʣ�");
}
%>
<%
	DataManagerObject dmo = new DataManagerObject();
	String strCurrentPage=request.getParameter("currentPage");
	int currentPage=strCurrentPage==null?1:Integer.parseInt(strCurrentPage);
	String noticeType=request.getParameter("noticeType");
	String noticeCate=request.getParameter("noticeCate");
	String whereSql=null;
	ValueObject[] noticevos =null;
	String url=null;
	if(noticeType!=null&&noticeType.trim().length()>0){
		if(noticeCate!=null&&noticeCate.trim().length()>0){
			whereSql="noticetype="+noticeType+" and noticeCate='"+noticeCate+"'";
			noticevos=dmo.queryByWhereForPage(nt_notice.class,whereSql,currentPage,20);
			url="admin_notice_cate.jsp?noticeType="+noticeType+"&noticeCate="+URLEncoder.encode(noticeCate.toString(),"GBK");
		}else{
			whereSql="noticetype="+noticeType;
			noticevos=dmo.queryByWhereForPage(nt_notice.class,whereSql,currentPage,20);
			url="admin_notice_cate.jsp?noticeType="+noticeType+"&noticeCate=";
		}
	}else{
		if(noticeCate!=null&&noticeCate.trim().length()>0){
			whereSql="noticeCate='"+noticeCate+"'";
			noticevos=dmo.queryByWhereForPage(nt_notice.class,whereSql,currentPage,20);
			url="admin_notice_cate.jsp?noticeType=&noticeCate="+URLEncoder.encode(noticeCate.toString(),"GBK");
		}else{
			whereSql=null;
			noticevos=dmo.queryAllForPage(nt_notice.class,currentPage,20);
			url="admin_notice_cate.jsp?noticeType=&noticeCate=";
		}
	}
	
	int totalPage=dmo.getTotalPage(nt_notice.class,whereSql,20.0);
	nt_notice[] nts = new nt_notice[noticevos.length];
	HashMap hmOldNoticeNane = new HashMap();
	for (int i = 0; i < noticevos.length; i++) {
		nts[i] = (nt_notice) noticevos[i];
	}
%>
<%@page import="com.pxl.pkb.framework.DataManagerObject"%>
<%@page import="com.pxl.pkb.framework.ValueObject"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.pxl.pkb.vo.nt_notice"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Pragma" content="no-cache">
<link href="main.css" rel="stylesheet" type="text/css">
<link href="css/color.css" rel="stylesheet" type="text/css">
<title>֪ͨ�б�</title>
</head>
<body>
	<table>
		<tr><td>&nbsp;��̨����&gt;֪ͨ&gt;֪ͨ�б�</td></tr>
		<tr><td><a href="#" onclick="window.location.href='admin_notice_add.jsp';">�½�֪ͨ</a></td></tr>
	</table><br/>
	<form action="admin_notice_cate.jsp" method="get">
	<table>
		<tr>
			<td>�����</td>
			<td>
				<select id="noticeType" name="noticeType">
					<option value="" <%if(noticeType==null||noticeType.trim().length()<=0){out.print("selected=selected");}%>>--��ѡ��--</option>
					<option value="0" <%if(noticeType.trim().equals("0")){out.print("selected=selected");}%>>֪ͨ</option>
					<option value="1" <%if(noticeType.trim().equals("1")){out.print("selected=selected");}%>>��˾�ƶ�</option>
				</select>
			</td>
			<td></td>
			<td>�����ͣ�</td>
			<td>
				<select id="noticeCate" name="noticeCate">
					<option value="">--��ѡ��--</option>
					<%
						Object[][] noticecatevas= dmo.querySQL("select distinct noticecate from nt_notice");
						for(int i=0;i<noticecatevas.length;i++){
							if(noticeCate!=null&&noticeCate.trim().length()>0&&noticeCate.trim().equals(noticecatevas[i][0])){
								out.print("<option value='"+noticecatevas[i][0]+"' selected='selected'>"+noticecatevas[i][0]+"</option>");
							}else{
								out.print("<option value='"+noticecatevas[i][0]+"'>"+noticecatevas[i][0]+"</option>");
							}
						}
					%>
				</select>
			</td>
			<td><input type="submit" value="ɸѡ"/></td>
		</tr>
	</table></form>
	<table width="500" border="0" cellpadding="2" cellspacing="2" class="blockborder">
		<tr class="tableBackGround">
			<td height="20" width="280">֪ͨ����</td>
			<td height="20" width="100">֪ͨ����</td>
			<td height="20" width="100">֪ͨ���</td>
			<td width="120" align="center">����</td>
		</tr>
		<%
		for (int i = 0; i < nts.length; i++) {
		%>
		<tr bgcolor="<%=(i%2==0)?"#f9f9f9":"#f7f7f7" %>">
			<td height="20">&nbsp;&nbsp;<%=nts[i].getNoticeTitle()%></td>
			<td height="20">&nbsp;&nbsp;<%if(nts[i].getNoticeType()==0){out.print("֪ͨ");}else{out.print("��˾�ƶ�");}%></td>
			<td height="20">&nbsp;&nbsp;<%=nts[i].getNoticeCate()%></td>
			<td align="center">
				<a href="NoticeDelete.do?noticeID=<%=nts[i].getNoticeID() %>" onclick="return confirm('�Ƿ�Ҫɾ����֪ͨ��');">ɾ��</a>
				<a href="InitEdit.do?noticeID=<%=nts[i].getNoticeID() %>">�༭</a>
			</td>
		</tr>
		<%}%>
	</table><br/>
	<table><tr><td>
		<pxl:pageSplit url="<%=url%>" totalPage="<%=totalPage%>" currentPage="<%=currentPage%>"/><br/>
	</td></tr></table>
</body>
</html>
