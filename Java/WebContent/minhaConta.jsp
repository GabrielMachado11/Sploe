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


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<head>
<meta charset="utf-8">
<title>Minha Conta</title>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://s3.amazonaws.com/codecademy-content/courses/ltp/css/shift.css" rel="stylesheet">
<link rel="stylesheet" href="https://s3.amazonaws.com/codecademy-content/courses/ltp/css/bootstrap.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<link rel="stylesheet" href="css/style_MinhaConta.css">
<link rel="stylesheet" href="css/Style_Popup.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/log_cad.css">
<link rel="stylesheet" href="css/css.css">

<meta name="viewport" content="width=device-width, initial-scale=1">



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
		 response.sendRedirect("minhaConta.jsp");
	}	
		
%>

<% 
		//------- > SENTE SE E PEGUE UM LACHE, PARA ENTENDER ISSO AQUI PRECISA DE PACIENCIA E CARINHO, JA AVISEI < -------
		
		
		
		
		
		UsuarioDAO usuarioDAO = new UsuarioDAO();
		Usuario user = new Usuario();
		user = usuarioDAO.populaUser((String) session.getAttribute("email"));
		//popula um usuario atraves do email gravado na sessao, necessario para pegar outras informaçoes futuramente	
		
%>


<script type="text/javascript">
	var user  = '<%=user.getNick()%>';
	//nick do usuario da sessao
	var webSocket = new WebSocket('wss://sploegame2.azurewebsites.net/websocket');
	//var webSocket = new WebSocket('ws://localhost:8080/SploeCorreto/websocket');
	// se conecta ao endpoint
	
	//quando o usuario receber uma mensagem ocorre esses paranaue
	webSocket.onmessage = function(event) {
		var mensagem = event.data;
		//mensagem que foi recebida
		
		
		if(mensagem.indexOf("%From:"+ user +"%--") != -1){
			var inicio = "%From:"+ user +"%--";
			var posTo = mensagem.indexOf("--%To");
			var msg = mensagem.slice(inicio.length, posTo);
			var para = mensagem.slice((posTo + 6), (mensagem.length - 1));
			document.getElementById(para + 'chat').innerHTML += '\n Voce: ' + msg;
			
			//esse if serve para ver se você é o remetente, se for, ele corta a string, no final so sobra a mensagem pura
		}else if(mensagem.indexOf("--%To:"+ user +"%") != -1){
			var posFrom = (mensagem.indexOf("%--") + 3);
			var posTo = mensagem.indexOf("--%To");
			var msg = mensagem.slice(posFrom, posTo);
			posFrom -= 3;
			var quem = mensagem.slice(6, posFrom);
			document.getElementById(quem + 'chat').innerHTML += '\n '+ quem + ': ' + msg;
			
			//esse if serve para ver se você é o destinatario, se for, ele corta a string, no final so sobra a mensagem pura e quem mandou ela
			//ele pega o campo que tenha o id de quem mandou+chat, por isso que por enquanto é necessario abrir o chat
		}
	};
	
	webSocket.onerror = function(event) {
		alert(event.data);
		//se tiver um erro apenas mostra um alert, para saber se ta conectando ou nao, nhaa
	};

	webSocket.onopen = function(event) {
		
	};

	webSocket.onclose = function(event) {
	
	};

	function send(forwho) {
		//for who eh uma string que indica para quem eh
		//var txt = "%From:"+user+"% " + document.getElementById((forwho+'texto')).value + " %To:" + forwho + "%"; <- apaga essa porra nao
		var txt = "%From:"+user+"%--" + document.getElementById((forwho+'texto')).value + "--%To:" + forwho + "%";
		//monta a string que vai ser  cortada quando ele receber, todos esses %-- sao necessarios
		webSocket.send(txt);
		return false;
	}

	<% 
		NotificacoesDAO not = new NotificacoesDAO();
		String[] all = not.pegaConvite(user.getEmail());
		int tamanho = not.qntdConvites(user.getEmail());
		
		//pega as notificaoes que o usuario tem no bdd e qntd
	%>

	
	<% 
		AmigoDAO amigoDAO = new AmigoDAO();
		String[] amigos = amigoDAO.retornaTodosAmigos(user.getEmail());
		int qntdAmigo = amigoDAO.qntdAmigo(user.getEmail());
		
		//pega os abiguinho que o usuario tem no bdd e qntd
	%>
	
	
	
	var amigos = new Array(); //array de amigos
	var qntdAmigo = eval('<%=qntdAmigo%>');
	<% for(int i=0; i < qntdAmigo; i++) { %>
		amigos[<%= i %>] = "<%= amigos[i] %>"; 
	<% } %>
	//passa os amigos de java para javascript
	
	
	
	var tamanho = eval('<%=not.qntdConvites(user.getEmail())%>');
	var todos = new Array();
	<% for(int i=0; i < tamanho; i++) { %>
		todos[<%= i %>] = "<%= all[i] %>"; 
	<% } %>
	//passa os convites de java para javascript
	
	
	//limpa div que aparece tudo, nhaaa
	function limpa(){
		document.getElementById('corpo').innerHTML = "";
	}
	
	//so alert de auxilio para saber se algo funcionou, ajuda em alguns testes, nada de significativo
	function msgExibe(){
		alert('Sucesso!');
	}
	
	function apareceChat(forwho){
		//funcao que cria o ambiente do chat
		
		var caixa = document.createElement('textarea');
		caixa.setAttribute('rows', '10');
		caixa.setAttribute('cols', '40');
		caixa.setAttribute('id', (forwho + 'chat'));
		document.getElementById("corpo").appendChild(caixa);
		//onde aparece a mensagem
		
		
		var p = document.createElement('p');
		p.setAttribute('type', 'p');
		document.getElementById("corpo").appendChild(p);
		//pula linha
		
		
		var input = document.createElement('input');
		input.setAttribute('type', 'input');
		input.setAttribute('id', (forwho + 'texto'));
		document.getElementById("corpo").appendChild(input);
		//onde escreve a mensagem
		
		var button = document.createElement('button');
		button.appendChild(document.createTextNode("Enviar"));
		button.setAttribute('onclick',  'send("'+forwho+'")');
		document.getElementById("corpo").appendChild(button);
		//botao para envio da mensgem
	}
	
	function apareceAmigos(){
		limpa();
		
		for(var c = 0; c < qntdAmigo; ++c){
			var btnAmigo = document.createElement('button');
			btnAmigo.setAttribute('name', ('amigo' + amigos[c]));
			btnAmigo.className = 'btn btn-success btn-sm';
			btnAmigo.appendChild(document.createTextNode(amigos[c]+" "));			
			btnAmigo.setAttribute('onclick', 'apareceChat("'+amigos[c]+'")');
			document.getElementById("corpo").appendChild(btnAmigo);
			
			var p = document.createElement('p');
			p.setAttribute('type','p');
			document.getElementById("corpo").appendChild(p);
		}
		
		//funcao responsavel por mostrar todos os amigos do usuario, cada botao é um amigo, e ao clicar abre o chat com ele
		
	}
	
	function showPesquisa(){
		limpa();
		
		var form = document.createElement('form');
		form.setAttribute('type','form');
		form.setAttribute('id', 'mandar');
		form.setAttribute('method', 'post');
		form.setAttribute('action', '/addAmigo');
		document.getElementById("corpo").appendChild(form);
		
		var input = document.createElement('input');
		input.setAttribute('type','text');
		input.setAttribute('name', 'nomeAmigo');
		input.setAttribute('id', 'nomeAmigo');
		document.getElementById("mandar").appendChild(input);
		
		var text = document.createElement('span');
		text.setAttribute('type','span');
		text.appendChild(document.createTextNode(' '));
		document.getElementById("mandar").appendChild(text);
		
		var input = document.createElement('input');
		input.setAttribute('type','submit');
		input.onclick = 'msgExibe()';
		input.setAttribute('value', 'Mandar Convite');
		document.getElementById("mandar").appendChild(input);
		//juro que nao lembro que porra é essa
	}
	
	function apareceConvites(){
		limpa();
		
		if(tamanho == 0){
			alert("Voce não possui convites! Ninguem quer ser seu amigo!");	
		}
		
		for(var c = 0; c < tamanho; ++c){
			
			var form = document.createElement('form');
			form.setAttribute('type','form');
			form.setAttribute('id', ('aparecer' + c));
			form.setAttribute('name', ('aparecer' + c));
			form.setAttribute('method', 'post');
			form.setAttribute('action', '/AdicinarAmigoServlet');
			document.getElementById("corpo").appendChild(form);
			//cria um form para cada notificacao
			
			var span = document.createElement('span');
			span.setAttribute('type','span');
			span.setAttribute('name',('span' + c));
			span.appendChild(document.createTextNode(todos[c]+" "));
			document.getElementById(('aparecer' + c)).appendChild(span);
			//Nome de quem enviou o convite
			
			
			var button = document.createElement('input');
			button.setAttribute('type','submit');
			button.setAttribute('name',('aceita' + c));
			button.className = 'btn btn-success btn-sm'; 
			button.onclick = function encaminha(){
				aparecer.nomeAceita.value = todos[c];
			}
			button.setAttribute('value','Aceita')
			document.getElementById(('aparecer' + c)).appendChild(button);
			//botao de aceitar
			
			
			var button = document.createElement('input');
			button.setAttribute('type','submit');
			button.setAttribute('value','Recusa');
			button.setAttribute('name',('recusa' + c));
			button.onclick = function encaminha(){
				aparecer.nomeAceita.value = todos[c] + " vai dar nao";
			}
			button.className = 'btn btn-success btn-sm'; 
			document.getElementById(('aparecer' + c)).appendChild(button);
			//botao de recusa
			
			var input = document.createElement('input');
			input.setAttribute('type','text');
			input.setAttribute('name', 'nomeAceita');
			input.setAttribute('id', 'nomeAceita');
			input.setAttribute('value', todos[c]);
			document.getElementById(('aparecer' + c)).appendChild(input);
			input.style.display = "none";
			//input responsavel por ter o valor quando for submetido para pegar na servlet, role do caramba
			
			var span = document.createElement('p');
			span.setAttribute('type','p');
			span.setAttribute('id', 'i');
			document.getElementById(('aparecer' + c)).appendChild(span);
			//apenas um paragrafo, para pular linha
		}

		
	}
	
	
		
</script>
</head>


<body>
	<div id="dialogoverlay"></div>
	<div id="dialogbox">
		<div>
			<div id="dialogboxhead"></div>
			<div id="dialogboxbody"></div>
			<div id="dialogboxfoot"></div>
		</div>
	</div>

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
			
				<!-- 
				<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Page 1 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li>Page 1-1</li>
						<li>Page 1-2</li>
						<li>Page 1-3</li>
					</ul>
				</li>
				 -->
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

	<!------------------fim da barra de menu-->

	<div class="container">
		<div class="row profile">
			<div class="col-md-3">
				<div class="profile-sidebar">
					<div class="profile-user-pic">
						<img src="css/perfil.png" alt="" class="img-responsive img-circle">
					</div>
					<div class="profile-user-title">
						
						<div class="profile-user-name"><% out.println(user.getNome()); %> </div>
						<div class="profile-user-award"><% out.println(user.getNick()); %></div>
					</div>
					<div class="profile-user-buttons">
						<button onclick="showPesquisa()" class="btn btn-success btn-sm"> <i class="glyphicon glyphicon-plus"></i> Adicionar um Amigo </button>
						<p> </p>
						<button onClick ="apareceConvites()" class="btn btn-success btn-sm"> Verificar Meus Convites </button>
						<p> </p>
						<button onClick="apareceAmigos()" class = "btn btn-success btn-sm"> Ver Amigos </button>
						
						<!--  
						<form action="http://localhost:8080/Danese/chatTeste.jsp" method="post">
							<p> </p>
							<button class="btn btn-success btn-sm">Chat Teste</button>
						</form>
						<form action="http://localhost:8080/Danese/SalaJogoTeste.jsp" method="post">
							<p> </p>
							<input type="hidden" name="nome" value="sala1">
							<input type="hidden" name="qntd" value="2">
							<button class="btn btn-success btn-sm">Sala 1</button>
						</form>
						<form action="http://localhost:8080/Danese/SalaJogoTeste.jsp" method="post">
							<p> </p>
							<input type="hidden" name="nome" value="sala2">
							<button class="btn btn-success btn-sm">Sala 2</button>
							<input type="hidden" name="qntd" value="2">
						</form>
						-->
					</div>
					<!-- 
					
					<div class="profile-user-menu">
						<ul class="nav">
							<li class="active"><a href="index.jsp"><i class="glyphicon glyphicon-user"></i> Sobre</a></li>
							<li><a href="index.jsp"><i class="glyphicon glyphicon-stats"></i> Status da Conta</a></li>
							<li><a href="index.jsp"><i class="glyphicon glyphicon-flag"></i> Denunciar</a></li>
						</ul>
					</div>
					-->
				</div>
			</div>
			<div class="col-md-9">
				<div id="corpo" class="profile-content">
					<form name="aceitaConvites" method="post">
						<span id="olee"> </span>
					</form>
				</div>
			</div>
		</div>
	</div>



</body>

</html>