package projetofinal.lp3.controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import projetofinal.lp3.dao.CategoriaDao;
import projetofinal.lp3.models.Categoria;
import projetofinal.lp3.models.Usuario;

/**
 * Servlet implementation class CategoriaController
 */
public class CategoriaController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CategoriaController() {
		super();
	}

	private void goToPagina(String template, String pagina,
			HttpServletRequest request, HttpServletResponse response) {
		RequestDispatcher rd = null;
		rd = request.getRequestDispatcher(template);
		request.setAttribute("pagina", new String(pagina));

		try {
			rd.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void processaRequest(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String action = request.getParameter("action");

		if (action.equals("redirect")) {
			goToPagina("Template.jsp", request.getParameter("pagina"), request,
					response);

		} else if (action.equals("listar_admin")) {
			listarCategoriasAdmin(request, response);

		} else if (action.equals("deletar_admin")) {
			deletarCategoriaAdmin(request, response);

		} else if (action.equals("add_admin")) {
			adicionarCategoriaAdmin(request, response);

		} else if (action.equals("editar_admin")) {
			editarCategoriaAdmin(request, response);
		}
	}

	private void editarCategoriaAdmin(HttpServletRequest request,
			HttpServletResponse response) {
		String pagina = request.getParameter("pagina");
		HttpSession session = request.getSession();
		Usuario userLogged = (Usuario) session
				.getAttribute("auth_session_usuario");
		if (userLogged.getAcl() != 1) {
			goToPagina("Template.jsp", "Principal", request, response);
		} else {
			if (request.getMethod() == "POST") {
				String tituloCat = (String) request.getParameter("titulo");
				Integer categoria_id = Integer.parseInt(request
						.getParameter("categoria_id"));
				CategoriaDao.atualizar(new Categoria(categoria_id, tituloCat));
				request.setAttribute("sysmsg", "Editado com sucesso.");
			}

			List<Categoria> categorias = CategoriaDao.listarCategorias();
			request.setAttribute("categorias", categorias);
			goToPagina("Template.jsp", pagina, request, response);
		}
	}

	private void adicionarCategoriaAdmin(HttpServletRequest request,
			HttpServletResponse response) {
		String pagina = request.getParameter("pagina");
		HttpSession session = request.getSession();
		Usuario userLogged = (Usuario) session
				.getAttribute("auth_session_usuario");
		if (userLogged.getAcl() != 1) {
			goToPagina("Template.jsp", "Principal", request, response);
		} else {
			if (request.getMethod() == "POST") {
				String tituloCat = (String) request.getParameter("titulo");
				CategoriaDao.salvar(new Categoria(tituloCat));
				request.setAttribute("sysmsg", "Salvo com sucesso.");
			}

			List<Categoria> categorias = CategoriaDao.listarCategorias();
			request.setAttribute("categorias", categorias);
			goToPagina("Template.jsp", pagina, request, response);
		}
	}

	private void deletarCategoriaAdmin(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		if (request.getMethod() == "POST") {
			Integer categoria_id = Integer.parseInt(request.getParameter("id"));

			if (categoria_id == null)
				response.getWriter().write("false");
			else {
				if (CategoriaDao.deletar(new Categoria(categoria_id, "")))
					response.getWriter().write("true");
				else
					response.getWriter().write("false");
			}
		}
	}

	private void listarCategoriasAdmin(HttpServletRequest request,
			HttpServletResponse response) {
		String pagina = request.getParameter("pagina");
		HttpSession session = request.getSession();
		Usuario userLogged = (Usuario) session
				.getAttribute("auth_session_usuario");
		if (userLogged.getAcl() != 1) {
			goToPagina("Template.jsp", "Principal", request, response);
		} else {
			List<Categoria> categorias = null;

			if (request.getMethod() == "POST") {
				String tituloCat = (String) request.getParameter("titulo");
				categorias = CategoriaDao.listarCategoriasByTitulo(tituloCat);
			} else {
				categorias = CategoriaDao.listarCategorias();
			}

			request.setAttribute("categorias", categorias);
			goToPagina("Template.jsp", pagina, request, response);
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processaRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processaRequest(request, response);
	}

}
