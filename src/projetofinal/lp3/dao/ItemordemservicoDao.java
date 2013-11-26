package projetofinal.lp3.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import projetofinal.lp3.models.Categoria;
import projetofinal.lp3.models.Itemordemservico;
import projetofinal.lp3.models.Ordemservico;
import projetofinal.lp3.models.Produto;
import projetofinal.lp3.utils.HibernateUtil;

public class ItemordemservicoDao {
	
	public static boolean salvar(Itemordemservico ios){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			session.save(ios);
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
	
	public static boolean atualizar(Itemordemservico ios){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			session.update(ios);
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
	
	public static boolean deletar(Itemordemservico ios){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			session.delete(ios);
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
	
	public static List<Itemordemservico> listarItensOS(){
		List<Itemordemservico> itensordemservicos = null;
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			Criteria cr = session.createCriteria(Itemordemservico.class);
			itensordemservicos = cr.list();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		return itensordemservicos;
	}
	
	public static List<Itemordemservico> listarItensOSByOS(Ordemservico OS){
		List<Itemordemservico> itensordemservicos = null;
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			Criteria cr = session.createCriteria(Itemordemservico.class);
			cr.add(Restrictions.eq("ordemservico", OS));
			itensordemservicos = cr.list();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		return itensordemservicos;
	}
	
}
