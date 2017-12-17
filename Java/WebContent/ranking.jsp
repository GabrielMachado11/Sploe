<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link href="https://s3.amazonaws.com/codecademy-content/courses/ltp/css/shift.css" rel="stylesheet">
<link rel="stylesheet" href="https://s3.amazonaws.com/codecademy-content/courses/ltp/css/bootstrap.css">
 
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/log_cad.css">
<link rel="stylesheet" href="css/css.css">


<% 
	//se tiver uma sessao ativa ele encaminha para a minha conta
	//se nao tiver ele recarrega a pagina com uma sessao null, eh necessario fazer isso pois como esta vazio, nem null tem, entao ele da um erro
	try{
		String email = (String) session.getAttribute("email");
		
		if(email.equals("null")){
			response.sendRedirect("login.jsp");
		}
	}catch (Exception e) {
		 session.setAttribute("email", "null");
		 response.sendRedirect("ranking.jsp");
	}	
		
%>

</head>

<body>


	<nav class="navbar navbar-inverse navbar-static-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#myNavbar">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
		   <a class="navbar-brand" href="index.jsp"><img src="css/LogoSploe.png"></a>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
			<ul class="nav navbar-nav">
				
				<li><a href="criarSala.jsp">Criar uma Sala</a></li>
				<li><a href="salaPesquisa.jsp">Entrar em  uma Sala</a></li>
				<li><a href="ranking.jsp">Ranking</a></li>
				<li><a href="Regras.html">Regras do jogo</a></li>
				
			</ul>
			<ul class="nav navbar-nav pull-right">
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"> <!-- The Profile picture inserted via div class below, with shaping provided by Bootstrap -->
						<div class="img-rounded profile-img"></div> Usuário <span
						class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="minhaConta.jsp">Minha Conta</a></li>
						<li><a href="ajuda.jsp">Ajuda</a></li>
						<li role="separator" class="divider"></li>
						<li><a href="/logout">Sair<span
								class="glyphicon glyphicon-log-out pull-right"></a></li>
					</ul></li>
			</ul>
		</div>
	</div>
	</nav>
	
	
	<div  style="width:500px; margin:0 auto;">
		<table class="table table-striped">
    <thead>
      <tr>
        <th></th>
        <th>Pos</th>
        <th>Nick</th>
        <th>Nº Vitórias</th>
      </tr>
    </thead>
    <tbody id="dado">
    <tr></tr>
    </tbody>
  </table>
		 </div> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="jquery.js" type="text/javascript"></script>
	<script src="jquery.maskedinput.js" type="text/javascript"></script>
	<script type="text/javascript">
	
	$(document).ready(function() {  
		var flag2 = 0;
		var colArray2 = [];
		var colArray1 = [];
		
		
		<%UsuarioDAO user = new UsuarioDAO();
		ArrayList<String> nick = new ArrayList<String>();
		ArrayList<String> num = new ArrayList<String>();
		num = user.pegaUserRankingVit();
		nick = user.pegaUserRanking();%>
		
		<%for (int i=0; i< nick.size(); i++) { %>
		colArray2.push("<%= nick.get(i) %>"); 
		colArray1.push("<%= num.get(i) %>"); 
		
		<% } %>
		
		for ( j =0;j < colArray2.length;j++){
			/* total = (colArray2[j]+"<br>")+ total; */
			
			var tr = document.createElement('tr');
			var tdcoroa = document.createElement('td');
			var tdpos = document.createElement('td');
			var tdnick = document.createElement('td');
			var tdnumvit = document.createElement('td');


			// Criar o nó de texto
			var tpos = document.createTextNode(j+1+"º ");
			var tnick = document.createTextNode(colArray2[j]);
			var tnum = document.createTextNode(colArray1[j]);
			var tcoroa = document.createElement("IMG");
			if(j < (colArray1.length*10/100)-(colArray1.length%1,1)){
				tcoroa.setAttribute("src", "cartas/coroa_1.png");
			}
			else if(j <(colArray1.length*30/100-colArray1.length%1,3)+(colArray1.length*10/100-colArray1.length%1,1)){
				tcoroa.setAttribute("src", "cartas/coroa_2.png");
			}
			else{
				tcoroa.setAttribute("src", "cartas/coroa_3.png");
			}
			tcoroa.setAttribute("width", "50");
			tcoroa.setAttribute("height", "50");
			//
			// Anexar o nó de texto ao elemento h1
			//
			tdcoroa.appendChild(tcoroa);
			tdpos.appendChild(tpos);
			tdnick.appendChild(tnick);
			tdnumvit.appendChild(tnum);
			
			
			
			tr.appendChild(tdcoroa);
			tr.appendChild(tdpos);
			tr.appendChild(tdnick);
			tr.appendChild(tdnumvit);
			
		
			document.getElementById("dado").appendChild(tr);
			
			
		}
		/* 	document.getElementById("teste").innerHTML = total; */
		
	});
	</script>
</body>
</html>