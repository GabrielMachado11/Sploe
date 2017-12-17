package model;

import java.util.ArrayList;

public class Jogador {
	private String nick;
	private int vidas = 3;
	private Integer aposta = null;
	private int RodFeitas = 0;
	private int ateTurno =0;
	private int fazendo = 0;
	private ArrayList<Carta> mao = new ArrayList<Carta>();
	
	public int getFazendo() {
		return fazendo;
	}
	
	public Jogador(String nick) {
		this.nick = nick;
	}
	
	public String getNick() {
		return nick;
	}
	
	public void addCartaMao(Carta c) {
		mao.add(c);
	}
	
	public Integer removeCartaMao(Carta c) {
		Integer pt = null;
		
		for(int i = 0; i < mao.size(); ++i) {
			if(mao.get(i).getNaipe().equals(c.getNaipe()) && mao.get(i).getValor().equals(c.getValor())) {
				pt = mao.get(i).getPt();
				mao.remove(i);
				
			}
		}
		
		return pt;
		
	}
	
	public void resetaMao() {
		mao.clear();
	}
	
	public void setAposta(Integer a) {
		aposta = a;
	}
	
	public Integer getAposta() {
		return aposta;
	}
	
	public void tiraVida() {
		--vidas;
	}
	
	public int getVida() {
		return vidas;
	}
	
	public void somaFazendo() {
		++fazendo;
	}
	
	public void resetaFazendo() {
		fazendo = 0;
	}
	
	public boolean perderVida() {
		if(fazendo != aposta) {
			tiraVida();
			return true;
		}else {
			return false;
		}
	}

	public ArrayList<Carta> getMao() {
		return mao;
	}

	public int getRodFeitas() {
		return RodFeitas;
	}

	public void setRodFeitas(int rodFeitas) {
		RodFeitas = rodFeitas;
	}

	public int getAteTurno() {
		return ateTurno;
	}

	public void setAteTurno(int ateTurno) {
		this.ateTurno = ateTurno;
	}
}
