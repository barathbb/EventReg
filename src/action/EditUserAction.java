package action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException;

import bean.EditUserBean;
import MyPackage.User;

public class EditUserAction extends Action {
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	
		boolean isAdmin = ((User)request.getSession().getAttribute("User")).getAccount_Type().equals("A");
		
		EditUserBean ub = (EditUserBean) form;
		
		Connection conn = (Connection) request.getSession().getAttribute("Con");

		User me = (User) request.getSession().getAttribute("User");
		
		String forward_string="Something wrong. Profile not edited",changed_attribute="";
		int way = ub.getWay();
		
		Integer UserId = ub.getUserid();
		
		PreparedStatement pt1 = null;
		
		if(way == 1)
		{
			pt1 = conn.prepareStatement("update Users set Name = ? where UserId = ?");
			pt1.setString(1, ub.getName());
			pt1.setInt(2, ub.getUserid());
			
			if(pt1.executeUpdate() == 1)
			{
				forward_string = "success";
				changed_attribute = "Name";
				if(!isAdmin)
					me.setName(ub.getName());
			}
		}
		
		if(way == 2)
		{
			changed_attribute = "Contact Number";
			
			char[] contact = ub.getContact_number().toCharArray();
			
			for(int i =0 ; i< contact.length; i++)
			{
				if(Character.isAlphabetic(contact[i]))
				{
					request.setAttribute("Changed Attribute", changed_attribute);
					request.setAttribute("Profile edited", new Boolean(false));
					return mapping.findForward("failure");	
				}
			}
			
			pt1 = conn.prepareStatement("update Users set Contact_Number = ? where UserId = ?");
			pt1.setString(1, ub.getContact_number());
			pt1.setInt(2, ub.getUserid());
			
			if(pt1.executeUpdate() == 1)
			{
				forward_string = "success";
				if(!isAdmin)
					me.setContact_Number(ub.getContact_number());
			}
		}
		
		if(way == 4)
		{
			pt1 = conn.prepareStatement("update Users set EmailId = ? where UserId = ?");
			pt1.setString(1, ub.getEmailid());
			pt1.setInt(2, ub.getUserid());
			
			try{
			
			if(pt1.executeUpdate() == 1)
			{
				forward_string = "success";
				changed_attribute = "Email";
				if(!isAdmin)
					me.setContact_Number(ub.getContact_number());
			}
			
			}
			
			catch(MySQLIntegrityConstraintViolationException e)
			{
				forward_string = "failure";
				request.setAttribute("Changed Attribute", new String("Email"));
				request.setAttribute("Profile edited", new Boolean(false));
				return mapping.findForward(forward_string);
			}
			
			catch(com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e)
			{
				forward_string = "failure";
				request.setAttribute("Changed Attribute", new String("Email"));
				request.setAttribute("Profile edited", new Boolean(false));
				return mapping.findForward(forward_string);
			}
			
			catch(Exception e)
			{
				forward_string = "failure";
				request.setAttribute("Changed Attribute", new String("Email"));
				request.setAttribute("Profile edited", new Boolean(false));
				return mapping.findForward(forward_string);
			}
		}
		
		if(way == 3)
		{
			changed_attribute = "Password";
			
			String got_password="";
			
			if(!isAdmin)
			{
			
			pt1 = conn.prepareStatement("select Password from Users where UserId = ?");
			pt1.setInt(1, ub.getUserid());
			
			ResultSet rs = pt1.executeQuery();
			
			while(rs.next())
				got_password = rs.getString("Password");
			}
			
			if(isAdmin || got_password.equals(ub.getOld_password()) )
			{
				pt1 = conn.prepareStatement("update Users set Password = ? where UserId = ?");
				pt1.setString(1, ub.getPassword());
				pt1.setInt(2, ub.getUserid());
				
				if(pt1.executeUpdate() == 1)
				{
					forward_string = "success";
				}	
			}
			else
			{
				request.setAttribute("Changed Attribute", changed_attribute);
				request.setAttribute("Profile edited", new Boolean(false));
				return mapping.findForward("failure");
			}
			
		}
		request.getSession().setAttribute("User", me);
		request.setAttribute("Changed Attribute", changed_attribute);
		request.setAttribute("Profile edited", new Boolean(true));
		return mapping.findForward(forward_string);
	}

}
