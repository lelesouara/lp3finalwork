<%@page import="projetofinal.lp3.models.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	Usuario usuarioLoginAutenticado = (Usuario) session.getAttribute("auth_session_usuario");
	
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
			if(usuarioLoginAutenticado.getPerfil() == null)
				out.write("<div class='alert alert-danger'>Bem vindo (a) "+usuarioLoginAutenticado.getLogin()+ " - <b> você deve criar um perfil. </b> <a href='PerfilController?action=redirect&pagina=CadastrarPerfil' class='btn btn-primary'> Criar Perfil </a> </div>");
	%>
</p>
<div id='perfil'>
	<img src="images/avatar.jpg" alt="avatar" width='150' class="img-thumbnail">
</div>