<%@page import="projetofinal.lp3.models.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="My Project Final of Language of Programation 3">
<meta name="author" content="Leandro Souza">

<title>Projeto Final - Leandro Souza</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/Narrow.css" rel="stylesheet">

<!-- jQuery Import -->
<script src="js/jquery-1.10.2.min.js" type='text/javascript'></script>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<!-- Just for debugging purposes. Don't actually copy this line! -->
<!--[if lt IE 9]><script src="../../docs-assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>

<body>

	<div class="container">
		<div class="header">
			<ul class="nav nav-pills pull-right">
				<li class="active"><a
					href="IndexController?action=redirect&pagina=Principal">Inicio</a></li>
				<li><a
					href="UsuarioController?action=redirect&pagina=CadastrarUsuario">Cadastro</a></li>
				<li><a
					href="UsuarioController?action=redirect&pagina=LogarUsuario">Logar</a></li>
				<li><a
					href="CarrinhoController?action=listar_carrinho&pagina=ListarCarrinho">Carrinho</a></li>
				<%
					Usuario usuarioLoginAutenticado = (Usuario) session.getAttribute("auth_session_usuario");
					if (usuarioLoginAutenticado != null) {
				%>
				<li><a
					href="UsuarioController?action=redirect&pagina=PainelUsuario">Painel Usuário</a></li>
				<li><a
					href="UsuarioController?action=logout">Sair</a></li>	
				<%
					}
				%>
			</ul>
			<h3 class="text-muted">LP3 - Cart</h3>
		</div>
<!-- 
		<br>
	
		<div class="jumbotron">
			<h1>Carrinho de Compras</h1>
			<p class="lead">Desenvolvimento de um carrinho de compras na
				linguagem JAVA - JSP. Utilizando Sessões e banco de dados
				PostgreSQL.</p>
			<p>
				<a class="btn btn-lg btn-success"
					href="UsuarioController?action=redirect&pagina=CadastrarUsuario"
					role="button">Faça sua Conta</a>
			</p>
		</div>
 -->
		<div class="container">
			<%
				String pagina = (String) request.getAttribute("pagina");
				if (pagina == null)
					pagina = (String) "Principal.jsp";
				else
					pagina = pagina + ".jsp";
			%>

			<jsp:include page="<%=pagina%>"></jsp:include>
		</div>

		<br>

		<div class="footer">
			<p>
				&copy; Leandro de Souza Araujo <span class="label label-primary">Linguagem
					de Programação 3</span>
			</p>
		</div>

	</div>
	<!-- /container -->

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
</body>
</html>