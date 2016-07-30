package com.pxl.ppm.itfs;

import com.pxl.pkb.extendvo.ppm_problemon;
import com.pxl.pkb.vo.ppm_member;
import com.pxl.pkb.vo.ppm_probassist;
import com.pxl.pkb.vo.ppm_problem;

/**
 * ����������ؽӿ�
 * @author Ricky
 *
 */
public interface IProblem {
	/**
	 * Ϊ������־��ѯ��������
	 * @param taskID
	 * @param userID
	 * @return
	 * @throws Exception
	 */
	public ppm_problemon [] queryForWorklog(int taskID) throws Exception;
	
	/**
	 * ������������
	 * @param problem
	 * @return
	 * @throws Exception
	 */
	public int insert(ppm_problem problem) throws Exception;
	
	/**
	 * ɾ����������
	 * @param problemID
	 * @throws Exception
	 */
	public void delete(int problemID) throws Exception;
	
	/**
	 * ������������
	 * @param problem
	 * @throws Exception
	 */
	public void update(ppm_problem problem) throws Exception;
	
	/**
	 * ���ppm_probassist�����������������˱�
	 * @param problem
	 * @throws Exception
	 */
	public ppm_probassist[] getProbassist(int problemId) throws Exception;
	/**
	 * д�����
	 * @param problem
	 * @throws Exception
	 */
	public void insertProbassist(ppm_probassist probassist)throws Exception;
	/**
	 * ����id��ѯ��
	 * @param problem
	 * @throws Exception
	 */
	public ppm_problem queryByProblemId(int problemID)throws Exception;

	public ppm_problemon[] queryBySql(String sql)throws Exception;
	public void deteProbassist(int problemId);
	public ppm_probassist[] queryProbassist(int memberID) throws Exception;
}
