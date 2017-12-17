<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

  <head>

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
         <li><a href="ajuda.jsp">Ajuda</a></li>
      </ul>
    </div>
  </div>
</nav>
	
	<div class="main">
  <div class="login-box">
    <div class="info">Nick já existente</div>
	<br/>
	<center>
		<form action="cadastro.jsp" method="post">
			<button class="animatedbutton2"><span>Cadastro</span></button>
			<input type="hidden" name="nome" id="nome" /> 
			<input type="hidden" name="nick" id="nick" />
			<input type="hidden" name="email" id="email" />
			<input type="hidden" name="resp" id="resp" />
			<input type="date" name="data" id="data" style="display:none" />
		</form>
	</center>
	 <br/><br/>
		      
	       </div>
		 </div>
     </div>
    
    <script type="text/javascript">
		document.getElementById("nome").value = "<%=request.getParameter("nome")%>";
		document.getElementById("nick").value = "<%=request.getParameter("nick")%>";
		document.getElementById("email").value = "<%=request.getParameter("email")%>";
		document.getElementById("resp").value = "<%=request.getParameter("resp")%>";
		document.getElementById("data").value = "<%=request.getParameter("data")%>";
	</script>
  </body>
</html>