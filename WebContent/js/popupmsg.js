
var IE6;
IE6=true;

//��������msn��½��֪ͨ��Ĵ��룬�����µ���Ϣ�����ʱ�򵯳�֪ͨ
if(IE6){
	var oPopup = window.createPopup();
	var popTop=30;
	var iTimeout;
	var iMoveSpeed		= 50;	//����ĺ�������ԽСԽ��
	var iTableWidth		= 200;	//���ݱ��Ŀ��
	var iTableHeight	= 130;	//���ݱ��ĸ߶�
	var iTaskBarHeight	= 25;	//�������ĸ߶����ã������������λ�ÿ�ʼ����
	var stayTime		= 300000;//���������Ժ�ͣ����ʱ�䳤��
	var bPopupHide		= false;//���ڿ������صı���
}

	function closePop(){
		bPopupHide=true;
		oPopup.hide();
		clearTimeout(iTimeout);
		return false;
	}

	function popmsg(msgstr)
	{
		
		bPopupHide = false;
		var oDiv;
		
		var divs = oPopup.document.getElementsByTagName("div");
		if(divs.length>0) {
			oDiv = divs[0];
		} else {
			oDiv=oPopup.document.createElement("div");
		}
		
		oDiv.style.backgroundColor="#ffffff";
		oDiv.style.border="1px solid #6A9924";
		/*
		oDiv.innerHTML = "<table width='"+ (iTableWidth-2) +"' height='"+ (iTableHeight-2) +"' border='0' cellpadding='0' cellspacing='0' style='font-size:12px;'>" +
						"<tr><td height=25 align=center><b>��������ʾ</b></td></tr>" +
						"<tr><td align='left' valign='top'>" +
						msgstr+"</td></tr><tr><td align=center  style='cursor: hand;' onclick='parent.closePop();'><font color='#333333'>�ر�</font></td></tr></table>";
		*/
		var myhtml="";
		myhtml+="<table style='font-size: 12px;' width='"+(iTableWidth-2)+"' height='"+(iTableHeight-2)+"' border=\"0\" cellpadding=\"2\" cellspacing=\"2\">  ";
		myhtml+="  <tr>                                                                                         ";
		myhtml+="	<td height=\"20\" width='150' bgcolor=\"#E6F4D0\">����֪ͨ</td> ";
		myhtml+="	<td height=\"20\" width='50' bgcolor=\"#E6F4D0\" align='right'><span style='cursor: hand;' onclick='parent.closePop();'>�ر�</span></td> ";
		myhtml+="  </tr>                                                                                        ";
		myhtml+="  <tr>";
		myhtml+="	<td colspan='2' valign='top'>";
		myhtml+=msgstr;
		myhtml+="	</td>";
		myhtml+="  </tr>";
		
		myhtml+="</table>";
		
		oDiv.innerHTML = myhtml;
		
		
		/*oDiv.oncontextmenu = function(){
			bPopupHide=true;
			oPopup.hide();
			clearTimeout(iTimeout);
			return false;
		}*/
		oPopup.document.body.insertBefore(oDiv);
		popshow();
	}
	
	function popshow(iStay)
	{
		try {
			if(bPopupHide){
				return false;
			}
			var bFullDisplay=popTop-iTaskBarHeight>=iTableHeight;
			if (bFullDisplay && arguments.length>0){
				oPopup.show(screen.width-iTableWidth-20, screen.height-popTop, iTableWidth, iTableHeight);
				if(iStay>0)iTimeout=setTimeout("popshow("+ (iStay-iMoveSpeed) + ");",iMoveSpeed)
				else pophide();
			}
			else if(bFullDisplay){
				oPopup.show(screen.width-iTableWidth-20, screen.height-popTop, iTableWidth, iTableHeight);
				iTimeout=setTimeout("popshow(" + stayTime +");",iMoveSpeed);
			}
			else{
				oPopup.show(screen.width-iTableWidth-20, screen.height-popTop, iTableWidth, popTop-iTaskBarHeight);
				popTop+=10;
				iTimeout=setTimeout("popshow();",iMoveSpeed);
			}
		} catch (e) {
		}
		
	}
	function pophide(){
		if(bPopupHide){
			return false;
		}
		var bNullDisplay	= popTop<=30;
		if (bNullDisplay){
			oPopup.hide();
		}
		else{
			oPopup.show(screen.width-iTableWidth-20, screen.height-popTop, iTableWidth, popTop-iTaskBarHeight);
			popTop-=10;
			iTimeout=setTimeout("pophide();",iMoveSpeed);
		}
	}
	