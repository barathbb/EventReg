package bean;

import org.apache.struts.action.ActionForm;

public class EditUserBean extends ActionForm {
	
	private final static long serialVersionUID = 8L;
	
	private int way;
	
	private Integer userid;
	
	private String password, old_password,contact_number,name,emailid;
	
	public void setEmailid(String emailid)
	{
		this.emailid = emailid;
	}
	
	public void setName(String name)
	{
		this.name = name;
	}
	
	public void setWay(int way)
	{
		this.way = way;
	}
	
	public void setUserid(Integer userid)
	{
		this.userid = userid;
	}
	
	public void setPassword(String password)
	{
		this.password = password;
	}

	public void setOld_password(String old_password)
	{
		this.old_password = old_password;
	}
	
	public void setContact_number(String contact_number)
	{
		this.contact_number = contact_number;
	}
	
	public String getEmailid()
	{
		return emailid;
	}
	
	public int getWay()
	{
		return way;
	}
	
	public Integer getUserid()
	{
		return userid;
	}
	
	public String getPassword()
	{
		return password;
	}
	
	public String getOld_password()
	{
		return old_password;
	}
	
	public String getContact_number()
	{
		return contact_number;
	}
	
	public String getName()
	{
		return name;
	}
	
}
