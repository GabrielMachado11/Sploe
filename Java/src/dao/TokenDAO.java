package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import dbcon.Conexao;
import model.Token;

public class TokenDAO {
	public void insereToken(Token a) throws SQLException{
		try {
			Conexao conexao = new Conexao();
			conexao.executarComando("insert into token (token, idusuario, data_geracao, tipo) values ('"+ a.getToken() +"'," + a.getIdUsuario() + ", " + a.getData() + ", '" + a.getTipo()+ "')");
			conexao.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	public boolean verificaCadastroToken(String idUsuario, Long dataGeracao, String tipo) {
		boolean podeCadastrar = true;
		
        String findSQL = "select * from token where idusuario = "+ idUsuario + "";
        try {
        	Conexao conexao = new Conexao();
            ResultSet resultados = conexao.buscarRegistros(findSQL);
            while(resultados.next()){
            	String tempo = resultados.getString("data_geracao");
            	Date data = new Date(Long.parseLong(tempo) + 300000); // 5 minutos
            	if(Integer.parseInt(resultados.getString("expirado")) == 0 && resultados.getString("tipo") == tipo) {
            		if(data.before(new Date())) {
            			expirarToken(resultados.getString("id"));
            		}else {
            			podeCadastrar = false;
            		}
            	}
            }
            conexao.close();
        } catch (SQLException ex) {
        	podeCadastrar = false;
            ex.printStackTrace();
        }
        
        return podeCadastrar;
	}
	
	public void expirarToken(String id) {
		try {
			Conexao conexao = new Conexao();
			String executaSQL = "UPDATE token SET expirado = 1 WHERE id = '" + id +"'";
			conexao.executarComando(executaSQL);
			conexao.close();
		}catch(SQLException ex) {
			ex.printStackTrace();
		}
	}
	
	public void expirarTokenByHash(String hash) {
		try {
			Conexao conexao = new Conexao();
			String executaSQL = "UPDATE token SET expirado = 1 WHERE token = '" + hash +"'";
			conexao.executarComando(executaSQL);
			conexao.close();
		}catch(SQLException ex) {
			ex.printStackTrace();
		}
	}
	
	public String verificaToken(String hash, String tipo) {
        String findSQL = "select * from token where token = '"+ hash + "'";
        String encontrado = "";
        try {
        	Conexao conexao = new Conexao();
            ResultSet resultados = conexao.buscarRegistros(findSQL);
            while(resultados.next()){            	
            	String tempo = resultados.getString("data_geracao");
            	Date data = new Date(Long.parseLong(tempo) + 300000); // 5 minutos
            	String tipoEncontrado = new String();
            	tipoEncontrado = resultados.getString("tipo");
            	
            	if(Integer.parseInt(resultados.getString("expirado")) == 0 && tipo.equals(tipoEncontrado)) {
            		if(data.before(new Date())) {
            			expirarToken(resultados.getString("id"));
            		}else {
            			encontrado = resultados.getString("idusuario");
            		}
        		}
            }
            conexao.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
		return encontrado;
	}
	
}
