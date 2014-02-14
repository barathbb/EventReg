package action;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import bean.ChangeStatusBean;

public class ChangeStatusAction extends Action {
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		ChangeStatusBean cs = (ChangeStatusBean) form; 
		Connection conn = (Connection) request.getSession().getAttribute("Con");
		
		PreparedStatement pt1 = conn.prepareStatement("update Events set Status = ? where EventId = ?");
		
		pt1.setString(1, cs.getStatus());
		pt1.setInt(2, cs.getEventid());
		
		pt1.executeUpdate();
	
		request.setAttribute("Status", cs.getStatus());
		
		return mapping.findForward("success");
		
	}

}
