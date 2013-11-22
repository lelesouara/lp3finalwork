<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="page-header">
  <h1>Usuários <small>Logar-se</small></h1>
</div>

<% 
	String msg = (String) request.getAttribute("sys_mensagem");
	if(msg != null)
		out.write("<div class='alert alert-info'>"+msg+"</div>");
%>

<div style='width:500px'>
	<form class="form-horizontal" role="form" action="UsuarioController?action=auth_user" method="post">
		<div class="form-group">
			<label for="login" class="col-sm-2 control-label">Login</label>
			<div class="col-sm-10">
				<input type="text" name='login' class="form-control" id="login"
					placeholder="Nome de Usuário" required="required">
			</div>
		</div>
		<div class="form-group">
			<label for="senha" class="col-sm-2 control-label">Senha</label>
			<div class="col-sm-10">
				<input type="password" name='senha' class="form-control" id="senha"
					placeholder="Chave para acesso" required="required">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" class="btn btn-default">Acessar</button>
			</div>
		</div>
	</form>
</div>

<!-- Clear HACK -->
<div style='width: 1000px; height: 40px; margin: auto;'></div>