package com.pxl.pkb.biz;

public class TaskUtils {
	
	public static final String [] TASK_TYPE_NAMES = {"��������","��Ҫ����","��̱�����","����"};
	
	public static String getTaskTypeNameByID(int id) {
		return TASK_TYPE_NAMES[id];
	}
}
