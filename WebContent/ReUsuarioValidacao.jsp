<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="page-header">
  <h1>Usuários <small>Validação</small></h1>
</div>

<% 
	String msg = (String) request.getAttribute("sys_mensagem");
	if(msg != null)
		out.write("<div class='alert alert-info'>"+msg+"</div>");
%>

<!-- Clear HACK -->
<div style='width: 1000px; height: 40px; margin: auto;'></div>