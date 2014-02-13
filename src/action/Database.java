package action;

import java.sql.Connection;
import java.sql.DriverManager;

final class Database {
	
	private static String url = "jdbc:mysql://localhost:3306/";
    private static String dbName = "EventReg";
    private static String driver = "com.mysql.jdbc.Driver";
    private static String userName = "root";
    private static String password = "";
	
	public static Connection connectToDb() 
	{
		try {
	    Class.forName(driver).newInstance();
	    
	    Connection conn = DriverManager.getConnection(url+dbName,userName,password);
	    
	    return conn;
		}
		
		catch(Exception e)
		{
			System.out.print("Something wrong with database");
			return null;
		}
	}

}
