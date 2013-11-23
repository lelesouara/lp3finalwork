package projetofinal.lp3.models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

@Entity
@Table(name = "perfils")
@SequenceGenerator(name = "seq", sequenceName = "perfils_perfil_id_seq", allocationSize = 1, initialValue = 1)
public class Perfil implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "perfil_id", unique=true, nullable=false)
	@GeneratedValue(generator = "seq")
	@GenericGenerator(name="seq", strategy="foreign", parameters=@Parameter(name="property", value="usuario_id"))
	private Integer perfil_id;
	
	@OneToOne
    @PrimaryKeyJoinColumn
    private Usuario usuario_id;
	
	@Column(name = "nome")
	private String nome;
	
	@Column(name = "telefone")
	private String telefone;
	
	@Column(name = "emailalternativo")
	private String emailalternativo;
	
	@Column(name = "endereco")
	private String endereco;
	
	public Perfil(){
		super();
	}
	
	public Perfil(Usuario usuario, String nome, String telefone,
			String emailalternativo, String endereco) {
		super();
		this.usuario_id = usuario;
		this.nome = nome;
		this.telefone = telefone;
		this.emailalternativo = emailalternativo;
		this.endereco = endereco;
	}

	public Integer getPerfil_id() {
		return perfil_id;
	}

	public void setPerfil_id(Integer perfil_id) {
		this.perfil_id = perfil_id;
	}

	public Usuario getUsuario() {
		return usuario_id;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario_id = usuario;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

	public String getEmailalternativo() {
		return emailalternativo;
	}

	public void setEmailalternativo(String emailalternativo) {
		this.emailalternativo = emailalternativo;
	}

	public String getEndereco() {
		return endereco;
	}

	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}

}
