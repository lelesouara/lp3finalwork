package projetofinal.lp3.controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import projetofinal.lp3.dao.CategoriaDao;
import projetofinal.lp3.dao.ProdutoDao;
import projetofinal.lp3.models.Categoria;
import projetofinal.lp3.models.Produto;

/**
 * Servlet implementation class IndexController
 */
public class IndexController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public IndexController() {
		super();
		// TODO Auto-generated constructor stub
	}

	private void processaRequest(HttpServletRequest request,
			HttpServletResponse response) {
		String action = request.getParameter("action");

		if (action.equals("redirect")) {
			goToPagina("Template.jsp", request.getParameter("pagina"), request,
					response);
			
		}else if(action.equals("index")){
			listar_index(request, response);
		}
	}
	
	private void listar_index(HttpServletRequest request, HttpServletResponse response){
		String pagina = request.getParameter("pagina");
		
		List<Categoria> categorias = CategoriaDao.listarCategorias();
		List<Produto> produtos = ProdutoDao.listarProdutos();
		
		request.setAttribute("categorias", categorias);
		request.setAttribute("produtos", produtos);
		goToPagina("Template.jsp", pagina, request, response);
		
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
