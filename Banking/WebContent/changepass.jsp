<%@ page import="java.sql.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Change Password -Net Banking</title>
<h2><center>Net Banking</center></h2>
<table align="center" border=1 style="border-collapse:collapse" cellpadding="10">
<tr><td><a href="userpage.jsp">Home</a></td>
<tr><td><a href="statement.jsp">View Statement</a></td>
<td><a href="onlinetransfer.jsp">Online Transfer</a></td>
<td><a href="changepass.jsp">Change Password</a></td>
</table>
<hr>
<br>
</head>
<body>
<%
try{	
	
if(session == null || session.getAttribute("uname") == null){
	 out.println("<h2>Your Session Has timed out!!!</h2>");
	 request.getRequestDispatcher("/index.jsp").forward(request, response);	
	
	}
else{
	int rs=0;
	String unamew=session.getAttribute("uname").toString();
	String pass=request.getParameter("pass");
	
	if(unamew.equals(null) ||  pass.equals(null)){
		
	}
	else{		
		Connection con=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking","root","");
			Statement stmt=con.createStatement();
			try {
				
				 rs=stmt.executeUpdate("UPDATE acholder SET pass='"+pass+"' WHERE loginid='"+unamew+"'");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			if(rs==1){out.println("<h2>Password Changed Successfully.. </h2>");}
			else {out.println("<h2>Password Not Changed<br>try again</h2>");}
		}
		catch(Exception e){e.printStackTrace();}		
}
}
}catch(Exception e){e.printStackTrace();}

%>
<form action="logout" method="post" style="float: right;">
<input type="submit" value="Logout" >
</form>

<script>function confirmpass(){if(document.getElementsByName("pass")[0].value!=document.getElementsByName("conpass")[0].value){document.getElementById("sub").disabled=true;document.getElementById("errmsg").innerHTML = "Passwords Should Match"}else {document.getElementById("sub").disabled=false;document.getElementById("errmsg").innerHTML = ""}}</script>
<form action="changepass.jsp" method="post">
Enter New Password&nbsp;&nbsp;<input type="password"  name="pass"  onchange="confirmpass()" required>&nbsp;&nbsp;Confirm New Password&nbsp;&nbsp;<input type="password"  name="conpass" onchange="confirmpass()"  required>&nbsp;&nbsp;<span  id="errmsg"> </span><br><br><input type="submit" id="sub" disabled >
</form>

</body>
</html>