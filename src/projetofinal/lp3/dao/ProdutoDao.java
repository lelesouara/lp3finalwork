package projetofinal.lp3.dao;

import java.util.List;
import java.util.Properties;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import projetofinal.lp3.models.Categoria;
import projetofinal.lp3.models.Produto;
import projetofinal.lp3.utils.HibernateUtil;

public class ProdutoDao {
	
	public static boolean salvar(Produto produto){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			session.save(produto);
			session.getTransaction().commit();
			return true;
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		return false;
	}
	
	public static boolean atualizar(Produto produto){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			session.update(produto);
			session.getTransaction().commit();
			return true;
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		return false;
	}
	
	public static boolean deletar(Produto produto){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			session.delete(produto);
			session.getTransaction().commit();
			return true;
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		return false;
	}
	
	public static List<Produto> listarProdutos(){
		List<Produto> produtos = null;
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			Criteria cr = session.createCriteria(Produto.class);
			cr.addOrder(Order.asc("titulo"));
			produtos = cr.list();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		return produtos;
	}
	
	public static List<Produto> listarProdutosByTitulo(String titulo){
		List<Produto> produtos = null;
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			Criteria cr = session.createCriteria(Produto.class);
			cr.add(Restrictions.ilike("titulo", "%"+ titulo +"%"));
			cr.addOrder(Order.asc("titulo"));
			produtos = cr.list();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		return produtos;
	}
	
	public static List<Produto> listarProdutosById(Integer id){
		List<Produto> produtos = null;
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			Criteria cr = session.createCriteria(Produto.class);
			cr.add(Restrictions.eq("produto_id", id));
			cr.addOrder(Order.asc("titulo"));
			produtos = cr.list();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		return produtos;
	}
	
	public static Properties ProdutoInCategoria(){
		List<Object> objetos = null;
		Properties prop = new Properties();
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			
			Criteria criteria = session.createCriteria(Produto.class);
			criteria.setProjection(Projections.projectionList().add(Projections.rowCount()).add(Projections.groupProperty("categoria")));
			
			objetos = criteria.list();
			for(Object o : objetos){
				Object[] objArr = (Object[]) o;
				prop.setProperty(((Categoria) objArr[1]).getTitulo(), 
						objArr[0].toString());				
			}
			
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} finally {
			session.close();
		}
		return prop;
	}
}
