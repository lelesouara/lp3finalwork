<%@page import="org.json.simple.JSONObject"%>
<%@page import="projetofinal.lp3.models.Itemordemservico"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="page-header">
	<h1>
		Carrinho de Compras <small>Todos os produtos adicionados</small>
	</h1>
	<p>Obs: Para finalizar uma compra você deve estar logado.</p>
</div>

<div id='editar-produto' style="display: none;"
		title="Editar Quantidade Produto">
		<form
			action="OrdemservicoController?action=editarquantidade&pagina=ListarCarrinho"
			method='post'>
			<div class="form-group">
				<p id='titulo-editar'></p>
			</div>
			<br>
			<div class="form-group">
				<label for="quantidade" cl0ass="col-sm-2 control-label">Qtd</label>
				<div class="col-sm-10">
					<input type="text" name='quantidade' class="form-control" id="quantidade-editar"
					required="required">
				</div>
			</div>
			<br> <br>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<input type = "hidden" id='produto_id-editar' name ="produto_id"> 
					<button type="submit" id='botao-editar' class="btn btn-default">Editar</button>
				</div>
			</div>
		</form>
	</div>

<%
	String msg = (String) request.getAttribute("sys_mensagem");
	if (msg != null)
		out.write("<div class='alert alert-info'>" + msg + "</div>");
%>

<div style='width: 700px'>
	<%
		Double totalCompra = 0.0;
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
			<td>Titulo</td>
			<td>Quantidade</td>
			<td>Subtotal</td>
			<td></td>
		</tr>
		<%	
			for(Itemordemservico aux : itensCarrinho){
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("titulo", aux.getProduto().getTitulo());
				jsonObj.put("quantidade", aux.getQuantidade());
				jsonObj.put("produto_id", aux.getProduto().getProduto_id());
				
				totalCompra += (aux.getProduto().getValor()*aux.getQuantidade());
		%>
		<tr>
			<td><%= aux.getProduto().getTitulo() %></td>
			<td><a href='#' onclick='editarQuantidadeProduto(<%= jsonObj %>)'><%= aux.getQuantidade() %></a></td>
			<td><%= (aux.getQuantidade()*aux.getProduto().getValor()) + " (Un.)" + aux.getProduto().getValor() %></td>
			<td><a href='OrdemservicoController?action=remover&pagina=ListarCarrinho&produto=<%= aux.getProduto().getProduto_id() %>' class='btn btn-danger'> <span class='glyphicon glyphicon-remove'></span> Remover </a></td>
		</tr>
		<% } %>
		<tr>
			<td></td>
			<td></td>
			<td>Total da Compra:</td>
			<td><b><%= totalCompra %></b></td>
		</tr>
	</table>
	<% } } %>
	<a href='OrdemservicoController?action=limpar&pagina=ListarCarrinho' class='btn btn-default'> <span class='glyphicon glyphicon-trash'></span> Limpar Carrinho </a>
	<a href='IndexController?action=index&pagina=Principal' class='btn btn-info'> <span class='glyphicon glyphicon-share-alt'></span> Continuar comprando </a>
	<% if((request.getSession().getAttribute("auth_session_usuario") == null)){ %>
		<a href='#LogueSE' disabled='disabled' class='btn btn-success'> <span class='glyphicon glyphicon-credit-card'></span> Finalizar Compra </a>
	<% }else{ if((totalCompra > 0.0)){ %>
		<a href='OrdemservicoController?action=finalizar&pagina=PainelUsuario' class='btn btn-success'> <span class='glyphicon glyphicon-credit-card'></span> Finalizar Compra </a>
	<% } } %>
</div>

<!-- Clear HACK -->
<div style='width: 1000px; height: 40px; margin: auto;'></div>

<script>
	function editarQuantidadeProduto(objectJson){
		document.getElementById('editar-produto').style.display = 'block';
		$(function() {
			$("#editar-produto").dialog({
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
		document.getElementById('titulo-editar').innerHTML = objectJson.titulo;
		document.getElementById('quantidade-editar').value = objectJson.quantidade;
		document.getElementById('produto_id-editar').value = objectJson.produto_id;
	}
</script>