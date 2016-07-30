package com.pxl.pkb.biz;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;

import com.pxl.pkb.framework.Params;
import com.pxl.pkb.framework.PxlInputStream;
import com.pxl.winservice.common.Utils;

public class FlashPaperUtil {
	
	//���ʹ�ת�����ļ�
	protected static void sendFile(String filePath,String fileName,DataOutputStream dout) throws Exception {
		PxlInputStream pin = null;
		try {
			pin = new PxlInputStream(filePath);
			dout.writeLong(pin.getFileSize());
			dout.write(Utils.getBytesByLen(fileName, 255));
			int len = -1;
			byte [] buff = new byte[512];
			while(true) {
				len = pin.read(buff);
				if(len<0) break;
				dout.write(buff,0,len);
			}
			dout.flush();
		} finally {
			try {if(pin!=null) pin.close();} catch (Exception e) {}
		}
	}
	
	//����ת������ļ�
	protected static void recvFile(String outFileName,DataInputStream din) throws Exception {
		
		//��ȡ���ر�־
		byte [] flagBytes = new byte[1];
		din.read(flagBytes);
		String flag = new String(flagBytes);
		if(!flag.equals("1")) {
			throw new Exception("ת����������");
		}
		
		//���ٴӷ�����´��ļ���ֻ��ȡ�ɹ���־
		/*
		//��ȡ�ļ�����
		long fileSize = din.readLong();
		
		//��ʼ�����ļ�
		long currSize = 0;
		long readSize = 0;
		int len = -1;
		byte [] buff = new byte[512];
		
		FileOutputStream fout = null;
		
		try {
			fout = new FileOutputStream(outFileName);
			while(true) {
				readSize = fileSize - currSize;
				readSize = Math.min(readSize, buff.length);
				if(readSize==0) break;
				len = din.read(buff, 0, (int)readSize);
				if(len<=0) break;
				fout.write(buff, 0, len);
				currSize+=len;
			}
			fout.flush();
		} finally {
			try {if(fout!=null) fout.close();} catch (Exception e) {}
		}
		*/
	}
	
	public static void convertFileToSwf(String date,int id,String fileExt) throws Exception {
		Params p = Params.getInstance();
		
		Socket s = null;
		InputStream in = null;
		OutputStream out = null;
		
		try {
			//ͨ��Socket�������͸�VMWare�е�Windows 2003ϵͳ�����˿ڹ̶�Ϊ9500
			s = new Socket(p.getFlashPaperServer(),p.getFlashPaperServerPort());
			in = s.getInputStream();
			out = s.getOutputStream();
			DataInputStream din = new DataInputStream(in);
			DataOutputStream dout = new DataOutputStream(out);
			
			//д�����������
			dout.write(Utils.getBytesByLen("FlashPaperConverter", 50));
			
			//�ļ����������չ�����Ա�FlashPaper����ת��
			String fileName = ""+id+((fileExt==null||fileExt.trim().length()==0)?"":("."+fileExt));
			
			//�����SWF�ļ�ȫ·��
			String outFileName = p.getFlashPaperPath()+File.separator+id+".swf";
			
			//���ܵĸ����ļ�ȫ·��
			String filePath = p.getUploadPath() +
				File.separator + "DOC" +
				File.separator + date +
				File.separator + id;
			
			//ͨ����������ȡ�ļ���Ϣ�����ļ�д��Socket�������͸�Windows 2003ϵͳ����
			sendFile(filePath, fileName, dout);
			
			//��ȡת�����SWF�ļ�
			recvFile(outFileName, din);
		} finally {
			try {if(in!=null) in.close();} catch (Exception e) {e.printStackTrace();}
			try {if(out!=null) out.close();} catch (Exception e) {e.printStackTrace();}
			try {if(s!=null) s.close();} catch (Exception e) {e.printStackTrace();}
		}
		
	}
	
}
