package com.pxl.pkb.biz;

import java.net.Socket;
import java.text.DateFormat;
import java.util.Date;
import java.util.Hashtable;
import java.util.Properties;
import java.util.Vector;

import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.naming.NamingEnumeration;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;

import com.pxl.pkb.framework.DataManagerObject;
import com.pxl.pkb.framework.Params;
import com.pxl.pkb.framework.ValueObject;
import com.pxl.pkb.vo.bd_mail;
import com.pxl.pkb.vo.bd_mailuser;
import com.pxl.pkb.vo.bd_user;
public class Mail {

	
	
	public static String [] getHostMxRecords(String host) throws Exception {
		Hashtable env = new Hashtable();
		env.put("java.naming.factory.initial","com.sun.jndi.dns.DnsContextFactory");
		env.put("java.naming.provider.url","dns://8.8.8.8");
		DirContext ictx = new InitialDirContext(env);
		
		Attributes attrs = ictx.getAttributes(host, new String[]{"MX"});
		Attribute attr = attrs.get("MX");
		
		if(attr==null) {
			return new String[]{host};
		}
		
		Vector v = new Vector();
		NamingEnumeration en = attr.getAll();
		while(en.hasMoreElements()) {
			String x = (String) en.next();
			String [] f = x.split(" ");
			if(f[1].endsWith(".")) {
				f[1] = f[1].substring(0,f[1].length()-1);
			}
			v.add(f[1]);
		}
		String [] records = new String[v.size()];
		v.copyInto(records);
		return records;
	}
	
	public static String getEmailHost(String emailAddress) throws Exception {
		if(emailAddress!=null) {
			int index = emailAddress.indexOf("@");
			if(index==-1) throw new Exception("�Ƿ���Email��ַ");
			return emailAddress.substring(index+1);
		} else {
			throw new Exception("email��ַ����Ϊ��");
		}
	}
	
	public static void sendmail(String emailAddress,String subject,String content) throws Exception {
		if(!Params.getInstance().isSendMail()) return;
		
		String [] mxRecords = getHostMxRecords(getEmailHost(emailAddress));
		
//		for (int i = 0; i < mxRecords.length; i++) {
//			try {
//				s = new Socket(mxRecords[i],25);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
		
		//if(s==null) throw new Exception("�����ʼ�������ʧ��");
		
		Properties props=System.getProperties();
		props.put("mail.smtp.auth","false");//ͬʱͨ����֤
		props.put("mail.smtp.connectiontimeout", "100000"); //��¼��ʱʱ��
		props.put("mail.smtp.timeout", "100000"); //���öϿ�ʱ��
		props.put("mail.mime.charset", "gbk");//�����ʼ��ı��뷽ʽ
		
		Session s=Session.getInstance(props,null);
		Message message=new MimeMessage(s);
		
		BodyPart bodyPart=new MimeBodyPart();
		bodyPart.setContent(content,"text/html;charset=gbk");
		MimeMultipart mm=new MimeMultipart();
		mm.addBodyPart(bodyPart);
		message.setContent(mm);
		
		Address from=new InternetAddress("pkb@pushingline.com","֪ʶ��ϵͳ");
		Address to=new InternetAddress(emailAddress);
		
		message.setFrom(from);//���÷�����
		message.setRecipient(Message.RecipientType.TO,to);// �����ռ���,���������������ΪTO,����3��Ԥ��������
		message.setSubject(subject);//��������
		message.setSentDate(new Date());//���÷���ʱ��
		message.saveChanges();//�洢�ʼ���Ϣ
		
		for (int i = 0; i < mxRecords.length; i++) {
			try {
				Transport transport=s.getTransport("smtp");
				transport.connect(mxRecords[i],null,null);
				transport.sendMessage(message, message.getAllRecipients());
				transport.close();
				break;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
	
	public static void main(String [] args) {
		try {
			sendmail("yangbo524@126.com","��������","�����ϵͳ���޸�");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void sendMail(int mailUserId) throws Exception {
		DateFormat format=DateFormat.getDateInstance();
		Date date=new Date();
		DataManagerObject dmo=new DataManagerObject();
		
		ValueObject[] mailUservos=dmo.queryByWhere(bd_mailuser.class, "mailuserid="+mailUserId);
		
		if(mailUservos.length!=1){
			throw new Exception("��ȡ�ʼ���Ϣ����");
		}
		bd_mailuser mailUser=(bd_mailuser)mailUservos[0];
		
		ValueObject[] mailvos=dmo.queryByWhere(bd_mail.class, "mailid="+mailUser.getMailID());
		if(mailvos.length!=1){
			throw new Exception("�����ʼ���Ϣ����");
		}
		bd_mail mail=(bd_mail)mailvos[0];
		String msg=mail.getMailContext()+"<br/><table align='right' width='90' border='0' style='color:gray;'><tr><td>"+format.format(date)+"</td></tr><tr><td><hr/></td></tr><tr><td>֪ʶ��ϵͳ</td></tr></talbe>";
		
		ValueObject[] uservos=dmo.queryByWhere(bd_user.class, "userid="+mailUser.getUserID());
		if(uservos.length!=1){
			throw new Exception("�����ʼ���ַʧ��");
		}
		bd_user user=(bd_user)uservos[0];
		try{
//			Properties props=System.getProperties();
//			//JavaMail��ҪProperties������һ��session��������Ѱ���ַ���"mail.smtp.host"������ֵ���Ƿ����ʼ�������.
//			//Properties�����ȡ�����ʼ����������û������������Ϣ���Լ�������������Ӧ�ó����� �������Ϣ��
//	
//	//		Properties props=new Properties();//Ҳ����Properties props = System.getProperties();
//	//		props.put("mail.smtp.host","smtp.126.com");// �洢�����ʼ�����������Ϣ
//			props.put("mail.smtp.auth","true");//ͬʱͨ����֤
//			props.put("mail.smtp.connectiontimeout", "10000"); //��¼��ʱʱ��
//			props.put("mail.smtp.timeout", "10000"); //���öϿ�ʱ��
//			props.put("mail.mime.charset", "gb2312");//�����ʼ��ı��뷽ʽ
//			
//			//�������� (�������weblogin����JavaMail������ָ��JNDI������
//			//Context ctx=new InitialContext();
//			//Session s=(Session)ctx.lookup("MailSession");
//			//Message msg=new MimeMessage(s);
//	
//	
//			//���Session�����JavaMail �е�һ���ʼ�session. ÿһ������ JavaMail��Ӧ�ó���������һ��session���ǿ�����������session��
//			//Session�ඨ��ȫ�ֺ�ÿ���û������ʼ���ص����ԡ��������˵���˿ͷ����ͷ�������ν�����Ϣ��
//	
//			Session s=Session.getInstance(props,null);//���������½�һ���ʼ��Ự��null������һ�� Authenticator(��֤����) ����
//	//		s.setDebug(true);//���õ��Ա�־,Ҫ�鿴�����ʼ��������ʼ���������ø÷���
//	
//			//  һ���������Լ���Session���󣬾��Ǹ�ȥ����Ҫ���͵���Ϣ�� ʱ���ˡ���ʱ��Ҫ�õ���Ϣ����(MimeMessage������һ������)��
//			//��Message���󽫴洢����ʵ�ʷ��͵ĵ����ʼ���Ϣ��Message������Ϊһ��MimeMessage����������������Ҫ֪��Ӧ��ѡ����һ��JavaMail session��
//			//  Message���ʾ�����ʼ���Ϣ���������԰������ͣ���ַ��Ϣ���������Ŀ¼�ṹ��
//	
//			Message message=new MimeMessage(s);//���ʼ��Ự�½�һ����Ϣ����
//			/**
//			 * ����text�ʼ�
//			 */
//			//message.setText(msg);//�����ż�����
//	
//			/**
//			 * ����HTML�ʼ�
//			 */
//			BodyPart bodyPart=new MimeBodyPart();//�½�һ������ż����ݵ�BodyPart����
//			bodyPart.setContent(msg,"text/html;charset=gb2312");//�oBodyPart�����O�Ã��ݺ͸�ʽ/���a��ʽ
//			MimeMultipart mm=new MimeMultipart();//�½�һ��MimeMultipart�����Á���BodyPart��
//			mm.addBodyPart(bodyPart);//��BodyPart���뵽MimeMultipart������(���Լ������BodyPart)
//			message.setContent(mm);//������Ϣ����������,������͵ĸ�ʽ��HTML��ʽ�ͱ������ã�
//			
//			//�����ʼ�,һ���������� Session �� Message����������������Ϣ�󣬾Ϳ�����Addressȷ���ż���ַ�ˡ�
//			//�������һ�����ֳ����ڵ����ʼ���ַ��Ҳ���Խ��䴫�ݸ���������
//			Address from=new InternetAddress("xiong3102598@126.com","֪ʶ��ϵͳ");//�����˵��ʼ���ַ
//			Address to=new InternetAddress(user.getEMail());//�ռ��˵��ʼ���ַ
//			
//			message.setFrom(from);//���÷�����
//			message.setRecipient(Message.RecipientType.TO,to);// �����ռ���,���������������ΪTO,����3��Ԥ��������
//			message.setSubject(mail.getMailSubject());//��������
//			message.setSentDate(date);//���÷���ʱ��
//			message.saveChanges();//�洢�ʼ���Ϣ
//	
//			// Transport ������������Ϣ�ģ�
//			// �����ʼ����շ��������
//			Transport transport=s.getTransport("smtp");
//			transport.connect("smtp.126.com","xiong3102598","3102598");//��smtp��ʽ��¼����
//			transport.sendMessage(message,message.getAllRecipients());// �����ʼ�,���еڶ�����������������õ��ռ��˵�ַ
//			transport.close();
			sendmail(user.getEMail(), mail.getMailSubject(), msg);
			mailUser.setSendDate(Pub.getCurrTime());
			mailUser.setFailedReason("");
			mailUser.setIsSuccess("1");
			dmo.update(mailUser);
		}catch(Exception e){
			mailUser.setFailedCount(mailUser.getFailedCount()+1);
			mailUser.setIsSuccess("0");
		}
	}
//	public static void main(String[] args) throws Exception {
//		Mail.sendMail("xiongay1@ufida.com.cn", "����", "���Բ��Բ��Բ��Բ��Բ���");
//	}
	
}
