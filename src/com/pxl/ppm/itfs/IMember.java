package com.pxl.ppm.itfs;

import com.pxl.pkb.vo.bd_user;
import com.pxl.pkb.vo.ppm_member;
import com.pxl.pkb.vo.ppm_project;

/**
 * ��Ŀ��Ա��ؽӿ�
 * @author Ricky
 *
 */
public interface IMember {
	
	/**
	 * ��bd_user����ȡ������Ա���б�
	 * �÷����Ѿ������ֶ�����Ӧ���ˣ�����ת��Ϊ��Ŀ��Ա�������
	 * @return
	 * @throws Exception
	 */
	public ppm_member [] queryPxlUser() throws Exception;
	
	/**
	 * ������ĿID��ѯ�����Ŀ��Ա
	 * @param projectID
	 * @return
	 * @throws Exception
	 */
	public ppm_member [] queryMemberByProject(int projectID) throws Exception;
	
	
	/**
	 * ������ĿID��ѯ�����Ŀ��Ա���������Ƿ�Ϊ�������û�����ɸѡ
	 * @param projectID
	 * @param bPxlOnly
	 * @return
	 * @throws Exception
	 */
	public ppm_member [] queryMemberByProject(int projectID,boolean bPxlOnly) throws Exception;
	
	/**
	 * ɾ����Ŀ��Ա
	 * ��̨��ɾ���߼����кϷ���У�飬���������ɾ������׳��쳣
	 * @param memberID
	 * @throws Exception
	 */
	public void delete(int memberID) throws Exception;
	
	/**
	 * ������Ŀ��Ա��������Ŀ��ԱID
	 * @param member
	 * @return
	 * @throws Exception
	 */
	public int insert(ppm_member member) throws Exception;
	
	/**
	 * ������Ŀ��Ա
	 * @param member
	 * @throws Exception
	 */
	public void update(ppm_member member) throws Exception;
	/**
	 * ��ʾ��Ŀ��Ա
	 * @param memberId
	 * @throws Exception
	 */
	public ppm_member queryByID(int id) throws Exception;
	/**
	 * sql��ѯ����Ŀ��Ա
	 * @param memberId
	 * @throws Exception
	 */
	public ppm_member[] queryBySql(String sql) throws Exception;
	/*
	 *��ѯ�û� 
	 * */
	public bd_user queryUserByID(int id) throws Exception;
}
