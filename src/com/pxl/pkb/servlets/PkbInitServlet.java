/**
 * 
 */
package com.pxl.pkb.servlets;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import com.pxl.pkb.framework.Params;
import com.pxl.pkb.service.BackupService;
import com.pxl.pkb.service.PkbFtpServer;
import com.pxl.pkb.service.SendMailThread;

/**
 * @author Ricky
 *
 */
public class PkbInitServlet extends HttpServlet {

	
	/**
	 * 
	 */
	public PkbInitServlet() {
		super();
	}

	public void init(ServletConfig sc) throws ServletException {
		Params p = Params.getInstance();
		p.setBackupTime(sc.getInitParameter("BackupTime"));
		p.setBackupPath(sc.getInitParameter("BackupPath"));
		p.setBatchUploadPath(sc.getInitParameter("BatchUploadPath"));
		p.setUploadPath(sc.getInitParameter("UploadPath"));
		p.setFlashPaperPath(sc.getInitParameter("FlashPaperPath"));
		p.setFlashPaperServer(sc.getInitParameter("FlashPaperServer"));
		p.setDb_url(sc.getInitParameter("DbUrl"));
		p.setDb_user(sc.getInitParameter("DbUser"));
		p.setDb_pass(sc.getInitParameter("DbPass"));
		p.setMysqldumpPath(sc.getInitParameter("mysqldumpPath"));
		if(sc.getInitParameter("sendMail").equalsIgnoreCase("true")) {
			p.setSendMail(true);
		} else {
			p.setSendMail(false);
		}
		//������̨�̣߳��������ݿⱸ��
		BackupService.getInstance().start();
		
		//������̨�̣߳����ڷ����ʼ�
		SendMailThread.getInstence().start();
		
		try {
			System.out.println("=========����FTP����========");
			PkbFtpServer.getInstance().start();
			System.out.println("=========�ɹ�����FTP========");
		} catch (Throwable e) {
			e.printStackTrace(System.out);
		}
		
		System.out.println("===freeMem:"+Runtime.getRuntime().freeMemory());
		System.out.println("===totalMem:"+Runtime.getRuntime().totalMemory());
		System.out.println("===maxMem:"+Runtime.getRuntime().maxMemory());
		System.out.println("============================================");
		//System.getProperties().list(System.out);
	}

	public void destroy() {
		Params.getInstance().setSystemRunning(false);
//		try {
//			Hashtable ht = DataManagerObject.htThreadConn;
//			if(!Params.getInstance().isSystemRunning()) {
//				System.out.println("=========��ʼֹͣ���ݿ�����=============");
//				synchronized (ht) {
//					Thread [] threads = new Thread[ht.keySet().size()];
//					System.out.println("=========�߳���:"+ht.keySet().size()+"========");
//					ht.keySet().toArray(threads);
//					
//					for (int i = 0; i < threads.length; i++) {
//						System.out.println("=========ֹͣ��"+i+"�����ݿ�����========");
//						Object objConn = ht.get(threads[i]);
//						ht.remove(threads[i]);
//						if(objConn!=null) {
//							System.out.println("=========�ͷ����ݿ�����=============");
//							try {
//								Connection conn = (Connection)objConn;
//								if((!conn.getAutoCommit())&&(!conn.isClosed())) {
//									conn.commit();
//								}
//								if(!conn.isClosed()) {
//									conn.close();
//								}
//							} catch (Exception e) {
//								e.printStackTrace();
//							}
//						}
//					}
//					System.out.println("=========���ݿ�����ֹͣ���===========");
//				}
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		
		try {
			System.out.println("=========�ر�FTP����========");
			PkbFtpServer.getInstance().stop();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
