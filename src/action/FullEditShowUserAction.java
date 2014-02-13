package action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import bean.UserBean;

public class FullEditShowUserAction extends Action {
	
	
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
			request.setAttribute("userid", ub.getUserid());
			request.setAttribute("contact_number", rs.getString("Contact_Number"));
		}
		
		return mapping.findForward("success");
	}

}
