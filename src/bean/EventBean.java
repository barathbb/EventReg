package bean;

import org.apache.struts.action.ActionForm;

public class EventBean extends ActionForm {

	private static final long serialVersionUID = 5L;
	
	private int eventid;
	
	public int getEventid()
	{
		return eventid;
	}
	
	public void setEventid(int eventid)
	{
		this.eventid = eventid;
	}
}
