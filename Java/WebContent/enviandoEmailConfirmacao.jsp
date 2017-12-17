<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="javax.mail.*"%>
<%@ page import="dao.UsuarioDAO"%>
<%@ page import="model.Usuario"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="java.math.BigInteger"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.security.NoSuchAlgorithmException"%>
<%@ page import="java.util.Properties"%>
<%
	
		
%>
<!DOCTYPE html>
<html>

  <head>

    <meta name="viewport" content="width=device-width, initial-scale=1">
     <link href="https://s3.amazonaws.com/codecademy-content/courses/ltp/css/shift.css" rel="stylesheet">
    <link rel="stylesheet" href="https://s3.amazonaws.com/codecademy-content/courses/ltp/css/bootstrap.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/main.css">
	<link rel="stylesheet" href="css/log_cad.css">
	<link rel="stylesheet" href="css/css.css">
    
  </head>

  <body>
   <nav class="navbar navbar-inverse navbar-static-top">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="index.jsp"><img src="css/LogoSploe.png"></a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      
      <ul class="nav navbar-nav navbar-right">
         <li><a href="ajuda.jsp">Ajuda</a></li>
      </ul>
    </div>
  </div>
</nav>
	
	<div class="main">
  <div class="login-box">
    <div class="info">Verifique seu e-mail, uma URL para confirmação foi enviada.</div>
	<br/>
	<center>
	 <a href="index.jsp"><button class="animatedbutton2"><span>Inicio</span></button></a>
	 <br/><br/>
		      
	       </div>
		 </div>
     </div>
    
  </body>
</html>