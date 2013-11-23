<%@page import="projetofinal.lp3.models.Categoria"%>
<%@page import="projetofinal.lp3.models.Produto"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="projetofinal.lp3.models.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	Usuario usuarioLoginAutenticado = (Usuario) session
	.getAttribute("auth_session_usuario");

	if (usuarioLoginAutenticado == null
	|| usuarioLoginAutenticado.getAcl() != 1) {
		out.write("<div class='alert alert-danger'> Área restrita, realize login. &nbsp; <a href='UsuarioController?action=redirect&pagina=LogarUsuario'>Clique Aqui</a></div>");
		return;
	}
%>

<div class="page-header">
	<h1>
		Produtos <small>Todas os produtos</small>
	</h1>
</div>

<%
	String msg = (String) request.getAttribute("sys_mensagem");
	if (msg != null)
		out.write("<div class='alert alert-info'>" + msg + "</div>");
%>

<div style='width: 500px'>
	<div id='opcoesBox'>
		<p>Ações para produtos:</p>
		<select name='opcoes' id='opcoes' class="form-control">
			<option value selected>Selecione uma opção</option>
			<option value="buscar">Buscar Produto</option>
			<option value="adicionar">Adicionar Produto</option>
			<option value="deletar">Deletar Produto</option>
		</select> <br>
		<button type="submit" id='botaopcoes' onclick='executaOpcoes();'
			class="btn btn-default">Executar</button>
	</div>

	<div id='search-produtos' style="display: none;"
		title="Buscar Produtos">
		<form
			action="ProdutoController?action=listar_admin&pagina=ListarProdutos"
			method='post'>
			<div class="form-group">
				<label for="titulo" class="col-sm-2 control-label">Titulo</label>
				<div class="col-sm-10">
					<input type="text" name='titulo' class="form-control" id="titulo"
						placeholder="Nome da Categoria" required="required">
				</div>
			</div>
			<br> <br>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" id='botao' class="btn btn-default">Pesquisar</button>
				</div>
			</div>
		</form>
	</div>

	<div id='add-produtos' style="display: none;"
		title="Adicionar Produto">
		<form
			action="ProdutoController?action=add_admin&pagina=ListarProdutos"
			method='post'>
			<div class="form-group">
				<label for="titulo" class="col-sm-2 control-label">Titulo</label>
				<div class="col-sm-10">
					<input type="text" name='titulo' class="form-control" id="titulo"
						placeholder="Nome da Categoria" required="required">
				</div>
			</div>
			<br> <br>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" id='botao' class="btn btn-default">Adicionar</button>
				</div>
			</div>
		</form>
	</div>
	
	<div id='editar-produtos' style="display: none;"
		title="Editar Produto">
		<form
			action="ProdutoController?action=editar_admin&pagina=ListarProdutos"
			method='post'>
			<div class="form-group">
				<label for="categoria" class="col-sm-2 control-label">Categoria</label>
				<br>
				<div class="col-sm-10">
					<select name='categoria' id='categoria_editar'>
						<%
							List<Categoria> categorias = (ArrayList<Categoria>) request.getAttribute("categorias");
							for(Categoria auxCat : categorias){
						%>
						<option value='<%= auxCat.getCategoria_id() %>'> <%=auxCat.getTitulo() %> </option>
						<% } %>
					</select>
				</div>
			</div>
			<br>
			<div class="form-group">
				<label for="titulo" class="col-sm-2 control-label">Titulo</label>
				<div class="col-sm-10">
					<input type="text" name='titulo' class="form-control" id="titulo-editar"
						placeholder="Nome da Categoria" required="required">
				</div>
			</div>
			<br>
			<div class="form-group">
				<label for="titulo" class="col-sm-2 control-label">Valor</label>
				<div class="col-sm-10">
					<input type="text" name='valor' class="form-control" id="valor-editar" 
					required="required">
				</div>
			</div>
			<br>
			<div class="form-group">
				<label for="titulo" class="col-sm-2 control-label">Desc</label>
				<div class="col-sm-10">
					<textarea rows="3" cols="20" name='descricao' id='descricao-editar'></textarea>
				</div>
			</div>
			<br>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<input type = "hidden" id='produtoid-editar' name ="produto_id"> 
					<button type="submit" id='botao-editar' class="btn btn-default">Editar</button>
				</div>
			</div>
		</form>
	</div>
	
	<div id='detalhes-produtos' style="display: none;"
		title="Detalhes do Produto">
		<p id='titulo-detalhes' style="font-weight: bold"></p>
		<p id='valor-detalhes'></p>
		<p id='descricao-detalhes'></p>
		<span id='categoria-detalhes' class="badge"></span>
	</div>

	<br>

	<table class="table">
		<tr>
			<td></td>
			<td>Id</td>
			<td>Categoria</td>
			<td>Titulo</td>
			<td></td>
		</tr>
		<%
			List<Produto> produtos = (List<Produto>) request
					.getAttribute("produtos");
			for (Produto aux : produtos) {
				
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("produto_id", aux.getProduto_id());
				jsonObj.put("titulo", aux.getTitulo());
				jsonObj.put("descricao", aux.getDescricao());
				jsonObj.put("valor", aux.getValor());
				jsonObj.put("categoria_id", aux.getCategoria().getCategoria_id());
				jsonObj.put("categoria_titulo", aux.getCategoria().getTitulo());
		%>
		<tr id='<%=aux.getProduto_id()%>'>
			<td><input type='checkbox' name='marcados'
				value='<%=aux.getProduto_id()%>'></td>
			<td><%=aux.getProduto_id()%></td>
			<td><a href='CategoriaController?action=listar_admin&pagina=ListarCategorias'><%=aux.getCategoria().getTitulo() %></a></td>
			<td><%=aux.getTitulo()%></td>
			<td><a class='btn btn-success' href='#' onclick='detalhes(<%=jsonObj%>)'>Detalhes</a> &nbsp; <a class='btn btn-success' href='#' onclick='editar(<%=jsonObj%>)'>Editar</a></td>
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
			document.getElementById('editar-produtos').style.display = 'block';
			$(function() {
				$("#editar-produtos").dialog({
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
			document.getElementById('valor-editar').value = jsonObject.valor;
			document.getElementById('descricao-editar').value = jsonObject.descricao;
			document.getElementById('produtoid-editar').value = jsonObject.produto_id;
			
			atualizaParaSelecionada(jsonObject.categoria_id);
	}
	
	function atualizaParaSelecionada(id){
		var selectbox = document.getElementById('categoria_editar').options;
		for( var i=0; i < selectbox.length; i++){
			if(selectbox[i].value == id){
				selectbox[i].selected = 'selected';
			}
		};
	}	
	
	function detalhes(jsonObject){
		document.getElementById('detalhes-produtos').style.display = 'block';
		$(function() {
			$("#detalhes-produtos").dialog({
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
		
		document.getElementById('titulo-detalhes').innerHTML = jsonObject.titulo;
		document.getElementById('valor-detalhes').innerHTML = "R$: "+jsonObject.valor;
		document.getElementById('descricao-detalhes').innerHTML = jsonObject.descricao;
		document.getElementById('categoria-detalhes').innerHTML = jsonObject.categoria_titulo;
	}

	function executaOpcoes() {
		var selectOpcoes = document.getElementById('opcoes');
		var opcoesBox = document.getElementById('opcoesBox');

		if (!selectOpcoes.value) {
			if (document.getElementById('spanError-Opcoes'))
				opcoesBox.removeChild(document
						.getElementById('spanError-Opcoes'));

			var node = document.createElement("span");
			node.setAttribute('id', 'spanError-Opcoes');
			node.setAttribute('class', 'alert alert-warning');
			node.innerHTML = "Você deve escolher uma <b>opção</b>.";
			opcoesBox.appendChild(node);
		} else {
			if (document.getElementById('spanError-Opcoes'))
				opcoesBox.removeChild(document
						.getElementById('spanError-Opcoes'));

			if (selectOpcoes.value == "buscar") {
				document.getElementById('search-produtos').style.display = 'block';
				$(function() {
					$("#search-produtos").dialog({
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
			}

			if (selectOpcoes.value == "deletar") {
				var arrValues = $('input[name = marcados]:checked').map(
						function() {
							return this.value;
						}).get();
				if (arrValues.length == 0) {
					if (document.getElementById('spanError-Opcoes'))
						opcoesBox.removeChild(document
								.getElementById('spanError-Opcoes'));

					var node = document.createElement("span");
					node.setAttribute('id', 'spanError-Opcoes');
					node.setAttribute('class', 'alert alert-warning');
					node.innerHTML = "Você deve <b>marcar</b> os itens a serem deletados.";
					opcoesBox.appendChild(node);
				} else {
					if (document.getElementById('spanError-Opcoes'))
						opcoesBox.removeChild(document
								.getElementById('spanError-Opcoes'));
				}

				for (var i = 0; i < arrValues.length; i++) {
					var elementoRemover = arrValues[i];
					$
							.ajax(
									{
										type : "POST",
										url : "ProdutoController?action=deletar_admin",
										data : {
											id : arrValues[i]
										}
									})
							.done(
									function(returned) {
										if (returned == "true") {
											$('input[name = marcados]:checked')
													.parents("tr")
													.hide(
															'slow',
															function() {
																$(
																		'#'
																				+ elementoRemover)
																		.remove();
															});
										}
									});
				}
			}

			if (selectOpcoes.value == "adicionar") {
				document.getElementById('add-produtos').style.display = 'block';
				$(function() {
					$("#add-produtos").dialog({
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
			}
		}

	}
</script>