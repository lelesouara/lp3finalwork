package projetofinal.lp3.controllers;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;

import projetofinal.lp3.dao.PerfilDao;
import projetofinal.lp3.models.Perfil;
import projetofinal.lp3.models.Usuario;
import projetofinal.lp3.utils.ManipulateString;

/**
 * Servlet implementation class PerfilController
 */
public class PerfilController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PerfilController() {
		super();
		// TODO Auto-generated constructor stub
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

		} else if (action.equals("new_profile")) {
			novoPerfil(request, response);
		}
	}

	private void novoPerfil(HttpServletRequest request,
			HttpServletResponse response) {
		
		String nome 	= request.getParameter("nome");
		String telefone = request.getParameter("telefone");
		String emailalternativo = request.getParameter("emailalternativo");
		String endereco = request.getParameter("endereco");
		HttpSession session = request.getSession();
		Usuario usuario = (Usuario) session.getAttribute("auth_session_usuario");
		
		if (nome.equals("")) {
			request.setAttribute("sys_mensagem",
					"Erro ao criar perfil. O usuario_id ou nome não podem ser vazio.");
			goToPagina("Template.jsp", "CadastrarPerfil", request, response);
		} else {
			boolean saved = false;

			Perfil perfil = new Perfil(usuario, nome, telefone, emailalternativo, endereco);

			List<Perfil> exists_in_Database = PerfilDao
					.getPerfilByUsuarioId(perfil);
			if (exists_in_Database.isEmpty())
				saved = PerfilDao.salvar(perfil);
			else
				saved = false;

			if (saved) {
				request.setAttribute("sys_mensagem",
						"Perfil salvo com sucesso!");
			} else {
				request.setAttribute("sys_mensagem", "Erro ao salvar perfil. Perfil jé existe");
			}

			goToPagina("Template.jsp", "CadastrarPerfil", request, response);
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
