<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><!-- chama os elementos referentes a bootstrap e estilo -->
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

	<%
		try {
			String email = (String) session.getAttribute("email");

			if (email.equals("null")) {
				response.sendRedirect("login.jsp");
			}
		} catch (Exception e) {
			session.setAttribute("email", "null");
			response.sendRedirect("criarSala.jsp");
		}
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

	<div class="sug form-box login-box"> <!-- Inicio da caixa de estilo que comporta o formulário-->
	<div class="info">Criar Sala</div>
	<div class="cont">
     <form method="post" action="sala.jsp"> <!-- Inicio do formulário -->
       <label for="fname">Nome da Sala</label>
       <input type="text" id="nome" name="nome" placeholder="Nome da sala..."> 
			<p>
				Quantidade de jogadores: 
				<select name="qntd">
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
				</select>
			</p>
 
   <input id = "enviar"  type="submit" class="btn btn-info btn-block sub-btn" value="Criar"> <!-- submit -->
  </form>
  </div>
</div>
</body>
</html>