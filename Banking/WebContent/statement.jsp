<%@ page import="java.sql.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Statement -NetBanking</title>
<h2><center>Net Banking</center></h2>
<table align="center" border=1 style="border-collapse:collapse" cellpadding="10">
<tr><td><a href="userpage.jsp">Home</a></td>
<td><a href="statement.jsp">View Statement</a></td>
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
	String unamew=session.getAttribute("uname").toString();
	String st=request.getParameter("st");
	String end=request.getParameter("end");
	if(unamew.equals(null) ||  st.equals(null)|| end.equals(null) ){
		
	}
	else{		
		Connection con=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking","root","");
			Statement stmt=con.createStatement();
			ResultSet rs=stmt.executeQuery("SELECT toac,amt,bal,txndate,txntype FROM transaction,acholder WHERE loginid='"+unamew+"' AND (txndate BETWEEN '"+st+" 00-00-00' AND '"+end+" 23-59-59') AND onac=acno ORDER BY txndate");
			out.println("<table border=1 cellpadding=\"10\" ><tr><th>Transaction Date & Time</th><th>FROM/TO A/C No</th><th>CREDIT/DEBIT</th><th>Amount</th><th>Balance</th>");
			while(rs.next()){	
				 String date=rs.getString(4);
				 
				 String toac=rs.getString(1);
				 String amt=rs.getString(2);
				 String bal=rs.getString(3);
				 String txntype=rs.getString(5);
				 
				 out.println("<tr><td>"+date+"</td>");
				
				 out.println("<td>"+toac+"</td>");
				 out.println("<td>"+txntype+"</td>");
				 out.println("<td>"+amt+"</td>");
				 out.println("<td>"+bal+"</td>");
				 
			}			
		}
		catch(Exception e){e.printStackTrace();}		
}
}
}catch(Exception e){e.printStackTrace();}

%>
<form action="logout" method="post" style="float: right;">
<input type="submit" value="Logout" >
</form>
<form action="statement.jsp" method="post">
Start date&nbsp;&nbsp;<input type="date" name="st">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;End date&nbsp;&nbsp;<input type="date" name="end">
<input type="submit">
</form>

</body>
</html>