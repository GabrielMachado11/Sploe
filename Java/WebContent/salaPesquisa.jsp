<%@ page import="model.*"%>
<%@ page import="dbcon.Conexao"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<!-- chama os elementos referentes a bootstrap e estilo -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/log_cad.css">
<link rel="stylesheet" href="css/css.css">

</head>

<body>

	<%
		try {
			String email = (String) session.getAttribute("email");

			if (email.equals("null")) {
				response.sendRedirect("login.jsp");
			}
		} catch (Exception e) {
			session.setAttribute("email", "null");
			response.sendRedirect("salaPesquisa.jsp");
		}
	
		AllSalas salas = AllSalas.getInstance();
	%>
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


	<div class="sug form-box login-box">
		<!-- Inicio da caixa de estilo que comporta o formulário-->
		<div class="info">Procurar Sala</div>
		<div class="cont">
			<form action="sala.jsp">
				<!-- Inicio do formulário -->
				<div class="form-group">
					<label for="exampleFormControlSelect1">Salas</label> <select
						class="form-control" id="drop" name="nome">
					</select>
				</div>






				<input id="enviar" type="submit"
					class="btn btn-info btn-block sub-btn" value="Entrar">
				<!-- submit -->
			</form>
		</div>
	</div>


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="jquery.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(document).ready(function ()   
	{  
		
		var flag = 0;
		var NomeSala = [];
		var Jogadores = [];
		var Jogadores2 = [];
		
		<%
		
			ArrayList<Sala> sala = new ArrayList<Sala>();
			sala = salas.getAllSalas();
			
			for(int i = 0; i < sala.size(); ++i){
				if(sala.get(i).getStatus().equals("comecou")){
					sala.remove(i);
				}
			}
			
			for (int i = 0; i < sala.size(); i++) {%>
			NomeSala.push("<%=sala.get(i).getNome()%>"); 
			Jogadores.push("<%=sala.get(i).getMaxJogadores()%>");
			Jogadores2.push(<%=sala.get(i).getJogadores().size()%>);
	<%}%>
		for (j = 0; j < NomeSala.length; j++) {
								/* total = (colArray2[j]+"<br>")+ total; */

								var li = document.createElement('option');
								li.setAttribute('value', NomeSala[j]);
								var a = document.createElement('a');

								// Criar o nó de texto
								var sala = document.createTextNode(NomeSala[j]
										+ "           " + Jogadores2[j] + "/"
										+ Jogadores[j] + " jogadores");

								//
								// Anexar o nó de texto ao elemento 
								//

								li.appendChild(sala);

								document.getElementById("drop").appendChild(li);

							}
						});
	</script>
</body>
</html>