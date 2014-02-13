package bean;

import org.apache.struts.action.ActionForm;

public class UserDataBean extends ActionForm {
	
	private static final long serialVersionUID = -10000L;
	
	private String email="";
	
	private String password="";
	
	public void setEmail(String email)
	{
		this.email = email;
	}
	
	public void setPassword(String password)
	{
		this.password = password;
	}
	
	public String getEmail()
	{
		return new String(email);
	}
	
	public String getPassword()
	{
		return new String(password);
	}
	
	public void reset()
	{
		email = null;
		password=null;
	}
}
