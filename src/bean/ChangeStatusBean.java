package bean;

import org.apache.struts.action.ActionForm;

public class ChangeStatusBean extends ActionForm {
	
	private static final long serialVersionUID = 10L;
	
	private Integer eventid;
	
	private String status;
	
	public void setEventid(Integer eventid)
	{
		this.eventid = eventid;
	}
	
	public void setStatus(String status)
	{
		this.status = status;
	}
	
	public Integer getEventid()
	{
		return eventid;
	}
	
	public String getStatus()
	{
		return status;
	}

}
