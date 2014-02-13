package action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import MyPackage.Event;
import MyPackage.User;
import MyPackage.Utils;
import bean.EventBean;

public class ShowEditEventAction extends Action {
	
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
			e.setStatus(rs.getString("Status"));
			e.setRegistration_Limit(rs.getInt("Registration_Limit"));
		}

		request.setAttribute("Event", e);
		
		String forward_string="",st = e.getStatus();
		
		if(((User)session.getAttribute("User")).getAccount_Type().equals("A"))
			forward_string = "adminsuccess";
		else if(st.equals("A"))
			forward_string = "Asuccess";
		else if(st.equals("P"))
			forward_string = "Psuccess";
		else if(st.equals("R"))
			forward_string = "Rsuccess";
	
		return mapping.findForward(forward_string);
	}

}
