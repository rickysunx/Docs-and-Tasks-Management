package com.pxl.ppm.itfs;

import com.pxl.pkb.vo.ppm_output;
import com.pxl.pkb.vo.sys_attach;

/**
 * ��������ؽӿ�
 * @author Ricky
 *
 */
public interface IOutput {
	/**
	 * ����������
	 * @param output
	 * @return
	 * @throws Exception
	 */
	public int insert(ppm_output output) throws Exception;
	
	/**
	 * ɾ��������
	 * @param id
	 * @throws Exception
	 */
	public void delete(int id) throws Exception;
	
	/**
	 * ���²�����
	 * @param output
	 * @throws Exception
	 */
	public void update(ppm_output output) throws Exception;
	/**
	 * ��������ID��ȡ������
	 * @param output
	 * @throws Exception
	 */
	public ppm_output[] queryForWorklog(int taskID)throws Exception;
	/**
	 * ����ID��ȡ������
	 * @param output
	 * @throws Exception
	 */
	public ppm_output queryOutById(int id)throws Exception;
	
	public sys_attach[] queryByOutID(int outId)throws Exception;
}
