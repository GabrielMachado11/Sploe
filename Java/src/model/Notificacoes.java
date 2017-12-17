package model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Notificacoes {
	private String emailEmissor;
	private String emailDestinatario;
	private String hora;
	private String data;
	private String tipo;
	
	
	public String getEmailEmissor() {
		return emailEmissor;
	}
	
	
	public void setEmailEmissor(String emailEmissor) {
		this.emailEmissor = emailEmissor;
	}
	

	public String getEmailDestinatario() {
		return emailDestinatario;
	}
	public void setEmailDestinatario(String emailDestinatario) {
		this.emailDestinatario = emailDestinatario;
	}
	public String getHora() {
		hora = "h:mm";
		String hora1;
		
		Date agora = new Date();;
		SimpleDateFormat formata = new SimpleDateFormat(hora);
		hora1 = formata.format(agora);
		
		return hora1;
	}
	public void setHora(String hora) {
		this.hora = hora;
	}
	
	
	public String getData() {
		data = "dd/MM/yyyy";
		String data1;
		
		Date agora = new Date();;
		
		SimpleDateFormat formata = new SimpleDateFormat(data);
		data1 = formata.format(agora);
	
		return data1;
	}
	
	
	public void setData(String data) {
		this.data = data;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
}
