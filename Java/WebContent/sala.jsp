<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="javax.websocket.Session"%>
<%@ page import="model.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="description" content="">
<meta name="author" content="">

<title>Sala</title>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Custom styles for this template -->
<link href="css/home.css" rel="stylesheet">
<link href="css/Sala_PopUP.css" rel="stylesheet">
<link href="css/mobile.css" rel="stylesheet" media="(max-width: 992px)">
<script src="js/mobile.js"></script>

</head>

<body>
	<%

		String email = "";
		try{
			email = (String) session.getAttribute("email");

			if(email.equals("null")){
				response.sendRedirect("login.jsp");
			}
		}catch (Exception e) {
		 	session.setAttribute("email", "null");
		 	response.sendRedirect("sala.jsp");
		}

		AllSalas salas = AllSalas.getInstance();


		String salaNome = request.getParameter("nome");

		Sala s;
		if (request.getParameter("qntd") != null) {
			int qntdJogadores = Integer.parseInt(request.getParameter("qntd"));
			s = new Sala(salaNome, qntdJogadores);
			salas.adicionarSala(s);
		}else{
			s = salas.getSala(salaNome);
		}

		if(s.getJogadores().size() == s.getMaxJogadores()){
			 response.sendRedirect("salaCheia.jsp");
		}else{
			Jogador j = new Jogador(email);
			salas.adicionarJogadorSala(s, j);

			s = salas.getSala(salaNome);

			if(s.getMaxJogadores() == s.getJogadores().size()){
				salas.mudaStatusSala(salaNome);
			}
		}
	%>



	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container">
		<a class="navbar-brand" href="#"><img src="css/LogoSploe.png"></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarResponsive" aria-controls="navbarResponsive"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon" onclick="showMenu()"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ml-auto">

					<li class="nav-item"><a class="nav-link" href="minhaConta.jsp">Sair da Partida</a></li>
				<!--<li class="nav-item"><a class="nav-link" href="#">Ajuda</a></li>
 				-->
			</ul>
		</div>
	</div>
	</nav>

	<!-- Page Content -->
	<div class="container">

		<div class="row">


			<div class="col-md-8 game-mobile">

				<div><h1 class="my-2">
					Vez de: <small id="turno"> Aguardando Outros Jogadores </small>
				</h1></div>
				<div><h1 class="my-2">
				 Sua rodada em:<small id="turnocount"> 2 </small><small>turno(s)</small>
				</h1></div>

                <div class="card mb-4">
					<div id="Overwiew">
					<table class="table table-mobile">
                        <thead>
					      <tr>
					        <th>Nick</th>
					        <th>Rodadas feitas</th>
					        <th>Rodadas Apostadas</th>
					        <th>Vidas</th>
					      </tr>
					    </thead>
					    <tbody id="Overview">

					    </tbody>
					</table>
					</div>
				</div>
				<!-- Mesa -->
				<div class="card mb-4">
					<h5 class="card-header">Mesa</h5>
					<div id="mesa" class="card-body Scrollcardl">
					</div>


				</div>

				<!-- MÃ¯Â¿Â½o-->
				<div class="card mb-4">
					<h5 class="card-header">Mao</h5>
					<div id="mao" class="card-body Scrollcardl"></div>
				</div>

				<div class="card mb-4">
					<h5 class="card-header">Aposta</h5>
					<div id="aposta" class="card-body tb">

					</div>
				</div>


			</div>

			<!-- Sidebar Widgets Column -->
			<div class="col-md-4 menu-mobile">

				<!-- Caixa da Manilha -->
				<div class="card my-4">
					<h5 class="card-header">Vira</h5>
					<div id="manilha" class="card-body"></div>
				</div>



				<div class="card my-4">
					<h5 class="card-header">Chat</h5>
					<div id="messages2" class="card-body Scrollcard"></div>
					<input type="text" id="input" class="chat"><input onclick='sendMessage()' type="button" value="send">
				</div>


				<!-- Lista dos Jogadores na sala -->

				<div class="card my-4">
					<h5 class="card-header">Lista de Jogadores</h5>
					<div id="lista" class="card-body Scrollcard">

					</div>
				</div>


				<!--Lista dos eventos da sala -->
				<div class="card my-4">
					<h5 class="card-header">Eventos da Sala</h5>
					<div id="messages" class="card-body Scrollcard"></div>

				</div>

				<div class="botoes-mobile">
					<a class="nav-link" href="minhaConta.jsp">Sair da Partida</a>
				</div>

			</div>

		</div>
		<!-- /.row -->

	</div>
	<!-- /.container -->

	<script type="text/javascript">
	    var ALERT_TITLE = "Atenção"
	    var ALERT_BUTTON_TEXT = "OK";
		var jog = [];
		<%


			ArrayList<Jogador> jogadores = new ArrayList<Jogador>(); // pega todos os jogadores
			for(Sala aux : salas.getAllSalas()){
				if(aux.getNome().equals(salaNome)){
					jogadores = aux.getJogadores();
				}
			}


			for (int i = 0; i < jogadores.size(); i++) {%>  // Pega o nick dos jogadores
				jog.push("<%=jogadores.get(i).getNick()%>");
			<%}%>

        var NumeroJogadores= jog.length;
		for(var i = 0; i < jog.length; ++i){ // Atribui a quantidade de vidas que cada jogador comeÃ§a, no caso 3
			document.getElementById('lista').innerHTML += jog[i] + "<br>";
			//document.getElementById('Overview').innerHTML += "<tr><td>"+jog[i]+"</td><td id='"+jog[i]+"ganhas'></td><td id='"+jog[i]+"apost'></td><td id='"+jog[i]+"vidas'></td></tr>"


		}


		var room = '<%=salaNome%>'
		var nick = '<%=email%>';
		var pe;
		var tAposta = 0;
		var caraios = 0;
		var vez = 'false';
		var pe = 'false';
		var turno;
		var apostas = 1;

		var tAposta = 0;

		var webSocket = new WebSocket('wss://sploegame2.azurewebsites.net/room/'+ room);
		//var webSocket = new WebSocket('ws://localhost:8080/SploeCorreto/room/'+ room);
		//se conecta no endpoint, o PathParam sera a room

		var chat = new WebSocket('wss://sploegame2.azurewebsites.net/chat/'+ room);
		//var chat = new WebSocket('ws://localhost:8080/SploeCorreto/chat/'+ room);

		chat.onerror = function(event) {
			//alert('ta dando algum erro');
		}

		chat.onopen = function(event) {
			//alert(event.data);
		}

		chat.onmessage = function(event) {
			var mensagem = event.data;
			var array = mensagem.split("%");
			if(array[0].indexOf(room) != -1){
				document.getElementById('messages2').innerHTML += array[1] + '<br/>';

			}
			//alert(mensagem);

		}

		function sendMessage(){
			var txt = document.getElementById('input').value;
			document.getElementById('input').value = "";
			chat.send(room + "%" + nick + ": " + txt);
		}

		webSocket.onerror = function(event) {
			createCustomAlert(event.data);
		}

		webSocket.onopen = function(event) {
			webSocket.send("%entrou " + nick);
			//document.getElementById('Overview').innerHTML += "<tr><td>"+nick+"</td><td id='"+nick+"ganhas'></td><td id='"+nick+"apost'></td><td id='"+nick+"vidas'></td></tr>"
			//manda uma msg falando quem etrou
			//document.getElementById('messages').innerHTML = 'Connection established';
		}

		webSocket.onmessage = function(event) {

			var mensagem = event.data;
			//alert(mensagem);
			//document.getElementById('messages').innerHTML += '<br /> '+ mensagem;

			if (mensagem.indexOf("recebeu a carta") != -1) {
				mostraMao(mensagem);
			} else if (mensagem.indexOf("jogou") != -1) {
				mesa(mensagem);
				//alert(mensagem);
			} else if (mensagem.indexOf("fez") != -1) {
				document.getElementById('messages').innerHTML += mensagem + '<br/>';
				document.getElementById('mesa').innerHTML = "";
			} else if (mensagem.indexOf("%vez") != -1) {
				var array = mensagem.split(" ");
				document.getElementById('turno').innerHTML = " " + array[1];
				verVez(mensagem);

			}else if (mensagem.indexOf("%Turnoteste") != -1) {
				var n = mensagem.split(" ");
				if(nick == n[1]){
					document.getElementById('turnocount').innerHTML= " "+ n[2]+" ";
				}

			}else if (mensagem.indexOf("Turno de apostas!") != -1) {
				tAposta = 0;
				pe = 'false';
				turno = "aposta";
				document.getElementById('messages').innerHTML += mensagem + '<br/>';
				mostraAposta();
			} else if (mensagem.indexOf("Turno de jogadas!") != -1) {
				document.getElementById('aposta').innerHTML = "";
				turno = "jogada";
				document.getElementById('messages').innerHTML += mensagem + '<br/>';
			} else if(mensagem.indexOf("ganhou") != -1){
				var array = mensagem.split(" ");
				var g = array[0];
				if(nick == g){
					createCustomAlert('Parabéns, você ganhou!!!');
					window.location.replace("minhaConta.jsp");
				}
			}else if(mensagem.indexOf("entrou") != -1){
				var array = mensagem.split(" ");
				if(document.getElementById('lista').innerHTML.indexOf(array[0]) == -1 ){
					document.getElementById('lista').innerHTML += array[0] + "<br>";
				}
			}else if(mensagem.indexOf("saiu") != -1){

				var n = mensagem.split(" ");
				var array = document.getElementById('lista').innerHTML.split("<br>");
				var pos;

				for(var i = 0; i < array.length; ++i){
					if(array[i].indexOf(n[0]) != -1){
						pos=i;
					}
				}

				array.splice(pos, 1);
				document.getElementById('lista').innerHTML = "";
				for(var i = 0; i < array.length; ++i){
					document.getElementById('lista').innerHTML += array[i] + "<br>";
				}
			}else if(mensagem.indexOf("manilha") != -1){
				mostraManilha(mensagem)
			}else if(mensagem.indexOf(" esta fora.") != -1){
				document.getElementById('messages').innerHTML += mensagem + '<br/>';
				var n = mensagem.split(" ");
				if(nick == n[0]){
					createCustomAlert('Vocï¿½ estï¿½ fora!');
					window.location.replace("minhaConta.jsp");
				}

			}else if(mensagem.indexOf("limpa vida") != -1){
				document.getElementById('lista').innerHTML = "";
				document.getElementById('Overview').innerHTML ="";
			}else if(mensagem.indexOf("-") != -1){
				var tt = mensagem.split("-");
				document.getElementById('lista').innerHTML += tt[0]+"<br>";
				var numeroFeitas = tt[3]/tt[4];
				document.getElementById('Overview').innerHTML += "<tr><td>"+tt[0]+"</td><td>"+numeroFeitas+"</td><td>"+tt[2]+"</td><td>"+tt[1]+"</td></tr>";

			}else if(mensagem.indexOf("pe") != -1){
				var n = mensagem.split(" ");
				if(nick == n[1]){
					pe  = 'true';
					mostraApostaPe();
					createCustomAlert('Você é o pé');
				}
			}else if(mensagem.indexOf("apostou") != -1){

				var n = mensagem.split(" ");

				if(pe == 'true'){
					tAposta = tAposta + parseInt(n[2]);
					mostraApostaPe();
				}

				document.getElementById('messages').innerHTML += mensagem + '<br/>';
			}

			else{

				document.getElementById('messages').innerHTML += mensagem + '<br/>';
			}

		};

		webSocket.onclose = function(event) {
			//webSocket.send("%saiu " + nick);
		};

		function verVez(mensagem) {
			var array = mensagem.split(" ");
			if (array[1].indexOf(nick) != -1) {
				vez = 'true';
				//alert('sua vez!');
			}else{
				vez = 'false';
			}
		}





		function mostraApostaPe(){
			document.getElementById('aposta').innerHTML = "";
			//alert(apostas + " - " + tAposta);
			for (var i = -1; i < apostas; ++i) {
				if((i + 1 + tAposta)  != (apostas)){
					var btn = document.createElement('input');
					btn.setAttribute('type', 'button');
					btn.setAttribute("class", "btn");
					btn.setAttribute('value', (i + 1));
					btn.setAttribute('onclick', 'aposta("' + (i + 1) + '")')

					var span = document.createElement('span');
					span.appendChild(document.createTextNode(' '));

					document.getElementById("aposta").appendChild(btn);
					document.getElementById("aposta").appendChild(span);
				}
			}
		}

		function mostraAposta() {

			++apostas;

			document.getElementById('aposta').innerHTML = "";
				//alert(apostas + " - " + tAposta);
				for (var i = -1; i < apostas; ++i) {


						var btn = document.createElement('input');
						btn.setAttribute('type', 'button');
						btn.setAttribute("class", "btn");
						btn.setAttribute('value', (i + 1));
						btn.setAttribute('onclick', 'aposta("' + (i + 1) + '")')

						var span = document.createElement('span');
						span.appendChild(document.createTextNode(' '));

						document.getElementById("aposta").appendChild(btn);
						document.getElementById("aposta").appendChild(span);

						caraios = 1;


				}
		}




		function aposta(aposta) {
			if (vez.indexOf('true') != -1) {
				vez = 'false';
				var txt = "%aposta " + aposta;
				document.getElementById('aposta').innerHTML = "";
				webSocket.send(txt);
			}
		}

		function mostraManilha(mensagem) {
			document.getElementById('manilha').innerHTML = "";
			var array = mensagem.split(" ");
			var naipe = array[1];
			var valor = array[2];

			var txt;
			txt = naipe + ' ' + valor;
			var carta = document.createElement('input');
			carta.setAttribute('type', 'image');
			carta.setAttribute('src', 'cartas/' + naipe + '/' + naipe + '_'
					+ valor + '.png');
			carta.setAttribute('height', '100');
			document.getElementById("manilha").appendChild(carta);
		}

		function jogaCarta(carta, nickname) {
			if (vez.indexOf('true') != -1 && turno.indexOf('jogada') != -1) {
				vez = 'false';
				var txt = "%jogada " + carta + " "+ nickname;
				//window.alert(txt);
				document.getElementById(carta).remove()
				webSocket.send(txt);
			}

		}

		function mesa(mensagem) {
			var array = mensagem.split(" ");
			var naipe = array[2];
			var valor = array[3];
			var quemjogou = array[0];


			var nomesolo = quemjogou.split("@");

			var txt;
			txt = naipe + ' ' + valor;
			var carta = document.createElement('input');
			carta.setAttribute('type', 'image');
			carta.setAttribute('src', 'cartas/' + naipe + '/' + naipe + '_'
					+ valor + '.png');
			carta.setAttribute('height', '100');
			carta.setAttribute('alt',''+quemjogou+'')
			var d = document.createElement('span');
			d.setAttribute('class','CartaShow');
			var t = document.createElement('p');
			t.appendChild(document.createTextNode(nomesolo[0]));
			d.appendChild(t);
			d.appendChild(carta);
			//d.appendChild(document.createElement("br"));


			document.getElementById("mesa").appendChild(d);
			//document.getElementById("quem").innerHTML(quemjogou);
		//	document.getElementById("mesa").appendChiel
		}

		function mostraMao(mensagem) {
			var naipe;
			var valor;

			if (mensagem.indexOf("Paus") != -1) {
				naipe = "Paus";
			} else if (mensagem.indexOf("Copas") != -1) {
				naipe = "Copas";
			} else if (mensagem.indexOf("Espadas") != -1) {
				naipe = "Espadas";
			} else {
				naipe = "Ouros";
			}

			if (mensagem.indexOf("A") != -1) {
				valor = "A";
			} else if (mensagem.indexOf("2") != -1) {
				valor = "2";
			} else if (mensagem.indexOf("3") != -1) {
				valor = "3";
			} else if (mensagem.indexOf("4") != -1) {
				valor = "4";
			} else if (mensagem.indexOf("5") != -1) {
				valor = "5";
			} else if (mensagem.indexOf("6") != -1) {
				valor = "6";
			} else if (mensagem.indexOf("7") != -1) {
				valor = "7";
			} else if (mensagem.indexOf("Q") != -1) {
				valor = "Q";
			} else if (mensagem.indexOf("J") != -1) {
				valor = "J";
			} else if (mensagem.indexOf("K") != -1) {
				valor = "K";
			}

			var txt;
			txt = naipe + ' ' + valor;
			var carta = document.createElement('input');
			carta.setAttribute('type', 'image');
			carta.setAttribute('src', 'cartas/' + naipe + '/' + naipe + '_'
					+ valor + '.png');
			carta.setAttribute('id', naipe + ' ' + valor);
			carta.setAttribute('height', '100');
			carta.setAttribute('onclick', 'jogaCarta("' + txt +'","'+ nick + '")')
			document.getElementById("mao").appendChild(carta);

		}

		function createCustomAlert(txt) {
			d = document;

			if(d.getElementById("modalContainer")) return;

			mObj = d.getElementsByTagName("body")[0].appendChild(d.createElement("div"));
			mObj.id = "modalContainer";
			mObj.style.height = d.documentElement.scrollHeight + "px";

			alertObj = mObj.appendChild(d.createElement("div"));
			alertObj.id = "alertBox";
			if(d.all && !window.opera) alertObj.style.top = document.documentElement.scrollTop + "px";
			alertObj.style.left = (d.documentElement.scrollWidth - alertObj.offsetWidth)/2 + "px";
			alertObj.style.visiblity="visible";

			h1 = alertObj.appendChild(d.createElement("h1"));
			h1.appendChild(d.createTextNode(ALERT_TITLE));

			msg = alertObj.appendChild(d.createElement("p"));
			//msg.appendChild(d.createTextNode(txt));
			msg.innerHTML = txt;

			btn = alertObj.appendChild(d.createElement("a"));
			btn.id = "closeBtn";
			btn.appendChild(d.createTextNode(ALERT_BUTTON_TEXT));
			btn.href = "#";
			btn.focus();
			btn.onclick = function() { removeCustomAlert();return false; }

			alertObj.style.display = "block";

		}

		function removeCustomAlert() {
			document.getElementsByTagName("body")[0].removeChild(document.getElementById("modalContainer"));
		}
		function ful(){
		alert('Alert this pages');
		}
	</script>


</body>

</html>
