package bean;

import org.apache.struts.action.ActionForm;

public class UserBean extends ActionForm {
	
	private final static long serialVersionUID = 7L;
	
	private int userid;
	
	public void setUserid(int userid)
	{
		this.userid = userid;
	}
	
	public int getUserid()
	{
		return userid;
	}

}
