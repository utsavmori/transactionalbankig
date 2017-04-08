<%@ page import="java.sql.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login -NetBanking</title>
<h1><center>Net Banking</center></h1>
</head>
<body>
<%
		
try{	
	String unamew=request.getParameter("uname");
	String passw=request.getParameter("pass");


	if(unamew.equals(null) && passw.equals(null)){
		
	}
	else{
		
	if(session == null || session.getAttribute("uname") == null){
		session=request.getSession();
		session.setAttribute("uname",unamew );
		 session.setMaxInactiveInterval(60*3); //3min
		
		}
		
		Connection con=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking","root","");
			Statement stmt=con.createStatement();
			ResultSet rs=stmt.executeQuery("SELECT 	loginid,pass FROM acholder WHERE loginid='"+unamew+"' AND pass='"+passw+"' ");
			if(rs.next()){
				
				 request.getRequestDispatcher("userpage.jsp").forward(request,response);
			}
			else{
				out.println("<h2>Wrong Details<h2>");
			}
			
		}
		catch(Exception e){e.printStackTrace();}
		
		

}
}catch(Exception e){e.printStackTrace();}
%>








<fieldset><legend>User Login</legend>
<form method="post" action="index.jsp">
Username&nbsp;&nbsp;<input type="text" name="uname" autofocus><br><br>
Password&nbsp;&nbsp;<input type="password" name="pass"><br><br>
<input type="submit" value="Log in">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset">
</form>
</fieldset>
</body>
</html>