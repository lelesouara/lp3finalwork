
<%@page import="projetofinal.lp3.models.Itemordemservico"%>
<%@page import="projetofinal.lp3.models.Ordemservico"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="projetofinal.lp3.models.Categoria"%>
<%@page import="java.util.ArrayList"%>
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
		OS <small>Todas os OS do usuario </small>
	</h1>
</div>

<%
	String msg = (String) request.getAttribute("sys_mensagem");
	if (msg != null)
		out.write("<div class='alert alert-info'>" + msg + "</div>");
%>

<div style='width: 700px'>
		<table class="table">
		<tr>
			<td>Id</td>
			<td>Data</td>
			<td>Status</td>
			<td></td>
		</tr>
		<%
			List<Ordemservico> oss = (List<Ordemservico>) request
					.getAttribute("osusuario");
			for (Ordemservico aux : oss) {
		%>
		<tr>
			<td><%=aux.getOrdemservico_id()%></td>
			<td><%=aux.getDatacompra()%></td>
			<td><%=aux.getStatusos()%></td>
			<td><% if(usuarioLoginAutenticado.getAcl() == 1){ %><a class='btn btn-info' href='#' onclick='editar()'>Editar</a><% } %> <a class='btn btn-info' href='OrdemservicoController?action=listarItensOS&pagina=ListarItensOS&os_id=<%= aux.getOrdemservico_id() %>'>Visualizar Itens</a> </td>
		</tr>
		<%
			}
		%>
	</table>
</div>

<!-- Clear HACK -->
<div style='width: 1000px; height: 40px; margin: auto;'></div>

<script>
	function editar(jsonObject){
			document.getElementById('editar-categorias').style.display = 'block';
			$(function() {
				$("#editar-categorias").dialog({
					modal : true,
					show : {
						effect : "clip",
						duration : 300
					},
					hide : {
						effect : "clip",
						duration : 300
					}
				});
			});
			
			document.getElementById('titulo-editar').value = jsonObject.titulo;
			document.getElementById('categoriaid-editar').value = jsonObject.categoria_id;
	}
</script>