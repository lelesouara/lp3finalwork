<%@page import="projetofinal.lp3.models.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	Usuario usuarioLoginAutenticado = (Usuario) session
			.getAttribute("auth_session_usuario");

	if (usuarioLoginAutenticado == null) {
		out.write("<div class='alert alert-danger'> Área restrita, realize login. &nbsp; <a href='UsuarioController?action=redirect&pagina=LogarUsuario'>Clique Aqui</a></div>");
		return;
	}
%>

<div class="page-header">
	<h1>
		Usuário Autenticado <small>Painel do Usuário</small>
	</h1>
</div>
<p>
	<%
		if (usuarioLoginAutenticado.getPerfil() == null)
			out.write("<div class='alert alert-danger'>Bem vindo (a) "
					+ usuarioLoginAutenticado.getLogin()
					+ " - <b> você deve criar um perfil. </b> <a href='PerfilController?action=redirect&pagina=CadastrarPerfil' class='btn btn-primary'> Criar Perfil </a> </div>");
	%>
</p>
<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title"> <img src="images/avatar.jpg" alt="avatar" width='25' class="img-thumbnail"> <b><%= usuarioLoginAutenticado.getPerfil().getNome() %></b></h3>
	</div>
	<div class="panel-body">
		<table class="table">
			<tr>
				<td>Email-Alternativo: <%= usuarioLoginAutenticado.getPerfil().getEmailalternativo() %></td>
			</tr>
			<tr>
				<td>Telefone: <%= usuarioLoginAutenticado.getPerfil().getTelefone() %></td>
			</tr>
			<tr>
				<td>Endereço: <%= usuarioLoginAutenticado.getPerfil().getEndereco() %></td>
			</tr>			
		</table>
	</div>
</div>