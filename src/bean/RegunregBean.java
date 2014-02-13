package bean;

import org.apache.struts.action.ActionForm;

public class RegunregBean extends ActionForm {
	
	private static final long serialVersionUID = 2L;
	
	private boolean reg=false,unreg=false;
	
	private Integer eventid;
	
	public boolean getReg()
	{
		return reg;
	}
	
	public boolean getUnreg()
	{
		return unreg;
	}
	
	public void setReg(boolean reg)
	{
		this.reg = reg;
	}
	
	public void setUnreg(boolean unreg)
	{
		this.unreg = unreg;
	}
	
	public Integer getEventid()
	{
		return eventid;
	}
	
	public void setEventid(Integer eventid)
	{
		this.eventid = eventid;
	}

}
