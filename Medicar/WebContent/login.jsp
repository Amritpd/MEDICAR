<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link type="text/css"
	href="css/ui-lightness/jquery-ui-1.8.18.custom.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="style/theme.css">

<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.18.custom.min.js"></script>
<title>MEDICAR Diagnosis Manager</title>
</head>

<h3>Login Form</h3>  
</body>

<form method="POST" action='LoginController' name="frmLogin">  
	<table>
		<tr>
			<td>Email:</td>
			<td><input type="text" name="email"/></td>	
			<td></td>
		</tr>
		<tr>
			<td>Password:</td>
			<td><input type="password" name="password"/></td>	
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="submit" value="Login"/></td>	
			<td></td>
		</tr>
	</table>

	<p>${message}</p>
	<c:remove var="message" scope="session" /> 

  
</form>  
</body>
</html>