package dao;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import dbcon.Conexao;
import model.Usuario;

public class UsuarioDAO {

	
	public void inserirUsuario(Usuario user) throws SQLException{
		try {
			Conexao conexao = new Conexao();
			conexao.executarComando("insert into usuario(pergunta, resposta, genero, nome, email, dataNascimento, senha, nick, numVitorias) values ('"+ user.getPergunta() +"','" + user.getResposta()+ "', '"+user.getGenero()+"', '"+ user.getNome()+"', '"+ user.getEmail() +"', '"+ user.getDataNascimento()+"', '"+ user.getSenha()+"','"+ user.getNick()+"', 0)");
			conexao.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		/*
		 * Recebe um objeto usuario e poe no bdd, apenas isso
		 */
	}
	
	public ArrayList<String> pegaUserRanking() {
		String findSQL = "select * from usuario order by numvitorias desc";
		ArrayList<String> nicks = new ArrayList<String>();
		 try {
	        	Conexao conexao = new Conexao();
	            ResultSet resultados = conexao.buscarRegistros(findSQL);
	            while(resultados.next()) {
	                nicks.add(resultados.getString("nick"));
	               
	            }
	            conexao.close();
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }
		 return nicks;
	}
	
	public ArrayList<String> pegaUserRankingVit() {
		String findSQL = "select * from usuario order by numvitorias desc";
		ArrayList<String> nicks = new ArrayList<String>();
		 try {
	        	Conexao conexao = new Conexao();
	            ResultSet resultados = conexao.buscarRegistros(findSQL);
	            while(resultados.next()) {
	                nicks.add(resultados.getString("numvitorias"));
	               
	            }
	            conexao.close();
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }
		 return nicks;
	}
	
	public void atualizarSenha(String novaSenha, String email) throws SQLException{
		Conexao conexao = new Conexao();
		String executaSQL = "UPDATE usuario SET senha = '"+  novaSenha  +"' WHERE email = '" + email +"'";
		conexao.executarComando(executaSQL);
		conexao.close();
    }
	
	public void confirmaCadastro(String confirma, String id) throws SQLException{
		Conexao conexao = new Conexao();
		String executaSQL = "UPDATE usuario SET confirmacao = '"+  confirma  +"' WHERE idusuario = '" + id +"'";
		conexao.executarComando(executaSQL);
		conexao.close();
    }
	
	public void somaVitoria(String email) {
		Conexao conexao;
		try {
			conexao = new Conexao();
			String executaSQL = "UPDATE usuario SET numvitorias = numvitorias + 1 WHERE email = '" + email +"'";
			conexao.executarComando(executaSQL);
			conexao.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public int[] confirmarExistenciaUsuarioCadastrado(Usuario user){
		int verifica[] = new int[2];
		int flag = 0;
		boolean pode;
		Usuario a = new Usuario();
        String findSQL = "select * from usuario where email = '"+ user.getEmail()+"' or nick = '" + user.getNick() + "'";
        try {
        	Conexao conexao = new Conexao();
            ResultSet resultados = conexao.buscarRegistros(findSQL);
            while(resultados.next()){
                a.setIdUsuario(Integer.parseInt(resultados.getString("idUsuario")));
                a.setNome(resultados.getString("nome"));
                a.setEmail (resultados.getString("email"));
                a.setNick(resultados.getString("nick"));
                a.setConfirmacao(resultados.getString("confirmacao"));
            }
            conexao.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        
        
        if(user.getEmail().equals(a.getEmail())){
        	if(a.getConfirmacao() == "1") {
        		verifica[0] = 1;
        	}else {
        		TokenDAO tokenDao = new TokenDAO();
        		if(!tokenDao.verificaCadastroToken(String.valueOf(user.getIdUsuario()), new Date().getTime(), "cadastro")) {
        			verifica[0] = 1;
        		}
        	}
     	   
        }else{
     	   verifica[0] = 0;
        }
        
        if(user.getNick().equals(a.getNick())){
     	   verifica[1] = 1;
        }else{
     	   verifica[1] = 0;
        }
       
        return verifica;
        /*
         * metodo que verifica se ja existe algum usuario com email e nick, apos analisar se já há um email ou nick ele seta a o vetor "verifica" com 1 ou 0 nas 2 posiçoes, onde a posiçao 0 é correspondete ao email e a posiçao 1 ao nick
         */
    }
	
	
	public boolean consultarLogin(Usuario user){
		boolean flag = false;
		Usuario a = new Usuario();
        String findSQL = "select * from usuario where email = '"+ user.getEmail()+"' and confirmacao = 1";
        try {
        	Conexao conexao = new Conexao();
            ResultSet resultados = conexao.buscarRegistros(findSQL);
            while(resultados.next()){
                a.setIdUsuario(Integer.parseInt(resultados.getString("idUsuario")));
                a.setEmail (resultados.getString("email"));
                a.setSenha(resultados.getString("senha"));
                a.setPergunta(resultados.getString("pergunta"));
            }
            conexao.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
       if(a.getEmail().length() != 0 && a.getSenha().equals(user.getSenha())){
    	   flag = true;
       }
       
        return flag;
		/*
		 * metodo que verifica o login, se tiver um email no bdd igual ao do objeto que foi passado e se a senha deste email for igual a do objeto, a flag vira true, permitindo que o usuario se logue
		 */
	}
	
	public Usuario getPergResp(String email) throws SQLException{
		
		Usuario a = new Usuario();
        String findSQL = "select * from usuario where email = '"+ email +"'";
        try {
        	Conexao conexao = new Conexao();
            ResultSet resultados = conexao.buscarRegistros(findSQL);
            while(resultados.next()){
                a.setPergunta(resultados.getString("pergunta"));
                a.setResposta(resultados.getString("resposta"));
            }
            conexao.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        return a;
	}
	
	public ArrayList<String> pegaUserEmail() {
		String findSQL = "select * from usuario";
		ArrayList<String> emails = new ArrayList<String>();
		 try {
	        	Conexao conexao = new Conexao();
	            ResultSet resultados = conexao.buscarRegistros(findSQL);
	            while(resultados.next()) {
	                emails.add(resultados.getString("email"));
	               
	            }
	            conexao.close();
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }
		 return emails;
	}
	
	public ArrayList<String> pegaUserNick() {
		String findSQL = "select * from usuario";
		ArrayList<String> nicks = new ArrayList<String>();
		 try {
	        	Conexao conexao = new Conexao();
	            ResultSet resultados = conexao.buscarRegistros(findSQL);
	            while(resultados.next()) {
	                nicks.add(resultados.getString("nick"));
	               
	            }
	            conexao.close();
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }
		 return nicks;
	}
	
	public Usuario populaUser(String email){
		Usuario a = new Usuario();
        String findSQL = "select * from usuario where email = '"+ email +"' or nick = '" + email + "'";
        try {
        	Conexao conexao = new Conexao();
            ResultSet resultados = conexao.buscarRegistros(findSQL);
            while(resultados.next()){
                a.setIdUsuario(Integer.parseInt(resultados.getString("idUsuario")));
                a.setEmail (resultados.getString("email"));
                a.setNick(resultados.getString("nick"));
                a.setNome(resultados.getString("nome"));
            }
            conexao.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
       
        return a;
		/*
		 * popula um usuario com todas suas informaçoes, usado na minhaconta.jsp 
		 */
	}
	
	public Usuario getUserById(String id){
		Usuario a = new Usuario();
        String findSQL = "select * from usuario where idUsuario = '"+ id +"'";
        try {
        	Conexao conexao = new Conexao();
            ResultSet resultados = conexao.buscarRegistros(findSQL);
            while(resultados.next()){
                a.setIdUsuario(Integer.parseInt(resultados.getString("idUsuario")));
                a.setEmail (resultados.getString("email"));
                a.setNick(resultados.getString("nick"));
                a.setNome(resultados.getString("nome"));
            }
            conexao.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return a;
	}
	
}
