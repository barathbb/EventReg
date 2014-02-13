package bean;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

public class SaveScoreBean extends ActionForm {
	
	
	private String ids,scores;
	
	private Integer eventid;
	
	public String getIds()
	{
		return ids;
	}
	
	public String getScores()
	{
		return scores;
	}
	
	public void setIds(String ids)
	{
		this.ids = ids;
	}
	
	public void setScores(String scores)
	{
		this.scores = scores;
	}
	
	public Integer getEventid()
	{
		return eventid;
	}
	
	public void setEventid(Integer eventid)
	{
		this.eventid = eventid;
	}
	
	/*
	private Integer eventid,userid,value;
	
	public void setEventid(Integer eventid)
	{
		this.eventid = eventid;
	}
	
	public void setUserid(Integer userid)
	{
		this.userid = userid;
	}
	
	public void setValue(Integer value)
	{
		this.value = value;
	}
	
	public Integer getEventid()
	{
		return eventid;
	}
	
	public Integer getUserid()
	{
		return userid;
	}
	
	public Integer getValue()
	{
		return value;
	} 
	
	*/
	
}

