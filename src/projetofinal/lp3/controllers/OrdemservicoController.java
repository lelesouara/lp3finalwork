package projetofinal.lp3.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import projetofinal.lp3.dao.ItemordemservicoDao;
import projetofinal.lp3.dao.OrdemservicoDao;
import projetofinal.lp3.dao.ProdutoDao;
import projetofinal.lp3.models.Itemordemservico;
import projetofinal.lp3.models.Ordemservico;
import projetofinal.lp3.models.Produto;
import projetofinal.lp3.models.Usuario;

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
			
		}else if (action.equals("listarOS")) {
			listarOSUsuario(request, response);
			
		}else if (action.equals("listarItensOS")) {
			listarItensOS(request, response);
			
		}else if(action.equals("remover")){
			removerItemCarrinho(request, response);
			
		}else if(action.equals("add")){
			adicionarCarrinho(request, response);
			
		}else if(action.equals("limpar")){
			limparCarrinho(request, response);
			
		}else if(action.equals("editarquantidade")){
			editarQuantidadeProdutoCarrinho(request, response);
			
		}else if(action.equals("finalizar")){
			finalizarCarrinho(request, response);
		}
	}
	
	private void listarItensOS(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		verificaExistenciaCarrinho(session);
		
		Integer os_id = Integer.parseInt(request.getParameter("os_id"));
		List<Ordemservico> osObj = OrdemservicoDao.listarOSById(os_id);
		List<Itemordemservico> itensOs = ItemordemservicoDao.listarItensOSByOS(osObj.get(0));
		
		request.setAttribute("itensOs", itensOs);
		goToPagina("Template.jsp", request.getParameter("pagina"), request, response);
	}
	
	private void listarOSUsuario(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		verificaExistenciaCarrinho(session);
		
		Usuario userLogged = (Usuario) session.getAttribute("auth_session_usuario");
		List<Ordemservico> OSUsuario = OrdemservicoDao.listarOsByPerfilId(userLogged.getPerfil());
		
		request.setAttribute("osusuario", OSUsuario);
		goToPagina("Template.jsp", request.getParameter("pagina"), request, response);
	}
	
	private void finalizarCarrinho(HttpServletRequest request, HttpServletResponse response){
		boolean saveOS = false;
		
		HttpSession session = request.getSession();
		verificaExistenciaCarrinho(session);
		
		Usuario userLogged = (Usuario) session.getAttribute("auth_session_usuario");
		
		Ordemservico os = new Ordemservico(userLogged.getPerfil(), new Date(System.currentTimeMillis()), "aberto");
		if(OrdemservicoDao.salvar(os))
			saveOS = true;
		List<Ordemservico> lastOSOfPerfil = OrdemservicoDao.listarOsByPerfilId(userLogged.getPerfil()); 
		Integer lastID = lastOSOfPerfil.get(0).getOrdemservico_id();
		
		List<Itemordemservico> itens = (ArrayList<Itemordemservico>) session.getAttribute("carrinho_compra");
		
		for(Itemordemservico aux : itens){
			Itemordemservico iOS = new Itemordemservico(lastOSOfPerfil.get(0), aux.getProduto(), aux.getQuantidade());
			ItemordemservicoDao.salvar(iOS);
		}
		
		//limpa carrinho
		session.removeAttribute("carrinho_compra");
		
		request.setAttribute("sys_mensagem", "Pedido realizado com sucesso, aguarde contato.");
		goToPagina("Template.jsp", request.getParameter("pagina"), request, response);
	}
	
	private void editarQuantidadeProdutoCarrinho(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		verificaExistenciaCarrinho(session);
		
		Integer produto_id = Integer.parseInt(request.getParameter("produto_id"));
		Integer quantidade = Integer.parseInt(request.getParameter("quantidade"));
		
		List<Itemordemservico> itens = (ArrayList<Itemordemservico>) session.getAttribute("carrinho_compra");
		
		for(Itemordemservico aux : itens){
			if(aux.getProduto().getProduto_id().equals(produto_id)){
				aux.setQuantidade(quantidade);
			}
		}
		
		goToPagina("Template.jsp", request.getParameter("pagina"), request, response);
	}
	
	private void limparCarrinho(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		verificaExistenciaCarrinho(session);
		
		session.removeAttribute("carrinho_compra");
		goToPagina("Template.jsp", request.getParameter("pagina"), request, response);
	}
	
	private void removerItemCarrinho(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		verificaExistenciaCarrinho(session);
		Integer produto_id = Integer.parseInt(request.getParameter("produto"));
		
		List<Itemordemservico> itens = (ArrayList<Itemordemservico>) session.getAttribute("carrinho_compra");
		
		for(int i=0; i< itens.size(); i++){
			Itemordemservico aux = itens.get(i);
			if(aux.getProduto().getProduto_id() == produto_id){
				itens.remove(aux);
			}
		}
		goToPagina("Template.jsp", request.getParameter("pagina"), request, response);
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
