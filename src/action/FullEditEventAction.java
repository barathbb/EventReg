package action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import bean.FullEditEventBean;

import MyPackage.DateManip;
import MyPackage.User;
import MyPackage.Utils;

public class FullEditEventAction extends Action {
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String forward_string = "";
		
		Connection conn = (Connection)request.getSession().getAttribute("Con");
		
		FullEditEventBean eb = (FullEditEventBean) form; 
		
		String account_type = ((User)request.getSession().getAttribute("User")).getAccount_Type();
		
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
		
		String query_string = "update Events set Name = ? ,Description = ? ,Event_Type =? ,Start_Date =? ,End_Date = ?,Location =? ,Registration_Limit =?, Status = ? ";
		
		query_string += " where EventId = ? ;";
		
		PreparedStatement pt1 = conn.prepareStatement(query_string);
		
		pt1.setString(1, eb.getName());
		pt1.setString(2, eb.getDescription());
		pt1.setString(3, eb.getEvent_type());
		pt1.setTimestamp(4, startDate);
		pt1.setTimestamp(5, endDate);
		pt1.setString(6, eb.getLocation());
		pt1.setInt(7, eb.getRegistration_limit());
		
		if(account_type.equals("A"))
			pt1.setString(8, "A");
		if(account_type.equals("U"))
			pt1.setString(8, "P");
		
		pt1.setInt(9, eb.getEventid());
		
		pt1.executeUpdate();
		
		String status = Utils.getStatus(eb.getEventid(), conn);	
		
		if(((User)request.getSession().getAttribute("User")).getAccount_Type().equals("A"))
			forward_string="adminsuccess";
		else if(status.equals("A"))
			forward_string="Asuccess";
		else if(status.equals("P") || status.equals("R"))
			forward_string="Osuccess";
		
		request.setAttribute("FullEdit", new Boolean(true));
		
		return mapping.findForward(forward_string);
		
	}

}
