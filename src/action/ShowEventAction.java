package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import bean.EventBean;
import java.sql.*;
import MyPackage.Event;
import MyPackage.User;
import MyPackage.Utils;
import java.util.List;
import java.util.ArrayList;

public class ShowEventAction extends Action {
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		Connection conn = (Connection)session.getAttribute("Con");
		
		EventBean eb = (EventBean)form;
		
		Event e = new Event();
		
		PreparedStatement pt1 = null;
		
		pt1 = conn.prepareStatement("select * from Events where EventId = ? ");
		pt1.setInt(1, eb.getEventid());
		
		ResultSet rs = pt1.executeQuery();
		
		while(rs.next()) 
		{
			e.setEventId(eb.getEventid());
			e.setName(rs.getString("Name"));
			e.setDescription(rs.getString("Description"));
			e.setLocation(rs.getString("Location"));
			e.setStart_Date(rs.getTimestamp("Start_Date"));
			e.setEnd_Date(rs.getTimestamp("End_Date"));
			e.setEvent_Type(rs.getString("Event_Type"));
			e.setEvent_Owner(rs.getInt("Event_Owner"));
			e.setAvailable(Utils.isAvailable(eb.getEventid(), conn));
			e.setRegistration_Limit(rs.getInt("Registration_Limit"));
			e.setStatus(rs.getString("Status"));
		}

		request.setAttribute("Event", e);
		
		PreparedStatement pt2 = conn.prepareStatement("select EventId,Name,Registration_Limit from Events where Event_Owner = ? and Status = ? and EventId <> ? order by EventId desc");
		pt2.setInt(1, e.getEvent_Owner());
		pt2.setString(2, "A");
		pt2.setInt(3, eb.getEventid());
		
		rs = pt2.executeQuery();
		
		List<Event> otherevents = new ArrayList<Event>();
		
		Event temp =  null;
		
		while(rs.next())
		{
			temp = new Event();
			temp.setEventId(rs.getInt("EventId"));
			temp.setName(rs.getString("Name"));
			temp.setRegistration_Limit(rs.getInt("Registration_Limit"));
			temp.setAvailable(Utils.isAvailable( rs.getInt("EventId") , conn));
			otherevents.add(temp);
		}
		
		request.setAttribute("OtherEvents", otherevents);
		
		String forward_string="";
		
		if(((User)session.getAttribute("User")).getAccount_Type().equals("A"))
			forward_string="adminsuccess";
		if(((User)session.getAttribute("User")).getAccount_Type().equals("U"))
			forward_string="success";
		
		
		request.setAttribute("Available Entries", new Integer(Utils.getAvailableEntries(eb.getEventid(), conn)));
		
		return mapping.findForward(forward_string);
	}

}
