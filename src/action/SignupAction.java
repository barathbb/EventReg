package action;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import MyPackage.User;
import bean.SignupBean;
import bean.SigninBean;

public class SignupAction extends Action {
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		SignupBean sb = (SignupBean)form;
		
		char[] contact = sb.getContact_number().toCharArray();
		
		for(int i=0; i< contact.length; i++ )
		{
			if(Character.isAlphabetic(contact[i]))
			{
				request.setAttribute("Name", sb.getName());
				request.setAttribute("EmailId", sb.getEmail());
				request.setAttribute("Contact_Number", sb.getContact_number());
				request.setAttribute("Wrong contact number", new Boolean(true));
				return mapping.findForward("failure");
			}
		}
		
		Connection conn;
		
		if(request.getSession(true).getAttribute("Con") == null)
		{
			conn = Database.connectToDb();
			request.getSession().setAttribute("Con", conn);
		}
			
		else
		    conn = (Connection)request.getSession().getAttribute("Con");
		
		PreparedStatement pt1 = conn.prepareStatement("insert into Users(Name,EmailId,Password,Contact_Number,Account_Type) values(?,?,?,?,?)");
		
		pt1.setString(1, sb.getName());
		pt1.setString(2, sb.getEmail());
		pt1.setString(3, sb.getPassword());
		pt1.setString(4, sb.getContact_number());
		pt1.setString(5, "U");
		
		String forward_string = "";
		
		User data =(User)sb.toUser();
		
		//request.setAttribute("UserData", data);
		
		request.setAttribute("Signup", new Boolean(true));
		
		request.setAttribute("email", sb.getEmail());
		
		request.setAttribute("password", sb.getPassword());
		
		if(pt1.executeUpdate() == 1)
		{
			forward_string = "done";
			SigninBean sbn = new SigninBean();
			sbn.setEmail(sb.getEmail());
			sbn.setPassword(sb.getPassword());
			request.getSession().setAttribute("RegisteredEventList", new ArrayList<Integer>().add(new Integer(0)));
			
			PreparedStatement pt2 = conn.prepareStatement("select UserId from Users where EmailId = ?");
			pt2.setString(1, sb.getEmail());
			
			ResultSet rs = pt2.executeQuery();
			Integer UserId = 0;
			while(rs.next())
				UserId = rs.getInt("UserId");
			
			User user = new User();
			user.setName(sb.getName());
			user.setContact_Number(sb.getContact_number());
			user.setEmailId(sb.getEmail());
			user.setAccount_Type("U");
			user.setUserId(UserId);
			request.getSession().setAttribute("User", user);
		}
		
		return mapping.findForward(forward_string);
	}
}
