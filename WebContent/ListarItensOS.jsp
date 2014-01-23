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
<c:if test="${empty usuarioLoginAutenticado}">
	<div class='alert alert-warning'>
		Você nao tem permissão para acessar esta página!
		<c:redirect url="Principal.jsp"/>
	</div>
</c:if>

<c:set var="sys_mensagem" scope="request" value="${requestScope.sys_mensagem}"/>
<c:if test="${not empty sys_mensagem}">
	<div class='alert alert-info'>
		<c:out value="${sys_mensagem}"></c:out>
	</div>
</c:if>

<div style='width: 700px'>
		<table class="table">
		<tr>
			<td>Id</td>
			<td>Titulo</td>
			<td>Quantidade</td>
			<td>Total </td>
		</tr>
		
		<c:set value="${requestScope.itensOs}" var="ios"/>
		<c:forEach var="aux" items="${ios}">
			<tr>
				<td> <c:out value='${ aux.getItemordemservico_id() }'></c:out> </td>
				<td> <c:out value='${ aux.getProduto().getTitulo() }'></c:out> </td>
				<td> <c:out value='${ aux.getQuantidade() }'></c:out> </td>
				<td> Valor Unit. (<c:out value='${aux.getProduto().getValor()}' />), Total: <c:out value='${ aux.getProduto().getValor() * aux.getQuantidade() }'></c:out> </td>
			</tr>
		</c:forEach>
	</table>
</div>

<!-- Clear HACK -->
<div style='width: 1000px; height: 40px; margin: auto;'></div>