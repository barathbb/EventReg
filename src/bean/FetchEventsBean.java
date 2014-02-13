package bean;

import org.apache.struts.action.ActionForm;

public class FetchEventsBean extends ActionForm {
	
	private final static long serialVersionUID = 3L;
	
	private int param ;
	
	public int getParam()
	{
		return param;
	}
	
	public void setParam(int param)
	{
		this.param = param;
	}
}
