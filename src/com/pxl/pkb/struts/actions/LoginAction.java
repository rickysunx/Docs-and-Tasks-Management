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
import com.pxl.pkb.struts.forms.LoginForm;
import com.pxl.pkb.vo.bd_user;

public class LoginAction extends PkbAction {

	public LoginAction() {
	}

	
	public ActionForward pkbExecute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		LoginForm loginForm = (LoginForm) form;
		String userCode = loginForm.getUserCode();
		String passWord = loginForm.getPassWord();
		passWord = Pub.encodeByMD5(passWord);
		
		HttpSession session = request.getSession();
		DataManagerObject dmo = new DataManagerObject();
		ValueObject [] vos = dmo.queryByWhere(bd_user.class, " UserCode='"+userCode+"'");
		if(vos.length==1) {
			bd_user user = (bd_user)vos[0];
			if(user.getPassWord().equals(passWord)) {
				if(user.getErrorCount()<5){
					user.setErrorCount(0);
					if(user.getIsAdmin().equalsIgnoreCase("3")) throw new Exception("δ��˵��û����ܵ�¼��");
					String currTime = Pub.getCurrTime();
					String currDate = currTime.substring(0,10);
					if(user.getLastLogTime()==null || (!user.getLastLogTime().startsWith(currDate))) {
						User.userScoreAdd(user.getUserID(), "�����״ε�¼", 10);
					}
					user.setLastLogTime(currTime);
					dmo.update(user);
					session.setAttribute(Consts.PKB_USER_SESSION_NAME, user);
					Pub.addOperaNote(request, "�û���¼", user.getUserID());
					
				}else{
					request.setAttribute("errinfo", "�Բ��������˻��ѱ�����������ϵ����Ա");
					return mapping.findForward("failed");
				}
			} else {
				user.setErrorCount(user.getErrorCount()+1);
				dmo.update(user);
				request.setAttribute("errinfo", "�������,��������5�δ�����û���������,����ǰ��ʣ"+(5-user.getErrorCount())+"�λ���");
				return mapping.findForward("failed");
			}
		} else {
			request.setAttribute("errinfo", "�����û�ʧ��");
			return mapping.findForward("failed");
		}
		
		if(request.getSession().getAttribute("oldURL")!=null){
			response.sendRedirect(request.getSession().getAttribute("oldURL").toString());
			request.getSession().removeAttribute("oldURL");
			return null;
		}
		return mapping.findForward("success");
	}

}
