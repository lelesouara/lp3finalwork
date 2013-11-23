package projetofinal.lp3.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import projetofinal.lp3.models.Usuario;
import projetofinal.lp3.utils.HibernateUtil;

public class UsuarioDao {
	
	public static boolean salvar(Usuario usuario){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			session.save(usuario);
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
	
	public static boolean atualizar(Usuario usuario){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			session.update(usuario);
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
	
	public static List<Usuario> listarUsuarios(){
		List<Usuario> usuarios = null;
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			Criteria cr = session.createCriteria(Usuario.class);
			//cr.add(Restrictions.like("nome", "C%"));
			//cr.add(Restrictions.lt("habitantes", new Double(80)));
			cr.addOrder(Order.asc("login"));
			usuarios = cr.list();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		return usuarios;
	}
	
	public static List<Usuario> getUsuarioByLoginBySenha(Usuario user){
		List<Usuario> usuarios = null;
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			Criteria cr = session.createCriteria(Usuario.class);
			cr.add(Restrictions.ilike("login", user.getLogin()));
			cr.add(Restrictions.ilike("senha", user.getSenha()));
			cr.setMaxResults(1);
			usuarios = cr.list();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		
		return usuarios;
	}
	
	public static List<Usuario> getUsuarioByLogin(Usuario user){
		List<Usuario> usuarios = null;
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		try {
			session.beginTransaction();
			Criteria cr = session.createCriteria(Usuario.class);
			cr.add(Restrictions.ilike("login", user.getLogin()));
			cr.setMaxResults(1);
			usuarios = cr.list();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		
		return usuarios;
	}
	
	public static Usuario validacao(String ch){
		Session session = HibernateUtil.getSessionFactory().openSession();
		String HQL = "SELECT u FROM Usuario u WHERE u.validacao =:chave";
		
		try {
			session.beginTransaction();
			Query consulta = session.createQuery(HQL);
			consulta.setString("chave", ch);
			return (Usuario) consulta.uniqueResult();
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally{
			session.close();
		}
		return null;
	}
	
	public static boolean isDisponivel(String login) {
		boolean retorno = false;
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			session.beginTransaction();
			Criteria cr = session.createCriteria(Usuario.class);
			cr.add(Restrictions.eq("login", login));
			Object obj = cr.uniqueResult();
			if(obj == null){
				retorno = true;
			} else {
				retorno = false;
			}
		} catch (HibernateException e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		} finally {
			session.close();
		}
		return retorno;
	}
	
}
