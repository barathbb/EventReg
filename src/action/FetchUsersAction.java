package action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class FetchUsersAction extends Action {
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		Connection conn = (Connection)request.getSession().getAttribute("Con"); 
		
		PreparedStatement pt1 = conn.prepareStatement("select Name,UserId from Users where Account_Type = ? order by UserId desc");
		pt1.setString(1, "U");
		
		ResultSet rs = pt1.executeQuery();
		
		HashMap<Integer,String> userdetails = new HashMap<Integer,String>();
		
		while(rs.next())
			userdetails.put(rs.getInt("UserId"), rs.getString("Name"));
		
		request.setAttribute("UserDetails", userdetails);
		
		return mapping.findForward("success"); 
	}
}
