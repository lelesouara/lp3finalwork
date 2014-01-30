package projetofinal.lp3.graphics;

import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import org.jfree.data.general.DefaultPieDataset;

import projetofinal.lp3.dao.ProdutoDao;
import de.laures.cewolf.DatasetProduceException;
import de.laures.cewolf.DatasetProducer;

public class GraficoProdutoPie implements DatasetProducer {

	public Object produceDataset(Map arg0) throws DatasetProduceException {
		DefaultPieDataset dataset = new DefaultPieDataset();
		
		Properties prop = ProdutoDao.ProdutoInCategoria();		
		Set produtos = prop.keySet();
		Iterator itr = produtos.iterator();
		while (itr.hasNext()) {
			String str = (String) itr.next();
			dataset.setValue(str, Integer.parseInt((String) prop.get(str)));
		}
		return dataset;
	}

	public boolean hasExpired(Map arg0, Date arg1) {
		return true;
	}

	public String getProducerId() {
		return "Grafico1";
	}
}