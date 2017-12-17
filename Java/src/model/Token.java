package model;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Date;
import java.util.Random;
import dao.TokenDAO;

public class Token {
	private String id;
	private String idusuario;
	private String token;
	private String tipo;
	private Long dataGeracao;
	
	public boolean criarToken(String idusuario, String tipo) {
		TokenDAO dao = new TokenDAO();
		this.idusuario = idusuario;
		this.dataGeracao = new Date().getTime();
		this.tipo = tipo;
		
		if(!dao.verificaCadastroToken(idusuario, dataGeracao, tipo)) {
			return false;
		}
		
		Random random = new Random();
		this.token = random.nextInt(100) + "sploe" +  random.nextInt(100);
		
		MessageDigest m = null;
		try {
			m = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e1) {
			e1.printStackTrace();
		}
		
	    m.update(token.getBytes(),0,token.length());
	    this.token = this.idusuario + "_" + new BigInteger(1,m.digest()).toString(16);
	    
	    try {
			dao.insereToken(this);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	    
		return true;
	}
	
	public String getToken() {
		return this.token;
	}
	public String getData() {
		return String.valueOf(this.dataGeracao);
	}
	public String getIdUsuario() {
		return this.idusuario;
	}
	public String getId() {
		return this.id;
	}
	public String getTipo() {
		return this.tipo;
	}
	

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public void setData(Long data) {
		this.dataGeracao = data;
	}
	public void setIdUsuario(String id) {
		this.idusuario = id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
}
