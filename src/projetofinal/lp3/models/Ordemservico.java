package projetofinal.lp3.models;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "ordemservicos")
@SequenceGenerator(name = "seq", sequenceName="ordemservicos_ordemservico_id_seq", allocationSize = 1, initialValue = 1)
public class Ordemservico implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "ordemservico_id", unique = true, nullable = false)
	@GeneratedValue(generator = "seq")
	private	 Integer ordemservico_id;
	
	@ManyToOne
	@JoinColumn(name = "perfil_id")
	private Perfil perfil;
	
	@Column(name = "datacompra")
	private Date datacompra;
	
	@Column(name = "statusos")
	private String statusos;
	
	@OneToMany(mappedBy = "ordemservico")
	private List<Itemordemservico> produtos;
	
	public Ordemservico(){
		super();
	}

	public Ordemservico(Integer ordemservico_id, Perfil perfil,
			Date datacompra, String statusos) {
		super();
		this.ordemservico_id = ordemservico_id;
		this.perfil = perfil;
		this.datacompra = datacompra;
		this.statusos = statusos;
	}
	
	public Ordemservico(Perfil perfil,
			Date datacompra, String statusos) {
		super();
		this.perfil = perfil;
		this.datacompra = datacompra;
		this.statusos = statusos;
	}

	public Integer getOrdemservico_id() {
		return ordemservico_id;
	}

	public void setOrdemservico_id(Integer ordemservico_id) {
		this.ordemservico_id = ordemservico_id;
	}

	public Perfil getPerfil() {
		return perfil;
	}

	public void setPerfil(Perfil perfil) {
		this.perfil = perfil;
	}

	public Date getDatacompra() {
		return datacompra;
	}

	public void setDatacompra(Date datacompra) {
		this.datacompra = datacompra;
	}

	public String getStatusos() {
		return statusos;
	}

	public void setStatusos(String statusos) {
		this.statusos = statusos;
	}
	
}
