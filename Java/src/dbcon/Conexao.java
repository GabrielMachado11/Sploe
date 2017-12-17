package dbcon;

import java.io.EOFException;
import java.sql.*;

import javax.swing.JOptionPane;

public class Conexao {
	
	String user;
	String senha;
	Connection con;
	
	
	public Conexao() throws SQLException{
		//this.user = "postgres";
		//this.senha = "oitdbem123";
	
		
		
		this.user = "kblmzzunggrywp";
		this.senha = "ae7622e81ecbf20c6b8db022fcf9b352d7811ca557fd0d9b4ad0f6ceee75a859";
		//this.con = this.getConnection();
		/*
		 * metodo construtor da classe, quando ela for instanciada ela pedira o username e senha do usuario que contem a permissao no banco
		 */
		
	}
	
	public void close(){
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());
		}
	}
	
	public Connection getConnection() throws SQLException{
		String driver = "org.postgresql.Driver";
		//String url = "jdbc:postgresql://localhost:5432/Sploe";
		String url = "jdbc:postgresql://ec2-184-73-247-240.compute-1.amazonaws.com:5432/d7ddmuqs9qo4p1?sslmode=require&user=kblmzzunggrywp&password=ae7622e81ecbf20c6b8db022fcf9b352d7811ca557fd0d9b4ad0f6ceee75a859";
		
		try {
			Class.forName(driver);
			con = (Connection) DriverManager.getConnection(url, user, senha);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return this.con;
		/*
		 * retorna uma conexao com o bdd que possua este driver e que  esta "hospedado" na url
		 */
	}
	
	public boolean executarComando(String comando) throws SQLException{
		Statement sql = null;
		boolean teste = false;
		try {
			getConnection();
			sql = con.createStatement();
			sql.execute(comando);
			teste = true;
			close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return teste;
		/*
		 * executa a string recebida no bdd, exatamente igual
		 */
	}
	
	public ResultSet buscarRegistros(String queryComando) throws SQLException{
		Statement sql = null;
		ResultSet registros = null;
		try {
			getConnection();
			sql = con.createStatement ();
			registros = sql.executeQuery (queryComando);
			close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		

		return registros;
		/*
		 * executa uma busca da string recebida no bdd
		 */
	}
	

}