package projetofinal.lp3.models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "itemordemservicos")
@SequenceGenerator(name = "seq", sequenceName="itemordemservicos_itemordemservico_id_seq", allocationSize = 1, initialValue = 1)
public class Itemordemservico implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "itemordemservico_id", unique = true, nullable = false)
	@GeneratedValue(generator = "seq")
	private	 Integer itemordemservico_id;
	
	@ManyToOne
	@JoinColumn(name = "ordemservico_id")
	private Ordemservico ordemservico;
	
	@ManyToOne
	@JoinColumn(name = "produto_id")
	private Produto produto;
	
	@Column(name = "quantidade")
	private Integer quantidade;
	
	
	public Itemordemservico(){
		super();
	}
	
	public Itemordemservico(Integer itemordemservico_id,
			Ordemservico ordemservico, Produto produto, Integer quantidade) {
		super();
		this.itemordemservico_id = itemordemservico_id;
		this.ordemservico = ordemservico;
		this.produto = produto;
		this.quantidade = quantidade;
	}

	public Itemordemservico(Ordemservico ordemservico, Produto produto,
			Integer quantidade) {
		super();
		this.ordemservico = ordemservico;
		this.produto = produto;
		this.quantidade = quantidade;
	}
	
	public Itemordemservico(Produto produto,
			Integer quantidade) {
		super();
		this.produto = produto;
		this.quantidade = quantidade;
	}

	public Integer getItemordemservico_id() {
		return itemordemservico_id;
	}


	public void setItemordemservico_id(Integer itemordemservico_id) {
		this.itemordemservico_id = itemordemservico_id;
	}


	public Ordemservico getOrdemservico() {
		return ordemservico;
	}


	public void setOrdemservico(Ordemservico ordemservico) {
		this.ordemservico = ordemservico;
	}


	public Produto getProduto() {
		return produto;
	}


	public void setProduto(Produto produto) {
		this.produto = produto;
	}


	public Integer getQuantidade() {
		return quantidade;
	}


	public void setQuantidade(Integer quantidade) {
		this.quantidade = quantidade;
	}
}
