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

import MyPackage.User;
import MyPackage.Utils;
import bean.EditEventBean;

public class EditEventAction extends Action  {
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		Connection conn = (Connection)session.getAttribute("Con");
		
		EditEventBean eb = (EditEventBean)form;
		
		//System.out.print(eb.getLimit());
		
		if(eb.getLimit().equals("N"))
			eb.setRegistration_limit(-1);
			
		PreparedStatement pt1 = conn.prepareStatement("update Events set Name = ?,Description=?,Event_Type=?,Registration_Limit=? where EventId = ? ");
		
		pt1.setString(1, eb.getName());
		pt1.setString(2, eb.getDescription());
		pt1.setString(3, eb.getEvent_type());
		pt1.setInt(4, eb.getRegistration_limit());
		pt1.setInt(5, eb.getEventid());
		
		pt1.executeUpdate();
		
		return mapping.findForward("success");	
	}

}
