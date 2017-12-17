package model;

import java.util.ArrayList;

import javax.websocket.Session;

public class AllSalas {
	private static AllSalas allSalas = null;
	ArrayList<Sala> salas = new ArrayList<Sala>();
	ArrayList<Websocket_Email> lista = new ArrayList<Websocket_Email>();
	
	
	private AllSalas() {
		
	}
	
	public void addLista(Websocket_Email e) {
		lista.add(e);
	}
	
	public void mudaStatusSala(String nome) {
		for(int i = 0; i < salas.size(); ++i) {
			if(salas.get(i).getNome().equals(nome)) {
				salas.get(i).setStatus("comecou");
			}
		}
	}
	
	public String getEmailById(String id) {
		Websocket_Email e = null;
		for(Websocket_Email aux : lista) {
			if(aux.getId().equals(id)) {
				e = aux;
			}
		}
		
		return e.getEmail();
	}
	
	public Session getSessionByEmail(String email) {
		Websocket_Email e = null;
		for(Websocket_Email aux : lista) {
			if(aux.getEmail().equals(email)) {
				e = aux;
			}
		}
		
		return e.getSession();
	}
	
	public ArrayList<Session> getSessionsBySala(String nome) {
		ArrayList<Session> sessions = new ArrayList<Session>();
		for(Sala s : salas) {
			if(s.getNome().equals(nome)) {
				ArrayList<Jogador> jogadores = s.getJogadores();
				for(Jogador j : jogadores) {
					sessions.add(getSessionByEmail(j.getNick()));
				}
			}
		}
	
		
		return sessions;
	}
	
	public void removeById(String id) {
		for(int i = 0; i < lista.size(); ++i) {
			if(lista.get(i).getId().equals(id)) {
				lista.remove(i);
			}
		}
	}
	
	public void removeJogador(String sala, String email) {
		for(int i = 0; i < salas.size(); ++i) {
			if(salas.get(i).getNome().equals(sala)) {
				salas.get(i).removeJogador(email);;
			}
		}
	}
	
	
	
	public static AllSalas getInstance() {
		if(allSalas == null) {
			allSalas = new AllSalas();
		}
		
		return allSalas;
	}
	
	public void adicionarSala(Sala s) {
		salas.add(s);
	}
	
	public void adicionarJogadorSala(Sala s, Jogador j) {
		for(int i = 0; i < salas.size();++i) {
			if(salas.get(i).getNome().equals(s.getNome())) {
				if(salas.get(i).getStatus() != "comecou") {
					salas.get(i).addJogador(j);
				}
			}
		}
	}
	
	public void darCartasSala(String sala) {
		for(int i = 0; i < salas.size(); ++i) {
			if(salas.get(i).getNome().equals(sala)) {
				salas.get(i).darCartas();	
			}
		}
	}
	
	
	
	public void printaSalas() {
		for(Sala s : salas) {
			System.out.print(s.getNome() + ": ");
			for(Jogador j : s.getJogadores()) {
				System.out.print(j.getNick() + " ");
			}
			System.out.println();
		}
	}
	
	public void removeSala(String nome) {
		for(int i = 0; i < salas.size(); ++i) {
			if(salas.get(i).getNome().equals(nome)) {
				salas.remove(i);
			}
		}
	}
	
	public Sala getSala(String nome) {
		Sala sala = null;
		for(Sala s : salas) {
			if(s.getNome().equals(nome)) {
				sala = s;
			}
		}
		
		return sala;
	}
	
	public ArrayList<Sala> getAllSalas(){
		return salas;
	}
	
}
