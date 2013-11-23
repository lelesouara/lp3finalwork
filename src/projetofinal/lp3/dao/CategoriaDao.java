package projetofinal.lp3.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import projetofinal.lp3.models.Categoria;
import projetofinal.lp3.utils.HibernateUtil;

public class CategoriaDao {
	
	public static boolean salvar(Categoria categoria){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			session.save(categoria);
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
	
	public static boolean atualizar(Categoria categoria){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			session.update(categoria);
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
	
	public static List<Categoria> listarCategorias(){
		List<Categoria> categorias = null;
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			Criteria cr = session.createCriteria(Categoria.class);
			//cr.add(Restrictions.like("nome", "C%"));
			//cr.add(Restrictions.lt("habitantes", new Double(80)));
			cr.addOrder(Order.asc("titulo"));
			categorias = cr.list();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		return categorias;
	}
	
}
