<%@page import="projetofinal.lp3.models.Itemordemservico"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="page-header">
	<h1>
		Carrinho de Compras <small>Todos os produtos adicionados</small>
	</h1>
</div>

<%
	String msg = (String) request.getAttribute("sys_mensagem");
	if (msg != null)
		out.write("<div class='alert alert-info'>" + msg + "</div>");
%>

<div style='width: 500px'>
	<%
		List<Itemordemservico> itensCarrinho = (ArrayList<Itemordemservico>) request.getSession().getAttribute("carrinho_compra");
		if(itensCarrinho == null){
			out.write("<div class='alert alert-info'>Carrinho está <b>vazio</b>.</div>");
		}else{
			if(itensCarrinho.isEmpty()){
				out.write("<div class='alert alert-info'>Carrinho está <b>vazio</b>.</div>");
			}else{
	%>
	<table class="table">
		<tr>
			<td></td>
			<td>Titulo</td>
			<td>Quantidade</td>
			<td>Subtotal</td>
			<td></td>
		</tr>
		<%
			for(Itemordemservico aux : itensCarrinho){
		%>
		<tr>
			<td></td>
			<td><%= aux.getProduto().getTitulo() %></td>
			<td><%= aux.getQuantidade() %></td>
			<td><%= (aux.getQuantidade()*aux.getProduto().getValor()) %></td>
			<td></td>
		</tr>
		<% } %>
	</table>
	<% } } %>
</div>

<!-- Clear HACK -->
<div style='width: 1000px; height: 40px; margin: auto;'></div>