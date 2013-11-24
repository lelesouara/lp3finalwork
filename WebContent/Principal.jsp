<%@page import="java.util.ArrayList"%>
<%@page import="projetofinal.lp3.models.Produto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="page-header">
  <h1>Inicio <small>Página Inicial</small></h1>
</div>

<% 
	List<Produto> produtos = (List<Produto>) request.getAttribute("produtos");
	for(Produto aux : produtos){
%>
<div class='floatItem'>
	<img src="images/apple.png" alt="productname" class="img-rounded">
	<div style='font-size:23px; color: #333; text-shadow: 1px 1px .5px #d1d1d1;'> <%= aux.getTitulo() %> </div>
	<div style='font-family: monospace; font-size: small; height: 70px; overflow: hidden'> <%= aux.getDescricao() %> </div>
	<div style='font-weight: bold; height: 25px;'> Somente R$ <%= aux.getValor() %> </div>
	<div> 
		<a class='btn btn-primary' href='CarrinhoController?action=add&pagina=ListarCarrinho'> <span class="glyphicon glyphicon-shopping-cart"></span> ADICIONAR AO CARRINHO </a>
	</div>
</div>
<% } %>