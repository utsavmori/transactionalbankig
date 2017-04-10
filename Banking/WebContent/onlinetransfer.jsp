<%@ page import="java.sql.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Online Transefer -NetBanking</title>

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
	int res=0;
	String unamew=session.getAttribute("uname").toString();
	String to=request.getParameter("to");
	String amt=request.getParameter("amt");
	if(unamew.equals(null) ||  to.equals(null)|| amt.equals(null) ){
		
	}
	else{		
		Connection con=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking","root","");
			java.sql.CallableStatement cstmt=null;
			try {
				
				cstmt = con.prepareCall("{call maketransaction (?,?,?,?)}");
				cstmt.setString(1,unamew);
				cstmt.setString(2,to);
				cstmt.setString(3,amt);
				cstmt.registerOutParameter(4, java.sql.Types.BIGINT);
				cstmt.execute();
			 res = cstmt.getInt(4);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			if(res==1){out.println("<h2>Transaction Successful <br>make another transaction</h2>");}
			else {out.println("<h2>Transaction UnSuccessful<br>try again</h2>");}
		}
		catch(Exception e){e.printStackTrace();}		
}
}
}catch(Exception e){e.printStackTrace();}

%>
<form action="logout" method="post" style="float: right;">
<input type="submit" value="Logout" >
</form>

<form action="onlinetransfer.jsp" method="post">
To A/C&nbsp;&nbsp;<input type="number" min="0" name="to">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Amount in &#8377;&nbsp;&nbsp;<input type="text" name="amt">
<input type="submit">
</form>


</body>
</html>