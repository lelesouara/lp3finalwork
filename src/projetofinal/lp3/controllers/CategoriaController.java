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
			HttpServletResponse response) {
		String action = request.getParameter("action");

		if (action.equals("redirect")) {
			goToPagina("Template.jsp", request.getParameter("pagina"), request,
					response);

		} else if (action.equals("listar_admin")) {
			listarCategoriasAdmin(request, response);
		}
	}
	
	private void listarCategoriasAdmin(HttpServletRequest request, HttpServletResponse response){
		String pagina = request.getParameter("pagina");
		HttpSession session = request.getSession();
		Usuario userLogged = (Usuario) session.getAttribute("auth_session_usuario");
		if(userLogged.getAcl() != 1){
			goToPagina("Template.jsp", "Principal", request, response);
		}else{
			List<Categoria> categorias = CategoriaDao.listarCategorias();
			request.setAttribute("categorias", categorias);
			goToPagina("Template.jsp", pagina, request, response);
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processaRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processaRequest(request, response);
	}

}
