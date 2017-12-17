package model;

import java.util.ArrayList;


import java.util.Random;


public class Baralho {

	private  ArrayList<Carta> baralho = new ArrayList<>();
	
	public Baralho() {
		createBaralho();
	}

	public void createBaralho() {
		String[] valores = { "4", "5", "6", "7", "Q", "J", "K", "A", "2", "3" };
		String[] naipes = { "Paus", "Copas", "Ouros", "Espadas" };
		

		for (int i = 0; i < naipes.length; i++) {
			for (int j = 0; j < valores.length; j++) {
				Carta cartaAuxiliar = new Carta();
				cartaAuxiliar.setNaipe(naipes[i]);
				cartaAuxiliar.setValor(valores[j]);
				cartaAuxiliar.setPt((j + 1));
				baralho.add(cartaAuxiliar);
			}
		}
	}



	
	
	public void mostraCartas(){
		for(int i = 0; i < baralho.size(); ++i){
			System.out.println(baralho.get(i).getNaipe() + " " + baralho.get(i).getValor() + "; ");
		}
	}
	
	public void resetaBaralho() {
		baralho.clear();
		createBaralho();
	}

	public void setBaralho(ArrayList<Carta> baralho){
		this.baralho = baralho;
	}
	public  Carta sortearCarta() {

		Carta cartaSorteada = new Carta();
		Random gerador = new Random();
		int num = gerador.nextInt(baralho.size());
		cartaSorteada = baralho.get(num);
		
		baralho.remove(num);
		

		return cartaSorteada;
	}
	

	
	public ArrayList<Carta> getBaralho(){
		return this.baralho;
	}
}
