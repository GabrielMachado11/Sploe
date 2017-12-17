package model;

import java.util.ArrayList;

public class Sala {
	
	

	private Baralho baralho = new Baralho();
	private Carta manilha = new Carta();
	private ArrayList<Jogador> jogadores = new ArrayList<Jogador>();
	private ArrayList<CartaJogada> mesa = new ArrayList<CartaJogada>();
	private String nome;
	private int maxJogadores;
	private int rodada = 1;
	private String status = "aguardando";
	private String comeca; //primeira que comeca jogando a mao
	private String vez; //vez na rodada
	private String pe;
	
	
	public String getPe() {
		return pe;
	}
	
	public void setPe() {
		int v = 0;
		for(int i = 0; i < jogadores.size(); ++i) {
			if(jogadores.get(i).getNick().equals(comeca)) {
				v = i;
			}
		}
		
		if(v > 0) {
			pe = jogadores.get((v-1)).getNick();
		}else {
			pe = jogadores.get((jogadores.size() - 1)).getNick();
		}
	}

	
	public void resetaMesa() {
		mesa = new ArrayList<CartaJogada>();
	}
	
	public ArrayList<CartaJogada> getMesa(){
		return this.mesa;
	}
	
	public String getComeca() {
		return comeca;
	}


	public void setPrimeiroComeca() {
		comeca = jogadores.get(0).getNick();
		pe = jogadores.get((jogadores.size() - 1)).getNick();
		//System.out.println(pe);
	}
	
	public void setComeca() {
		int v = 0;
		for(int i = 0; i < jogadores.size(); ++i) {
			if(jogadores.get(i).getNick().equals(comeca)) {
				v = i;
			}
		}
		
		try {
			comeca = jogadores.get(v+1).getNick();
		}catch(Exception e) {
			comeca = jogadores.get(0).getNick();
		}
		
		setPe();
		//System.out.println(getPe());
	}
	
	public void setPrimeiraVez() {
		vez = comeca;
	}
	
	public void setVez() {
		int v = 0;
		for(int i = 0; i < jogadores.size(); ++i) {
			if(jogadores.get(i).getNick().equals(vez)) {
				v = i;
			}
		}
		try {
			vez = jogadores.get(v+1).getNick();
		}catch(Exception e) {
			vez = jogadores.get(0).getNick();
		}
	}
	
	public String getVez() {
		return vez;
	}

	
	public void setFezJogador(String email) {
		for(int i = 0; i < jogadores.size(); ++i) {
			if(jogadores.get(i).getNick().equals(email)) {
				jogadores.get(i).somaFazendo();
			}
		}
	}
	
	public void setApostaJogador(String email, int aposta) {
		for(int i = 0; i < jogadores.size(); ++i) {
			if(jogadores.get(i).getNick().equals(email)) {
				jogadores.get(i).setAposta(aposta);
			}
		}
	}
	
	
	
	
	public int getRodada() {
		return rodada;
	}
	
	public void somaRodada() {
		rodada = rodada + 1;
	}
	
	public Carta getManilha() {
		return manilha;
	}

	public void setManilha() {
		this.manilha = baralho.sortearCarta();
	}
	
	public Carta sortearCarta() {
		return baralho.sortearCarta();
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Sala(String nome, int maxJogadores) {
		this.nome = nome;
		this.maxJogadores = maxJogadores;
		manilha = baralho.sortearCarta();
	}
	
	public String getNome() {
		return nome;
	}
	
	public ArrayList<Jogador> getJogadores(){
		return jogadores;
	}
	
	public void darCartas() {
		for(int i = 0; i <= rodada; ++i) {
			for(int j = 0; j < jogadores.size(); ++j) {
				Carta c = baralho.sortearCarta();
				jogadores.get(j).addCartaMao(c);
			}
		}
	}
	
	public void resetaBaralho() {
		baralho.resetaBaralho();
	}
	
	public void jogaCarta(String nick, Carta c) {
		CartaJogada cj = new CartaJogada();
		
		cj.setEmail(nick);
		
		for(int i = 0; i < jogadores.size(); ++i) {
			if(jogadores.get(i).getNick().equals(nick)) {
				c.setPt(jogadores.get(i).removeCartaMao(c));
				cj.setCarta(c);
			}
		}
		
		
		
		mesa.add(cj);
	}
	
	
	
	public void addJogador(Jogador j) {
		jogadores.add(j);
	}
	
	public void removeJogador(String email) {
		
		for(int i = 0; i < jogadores.size(); ++i) {
			if(jogadores.get(i).getNick().equals(email)) {
				jogadores.remove(i);
			}
		}
	}
	
	public int getMaxJogadores() {
		return maxJogadores;
	}
	public void setMaxJogadores(int maxjogadores) {
		this.maxJogadores = maxjogadores;
	}
	
}
