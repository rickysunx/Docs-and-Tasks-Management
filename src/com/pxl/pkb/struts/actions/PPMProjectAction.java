package com.pxl.pkb.struts.actions;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

import com.pxl.pkb.extendvo.ppm_taskon;
import com.pxl.pkb.framework.DataManagerObject;
import com.pxl.pkb.framework.PkbAction;
import com.pxl.pkb.struts.forms.PPMProjectForm;
import com.pxl.pkb.vo.ppm_member;
import com.pxl.pkb.vo.ppm_project;
import com.pxl.pkb.vo.ppm_task;
import com.pxl.pkb.vo.ppm_version;
import com.pxl.ppm.framework.BeanFactory;
import com.pxl.ppm.itfs.IMember;
import com.pxl.ppm.itfs.IProject;
import com.pxl.ppm.itfs.ITask;

public class PPMProjectAction extends PkbAction {
	IProject dom=null;
	ITask    tdom=null;
	IMember  mdom=null;
	public PPMProjectAction(){
		try {
			if(null==dom){
				dom = (IProject) BeanFactory.getBean("Project");
			}
			if(null==tdom){
				tdom=(ITask) BeanFactory.getBean("Task");
			}
			if(null==mdom){
				mdom = (IMember) BeanFactory.getBean("Member");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ActionForward pkbExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		PPMProjectForm projectForm = (PPMProjectForm) form;
		String method = projectForm.getMethod();
		if(null!=method&&!"".equals(method)){
			if(method.equals("add")){
			   return addExecute(mapping, projectForm, request, response);
			}else if(method.equals("select")){
				return selExecute(mapping,projectForm,request,response);
			}else if(method.equals("update")){
				return updaExecute(mapping,projectForm,request,response);
			}else if(method.equals("delete")){
				return delExcute(mapping,projectForm,request,response);
			}else if(method.equals("modify")){
				return modExcute(mapping,projectForm,request,response);
			}else if(method.equals("list")){
				return listExcute(mapping,projectForm,request,response);
			}else{
				return null;
			}
		}else{
			return null;
		}
		
	}


	//�����Ϣ
	private ActionForward addExecute(ActionMapping mapping, PPMProjectForm projectForm,HttpServletRequest request, HttpServletResponse response)throws Exception {
		ActionErrors errors = projectForm.validate(mapping, request);
		if(0!=errors.size()){
		    System.out.println(new Exception("�����ֵΪ�մ���")); 
		    System.out.println("�쳣��"+errors);
		    return mapping.findForward("errors");
		}else{
				try {
				if(null!=projectForm.getProjectCode()&&!"".equals(projectForm.getProjectCode())){
					String sql ="ProjectCode='"+projectForm.getProjectCode()+"'";
					ppm_project[] ppmproject = dom.queryByWhere(sql);
				    if(ppmproject.length!=0){
				    	  System.out.println(new Exception("����Ѿ�����"));
				    	return mapping.findForward("errors");
				    }
				}
				    ppm_project ppmproject = new ppm_project();
				    ppmproject.setProjectCode(projectForm.getProjectCode());
				    ppmproject.setProjectName(projectForm.getProjectName());
				    ppmproject.setProjectValue(projectForm.getProjectvalue());
				    ppmproject.setProjectStatus(IProject.PROJECT_STATUS_EDITING);
				    int id =dom.insert(ppmproject);
					ppm_project[] ppmprojects = dom.queryAll();
	    			request.setAttribute("ppmprojects", ppmprojects);
	    			return mapping.findForward("list");
				} catch (Exception e) {
					System.out.println("�����Ŀ�쳣");
					e.printStackTrace();
					 return mapping.findForward("errors");
				}
			   			
		}
		
	}

	//��ʾ������ϸ��Ϣ
	private ActionForward selExecute(ActionMapping mapping, PPMProjectForm projectForm, HttpServletRequest request, HttpServletResponse response) {
		String projectID = request.getParameter("projectId").trim();
		if(null==projectID||"".equals(projectID)){
			return mapping.findForward("error");
		}
		int projectId =Integer.parseInt(projectID);
		 if(0!=projectId){
			 try {
				 ppm_project ppmproject = dom.queryByID(projectId);
				 String sql ="IsLatest='1' and ProjectID='"+projectID+"'";
				 ppm_version[] ppmversions = dom.queryBysql(sql);
				 String vername="";
				 for(ppm_version ppmversion:ppmversions){
					 vername =ppmversion.getVerName();
				 }
				 ppm_member[] members = mdom.queryMemberByProject(projectId);
				 if(null!=ppmproject){
					  if(null!=vername&&!"".equals(vername)){
						  request.setAttribute("vername", vername);
					  }else{
						  request.setAttribute("vername", "�ް汾");
					  }
					 request.setAttribute("ppmproject",ppmproject);
					 request.setAttribute("members",members);
					 return mapping.findForward("select");
				 }else{
					 return mapping.findForward("error");
				 }
			} catch (Exception e) {
				  try {
					throw new Exception("��ʾ��Ŀ������Ϣʧ��");
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			      return mapping.findForward("error");
			}
			
		 }else{
			 return mapping.findForward("error");
		 }
	  
	}
   
	/*
	 * �༭ʱ��ʾ������Ϣ
	 * */
	private ActionForward modExcute(ActionMapping mapping, PPMProjectForm projectForm, HttpServletRequest request, HttpServletResponse response) {
		String projectID = request.getParameter("projectId").trim();
		if(null==projectID||"".equals(projectID)){
			return null;
		}
		int projectId =Integer.parseInt(projectID);
		 if(0!=projectId){
			 try {
				 ppm_project ppmproject = dom.queryByID(projectId);
				 if(null!=ppmproject){
					 request.setAttribute("ppmproject",ppmproject);
					 return mapping.findForward("modify");
				 }else{
					 return mapping.findForward("error");
				 }
			} catch (Exception e) {
				 System.out.println("��ʾ��Ŀ��ϸ��Ϣ��������");
				e.printStackTrace();
				 return mapping.findForward("error");
			}
			
		 }else{
			 return mapping.findForward("error");
		 }
	}


	
	//�༭�޸���Ϣ
	private ActionForward updaExecute(ActionMapping mapping, PPMProjectForm projectForm, HttpServletRequest request, HttpServletResponse response) {
		ActionErrors errors = projectForm.validate(mapping, request);
		if(0!=errors.size()){
		    System.out.println(new Exception("�����ֵΪ�մ���")); 
		    System.out.println("�쳣��"+errors);
		    return mapping.findForward("errors");
		}else{
				int projectId = projectForm.getProjectID();
				if(0!=projectId){
					try {
						ppm_project ppmproject = dom.queryByID(projectId);
						ppmproject.setProjectCode(projectForm.getProjectCode());
						ppmproject.setProjectName(projectForm.getProjectName());
						ppmproject.setProjectStatus(dom.PROJECT_STATUS_EDITING);
						dom.update(ppmproject);
						ppm_project[] ppmprojects = dom.queryAll();
		    			request.setAttribute("ppmprojects", ppmprojects);
		    			return mapping.findForward("list");
					} catch (Exception e) {
					    System.out.println("�༭��Ϣ����ʱ�����쳣");
						e.printStackTrace();
					    return mapping.findForward("errors");
					}
					
				}else{
					System.out.println("��ȡ��ĿID�쳣��Ϊnull");
				    return mapping.findForward("errors");
				}
		
			
			
		}
	}
   //ɾ����Ϣ
	private ActionForward delExcute(ActionMapping mapping, PPMProjectForm projectForm, HttpServletRequest request, HttpServletResponse response) {
		String projectID = request.getParameter("projectId").trim();
		int projectId =Integer.parseInt(projectID);
		if(0!=projectId){
			try {
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out = response.getWriter(); 
				ppm_task[] ppm_tasks = tdom.queryTaskByProject(projectId);
				if(ppm_tasks!=null&&ppm_tasks.length!=0){
					out.print("<script type=\"text/javaScript\"> alert(\"����Ŀ���Ѿ�������Ŀ�����޷�ɾ��\");history.go(-1);</script>");
				   return null;
				}else{
					dom.delete(projectId);
					ppm_project[] ppmprojects = dom.queryAll();
	    			request.setAttribute("ppmprojects", ppmprojects);
	    			return mapping.findForward("list");
				}
			} catch (Exception e) {
				e.printStackTrace();
				return mapping.findForward("errors");
			}
		}else{
			return mapping.findForward("errors");
		}
	}
	
	//�б�
	private ActionForward listExcute(ActionMapping mapping, PPMProjectForm projectForm, HttpServletRequest request, HttpServletResponse response) {
		  try {
			    String refproject=request.getParameter("refproject").trim();
			    if(refproject==null||refproject.equals("")){
			    	refproject="list";
			    }
               if(refproject!=null&&!refproject.equals("")){
		    		if(refproject.equals("list")){
		    			ppm_project[] ppmprojects = dom.queryAll();
		    			request.setAttribute("ppmprojects", ppmprojects);
		    			return mapping.findForward("list");
		    		}else if(refproject.equals("sele")){
		    			ppm_project[] ppmprojects = dom.queryByWhere("ProjectStatus=1");
		    			request.setAttribute("ppmprojects", ppmprojects);
		    			return mapping.findForward("chose");
		    		}else{
		    			return mapping.findForward("errors");
		    		}
		    	}else{
		    		return mapping.findForward("errors");
		    	}
		  } catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("errors");
		}
	}

}
