package action;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import bean.RemoveEntryBean;

public class RemoveEntryAction extends Action {
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		RemoveEntryBean rb = (RemoveEntryBean)form;
		
		Connection conn = (Connection) request.getSession().getAttribute("Con");
		
		PreparedStatement pt1 = conn.prepareStatement("delete from EventReg where EventId = ? and UserId = ?");
		
		pt1.setInt(1, rb.getEventid());
		pt1.setInt(2, rb.getUserid());

		pt1.executeUpdate();
		
		return mapping.findForward("success");
	
	}

}
