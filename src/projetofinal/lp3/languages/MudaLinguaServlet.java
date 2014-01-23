package projetofinal.lp3.languages;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.jstl.core.Config;

import projetofinal.lp3.models.*;

public class MudaLinguaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MudaLinguaServlet() {
		super();
	}

	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		String language = request.getParameter("lingua");
        Locale locale = new Locale(language);
 
        Config.set(request.getSession(), Config.FMT_LOCALE, locale);
        Config.set(request.getSession(), Config.FMT_FALLBACK_LOCALE, locale);
 
         
        response.sendRedirect("Template.jsp");
	}

}

