<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="page-header">
  <h1><fmt:message key="title.page"/> <small><fmt:message key="slogan.page"/></small></h1>
</div>

<% 
	String msg = (String) request.getAttribute("sys_mensagem");
	if(msg != null)
		out.write("<div class='alert alert-info'>"+msg+"</div>");
%>

<div style='width:500px'>
	<form class="form-horizontal" role="form" action="UsuarioController?action=new_user" method="post">
		<div class="form-group">
			<label for="login" class="col-sm-2 control-label"><fmt:message key="campo.login"/></label>
			<div class="col-sm-10">
				<input type="text" name='login' class="form-control" id="login"
					placeholder="Nome de Usuário" required="required" onfocus="mostrar_botao()" onblur="verificar_user_name()">
				<span id="validar_user" style="display:none; color: red">login já existe</span>
			</div>
		</div>
		<div class="form-group">
			<label for="senha" class="col-sm-2 control-label"><fmt:message key="campo.senha"/></label>
			<div class="col-sm-10">
				<input type="password" name='senha' class="form-control" id="senha"
					placeholder="Chave para acesso" required="required">
			</div>
		</div>
		<div class="form-group">
			<label for="resenha" class="col-sm-2 control-label"><fmt:message key="campo.resenha"/></label>
			<div class="col-sm-10">
				<input type="password" name='resenha' class="form-control" id="resenha"
					placeholder="Repita a chave para acesso" required="required">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" id='botao' class="btn btn-default"><fmt:message key="btn.cadastrar"/></button>
			</div>
		</div>
	</form>
</div>

<!-- Clear HACK -->
<div style='width: 1000px; height: 40px; margin: auto;'></div>

<!-- The imports JavaScript (Source Code) -->
<script type="text/javascript">

		//Verifica se o login já está cadastrado no banco de dados em tempo real.
		function verificar_user_name(){
			$.ajax({
	   			url:"UsuarioController",
	   			data:"action=verificar_login&login="+escape($("#login").val()),
	   			type:"GET",
	   			dataType:"json",
				cache:false,
	   			timeout:30000,
	    		success:function(jsonObject){
	    			console.log(jsonObject);
	    			
	     			if(jsonObject.is_disponivel == false){ 
	     				$("#validar_user").show();
	     				$("#botao").attr('disabled', 'disabled');
	     			} else {
	     				$("#botao").removeAttr("disabled");
			     	}
	    		},error:function(error){
	    			
	    		},complete:function(){
	    			
	    		}
	    	});
		}

		function mostrar_botao(){
			$("#login").val("");
			$("#botao").show();
			$("#validar_user").hide();
		}
</script>
