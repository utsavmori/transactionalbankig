<%@ page import="java.sql.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Home -Net Banking</title>
<h2><center>Net Banking Admin</center></h2>
</head>
<%
try{	
	String unamew=request.getParameter("uname");
	String passw=request.getParameter("pass");
if(unamew.equals(null) && passw.equals(null)){
		
	}

else{
	
	if(session == null || session.getAttribute("uname") == null){
		session=request.getSession();
		session.setAttribute("aname",unamew );
		 session.setMaxInactiveInterval(60*5); //5min
		
		}
	
		
		Connection con=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking","root","");
			Statement stmt=con.createStatement();
			ResultSet rs=stmt.executeQuery("SELECT 	uname,pass FROM admin WHERE uname='"+unamew+"' AND pass='"+passw+"' ");
			if(rs.next()){				
				 request.getRequestDispatcher("/newuser.jsp").forward(request,response);
			}
			else{
				out.println("<h2>Wrong Details<h2>");
				 
			}
			
		}
		catch(Exception e){e.printStackTrace();}
		
		

}
}catch(Exception e){e.printStackTrace();}

%>
<body>

<fieldset align="center"><legend>Admin Login</legend>
<form action="admin.jsp" method="post">
Username&nbsp;&nbsp;<input type="text" name="uname" required><br><br>
Password&nbsp;&nbsp;<input type="password" name="pass" required><br><br>
<input type="submit">
</form>
</fieldset>
</body>
</html>