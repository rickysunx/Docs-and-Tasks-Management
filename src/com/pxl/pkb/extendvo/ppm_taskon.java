package com.pxl.pkb.extendvo;

import com.pxl.pkb.vo.ppm_task;

public class ppm_taskon extends ppm_task{
    
	 public String pxlUsername;//���ڱ��������������ˣ����ݿ��в�����
	    public String chargename;//���ڱ��渺���ˣ����ݿ��в�����
	    public String projectName;//���ڴ洢����������Ŀ�����ݿ��в�����
	    
	    public String getProjectName() {
			return projectName;
		}

		public void setProjectName(String projectName) {
			this.projectName = projectName;
		}

		public String getChargename() {
			return chargename;
		}

		public void setChargename(String chargename) {
			this.chargename = chargename;
		}

		public String getPxlUsername() {
			return pxlUsername;
		}

		public void setPxlUsername(String pxlUsername) {
			this.pxlUsername = pxlUsername;
		}
}
