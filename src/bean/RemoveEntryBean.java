package bean;

import org.apache.struts.action.ActionForm;

public class RemoveEntryBean extends ActionForm {

	private final static long serialVersionUID = 6L;
	
	private int eventid,userid;
	
	public int getUserid()
	{
		return userid;
	}
	
	public int getEventid()
	{
		return eventid;
	}
	
	public void setUserid(int userid)
	{
		this.userid = userid;
	}
	
	public void setEventid(int eventid)
	{
		this.eventid = eventid;
	}
}

