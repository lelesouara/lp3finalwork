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
			Double totalCompra = 0.0;
			for(Itemordemservico aux : itensCarrinho){
				totalCompra += (aux.getProduto().getValor()*aux.getQuantidade());
		%>
		<tr>
			<td></td>
			<td><%= aux.getProduto().getTitulo() %></td>
			<td><a href='#'><%= aux.getQuantidade() %></a></td>
			<td><%= (aux.getQuantidade()*aux.getProduto().getValor()) %></td>
			<td><a href='OrdemservicoController?action=remover&pagina=ListarCarrinho&produto=<%= aux.getProduto().getProduto_id() %>' class='btn btn-danger'> <span class='glyphicon glyphicon-remove'></span> Remover </a></td>
		</tr>
		<% } %>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td>Total da Compra:</td>
			<td><b><%= totalCompra %></b></td>
		</tr>
	</table>
	<% } } %>
	<a href='OrdemservicoController?action=limpar&pagina=ListarCarrinho' class='btn btn-default'> <span class='glyphicon glyphicon-trash'></span> Limpar Carrinho </a>
	<a href='IndexController?action=index&pagina=Principal' class='btn btn-info'> <span class='glyphicon glyphicon-share-alt'></span> Continuar comprando </a>
	<a href='OrdemservicoController?action=finalizar&pagina=OSUsuario' class='btn btn-success'> <span class='glyphicon glyphicon-credit-card'></span> Finalizar Compra </a>
</div>

<!-- Clear HACK -->
<div style='width: 1000px; height: 40px; margin: auto;'></div>