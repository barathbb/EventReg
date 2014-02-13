package action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import bean.UserBean;
import MyPackage.Event;
import MyPackage.User;
import MyPackage.Utils;

public class ShowUserAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		UserBean ub = (UserBean) form;
		
		Connection conn = (Connection) request.getSession().getAttribute("Con");
		
		PreparedStatement pt1 = conn.prepareStatement("select Name,EmailId,Contact_Number from Users where UserId = ?");
		
		pt1.setInt(1, ub.getUserid());
		
		ResultSet rs = pt1.executeQuery();
		
		while(rs.next())
		{
			request.setAttribute("name", rs.getString("Name"));
			request.setAttribute("emailid", rs.getString("EmailId"));
			request.setAttribute("contact_number", rs.getString("Contact_Number"));
			request.setAttribute("userid", ub.getUserid());
		}
		
		
		//For created events
		pt1 = conn.prepareStatement("select EventId,Name,Registration_Limit from Events where Event_Owner = ? and Status= ?");
		pt1.setInt(1, ub.getUserid());
		pt1.setString(2, "A");
		
		rs = pt1.executeQuery();
		
		List<Event> createdevents = new ArrayList<Event>();
		Event temp = null;
		
		while(rs.next())
		{
			temp = new Event();
			temp.setName(rs.getString("Name"));
			temp.setEventId(rs.getInt("EventId"));
			temp.setAvailable(Utils.isAvailable(rs.getInt("EventId"), conn));
			createdevents.add(temp);
		}
		
		request.setAttribute("CreatedEvents", createdevents);
			
		String query_string = "select Name,EventId,Event_Owner,Registration_Limit from Events where EventId in ";
		query_string  += " (select EventId from EventReg where UserId = ? and Status = ? order by EventId desc ) order by EventId desc ";
		pt1 = conn.prepareStatement(query_string);
		pt1.setInt(1, ub.getUserid());
		pt1.setString(2, "A");
		
		rs = pt1.executeQuery();
		
		List<Event> registeredevents = new ArrayList<Event>();
		
		while(rs.next())
		{
			temp = new Event();
			temp.setName(rs.getString("Name"));
			temp.setEventId(rs.getInt("EventId"));
			temp.setAvailable(Utils.isAvailable(rs.getInt("EventId"), conn));
			registeredevents.add(temp);
			
		}
		
		request.setAttribute("RegisteredEvents", registeredevents);
		
		String forward_string="";
		
		if(((User)request.getSession().getAttribute("User")).getAccount_Type().equals("A"))
			forward_string="adminsuccess";
		if(((User)request.getSession().getAttribute("User")).getAccount_Type().equals("U"))
			forward_string="success";
		
		return mapping.findForward(forward_string);
		
	}
	
}
