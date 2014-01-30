package projetofinal.lp3.languages;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.jstl.core.Config;

import projetofinal.lp3.dao.UsuarioDao;
import projetofinal.lp3.models.*;

public class MudaLinguaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MudaLinguaServlet() {
		super();
	}

	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sessao = request.getSession();
		Usuario usuario = (Usuario) sessao.getAttribute("auth_session_usuario");

		String language = request.getParameter("lang");
		String country = request.getParameter("country");
		String[] parts = null;
		
		Config.set(request.getSession(), Config.FMT_LOCALE, new java.util.Locale(language, country));
		
		if(usuario != null){			
			usuario.setIdioma(language+"_"+country);
			if(UsuarioDao.atualizar(usuario)){
				List<Usuario> usuarios = UsuarioDao.getUsuarioByLoginBySenha(usuario);
				sessao.setAttribute("auth_session_usuario", usuarios.get(0));
			}
		}
		
		response.sendRedirect("Template.jsp");
	}
}

