package com.pxl.pkb.extendvo;

import com.pxl.pkb.vo.ppm_problem;

public class ppm_problemon extends ppm_problem {
    public String[] useroper=null;//���ڴ洢�����,���ݿ��в�����
	public String chargerName=null;//���ڴ洢�����Σ����ݿ��в�����
    public String[] useroperid=null;//���ڴ洢�����Id,���ݿ��в�����
    public String taskName=null;//����洢��������,���ݿ��в�����
    public String projectName=null;//���ڴ洢��Ŀ���ƣ����ݿ��в�����
    public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public String[] getUseroper() {
		return useroper;
	}

	public void setUseroper(String[] useroper) {
		this.useroper = useroper;
	}
	
	public String getChargerName() {
		return chargerName;
	}

	public void setChargerName(String chargerName) {
		this.chargerName = chargerName;
	}

	public String[] getUseroperid() {
		return useroperid;
	}

	public void setUseroperid(String[] useroperid) {
		this.useroperid = useroperid;
	}
}
