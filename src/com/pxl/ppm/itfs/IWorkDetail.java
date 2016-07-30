package com.pxl.ppm.itfs;

import com.pxl.pkb.vo.ppm_workdetail;

/**
 * ������������
 * @author Ricky
 *
 */
public interface IWorkDetail {
	/**
	 * ���빤������
	 * @param detail
	 * @return
	 * @throws Exception
	 */
	public int insert(ppm_workdetail detail) throws Exception;
	
	/**
	 * ɾ����������
	 * @param detailid
	 * @throws Exception
	 */
	public void delete(int detailid) throws Exception;
	
	/**
	 * ���¹�������
	 * @param detail
	 * @throws Exception
	 */
	public void update(ppm_workdetail detail) throws Exception;
	
	/**
	 * ��ѯ��������
	 * @param taskID
	 * @param userID
	 * @return
	 * @throws Exception
	 */
	public ppm_workdetail [] queryForWorklog(int taskID,int userID) throws Exception;
	
	public  ppm_workdetail  queryByid(int id)throws Exception;
	
}
