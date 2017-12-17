<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="model.*"%>
<%@ page import="dbcon.Conexao"%>
<%@ page import="dao.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpServlet"%>
<%@ page import="javax.servlet.annotation.WebServlet"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ page import="javax.servlet.RequestDispatcher"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.io.IOException"%>

<% 
	//se tiver uma sessao ativa ele encaminha para a minha conta
	//se nao tiver ele recarrega a pagina com uma sessao null, eh necessario fazer isso pois como esta vazio, nem null tem, entao ele da um erro	
	try{
		
		Usuario user = new Usuario();
		String email = (String) session.getAttribute("email");
		
		if(!email.equals("null")){
			response.sendRedirect("minhaConta.jsp");
		}
	}catch (Exception e) {
		 session.setAttribute("email", "null");
		 response.sendRedirect("login.jsp");
	}	
		
%>
<!DOCTYPE html>
<html>

  <head>
    <meta charset="utf-8">
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
        <li><a href="cadastro.jsp">Cadastrar</a></li>
        <li><a href="ajuda.jsp">Ajuda</a></li>
      </ul>

    </div>
  </div>
</nav>
	
	<div class="main">
  <div class="login-box">
    <div class="info">Login</div>
		      <form  action="/login" method="post" class="form-horizontal form-box">
			      <div class="logo">
				     <img src="css/perfil.png" width="100" height="100">
                   </div>
				   <div class="input-group-lg">
				     
					 <input name="email" type="text" class="form-control inp" placeholder="Email" maxlength="30" required />
		           </div>
				   <div class="input-group-lg">
				     
					 <input name="senha" type="password" class="form-control inp" placeholder="Senha" maxlength="10" required />
		           </div>
				   <div class="k">
				   		<a class="pull-right" href="redefinir.jsp">Esqueceu sua senha?</a>
	
				   </div>
				   <br/>
				   <div class="form-group-in">
					 <input type="submit" class="btn btn-info btn-block sub-btn" value="Entrar">
		           </div>
				   
			 </form>
	       </div>
		 </div>
     </div>
    
  </body>
</html>