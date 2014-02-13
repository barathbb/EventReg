package action;

import MyPackage.*;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import bean.RegunregBean;
import java.util.List;
import java.util.ArrayList;

public class RegunregAction extends Action {
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		RegunregBean ru = (RegunregBean)form;
		
		HttpSession session = request.getSession();
		
		List<Integer> REL = (ArrayList<Integer>)session.getAttribute("RegisteredEventList");
		
		Connection conn = (Connection)session.getAttribute("Con");
		
		PreparedStatement pt1 = null;
		
		if(ru.getReg() == true)
		{
			if(Utils.getAvailableEntries(ru.getEventid(), conn) > 0 ) 
			{
			pt1 = conn.prepareStatement("insert into EventReg values (?,?)");
			pt1.setInt(1, ru.getEventid());
			pt1.setInt(2, ((User)session.getAttribute("User")).getUserId());
			}
			else
			{
				request.setAttribute("RegFailure", new Boolean(true));
				return mapping.findForward("not done");
			}
		}
		
		if(ru.getUnreg() == true)
		{
			pt1 = conn.prepareStatement("delete from EventReg where EventId = ? and UserId = ?");
			pt1.setInt(1, ru.getEventid());
			pt1.setInt(2, ((User)session.getAttribute("User")).getUserId());
		}
		
		String forward_string = "";
		
		if(pt1.executeUpdate() == 1)
			forward_string = "done";
		else
			forward_string = " not done";
		
		if(ru.getReg() == true) 
		{
			request.setAttribute("Registered", new Boolean(true));
			REL.add(ru.getEventid());
		}
			
		
		if(ru.getUnreg() == true )
		{
			request.setAttribute("Unregistered", new Boolean(true));
			REL.remove(ru.getEventid());
		}
		
		session.setAttribute("RegisteredEventList", REL);
		
		return  mapping.findForward(forward_string);
	}
}
