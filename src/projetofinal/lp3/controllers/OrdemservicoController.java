package projetofinal.lp3.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import projetofinal.lp3.dao.ProdutoDao;
import projetofinal.lp3.models.Itemordemservico;
import projetofinal.lp3.models.Produto;

/**
 * Servlet implementation class Ordemservico
 */
public class OrdemservicoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrdemservicoController() {
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
			HttpServletResponse response) throws IOException {
		String action = request.getParameter("action");

		if (action.equals("redirect")) {
			goToPagina("Template.jsp", request.getParameter("pagina"), request,
					response);

		} else if (action.equals("listar")) {
			listarCarrinho(request, response);
			
		}else if(action.equals("deletar_admin")){
			
		}else if(action.equals("add")){
			adicionarCarrinho(request, response);
			
		}else if(action.equals("editar_admin")){
			
		}
	}
	
	private void adicionarCarrinho(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		verificaExistenciaCarrinho(session);
		
		Integer produto_id = Integer.parseInt(request.getParameter("produto"));
		List<Produto> produtoById = ProdutoDao.listarProdutosById(produto_id);
		if(!produtoById.isEmpty()){
			List<Itemordemservico> itens = (ArrayList<Itemordemservico>) session.getAttribute("carrinho_compra");
			boolean encontrouNoCarrinho = false;
			for(Itemordemservico aux : itens){
				if(aux.getProduto().getProduto_id() == produtoById.get(0).getProduto_id()){
					Integer quantidadeAtual = aux.getQuantidade();
					aux.setQuantidade(quantidadeAtual + 1);
					encontrouNoCarrinho = true;
				}
			}
			
			if(!encontrouNoCarrinho)
				itens.add(new Itemordemservico(produtoById.get(0), 1));
		}
		goToPagina("Template.jsp", request.getParameter("pagina"), request, response);
	}

	private void verificaExistenciaCarrinho(HttpSession session) {
		if(session.getAttribute("carrinho_compra") == null){
			List<Itemordemservico> itens = new ArrayList<Itemordemservico>();
			session.setAttribute("carrinho_compra", (ArrayList<Itemordemservico>) itens);
		}
	}

	private void listarCarrinho(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		verificaExistenciaCarrinho(session);
		
		goToPagina("Template.jsp", request.getParameter("pagina"), request, response);
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
