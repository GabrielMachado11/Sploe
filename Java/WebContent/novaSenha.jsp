<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
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
	<div class="sug form-box login-box">
		<div class="cont">
			<form action="/troca" name="form" method="post">
 
				<input type="hidden" id="token" name="token">

				<label for="NSenha">Nova senha</label> <input type="password"
					id="NSenha" name="NSenha" placeholder="Digite sua nova senha">

				<label for="CSenha">Confirmar senha</label> <input type="password"
					id="CSenha" name="CSenha" placeholder="Confirme sua nova senha">

				<input type="hidden" name="resposta" id="resposta">
				<input type="hidden" name="email" id="email">
				 
				<input id="go" type="submit" class="btn btn-info btn-block sub-btn" value="Redefinir Senha">
			</form>
		</div>
	</div>

	<script type="text/javascript">
  		form.token.value = '<%=request.getParameter("t")%>';
	</script>
</body>
</html>