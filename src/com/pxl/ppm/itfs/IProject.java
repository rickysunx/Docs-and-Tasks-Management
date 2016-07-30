package com.pxl.ppm.itfs;

import com.pxl.pkb.vo.ppm_project;
import com.pxl.pkb.vo.ppm_version;

/**
 * �й���Ŀ�Ľӿڷ���
 * @author Ricky
 *
 */
public interface IProject {
	
	/**
	 * ��������
	 */
	
	public static final int PROJECT_STATUS_EDITING = 0;    //�༭��״̬
	public static final int PROJECT_STATUS_PUBLISHED = 1;  //�ѷ���״̬
	
	/**
	 * ��ѯ���е���Ŀ
	 * @return
	 * @throws Exception
	 */
	public ppm_project [] queryAll() throws Exception;
	
	/**
	 * ����ID��ѯָ������Ŀ
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public ppm_project queryByID(int id) throws Exception;
	
	/**
	 * ��������SQL��ѯָ����Ŀ
	 * @param whereSQL
	 * @return
	 * @throws Exception
	 */
	public ppm_project [] queryByWhere(String whereSQL) throws Exception;
	
	/**
	 * ������Ŀ��ID������Ŀ���и���
	 * ��̨�����д��ж���Ŀ��Ϣ����У����߼���
	 * �Ѿ����ڷ���״̬����Ŀ���޷����и��¡�
	 * @param project
	 * @throws Exception
	 */
	public void update(ppm_project project) throws Exception;
	
	/**
	 * ����һ����Ŀ��������Ŀ��ID��
	 * ��̨�����д��ж���Ŀ��Ϣ����У����߼�
	 * @param project
	 * @return ��ĿID��
	 * @throws Exception
	 */
	public int insert(ppm_project project) throws Exception;
	
	/**
	 * ������Ŀ������Ŀ��Ϊ����״̬
	 * @param projectID
	 * @throws Exception
	 */
	public void publish(int projectID) throws Exception;
	
	/**
	 * �޶���Ŀ����������Ŀ�°汾������Ŀ�޸�Ϊ�༭��״̬��
	 * 
	 * @param projectID ����Ϊ��
	 * @param verName ���Ϊ�գ�����ݵ�ǰϵͳʱ�����Ĭ�ϰ汾����
	 * @return ��Ŀ�°汾
	 * @throws Exception
	 */
	public ppm_version revise(int projectID,String verName,String first) throws Exception;
	
	/**
	 * ɾ����Ŀ����̨�����и��������Ŀɾ���Ϸ���У��
	 * @param projectID
	 * @throws Exception
	 */
	public void delete(int projectID) throws Exception;
	/**
	 * ����sql��ѯ��Ŀ�汾
	 * @param sql
	 * @return
	 * @throws Exception
	 */
	public ppm_version[] queryBysql(String sql) throws Exception;
	
	/**
	 * 
	 * @param projectID
	 * @return
	 * @throws Exception
	 */
	public ppm_version queryLatestVersion(int projectID) throws Exception;
	
}
