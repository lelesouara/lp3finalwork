package projetofinal.lp3.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.json.simple.JSONObject;

import projetofinal.lp3.dao.UsuarioDao;
import projetofinal.lp3.models.Usuario;
import projetofinal.lp3.utils.Email;
import projetofinal.lp3.utils.ManipulateString;

/**
 * Servlet implementation class UsuarioController
 */
public class UsuarioController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UsuarioController() {
		super();
	}

	private void processaRequest(HttpServletRequest request,
			HttpServletResponse response) throws EmailException {
		String action = request.getParameter("action");

		if (action.equals("redirect")) {
			goToPagina("Template.jsp", request.getParameter("pagina"), request,
					response);

		} else if (action.equals("new_user")) {
			// Ir� adicionar um novo usu�rio
			novoUsuario(request, response);

		} else if (action.equals("auth_user")) {
			autenticarUsuario(request, response);

		} else if (action.equals("logout")) {
			HttpSession session = request.getSession();
			session.invalidate();
			goToPagina("Template.jsp", "Intro", request, response);

		} else if (action.equals("validacao")) {
			confirmarCadastro(request, response);
			
		}else if (action.equals("verificar_login")) {
			validarLogin(request, response);
		}
	}
	
	private void validarLogin(HttpServletRequest request,
			HttpServletResponse response) {
		String login = request.getParameter("login");
		boolean result = UsuarioDao.isDisponivel(login);
		System.out.println(login);
		PrintWriter out;
		try {
			JSONObject json = new JSONObject();
			out = response.getWriter();
			response.setContentType("application/json");
			if (result == true) {
				json.put("is_disponivel", true);
			} else {
				json.put("is_disponivel", false);
			}
			out.print(json);
			out.close();
		} catch (IOException exception) {
			System.out.println("Problemas ao verificar usuario");
		}
	}

	private void confirmarCadastro(HttpServletRequest request,
			HttpServletResponse response) {
		String chave = request.getParameter("chave");

		Usuario usuario = UsuarioDao.validacao(chave);
		if (usuario == null) {
			request.setAttribute("sys_mensagem",
					"Erro ao validar. Chave inexistente");
			goToPagina("Template.jsp", "ReUsuarioValidacao", request, response);
		}
		usuario.setAtivo(1);
		UsuarioDao.atualizar(usuario);

		HttpSession session = request.getSession();
		session.setAttribute("auth_session_usuario", usuario);
		request.setAttribute("sys_mensagem", "Validado com sucesso!");
		goToPagina("Template.jsp", "ReUsuarioValidacao", request, response);
	}

	private String[] getDadosEmail(String nome, String email,
			String chaveValidacao, String context) {
		String[] dadosEmail = new String[8];
		dadosEmail[0] = email;
		dadosEmail[1] = nome;
		dadosEmail[2] = "leandro.souara.web@gmail.com";
		dadosEmail[3] = "IFMS";
		dadosEmail[4] = "Confirmacao de Cadastro";
		dadosEmail[5] = "Ola " + nome
				+ " clique no link para validar seu cadastro:  " + context
				+ "?action=validacao&chave=" + chaveValidacao;
		dadosEmail[6] = "leandro.souara.web";
		dadosEmail[7] = "tlam114n";
		return dadosEmail;
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

	private void autenticarUsuario(HttpServletRequest request,
			HttpServletResponse response) {
		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		Usuario user = new Usuario(login, senha);

		List<Usuario> exists_in_Database = UsuarioDao
				.getUsuarioByLoginBySenha(user);
		if (!exists_in_Database.isEmpty()) {
			request.setAttribute("sys_mensagem", "Logado com sucesso!");
			HttpSession session = request.getSession();
			session.setAttribute("auth_session_usuario",
					exists_in_Database.get(0));
			goToPagina("Template.jsp", "PainelUsuario", request, response);
		} else {
			request.setAttribute("sys_mensagem",
					"Erro: Login ou senha errados!");
		}

		goToPagina("Template.jsp", "LogarUsuario", request, response);
	}

	private void novoUsuario(HttpServletRequest request,
			HttpServletResponse response) throws EmailException {

		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		String resenha = request.getParameter("resenha");

		if (!senha.equals(resenha) && !senha.equals("") && !resenha.equals("")) {
			request.setAttribute("sys_mensagem",
					"Senhas n�o conferem! Tente novamente.");
			goToPagina("Template.jsp", "CadastrarUsuario", request, response);
		} else {
			boolean saved = false;

			// Possivel cadastrar senhas iguais.
			Usuario user = new Usuario(login, senha, new Date(
					System.currentTimeMillis()));
			user.setValidacao(ManipulateString.generateString());

			List<Usuario> exists_in_Database = UsuarioDao
					.getUsuarioByLogin(user);
			if (exists_in_Database.isEmpty())
				saved = UsuarioDao.salvar(user);
			else
				saved = false;

			if (saved) {
				String context = request.getRequestURL().toString();
				String[] dadosEmail = this.getDadosEmail(user.getLogin(),
						user.getLogin(), user.getValidacao(), context);
				Email.enviarEmail(dadosEmail);

				request.setAttribute("sys_mensagem",
						"Usuario salvo com sucesso!");
			} else {
				request.setAttribute("sys_mensagem", "Erro ao salvar usuario.");
			}

			goToPagina("Template.jsp", "CadastrarUsuario", request, response);
		}

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			processaRequest(request, response);
		} catch (EmailException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			processaRequest(request, response);
		} catch (EmailException e) {
			e.printStackTrace();
		}
	}

}