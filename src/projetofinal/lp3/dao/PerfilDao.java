package projetofinal.lp3.dao;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.dialect.function.CastFunction;

import projetofinal.lp3.models.Perfil;
import projetofinal.lp3.utils.HibernateUtil;

public class PerfilDao {
	
	public static boolean salvar(Perfil perfil){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			session.save(perfil);
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
	
	public static boolean atualizar(Perfil perfil){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			session.update(perfil);
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
	
	public static List<Perfil> getPerfilByUsuarioId(Perfil perfil){
		List<Perfil> perfils = null;
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			Criteria cr = session.createCriteria(Perfil.class);
			cr.add(Restrictions.eq("perfil_id", perfil.getUsuario().getUsuario_id()));
			perfils = cr.list();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		
		return perfils;
	}	
}
