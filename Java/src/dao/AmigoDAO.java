package dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import dbcon.Conexao;
import model.Amigos;
import model.Notificacoes;
import model.Usuario;


public class AmigoDAO {
	public void mandaConvite(Amigos a) throws SQLException{
		try {
			Conexao conexao = new Conexao();
			conexao.executarComando("insert into amigos (Usuario1, Usuario2) values ('"+ a.getAmigo() +"','" + a.getUsuario() + "')");
			conexao.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	public boolean verificaExistencia(String amigo1, String amigo2){
		boolean tem = false;
		
        String findSQL = "select * from amigos where usuario1 = '"+ amigo1 +"' and usuario2 = '" + amigo2 + "'";
        try {
        	Conexao conexao = new Conexao();
            ResultSet resultados = conexao.buscarRegistros(findSQL);
            while(resultados.next()){
            	tem = true;
            }
            conexao.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        return tem;
	}
	
	
	public int qntdAmigo(String email){
		int i = 0;
		String findSQL = "select * from amigos where usuario1 = '"+ email +"' or usuario2 = '" + email +"'";
        try {
        	Conexao conexao = new Conexao();
            ResultSet resultados = conexao.buscarRegistros(findSQL);
            while(resultados.next()){
            	i += 1;
            }
            conexao.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        return i;
	}
	public String[] retornaTodosAmigos(String email){
		int contador = 0;
		String[] vetor = new String[100];
        String findSQL = "select * from amigos where usuario1 = '"+ email +"' or usuario2 = '" + email +"'";
        try {
        	Conexao conexao = new Conexao();
            ResultSet resultados = conexao.buscarRegistros(findSQL);
            while(resultados.next()){
            	String usuario1 = resultados.getString("usuario1");
            	String usuario2 = resultados.getString("usuario2");
            	
            	UsuarioDAO usuarioDAO = new UsuarioDAO();
            	
            	Usuario temp1 = usuarioDAO.populaUser(usuario1);
            	Usuario temp2 = usuarioDAO.populaUser(usuario2);
            	
            	if(usuario1.equals(email)){
            		vetor[contador] = temp2.getNick();
            	}else{
            		vetor[contador] = temp1.getNick();
            	}
                
                ++contador;
                
            }
            conexao.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        return vetor;
        
	}
}
