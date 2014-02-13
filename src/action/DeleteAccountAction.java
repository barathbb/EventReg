package action;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import MyPackage.User;
import bean.UserBean;

public class DeleteAccountAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		UserBean  db = (UserBean) form;
		
		Connection conn = (Connection) request.getSession().getAttribute("Con");
		
		PreparedStatement pt1 = conn.prepareStatement("delete from Users where UserId = ?");
		
		//System.out.print(db.getUserid());
		
		pt1.setInt(1, db.getUserid());
		
		pt1.executeUpdate();
		
		String forward_string = "";
		
		if(((User)request.getSession().getAttribute("User")).getAccount_Type().equals("A"))
			forward_string = "adminsuccess";
		
		if(((User)request.getSession().getAttribute("User")).getAccount_Type().equals("U"))
			forward_string = "success";

		return mapping.findForward(forward_string);	
	}
}
