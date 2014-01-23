<!-- Pagina implementando JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="projetofinal.lp3.models.Itemordemservico"%>
<%@page import="projetofinal.lp3.models.Ordemservico"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="projetofinal.lp3.models.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="projetofinal.lp3.models.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="page-header">
	<h1>
		Itens OS <small>Itens OS</small>
	</h1>
</div>

<c:set var="usuarioLoginAutenticado" value="${sessionScope.auth_session_usuario}"></c:set>


<c:set var="sys_mensagem" scope="request" value="${requestScope.sys_mensagem}"/>
<c:if test="${not empty sys_mensagem}">
	<div class='alert alert-info'>
		<c:out value="${sys_mensagem}"></c:out><c:out value="1111111111"></c:out>
	</div>
</c:if>

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