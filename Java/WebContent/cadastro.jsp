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
<link href="https://s3.amazonaws.com/codecademy-content/courses/ltp/css/shift.css" rel="stylesheet">
<link rel="stylesheet" href="https://s3.amazonaws.com/codecademy-content/courses/ltp/css/bootstrap.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/log_cad.css">
<link rel="stylesheet" href="css/css.css">

<% 
	//se tiver uma sessao ativa ele encaminha para a minha conta
	//se nao tiver ele recarrega a pagina com uma sessao null, eh necessario fazer isso pois como esta vazio, nem null tem, entao ele da um erro
	try{
		String email = (String) session.getAttribute("email");
		
		if(!email.equals("null")){
			response.sendRedirect("minhaConta.jsp");
		}
	}catch (Exception e) {
		 session.setAttribute("email", "null");
		 response.sendRedirect("cadastro.jsp");
	}	
		
%>

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
        <li><a href="login.jsp">Entrar</a></li>
        <li><a href="ajuda.jsp">Ajuda</a></li>
      </ul>

    </div>
  </div>
</nav>

	<div class="main">
		<div class="login-box">
			<div class="info">Cadastro</div>
			<form action="/cadastro"
				class="form-horizontal form-box" >

				<div class="input-group-lg data">
				
					<input type="text" name="nome" class="form-control inp" id="nome" placeholder="Nome" maxlength="30" required /> 
					<input type="text" name="nick" class="form-control inp" id="nick" placeholder="Nickname" min="1" maxlength="20" required />
					<span style="color : red" id="NA" hidden>Nick já cadastrado!!</span>
				


				
					<input type="email" name="email" id="email" class="form-control inp" placeholder="Email" min="1" maxlength="50" required value="${registration}" "/> 
					<span style="color : red" id="EC" hidden>Email já cadastrado!!</span>
					<span style="color : red" id="EI" hidden>Email inválido!!</span>
					<input type="password" name="senha" id="senha" class="form-control inp" placeholder="Senha" maxlength="20" required /> 
					<span style="color : red" id="SP" hidden>Mínimo de 8 caracteres!!</span>
					<span style="color : red" id="SA" hidden>Senha de ter pelo menos 1 letra maiúscula, 1 número e 1 caractere especial!!</span>
					<span style="color : red" id="SCM" hidden>Pelo menos 1 caractere maiúsculo!!</span>
					
					<input type="password" name="confirma" id="senhac" class="form-control inp" placeholder="Confirme sua Senha" maxlength="20" required />
					<span style="color : red" id="SCI" hidden>Senhas tem que ser iguais!!</span>
					<input placeholder="Data de Nascimento (dd/mm/aaaa)" class="form-control inp" id="data" name="data" type="text" required onkeypress="mascaraData(this)" /><br/>
					<span style="color : red" id="DI" hidden>Data inválida!!</span>
				
					Genero: <select name="genderr" required>
						<option value="Masculino">Masculino</option>
						<option value="Feminino">Feminino</option>
						<option value="Genero">Outro</option>
					</select>
					
					
					
						Pergunta de Seguranca: 
						<select name="pergunta">
							<option value="1">Qual a escola em que voce cursou o 6 ano?</option>
							<option value="2">Em que ano voce se formou no colegio?</option>
							<option value="3">Qual o nome do seu primeiro cachorro?</option>
							<option value="5">Qual foi seu primeiro video game?</option>
							<option value="6">Seu jogo preferido?</option>
						</select>
					
						<input type="text" name="resp" id="resp" class="form-control inp" placeholder="Resposta" min="1" maxlength="50" required />
					
				
				</div>


				<div class="form-group in">
					<br>
					<input id="go" type="submit" class="btn btn-info btn-block sub-btn" value="Cadastrar" />
				</div>

			</form>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="jquery.js" type="text/javascript"></script>
	<script src="jquery.maskedinput.js" type="text/javascript"></script>
	<script type="text/javascript">
	$("#email").focusout(function ValidateEmail()   
	{  
		var email = document.getElementById("email").value;
		if (email.length > 0){
		 if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email))  
	  {  
		 $("#go").prop('disabled' , false);
		 $("#EI").toggle(false); 
	    return true  ;
	  }  else{
		 $("#go").prop('disabled' , true);
		 $("#EI").toggle(true); 
	    return false;  
	}
		}
		else
			{
			$("#EI").toggle(false);
			}
	});
	$("#data").focusout(function ValidateData()   
	{  
		var data = document.getElementById("data").value;
		if (data != ""){
		 if (/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/.test(data))  
	  {  
		var teste = data.split("/");
		if((parseInt(teste[0])) > 31){
			$("#go").prop('disabled' , true);
			 $("#DI").toggle(true); 
		}
		else if(teste[1] > 12){
			$("#go").prop('disabled' , true);
			 $("#DI").toggle(true); 
		}else{
		 $("#go").prop('disabled' , false);
		 $("#DI").toggle(false);
	  }
	    return true  ;
	  }  else{
		 $("#go").prop('disabled' , true);
		 $("#DI").toggle(true); 
	    return false;  
	}
		}
	});

		var aux =  "<%=request.getParameter("nome")%>";
		if(aux != "null"){
			document.getElementById("nome").value = "<%=request.getParameter("nome")%>";
			document.getElementById("nick").value = "<%=request.getParameter("nick")%>";
			document.getElementById("email").value = "<%=request.getParameter("email")%>";
			document.getElementById("resp").value = "<%=request.getParameter("resp")%>";
			document.getElementById("data").value = "<%=request.getParameter("data")%>";
		}
		//todos esses requests vem da pagina de erro de cadastro, isso eh usado para nao perder os dados do usuario burro
		$("#email").focusout(function EmailBDD()   
		{  
			var email = document.getElementById("email").value;
			var flag = 0;
			var colArray = [];
			<%UsuarioDAO user = new UsuarioDAO();
			Conexao con = new Conexao();
			ArrayList<String> email = new ArrayList<String>();
			email = user.pegaUserEmail();
			for (int i=0; i< email.size(); i++) { %>
			colArray.push("<%= email.get(i) %>"); 
			<% } %>
			for ( j =0;j < colArray.length;j++){
				if (email == colArray[j]){
					flag = flag +1;
					
				} 
			}
			if (flag > 0){
				$("#EC").toggle(true);
				$("#go").prop('disabled' , true);
			}
			else{
				$("#go").prop('disabled' , false);
				$("#EC").toggle(false);
			}
		});
		$("#nick").change(function nickBDD()   
		{  
			var nick = document.getElementById("nick").value;
			var flag2 = 0;
			var colArray2 = [];
			
			<%ArrayList<String> nick = new ArrayList<String>();
			nick = user.pegaUserNick();
			for (int i=0; i< nick.size(); i++) { %>
			colArray2.push("<%= nick.get(i) %>"); 
			<% } %>
			for ( j =0;j < colArray2.length;j++){
				if (nick == colArray2[j]){
					flag2 = flag2 +1 ;
				} 
			}
			if(flag2 > 0){
			$("#NA").toggle(true);
			$("#go").prop('disabled' , true);
		}
			else{
				$("#go").prop('disabled' , false);
				$("#NA").toggle(false);
			}
			
		});
		
		$("#senha").change(function senhaval()   
		{  
			var senha = document.getElementById("senha").value;
			var regex = /^(?=(?:.*?[A-Z]){1})(?=(?:.*?[0-9]){1})(?=(?:.*?[!@#$%*()_+^&}{:;?.]){1})(?!.*\s)[0-9a-zA-Z!@#$%;*(){}_+^&]*$/; 
			if (senha.length > 0){
			if(senha.length < 8 )
			{
			    $("#SP").toggle(true);
			    $("#go").prop('disabled' , true);
			}
			else if(!regex.exec(senha))
			{
				$("#go").prop('disabled' , true);
				$("#SP").toggle(false);
			    $("#SA").toggle(true);
			}
			else{
				  $("#SA").toggle(false);
			}
			}
			else
			{
				$("#SP").toggle(false);
				$("#SA").toggle(false);
			}
			
					});
		$("#senhac").change(function senhacval()   
		{  
			var senha = document.getElementById("senha").value;
			var senhac = document.getElementById("senhac").value;
			if (senha.length > 0){
			if(senhac != senha){
				$("#SCI").toggle(true);
				$("#go").prop('disabled' , true);
			}
			else
			{
				$("#go").prop('disabled' , false);
				$("#SCI").toggle(false);	
			}
			}
			else
			{
				$("#SCI").toggle(false);
			}
		});
		function mascaraData(val) {
			  var pass = val.value;
			  var expr = /[0123456789]/;

			  for (i = 0; i < pass.length; i++) {
			    // charAt -> retorna o caractere posicionado no índice especificado
			    var lchar = val.value.charAt(i);
			    var nchar = val.value.charAt(i + 1);

			    if (i == 0) {
			      // search -> retorna um valor inteiro, indicando a posição do inicio da primeira
			      // ocorrência de expReg dentro de instStr. Se nenhuma ocorrencia for encontrada o método retornara -1
			      // instStr.search(expReg);
			      if ((lchar.search(expr) != 0) || (lchar > 3)) {
			        val.value = "";
			      }

			    } else if (i == 1) {

			      if (lchar.search(expr) != 0) {
			        // substring(indice1,indice2)
			        // indice1, indice2 -> será usado para delimitar a string
			        var tst1 = val.value.substring(0, (i));
			        val.value = tst1;
			        continue;
			      }

			      if ((nchar != '/') && (nchar != '')) {
			        var tst1 = val.value.substring(0, (i) + 1);

			        if (nchar.search(expr) != 0)
			          var tst2 = val.value.substring(i + 2, pass.length);
			        else
			          var tst2 = val.value.substring(i + 1, pass.length);

			        val.value = tst1 + '/' + tst2;
			      }

			    } else if (i == 4) {

			      if (lchar.search(expr) != 0) {
			        var tst1 = val.value.substring(0, (i));
			        val.value = tst1;
			        continue;
			      }

			      if ((nchar != '/') && (nchar != '')) {
			        var tst1 = val.value.substring(0, (i) + 1);

			        if (nchar.search(expr) != 0)
			          var tst2 = val.value.substring(i + 2, pass.length);
			        else
			          var tst2 = val.value.substring(i + 1, pass.length);

			        val.value = tst1 + '/' + tst2;
			      }
			    }

			    if (i >= 6) {
			      if (lchar.search(expr) != 0) {
			        var tst1 = val.value.substring(0, (i));
			        val.value = tst1;
			      }
			    }
			  }

			  if (pass.length > 10)
			    val.value = val.value.substring(0, 10);
			  return true;
			}

	</script>
</body>
</html>