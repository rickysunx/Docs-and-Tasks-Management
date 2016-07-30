package com.pxl.pkb.struts.forms;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

public class PPMMemberForm extends ActionForm {
  
	  @Override
	public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
		ActionErrors errors = new ActionErrors();
          email=request.getParameter("email").trim();
		if(null==userName||"".equals(userName)){
			errors.add("userName",new ActionMessage("��������Ϊ��"));
		}else if(null==unit||"".equals(unit)){
			errors.add("userName",new ActionMessage("������λ����Ϊ��"));
		}else if(null==position||"".equals(position)){
			errors.add("position",new ActionMessage("��λְ����Ϊ��"));
		}else if((null==custRole||"".equals(custRole))&&(null==ufidaRole||"".equals(ufidaRole))){
			errors.add("custRole",new ActionMessage("���ͻ���Ŀ��ɫ���͡�������Ŀ��ɫ�����߱�ѡһ"));
		}else if(null==tel||"".equals(tel)){
			errors.add("tel",new ActionMessage("�绰����Ϊ��"));
		}else if(null==email||"".equals(email)){
			errors.add("email",new ActionMessage("�����ʼ�����Ϊ��"));
		}else if(email.matches("[\\w[.-]]+@[\\w[.-]]+\\.[\\w]+")==false){
			errors.add("errorEamil",new ActionMessage("�����ʼ���ʽ����"));
		}
		return errors;
	  }
	  
	  private int memberID;
	  private int userID;
	  private int projectID;
	  private String userName;
	  private String unit;
	  private String position;
	  private String custRole;
	  private String ufidaRole;
	  private String tel;
	  private String email;
	  private String notes;
	  private String method;//����
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}
	public String getCustRole() {
		return custRole;
	}
	public void setCustRole(String custRole) {
		this.custRole = custRole;
	}
	public String getEmail() {
		return email;
	}
	public void setEMail(String email) {
		email = email;
	}

	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public int getProjectID() {
		return projectID;
	}
	public void setProjectID(int projectID) {
		this.projectID = projectID;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getUfidaRole() {
		return ufidaRole;
	}
	public void setUfidaRole(String ufidaRole) {
		this.ufidaRole = ufidaRole;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}

	public int getMemberID() {
		return memberID;
	}
	public void setMemberID(int memberID) {
		this.memberID = memberID;
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
}
