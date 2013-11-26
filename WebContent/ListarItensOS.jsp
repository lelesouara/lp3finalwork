
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
		Itens OS <small>Itens OS</small>
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
			<td>Titulo</td>
			<td>Quantidade</td>
		</tr>
		<%
			List<Itemordemservico> ios = (List<Itemordemservico>) request
					.getAttribute("itensOs");
			for (Itemordemservico aux : ios) {
		%>
		<tr>
			<td><%=aux.getItemordemservico_id()%></td>
			<td><%=aux.getProduto().getTitulo()%></td>
			<td><%=aux.getQuantidade()%></td>
		</tr>
		<%
			}
		%>
	</table>
</div>

<!-- Clear HACK -->
<div style='width: 1000px; height: 40px; margin: auto;'></div>