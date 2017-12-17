<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

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
		}else{
			logado = "nao";
		}
		
		
	} catch (Exception e) {
		session.setAttribute("email", "null");
		response.sendRedirect("index.jsp");
	}

	
%>



<!DOCTYPE html>
<html>

<head>
<link href="https://s3.amazonaws.com/codecademy-content/courses/ltp/css/shift.css" rel="stylesheet">
<link rel="stylesheet" href="https://s3.amazonaws.com/codecademy-content/courses/ltp/css/bootstrap.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="css/main.css">



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
				<ul class="nav navbar-nav navbar-right" id="options">

					<li id="entrar"><a id="aEntrar" href="login.jsp">Entrar</a></li>
					<li id="cadastrar"><a id="aCadastrar" href="cadastro.jsp">Cadastrar</a></li>
					<li><a href="ajuda.jsp">Ajuda</a></li>
				</ul>

			</div>
		</div>
	</nav>

	 <div class="jumbotron"> <!--Área de Boas Vindas(contém imagem)-->
      <div class="container"><!--Area de conteúdo-->
        <h1>Bem-vindo ao Sploe</h1>
        <p>Um jogo de cartas da equipe Sploe</p>
        <a id="myBtn">Sobre nós</a>
		<div id="myModal" class="modal">

				  <!-- Modal content -->
				  <div class="modal-content">
					<div class="modal-header">
					  <span class="close">&times;</span>
					  <h2>Projeto Sploe</h2>
					</div>
					<div class="modal-body">
					  <p>Sploe é um jogo de cartas online que permite a interação lúdica entre usuários. Foi desenvolvido pela equipe 
					  de mesmo nome e durante sua criação teve o propósito de suprir uma necessidade dos desenvolvedores.</p>
				
					</div>
					<div class="modal-footer">
					  <h3>Equipe - Sploe</h3>
					</div>
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
      </div> <!--Fim da Area de Conteúdo-->
    </div> <!--Fim da área de boas vindas-->



	<div class="learn-more">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<h3>Blog de Desenvolvimento</h3>
					<p>Veja o nosso blog para saber como o jogo foi desenvolvido</p>
					<p>
						<a href="http://projetosploe.blogspot.com.br/">Ir para
							ProjetoSploe</a>
					</p>
				</div>
				<div class="col-md-4">
					<h3>Youtube</h3>
					<p>Se inscreva no nosso canal para receber novidades sobre as
						atualizações do jogo</p>
					<p>
						<a href="https://www.youtube.com/channel/UC4SRM59VC2SciPRwtNaqhYQ">Acessar
							Canal do Youtube</a>
					</p>
				</div>
				<div class="col-md-4">
					<h3>Sugestões</h3>
					<p>Envie Sugestões para nos ajudar a melhor sua experiência de
						jogo</p>
					<p>
						<a href="Sugestao.html">Abrir formulário</a>
					</p>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		var logado;
		logado = '<%=logado%>'
		if(logado == 'sim'){
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