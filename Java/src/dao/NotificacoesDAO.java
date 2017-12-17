package dao;



import java.io.IOException;
import java.sql.ResultSet;

import java.sql.SQLException;

import dbcon.Conexao;
import model.Notificacoes;
import model.Usuario;


public class NotificacoesDAO {
	public void mandaConvite(String emailDestinatario, String emailEmissor){
		try {
			Conexao conexao = new Conexao();
			Notificacoes not = new Notificacoes();
			conexao.executarComando("insert into notificacoes (emailEmissor, emailDestinatario, hora, dataa, tipo) values ('"+ emailEmissor +"','" + emailDestinatario + "', '"+ not.getHora() +"', '"+ not.getData() +"','amizade')");
			conexao.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		
	}
	
	public void excluiNotificacoes(String emailEmissor, String emailDestinatario){
		try {
			Conexao conexao = new Conexao();
			conexao.executarComando("delete from notificacoes where emailDestinatario = '" + emailDestinatario + "' and emailEmissor = '" + emailEmissor + "'");
			conexao.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		
		
	}
	
	public boolean verificaExistencia(String emailDestinatario, String emailEmissor){
		boolean tem = false;

        String findSQL = "select * from notificacoes where emailEmissor = '"+ emailEmissor +"' and emailDestinatario = '" + emailDestinatario + "'";
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
	
	public String[] pegaConvite(String email){
		int contador = 0;
		String[] vetor = new String[100];
        String findSQL = "select * from notificacoes where emaildestinatario = '"+ email +"'";
        try {
        	Conexao conexao = new Conexao();
            ResultSet resultados = conexao.buscarRegistros(findSQL);
            while(resultados.next()){
            	String emissor = resultados.getString("emailemissor");
                vetor[contador] = emissor;
                ++contador;
            }
            conexao.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
 
        return vetor;
	}
	
	public int qntdConvites(String email){
		int i = 0;
		String findSQL = "select * from notificacoes where emaildestinatario = '"+ email +"'";
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
	
	
}
