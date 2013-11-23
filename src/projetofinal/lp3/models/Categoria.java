package projetofinal.lp3.models;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "categorias")
@SequenceGenerator(name = "seq", sequenceName="categorias_categoria_id_seq", allocationSize = 1, initialValue = 1)
public class Categoria implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "categoria_id", unique = true, nullable = false)
	@GeneratedValue(generator = "seq")
	private	 Integer categoria_id;
	
	@OneToMany(mappedBy="categoria", cascade=CascadeType.ALL)
    private List<Produto> produto;
	
	@Column(name = "titulo")
	private String titulo;
	
	public Categoria(){
		super();
	}
	
	public Categoria(String titulo) {
		super();
		this.titulo = titulo;
	}

	public Categoria(Integer categoria_id, String titulo) {
		super();
		this.categoria_id = categoria_id;
		this.titulo = titulo;
	}

	public Integer getCategoria_id() {
		return categoria_id;
	}

	public void setCategoria_id(Integer categoria_id) {
		this.categoria_id = categoria_id;
	}

	public List<Produto> getProduto() {
		return produto;
	}

	public void setProduto(List<Produto> produto) {
		this.produto = produto;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
}
