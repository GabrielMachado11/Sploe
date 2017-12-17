package model;

public class Carta {

	private String valor = new String();
	private String naipe = new String();
	private String quem = new String();
	private int pt;
	
	public int getPt() {
		return pt;
	}
	public void setPt(int pt) {
		this.pt = pt;
	}
	public String getValor() {
		return valor;
	}
	public void setValor(String valor) {
		this.valor = valor;
	}
	public String getNaipe() {
		return naipe;
	}
	public void setNaipe(String naipe) {
		this.naipe = naipe;
	}
	public String getQuem() {
		return quem;
	}
	public void setQuem(String quem) {
		this.quem = quem;
	}
	
}
