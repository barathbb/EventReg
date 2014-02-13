package bean;

import org.apache.struts.action.ActionForm;

import MyPackage.User;

public class SignupBean extends ActionForm {
	
	private final static long serialVersionUID = 7L;
	
	private String name,email,password,contact_number;
	
	public void setName(String name)
	{
		this.name = name;
	}
	
	public void setEmail(String email)
	{
		this.email = email;
	}
	
	public void setPassword(String password)
	{
		this.password = password;
	}
	
	public void setContact_number(String contact_number)
	{
		this.contact_number = contact_number;
	}
	
	public String getName()
	{
		return name;
	}
	
	public String getEmail()
	{
		return email;
	}
	
	public String getPassword()
	{
		return password;
	}
	
	public String getContact_number()
	{
		return contact_number;
	}

	public User toUser()
	{
		User u = new User();
		u.setName(name);
		u.setEmailId(email);
		u.setContact_Number(contact_number);
		return u;
		
	}
}
