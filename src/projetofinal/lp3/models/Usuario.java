package projetofinal.lp3.models;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "usuarios")
@SequenceGenerator(name = "seq", sequenceName="usuarios_usuario_id_seq", allocationSize = 1, initialValue = 1)
public class Usuario implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "usuario_id", unique = true, nullable = false)
	@GeneratedValue(generator = "seq")
	private	 Integer usuario_id;
	
	@OneToOne(mappedBy="usuario_id", cascade=CascadeType.ALL)
    private Perfil perfil;
	
	@Column(name = "login")
	private String login;
	
	@Column(name = "senha")
	private String senha;
	
	@Column(name = "ult_acesso")
	private Date ult_acesso;
	
	@Column(name = "ativo")
	private Integer ativo;
	
	@Column(name = "idioma")
	private String idioma;
	
	@Column(name = "validacao")
	private String validacao;
	
	@Column(name = "acl")
	private int acl = 3;
	
	public Usuario(){
		super();
	}
	
	public Usuario(String login, String senha, Date ult_acesso) {
		super();
		this.login = login;
		this.senha = senha;
		this.ult_acesso = ult_acesso;
		this.ativo = 0;
		this.acl = 3;
	}
	
	public Usuario(String login, String senha, Date ult_acesso, String idioma) {
		super();
		this.login = login;
		this.senha = senha;
		this.ult_acesso = ult_acesso;
		this.ativo = 0;
		this.acl = 3;
		this.idioma = idioma;
	}

	public Usuario(String login, String senha) {
		super();
		this.login = login;
		this.senha = senha;
		this.acl = 3;
	}

	public Usuario(Integer usuario_id, String login, String senha, Date ult_acesso) {
		super();
		this.usuario_id = usuario_id;
		this.login = login;
		this.senha = senha;
		this.ult_acesso = ult_acesso;
		this.acl = 3;
	}

	public int getUsuario_id() {
		return usuario_id;
	}

	public void setUsuario_id(int usuario_id) {
		this.usuario_id = usuario_id;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}
	
	public String getIdioma() {
		return idioma;
	}

	public void setIdioma(String idioma) {
		this.idioma = idioma;
	}

	public Date getUlt_acesso() {
		return ult_acesso;
	}

	public void setUlt_acesso(Date ult_acesso) {
		this.ult_acesso = ult_acesso;
	}

	public Integer getAtivo() {
		return ativo;
	}

	public void setAtivo(Integer ativo) {
		this.ativo = ativo;
	}

	public String getValidacao() {
		return validacao;
	}

	public void setValidacao(String validacao) {
		this.validacao = validacao;
	}

	public Perfil getPerfil() {
		return perfil;
	}

	public void setPerfil(Perfil perfil) {
		this.perfil = perfil;
	}

	public void setUsuario_id(Integer usuario_id) {
		this.usuario_id = usuario_id;
	}

	public int getAcl() {
		return acl;
	}

	public void setAcl(int acl) {
		this.acl = acl;
	}
	
}
