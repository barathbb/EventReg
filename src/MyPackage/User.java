package MyPackage;

public class User {

	private static Integer UserId;
	
	private static String Name;
	
	private static String EmailId;
	
	private static String Contact_Number;
	
	private static String Account_Type;
	
	public User()
	{
		
	}
	
	public User (Integer UserId, String Name, String EmailId, String Contact_Number,String Account_Type)
	{
		this.Name = Name;
	
		this.EmailId = EmailId;
	
		this.Contact_Number = Contact_Number;
	
		this.Account_Type = Account_Type;
	
		this.UserId = UserId ;	
	}
	
	
	public String getName()
	{
		return Name;
	}
	
	public String getEmailId()
	{
		return EmailId;
	}
	
	public String getContact_Number()
	{
		return Contact_Number;
	}
	
	public String getAccount_Type()
	{
		return Account_Type;
	}
	
	public int getUserId()
	{
		return UserId ;
	}
	
	public void setName(String s)
	{
		this.Name = s;
	}
	
	public void setEmailId(String s)
	{
		this.EmailId = s;
	}
	
	public void setContact_Number(String s)
	{
		this.Contact_Number = s;
	}

	public void setAccount_Type(String s)
	{
		this.Account_Type = s;
	}
	
	public void setUserId(int s)
	{
		this.UserId = s ;
	}
}
