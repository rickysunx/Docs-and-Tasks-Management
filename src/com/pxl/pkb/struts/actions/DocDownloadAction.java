package com.pxl.pkb.struts.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.pxl.pkb.biz.Consts;
import com.pxl.pkb.biz.Pub;
import com.pxl.pkb.biz.User;
import com.pxl.pkb.framework.DataManagerObject;
import com.pxl.pkb.framework.PkbAction;
import com.pxl.pkb.framework.ValueObject;
import com.pxl.pkb.vo.bd_user;
import com.pxl.pkb.vo.doc_doc;
import com.pxl.pkb.vo.doc_userdown;
import com.pxl.pkb.vo.doc_ver;
import com.pxl.pkb.vo.sys_attach;

public class DocDownloadAction extends PkbAction {

	public ActionForward pkbExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String strDocID = request.getParameter("docid");
		String strDocVerID = request.getParameter("docverid");
		
		int docid = Integer.parseInt(strDocID);
		int docverid = 0;
		
		DataManagerObject dmo = new DataManagerObject();
		
		//�������ش���
		ValueObject[] docvos=dmo.queryByWhere(doc_doc.class, "DocID="+docid);
		doc_doc doc=(doc_doc)docvos[0];
		
		//�ж��Ƿ���Ŀ�ĵ�
		Object[][] cates=dmo.querySQL("select docType from doc_doccate,doc_cate where doc_doccate.cateid=doc_cate.doccateid and docid="+docid);
		Object[][] docCates=dmo.querySQL("select docType from doc_cate where doccateid="+doc.getDocCateID());
		Boolean isProjectCate=false;
		if(docCates.length==1&&docCates[0][0].equals("2")){
			isProjectCate=true;
		}
		for(int i=0;i<cates.length;i++){
			if(cates[i][0].toString().equals("2")){
				isProjectCate=true;
			}
		}
		//�ж��Ƿ�Ϊ��Ʒ�ĵ�
		Boolean isProductCate=false;
		if(docCates.length==1&&docCates[0][0].equals("1")){
			isProductCate=true;
		}
		for(int i=0;i<cates.length;i++){
			if(cates[i][0].toString().equals("1")){
				isProductCate=true;
			}
		}
		
		dmo.updateBySQL("update doc_doc set DownloadCount=DownloadCount+1 where DocID="+docid);
		
		HttpSession session = request.getSession();
		bd_user user = (bd_user)session.getAttribute(Consts.PKB_USER_SESSION_NAME);
		
		if(Pub.isUnCheckUser(session)) {
			throw new Exception ("�����û�δͨ����ˣ����ܽ����ļ����أ�");
		}
		if(isProjectCate&&(!(user.getIsAdmin().equals("0")||user.getIsAdmin().equals("1")))){
			throw new Exception("�Բ�������Ȩ���ظ��ĵ�");
		}
		if(isProductCate&&(user.getIsAdmin().equals("4")||user.getIsAdmin().equals("3"))){
			throw new Exception("�Բ�������Ȩ���ظ��ĵ�");
		}		
		doc_userdown down = new doc_userdown();
		String currTime = Pub.getCurrTime();
		down.setDocID(docid);
		down.setDownTime(currTime);
		down.setUserID(user.getUserID());
		dmo.insert(down);
		
		Object [][] countData = dmo.querySQL("select count(distinct docid) from doc_userdown where DownTime like '"+
				currTime.substring(0, 10)+"%' and UserID="+user.getUserID());
		
		int downCount = ((Long)countData[0][0]).intValue();
		
		if(downCount>5) {
			throw new Exception("���������ص��ĵ��Ѿ���������");
		}
		
		if(strDocVerID!=null && strDocVerID.trim().length()>0) {
			docverid = Integer.parseInt(strDocVerID);
		} else if(strDocID!=null && strDocID.trim().length()>0) {
			ValueObject [] docvers = dmo.queryByWhere(doc_ver.class, " DocID="+docid+" and IsLatest=1");
			if(docvers.length==1) {
				doc_ver ver = (doc_ver)docvers[0];
				docverid = ver.getDocVerID();
			}
		}
		//�����ж��Ƿ����ظ�����
		ValueObject[] isdownloadvos=dmo.queryByWhere(doc_userdown.class, "docid="+docid+" and userid="+user.getUserID());
		
		if(docverid!=0) {
			ValueObject [] attachs = dmo.queryByWhere(sys_attach.class, " ObjID="+docverid+" and AttachCate='DOC'");
			if(attachs.length==1) {
				sys_attach attach = (sys_attach)attachs[0];
				if(user.getUserID()!=doc.getAddUser()&&isdownloadvos.length<1){
					//������Ŀ�ĵ��Ҳ����ظ��������100��
					if(isProjectCate){
						User.userScoreAdd(user.getUserID(), "������Ŀ�ĵ�:"+docid, -100);
						User.userScoreAdd(doc.getAddUser(), "��Ŀ�ĵ�������:"+docid, 100);
					}else{
						User.userScoreAdd(user.getUserID(), "�����ĵ�:"+docid, -20);
						User.userScoreAdd(doc.getAddUser(), "�ĵ�������:"+docid, 100);
					}
				}
				request.getRequestDispatcher("DownloadFile?attachid="+attach.getAttachID()).forward(request, response);
			}
		} else {
			throw new Exception("�ļ������ڣ��뷵�أ�");
		}
		
		
		return null;
	}

}
