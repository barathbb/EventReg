package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import MyPackage.DateManip;
import MyPackage.User;
import bean.CreateEventBean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.*;

public class CreateEventAction extends Action  {
	
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception 
	{
		CreateEventBean eb = (CreateEventBean) form;
		
		Connection conn = (Connection) request.getSession().getAttribute("Con"); 
		
		String startDateValue="",endDateValue="",startTimeValue="",endTimeValue="";
		
		startDateValue = eb.getStart_year() + "-" + eb.getStart_month() + "-" + eb.getStart_day();
		endDateValue = eb.getEnd_year() + "-" + eb.getEnd_month() + "-" + eb.getEnd_day();
 		
		//String startDateValue = sy + "-"+ sM +"-"+sd;
		//String endDateValue = ey + "-"+ eM +"-"+ed;

		if(eb.getStart_AMPM().equalsIgnoreCase("PM"))
			eb.setStart_hour(eb.getStart_hour() + 12);
		
		if(eb.getEnd_AMPM().equalsIgnoreCase("PM"))
			eb.setEnd_hour(eb.getEnd_hour() + 12);
		
		//if(eap.equalsIgnoreCase("PM"))
			//eh = new Integer(Integer.parseInt(eh) + 12).toString();

		//if(sap.equalsIgnoreCase("PM"))
			//sh = new Integer(Integer.parseInt(sh) + 12).toString();
		
		startTimeValue = eb.getStart_hour() + ":" + eb.getStart_minute() + ":00";
		endTimeValue = eb.getEnd_hour() + ":" + eb.getEnd_minute() + ":00";
		
		//String startTimeValue = sh + ":"+ sm +":00";
		//String endTimeValue = eh + ":"+ em +":00";
		
		//System.out.println(startDateValue + "\t" + startTimeValue);
		//System.out.println(endDateValue + "\t" + endTimeValue);

		Timestamp startDate = DateManip.toTimestamp(startDateValue, startTimeValue);

		Timestamp endDate = DateManip.toTimestamp(endDateValue, endTimeValue);
		
		if(startDate.after(endDate))
		{
			request.setAttribute("DateFailure", new String("Start date was after End date"));
			return mapping.findForward("datefailure");
		}
		
		String query_string = "insert into Events(Name,Description,Event_Type,Start_Date,End_Date,Location,Registration_Limit,Event_Owner,Status) ";
		
		query_string += " values(?,?,?,?,?,?,?,?,?);";
		
		PreparedStatement pt1 = conn.prepareStatement(query_string);
		
		pt1.setString(1, eb.getName());
		pt1.setString(2, eb.getDescription());
		pt1.setString(3, eb.getEvent_type());
		pt1.setTimestamp(4, startDate);
		pt1.setTimestamp(5, endDate);
		pt1.setString(6, eb.getLocation());
		pt1.setInt(7, eb.getRegistration_limit());
		pt1.setInt(8, ((User)request.getSession().getAttribute("User")).getUserId());
		pt1.setString(9, "P");
		
		pt1.executeUpdate();
		
		request.setAttribute("Event Created", new Boolean(true));
		
		pt1 = conn.prepareStatement("select LAST_INSERT_ID()");
		
		ResultSet rs = pt1.executeQuery();
		
		while(rs.next())
			request.setAttribute("EventId", rs.getInt(1));
		
		return mapping.findForward("success");
		
	}

}
