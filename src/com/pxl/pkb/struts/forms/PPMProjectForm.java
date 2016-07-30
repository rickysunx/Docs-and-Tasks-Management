package com.pxl.pkb.struts.forms;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

public class PPMProjectForm extends ActionForm {

	public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
    	  ActionErrors errors = new ActionErrors();
    	  if(null==projectName.trim()||"".equals(projectName.trim())){
    		  errors.add("projectName", new ActionMessage("��Ŀ������Ϊ��"));
    	  }
    	  if(null==projectCode.trim()||"".equals(projectCode.trim())){
    		  errors.add("projectCode",new ActionMessage("��Ŀ���벻��Ϊ��"));
    	  }
	   return errors;
	}
   
	private int projectID;
      private String projectCode;
      private String projectName;
      private String projectStatus;
      private String method;//���������жϸ�ִ���ĸ�����
      private String projectvalue;
	public String getProjectvalue() {
		return projectvalue;
	}
	public void setProjectvalue(String projectvalue) {
		this.projectvalue = projectvalue;
	}
	public String getProjectCode() {
		return projectCode;
	}
	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}
	public int getProjectID() {
		return projectID;
	}
	public void setProjectID(int projectID) {
		this.projectID = projectID;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getProjectStatus() {
		return projectStatus;
	}
	public void setProjectStatus(String projectStatus) {
		this.projectStatus = projectStatus;
	}
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}
	
      
}
