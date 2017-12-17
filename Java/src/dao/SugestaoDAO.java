package dao;

import java.sql.SQLException;

import dbcon.Conexao;
import model.Sugestao;

public class SugestaoDAO {
	public void envia(Sugestao s) throws SQLException{
		try {
			Conexao conexao = new Conexao();
			conexao.executarComando("insert into sugestao(tipo, conteudo) values ('"+ s.getTipo() +"','" + s.getConteudo() + "')");
			conexao.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
}
