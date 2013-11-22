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

<!-- The imports JavaScript (Source Code) -->
<script type="text/javascript">

		//Verifica se o login já está cadastrado no banco de dados em tempo real.
		function verfica_perfil(){
			$.ajax({
	   			url:"PerfilController",
	   			data:"action=exists_perfil&usuario_id="+escape($("#login").val()),
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
