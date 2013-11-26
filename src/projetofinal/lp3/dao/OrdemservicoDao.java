package projetofinal.lp3.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import projetofinal.lp3.models.Categoria;
import projetofinal.lp3.models.Ordemservico;
import projetofinal.lp3.models.Perfil;
import projetofinal.lp3.models.Produto;
import projetofinal.lp3.utils.HibernateUtil;

public class OrdemservicoDao {
	
	public static boolean salvar(Ordemservico os){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			session.save(os);
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
	
	public static boolean atualizar(Ordemservico os){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			session.update(os);
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
	
	public static boolean deletar(Ordemservico os){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			session.delete(os);
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
	
	public static List<Ordemservico> listarOS(){
		List<Ordemservico> ordemservicos = null;
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			Criteria cr = session.createCriteria(Ordemservico.class);
			cr.addOrder(Order.desc("datacompra"));
			ordemservicos = cr.list();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		return ordemservicos;
	}
	
	
	public static List<Ordemservico> listarOSById(Integer id){
		List<Ordemservico> ordemservicos = null;
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			Criteria cr = session.createCriteria(Ordemservico.class);
			cr.add(Restrictions.eq("ordemservico_id", id));
			cr.addOrder(Order.desc("datacompra"));
			//cr.setMaxResults(1);
			ordemservicos = cr.list();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		return ordemservicos;
	}
	
	public static List<Ordemservico> listarOsByPerfilId(Perfil perfil){
		List<Ordemservico> ordemservicos = null;
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			Criteria cr = session.createCriteria(Ordemservico.class);
			cr.add(Restrictions.eq("perfil", perfil));
			cr.addOrder(Order.desc("ordemservico_id"));
			//cr.setMaxResults(1);
			ordemservicos = cr.list();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		return ordemservicos;
	}
	
}
