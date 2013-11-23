
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

	if (usuarioLoginAutenticado == null
	|| usuarioLoginAutenticado.getAcl() != 1) {
		out.write("<div class='alert alert-danger'> Área restrita, realize login. &nbsp; <a href='UsuarioController?action=redirect&pagina=LogarUsuario'>Clique Aqui</a></div>");
		return;
	}
%>

<div class="page-header">
	<h1>
		Categorias <small>Todas as categorias</small>
	</h1>
</div>

<%
	String msg = (String) request.getAttribute("sys_mensagem");
	if (msg != null)
		out.write("<div class='alert alert-info'>" + msg + "</div>");
%>

<div style='width: 500px'>
	<div id='opcoesBox'>
		<p>Ações para categoria:</p>
		<select name='opcoes' id='opcoes' class="form-control">
			<option value selected>Selecione uma opção</option>
			<option value="buscar">Buscar Categoria</option>
			<option value="adicionar">Adicionar Categoria</option>
			<option value="deletar">Deletar Categoria</option>
		</select> <br>
		<button type="submit" id='botaopcoes' onclick='executaOpcoes();'
			class="btn btn-default">Executar</button>
	</div>

	<div id='search-categorias' style="display: none;"
		title="Buscar Categoria">
		<form
			action="CategoriaController?action=listar_admin&pagina=ListarCategorias"
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

	<div id='add-categorias' style="display: none;"
		title="Adicionar Categoria">
		<form
			action="CategoriaController?action=add_admin&pagina=ListarCategorias"
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
	
	<div id='editar-categorias' style="display: none;"
		title="Editar Categoria">
		<form
			action="CategoriaController?action=editar_admin&pagina=ListarCategorias"
			method='post'>
			<div class="form-group">
				<label for="titulo" class="col-sm-2 control-label">Titulo</label>
				<div class="col-sm-10">
					<input type="text" name='titulo' class="form-control" id="titulo-editar"
						placeholder="Nome da Categoria" required="required">
				</div>
			</div>
			<br> <br>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<input type = "hidden" id='categoriaid-editar' name ="categoria_id"> 
					<button type="submit" id='botao-editar' class="btn btn-default">Editar</button>
				</div>
			</div>
		</form>
	</div>

	<br>

	<table class="table">
		<tr>
			<td></td>
			<td>Id</td>
			<td>Titulo</td>
		</tr>
		<%
			List<Categoria> categorias = (List<Categoria>) request
					.getAttribute("categorias");
			for (Categoria aux : categorias) {
				
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("categoria_id", aux.getCategoria_id());
				jsonObj.put("titulo", aux.getTitulo());
		%>
		<tr id='<%=aux.getCategoria_id()%>'>
			<td><input type='checkbox' name='marcados'
				value='<%=aux.getCategoria_id()%>'></td>
			<td><%=aux.getCategoria_id()%></td>
			<td><a
				href='#' onclick='editar(<%=jsonObj%>)'><%=aux.getTitulo()%></a></td>
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
				document.getElementById('search-categorias').style.display = 'block';
				$(function() {
					$("#search-categorias").dialog({
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
										url : "CategoriaController?action=deletar_admin",
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
				document.getElementById('add-categorias').style.display = 'block';
				$(function() {
					$("#add-categorias").dialog({
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