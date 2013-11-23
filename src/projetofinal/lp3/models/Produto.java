package projetofinal.lp3.models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

@Entity
@Table(name = "produtos")
@SequenceGenerator(name = "seq", sequenceName = "produtos_produto_id_seq", allocationSize = 1, initialValue = 1)
public class Produto implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "produto_id", unique=true, nullable=false)
	@GeneratedValue(generator = "seq")
	private Integer produto_id;
	
	@ManyToOne
    @JoinColumn(name = "categoria_id")
    private Categoria categoria;
	
	@Column(name = "titulo")
	private String titulo;
	
	@Column(name = "descricao")
	private String descricao;
	
	@Column(name = "valor")
	private Double valor;
	
	public Produto(){
		super();
	}
	
	public Produto(Categoria categoria, String titulo, String descricao,
			Double valor) {
		super();
		this.categoria = categoria;
		this.titulo = titulo;
		this.descricao = descricao;
		this.valor = valor;
	}
	
	public Produto(Integer produto_id, Categoria categoria, String titulo, String descricao,
			Double valor) {
		super();
		this.produto_id = produto_id;
		this.categoria = categoria;
		this.titulo = titulo;
		this.descricao = descricao;
		this.valor = valor;
	}

	public Integer getProduto_id() {
		return produto_id;
	}

	public void setProduto_id(Integer produto_id) {
		this.produto_id = produto_id;
	}

	public Categoria getCategoria() {
		return categoria;
	}

	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public Double getValor() {
		return valor;
	}

	public void setValor(Double valor) {
		this.valor = valor;
	}
}
