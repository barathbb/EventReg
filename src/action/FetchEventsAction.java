package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import MyPackage.*;
import bean.FetchEventsBean;
import java.sql.*;
import java.util.*;

public class FetchEventsAction extends Action {
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception 
	{
		HttpSession session = request.getSession();
		
		User user = (User)session.getAttribute("User");
				
		Connection conn = (Connection)session.getAttribute("Con");
		
		FetchEventsBean fb = (FetchEventsBean)form;
		
		int p = fb.getParam(); 
		
		PreparedStatement pt1 = null;
		
		if(p == 1)
		{
			pt1 = conn.prepareStatement("select Name,EventId,Location,Start_Date,End_Date,Event_Owner,Status from Events where Status= ? order by EventId desc");
			pt1.setString(1, "A");
		}
		
		if(p == 2)
		{	
			String query_string = "select Name,EventId,Location,Start_Date,End_Date,Event_Owner,Status from Events where EventId in ";
			query_string  += " (select EventId from EventReg where UserId = ? order by EventId desc ) order by EventId desc ";
			pt1 = conn.prepareStatement(query_string);
			pt1.setInt(1, user.getUserId()); 
		}
		
		if(p == 3)
		{
			pt1 = conn.prepareStatement("select Name,EventId,Location,Start_Date,End_Date,Event_Owner,Status from Events where Event_Owner = ? order by EventId desc");
			pt1.setInt(1, user.getUserId());
		}
		
		if(p == 4)
		{
			pt1 = conn.prepareStatement("select Name,EventId,Location,Start_Date,End_Date,Event_Owner from Events where Status = ? order by EventId desc ");
			pt1.setString(1, "A");
		}
		
		if(p == 5)
		{
			pt1 = conn.prepareStatement("select Name,EventId,Location,Start_Date,End_Date,Event_Owner from Events where Status = ? order by EventId desc ");
			pt1.setString(1, "P");
		}
		
		if(p == 6)
		{
			
			pt1 = conn.prepareStatement("select Name,EventId,Location,Start_Date,End_Date,Event_Owner from Events where Status = ? order by EventId desc ");
			pt1.setString(1, "R");
		}
		
		ResultSet rs = pt1.executeQuery();
		
		List<Event> eventlist = new ArrayList<Event>(); Event event;
		while(rs.next())
		{
			event = new Event();
			event.setName(rs.getString("Name"));
			event.setEventId(rs.getInt("EventId"));
			event.setLocation(rs.getString("Location"));
			event.setStart_Date(rs.getTimestamp("Start_Date"));
			event.setEnd_Date(rs.getTimestamp("End_Date"));
			event.setEvent_Owner(rs.getInt("Event_Owner"));
			if(p < 4)
				event.setStatus(rs.getString("Status"));
			event.setAvailable(Utils.isAvailable(event.getEventId(), conn));
			eventlist.add(event);
		}
		
		request.setAttribute("EventList", eventlist);
		request.setAttribute("param", new Integer(p));
		
		String forward_string="";
		
		if(user.getAccount_Type().equals("U"))
				forward_string = "displayevents";
		if(user.getAccount_Type().equals("A"))
				forward_string = "admindisplayevents";
		
		return mapping.findForward(forward_string);
	}
	
}
