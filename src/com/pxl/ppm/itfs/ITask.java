package com.pxl.ppm.itfs;

import com.pxl.pkb.extendvo.ppm_taskon;
import com.pxl.pkb.vo.ppm_task;
import com.pxl.pkb.vo.ppm_taskassist;

/**
 * ������ز����Ľӿ�
 * @author Ricky
 *
 */
public interface ITask {
	/**
	 * ������ĿID��ѯ����
	 * @param projectID
	 * @return
	 * @throws Exception
	 */
	public ppm_task [] queryTaskByProject(int projectID) throws Exception;
	
	/**
	 * Ϊ������־��ѯ����
	 * @param userID
	 * @param date
	 * @return
	 * @throws Exception
	 */
	public ppm_taskon [] queryTaskForWorklog(int userID,String date,String lastFivetask) throws Exception;
	
	/**
	 * ��������
	 * @param task
	 * @return
	 * @throws Exception
	 */
	public int insert(ppm_task task) throws Exception;
	
	/**
	 * ɾ������
	 * @param taskid
	 * @throws Exception
	 */
	public void delete(int taskid) throws Exception;
	
	/**
	 * ��������
	 * @param task
	 * @throws Exception
	 */
	public void update(ppm_task task) throws Exception;
	/**
	 * ��ѯ���������
	 * @param task
	 * @throws Exception
	 */
	public ppm_taskassist [] queryByWhere(String whereSQL) throws Exception;

	public ppm_task  queryTaskbyID (int id) throws Exception;
	
	/**
	 * ��������
	 * @param tasks
	 * @throws Exception
	 */
	public void saveTask(int projectID,ppm_task [] tasks,String [] assists) throws Exception;
	
	public ppm_task[] queryBywhere(String sql) throws Exception;
	
	/**
	 * ��ѯ���������
	 * @param taskid
	 * @return �������飬str[0]-�Զ��ŷָ���ID��str[1]-�Զ��ŷָ�������
	 * @throws Exception
	 */
	public String [] queryAssistsByTaskID(int taskid) throws Exception;
    /**��������
     * @throws Exception 
     * 
     * 
     * */
	public void updateTask(int projectID, ppm_task taskcopy) throws Exception;
	/**
	 * 
	 */
	
	public ppm_taskon[] queryworklog(int userID, String startdate, String enddate,int projectID) throws Exception;
	
	public ppm_taskon [] queryTaskonByProject(int projectID,String startdate,String enddate) throws Exception;
}
