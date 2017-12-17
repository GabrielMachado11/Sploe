<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="model.*"%>
<%@ page import="dbcon.Conexao"%>
<%@ page import="dao.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link
	href="https://s3.amazonaws.com/codecademy-content/courses/ltp/css/shift.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://s3.amazonaws.com/codecademy-content/courses/ltp/css/bootstrap.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/main.css">



</head>

<body class="grad1">

	<%@ page import="model.*"%>
	<%@ page import="dbcon.Conexao"%>
	<%@ page import="dao.*"%>

	<%
		//se tiver uma sessao ativa ele encaminha para a minha conta
		//se nao tiver ele recarrega a pagina com uma sessao null, eh necessario fazer isso pois como esta vazio, nem null tem, entao ele da um erro
		String logado = "";
		try {
			Usuario user = new Usuario();
			String email = (String) session.getAttribute("email");

			if (!email.equals("null")) {
				logado = "sim";
			} else {
				logado = "nao";
			}

		} catch (Exception e) {
			session.setAttribute("email", "null");
			response.sendRedirect("ajuda.jsp");
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
			<a class="navbar-brand" href="index.jsp"><img
				src="css/LogoSploe.png"></a>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
			<ul class="nav navbar-nav navbar-right" id="options">

				<li id="entrar"><a id="aEntrar" href="login.jsp">Entrar</a></li>
				<li id="cadastrar"><a id="aCadastrar" href="cadastro.jsp">Cadastrar</a></li>
				<li><a href="ajuda.jsp">Ajuda</a></li>
			</ul>

		</div>
	</div>
	</nav>

	<div class="login-box">
		<h1>Ajuda</h1>
		<div class="container container2">
			<h3>Esqueci Minha Senha.</h3>
			<h5>
				Caso você tenha esquecido sua senha, basta clicar no Link "Recuperar
				senha" para ser redirecionado para o formulário de recuperação. <a
					href="Esqueci_Senha.html">Recuperar Senha</a>
		</div>
		<br />
		<div class="container container2">
			<h3>Gostaria de entar em contato com os desenvolvedores.</h3>
			<p>
				Para entrar em contato com os nossos desenvolvedores basta acessar
				nosso <a href="http://projetosploe.blogspot.com.br/">blog</a>, lá se
				encontram nossos e-mails para contato.
			</p>
		</div>
		<br />
		<div class="container container2">
			<h3>Posso mandar sugestões para melhorar o jogo?</h3>
			<p>
				Sim você pode. Para enviar sugestões basta preencher um formulário
				presente em na página de <a href="Sugestao.html">Sugestões</a>. Esse formulário
				também pode ser acessado pela página inicial do Projeto Sploe.
			</p>

		</div>
	</div>

	<script language="javascript">
						// Get the modal
						var modal = document.getElementById('myModal');

						// Get the button that opens the modal
						var btn = document.getElementById("myBtn");

						// Get the <span> element that closes the modal
						var span = document.getElementsByClassName("close")[0];

						// When the user clicks the button, open the modal 
						btn.onclick = function() {
							modal.style.display = "block";
						}

						// When the user clicks on <span> (x), close the modal
						span.onclick = function() {
							modal.style.display = "none";
						}

						// When the user clicks anywhere outside of the modal, close it
						window.onclick = function(event) {
							if (event.target == modal) {
								modal.style.display = "none";
							}
						}
						</script>

	<script type="text/javascript">
		var logado;
		logado = '<%=logado%>';
		if (logado == 'sim') {
			var node = document.getElementById("cadastrar");
			if (node.parentNode) {
				node.parentNode.removeChild(node);
			}

			document.getElementById("aEntrar").innerHTML = "Minha Conta";
			// se tiver logado ao inves de aparecer login e cadastro, apenas aparece um link para a minha conta
		}
	</script>
</body>
</html>