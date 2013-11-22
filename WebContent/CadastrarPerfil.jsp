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
		Usuários > Perfil <small>Cadastro de um novo perfil</small>
	</h1>
</div>

<%
	String msg = (String) request.getAttribute("sys_mensagem");
	if (msg != null)
		out.write("<div class='alert alert-info'>" + msg + "</div>");
%>

<div style='width: 500px'>
	<form class="form-horizontal" role="form"
		action="PerfilController?action=new_profile" method="post">
		<div class="form-group">
			<label for="nome" class="col-sm-2 control-label">Nome
				Completo</label>
			<div class="col-sm-10">
				<input type="text" name='nome' class="form-control" id="nome"
					placeholder="Nome Completo" required="required">
			</div>
		</div>
		<div class="form-group">
			<label for="telefone" class="col-sm-2 control-label">Telefone</label>
			<div class="col-sm-10">
				<input type="text" name='telefone' class="form-control"
					id="telefone" placeholder="Ex: (67) xxxx-xxxx">
			</div>
		</div>
		<div class="form-group">
			<label for="emailalternativo" class="col-sm-2 control-label">Email
				Alternativo</label>
			<div class="col-sm-10">
				<input type="text" name='emailalternativo' class="form-control"
					id="emailalternativo" placeholder="(Opcional) Email Alternativo">
			</div>
		</div>
		<div class="form-group">
			<label for="endereco" class="col-sm-2 control-label">Endereço</label>
			<div class="col-sm-10">
				<textarea name='endereco' class="form-control"></textarea>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<input type='hidden' name='usuario_id'
					value='<%=usuarioLoginAutenticado.getUsuario_id()%>'>
				<button type="submit" id='botao' class="btn btn-default">Cadastrar</button>
			</div>
		</div>
	</form>
</div>

<!-- Clear HACK -->
<div style='width: 1000px; height: 40px; margin: auto;'></div>
