package com.pxl.ppm.framework;

/**
 * Bean����
 * ͨ����������ȡ����ӿ�
 * @author Ricky
 * @version 1.0
 */
public class BeanFactory {
	
	/**
	 * ��ȡ����ӿ�Bean
	 * @param beanName �ӿ���
	 * @return �ӿ�Bean��ʵ��
	 */
	public static Object getBean(String beanName) throws Exception {
		String className = "com.pxl.ppm.impls."+beanName+"Impl";
		Class c = Class.forName(className);
		return c.newInstance();
	}
	
}
