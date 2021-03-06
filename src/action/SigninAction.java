package action;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import java.sql.*;

import MyPackage.*;
import java.util.*;

import bean.SigninBean;
import bean.UserDataBean;
//import bean.UserIdBean;

public class SigninAction extends Action 
{
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception 
			{
		
		Connection conn ;
		
		HttpSession session = request.getSession(true); 
		
		String forward_string="";
		
		if(session.getAttribute("Con") == null)
		{
		conn = Database.connectToDb();
		
		session.setAttribute("Con", conn);
		}
		else
			conn = (Connection)session.getAttribute("Con");
		
		SigninBean udb = (SigninBean) form;
	    
	    PreparedStatement pt1 = conn.prepareStatement("select Password from Users where EmailId=?");
	    pt1.setString(1, udb.getEmail());
	    
	    ResultSet rs1 = pt1.executeQuery();
	        
	    String got_password="";
	    
	    while(rs1.next())
	    {
	    	got_password = rs1.getString("Password");
	    }
	    
	    if(got_password.equals(udb.getPassword()))
	    {
	    	User user = new User();
	    	PreparedStatement pt2 = conn.prepareStatement("select Name,Account_Type,UserId,Contact_Number from Users where EmailId = ?");
	    	pt2.setString(1, udb.getEmail());
	    	rs1 = pt2.executeQuery();
	    	while(rs1.next())
	    	{
	    		user.setAccount_Type(rs1.getString("Account_Type"));
	    		user.setContact_Number(rs1.getString("Contact_Number"));
	    		user.setName(rs1.getString("Name"));
	    		user.setUserId(rs1.getInt("UserId"));
	    		session.setAttribute("User", user);
	    	 } //Setting 'User' object
	    	
	    	PreparedStatement pt3 = conn.prepareStatement("select EventId from EventReg where UserId = ?");
	    	pt3.setInt(1, user.getUserId());
	    	
	    	ResultSet rs = pt3.executeQuery();
	    	
	    	List<Integer> REL = new ArrayList<Integer>();
	    	
	    	while(rs.next()) 
	    		REL.add(new Integer(rs.getInt("EventID")));
	    	
	    	if(REL.size() == 0)
	    		REL.add(new Integer(0));
	    	
	    	session.setAttribute("RegisteredEventList", REL); 
	    	
	    	if(user.getAccount_Type().equals("U"))
	    		forward_string="home";
	    	if(user.getAccount_Type().equals("A"))
	    		forward_string="adminhome";
	    }
	    else
	    	forward_string="index";
	    
		
		return mapping.findForward(forward_string);
	}	

	private List<Integer> getREL(Integer UserId, Connection conn) throws Exception
	{
		PreparedStatement pt1 = conn.prepareStatement("select EventId from EventReg where UserId = ? ");
		pt1.setInt(1, UserId);
		
		ResultSet rs = pt1.executeQuery();
		
		List<Integer> l = new ArrayList<Integer>();
		
		while(rs.next())
			l.add(new Integer(rs.getInt("EventId")));
		
		return l;
	}
}