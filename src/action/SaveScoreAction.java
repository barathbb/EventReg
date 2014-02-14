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

import bean.SaveScoreBean;

public class SaveScoreAction extends Action {

	private Connection conn;
	
	private PreparedStatement pt1;
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		SaveScoreBean ss = (SaveScoreBean) form;
		
		conn = (Connection)request.getSession().getAttribute("Con");
		
		String[] idlist= ss.getIds().split(",");
		
		String[] scorelist = ss.getScores().split(",");
		
		int eventid = ss.getEventid();
		
		try{
		
		for(int i=0; i<idlist.length; i++)
		{
			saveOneScore(eventid, Integer.parseInt(idlist[i]), Integer.parseInt(scorelist[i]));
		}
		
		}
		
		catch(NumberFormatException n)
		{
			request.setAttribute("Scored", new Boolean(false));
			return mapping.findForward("failure");
		}
		
		request.setAttribute("Scored", new Boolean(true));
		
		return mapping.findForward("success");
		
	}
	
	public void saveOneScore(int eventid,int userid,int value) throws Exception
	{
		
		pt1 = conn.prepareStatement("select exists(select Points from Points where UserId = ? and EventId = ?)");
		pt1.setInt(1, userid);
		pt1.setInt(2, eventid);
		
		ResultSet rs = pt1.executeQuery();
		
		int count = 0;
		
		while(rs.next())
			count = rs.getInt(1);
		
		//System.out.print("Count is " + count);
		
		if(count == 1)
		{
			pt1 = conn.prepareStatement("update Points set Points = ? where EventId = ? and UserId =  ? ");
			pt1.setInt(1, value);
			pt1.setInt(2, eventid);
			pt1.setInt(3, userid);
		}
		else
		{
			pt1 = conn.prepareStatement("insert into Points values (?,?,?) ");
			pt1.setInt(1, userid);
			pt1.setInt(2, eventid);
			pt1.setInt(3, value);			
		}
		
		pt1.executeUpdate();
	}
	
}
