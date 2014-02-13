package action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import bean.EventBean;
import MyPackage.User;
import MyPackage.Utils;

public class ShowReportAction extends Action{
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	
		EventBean eb = (EventBean) form;
		
		HttpSession session = request.getSession();
		
		Connection conn = (Connection) session.getAttribute("Con");
		
		PreparedStatement pt1= conn.prepareStatement("select Name from Events where EventId = ?");
		pt1.setInt(1, eb.getEventid());
		
		ResultSet rs = pt1.executeQuery();
		
		while(rs.next())
			session.setAttribute("EventName", rs.getString("Name")); 
		
		pt1 = conn.prepareStatement("select UserId from EventReg where EventId = ?");
		pt1.setInt(1, eb.getEventid());
		
		rs = pt1.executeQuery();
		
		List<Integer> regidlist = new ArrayList<Integer>();
		
		while(rs.next())
			regidlist.add(new Integer(rs.getInt("UserId")));
		
		HashMap<Integer,String[]> reguserlist = new HashMap<Integer,String[]>();
		
		String[] temp = null;
		
		for(Integer i : regidlist)
		{
			pt1 = conn.prepareStatement("select Name, EmailId, Contact_Number from Users where UserId = ?");
			pt1.setInt(1, i);
			
			rs = pt1.executeQuery();
			
			while(rs.next())
			{
				temp = new String[3];
				temp[0] = rs.getString("Name");
				temp[1] = rs.getString("EmailId");
				temp[2] = rs.getString("Contact_Number");
				reguserlist.put(i, temp);
			}
		}
		
		//request.setAttribute("UserList", reguserlist);
		
		session.setAttribute("UserList", reguserlist);
		
		request.setAttribute("EventId", eb.getEventid());
		
		session.setAttribute("EventId", eb.getEventid());
		
		if(Utils.hasScore(eb.getEventid(), conn))
		{
			//request.setAttribute("Scores", getScores(eb.getEventid(),conn));
			session.setAttribute("Scores", getScores(eb.getEventid(),conn));
		}
		
		return mapping.findForward("success");
	}
	
	public HashMap<Integer,Integer> getScores(Integer eventid, Connection conn) throws Exception
	{
		PreparedStatement pt1 = conn.prepareStatement("select UserId,Points from Points where EventId = ?");
		pt1.setInt(1, eventid);
		
		ResultSet rs = pt1.executeQuery();
		
		HashMap<Integer,Integer> scores = new HashMap<Integer,Integer>();
		
		while(rs.next())
		{
			scores.put(new Integer(rs.getInt("UserId")), new Integer(rs.getInt("Points")));
		}
		
		//System.out.print(scores); 
		
		return scores;	
	}
}
