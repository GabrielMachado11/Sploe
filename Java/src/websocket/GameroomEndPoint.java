package websocket;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import dao.UsuarioDAO;
import model.AllSalas;
import model.Carta;
import model.CartaJogada;
import model.Jogador;
import model.Sala;
import model.Websocket_Email;

/*
 * Classe responsavel pelo ser o endpoint das salas dos jogos, por eqnaunto a unica coisa funcional Ã© falar quem esta na sala, no caso quem entrou e colocar no bdd
 */

@ServerEndpoint(value = "/room/{room}") // <------ setinha, leia tudo e voce
										// entendera
public class GameroomEndPoint {
	AllSalas salas = AllSalas.getInstance();

	@OnOpen
	public void onOpen(@PathParam("room") String room, Session session) throws SQLException, IOException {

	}

	@OnMessage
	public void onMessage(@PathParam("room") String room, String text, Session session) throws IOException {
		// System.out.println(text);
		if (text.contains("%entrou")) {
			String[] aux = text.split(" ");
			Websocket_Email e = new Websocket_Email();
			e.setId(session.getId());
			e.setEmail(aux[1]);
			e.setSession(session);
			salas.addLista(e);

			Carta manilha = null;

			// ve se a sala ficou cheia, se sim da distribiu as cartas para
			// todos
			for (Sala s : salas.getAllSalas()) {
				if (s.getNome().equals(room) && s.getStatus() == "comecou") {
					manilha = s.getManilha();
					salas.darCartasSala(room);
				}
			}

			// manda informaçoes
			for (Session s : salas.getSessionsBySala(room)) {
				s.getBasicRemote().sendText(e.getEmail() + " entrou");
				// se e se apenas se a sala ficar cheia o jogo começa e as
				// informaçoes abaixo sao enviadas
				if (manilha != null) {
					s.getBasicRemote().sendText("O jogo vai começar!");
					s.getBasicRemote().sendText("Turno de apostas!");
					s.getBasicRemote().sendText("manilha " + manilha.getNaipe() + " " + manilha.getValor());
				}
			}

			// manda as cartas para o usuario
			if (manilha != null) {
				mandaCartas(room);

				for (int i = 0; i < salas.getAllSalas().size(); ++i) {
					if (salas.getAllSalas().get(i).getNome().equals(room)) {
						salas.getAllSalas().get(i).setPrimeiroComeca();
						salas.getAllSalas().get(i).setPrimeiraVez();
						for (Session s : salas.getSessionsBySala(room)) {
							s.getBasicRemote().sendText("pe " + salas.getAllSalas().get(i).getPe());
							s.getBasicRemote().sendText("%vez " + salas.getAllSalas().get(i).getVez());
						}
					}
				}

			}

			for (int i = 0; i < salas.getAllSalas().size(); ++i) {
				if (salas.getAllSalas().get(i).getNome().equals(room)) {
					for (int j = 0; j < salas.getAllSalas().get(i).getJogadores().size(); j++) {
						salas.getAllSalas().get(i).getJogadores().get(j).setAteTurno(j);
					}
					for (Session s : salas.getSessionsBySala(room)) {

						for (int j = 0; j < salas.getAllSalas().get(i).getJogadores().size(); j++) {
							s.getBasicRemote()
									.sendText("%Turnoteste "
											+ salas.getAllSalas().get(i).getJogadores().get(j).getNick() + " "
											+ salas.getAllSalas().get(i).getJogadores().get(j).getAteTurno());
						}

					}
				}
			}

		} else {

			String email = salas.getEmailById(session.getId());

			Websocket_Email e = new Websocket_Email();
			e.setEmail(email);
			e.setId(session.getId());
			e.setSession(session);

			if (text.contains("%aposta ")) {

				String aposta[] = text.split(" ");
				int a = Integer.parseInt(aposta[1]);

				boolean flag = false;

				for (int i = 0; i < salas.getAllSalas().size(); ++i) {
					if (salas.getAllSalas().get(i).getNome().equals(room)) {

						for (int j = 0; j < salas.getAllSalas().get(i).getJogadores().size(); ++j) {
							if (salas.getAllSalas().get(i).getJogadores().get(j).getNick().equals(email)) {
								salas.getAllSalas().get(i).getJogadores().get(j).setAposta(a);
							}

							if (salas.getAllSalas().get(i).getJogadores().get(j).getAposta() == null) {
								flag = true;
							}
						}

						salas.getAllSalas().get(i).setVez();
					}
				}

				for (Session s : salas.getSessionsBySala(room)) {
					s.getBasicRemote().sendText(email + " apostou " + a);
					for (Sala sala : salas.getAllSalas()) {
						if (flag == false) {
							if (sala.getNome().equals(room)) {
								s.getBasicRemote().sendText("Turno de jogadas!");
							}
						}
						if (sala.getNome().equals(room)) {
							s.getBasicRemote().sendText("%vez " + sala.getVez());
						}
					}
				}

			} else if (text.contains("%jogada ")) {

				String jogada[] = text.split(" ");
				String vez = "";
				System.out.println(jogada);
				Carta carta = new Carta();
				carta.setNaipe(jogada[1]);
				carta.setValor(jogada[2]);
				carta.setQuem(jogada[3]);

				CartaJogada forte = null;
				boolean maoFim = false;

				for (int i = 0; i < salas.getAllSalas().size(); ++i) {
					if (salas.getAllSalas().get(i).getNome().equals(room)) {
						salas.getAllSalas().get(i).jogaCarta(email, carta);
						salas.getAllSalas().get(i).setVez();
						vez = salas.getAllSalas().get(i).getVez();

						if (salas.getAllSalas().get(i).getJogadores().size() == salas.getAllSalas().get(i).getMesa()
								.size()) {
							ArrayList<CartaJogada> cjs = salas.getAllSalas().get(i).getMesa();
							forte = cjs.get(0);
							Carta manilha = salas.getAllSalas().get(i).getManilha();
							if (cjs.get(0).getCarta().getPt() - 1 == manilha.getPt()) {
								cjs.get(0).getCarta().setPt(100);
							}

							for (int j = 1; j < cjs.size(); ++j) {
								if (cjs.get(i).getCarta().getPt() - 1 == manilha.getPt()) {
									cjs.get(i).getCarta().setPt(100);
								}

								if (cjs.get(j).getCarta().getPt() > forte.getCarta().getPt()) {
									forte = cjs.get(j);
								}
							}
							salas.getAllSalas().get(i).resetaMesa();
							salas.getAllSalas().get(i).setFezJogador(forte.getEmail());

							if (salas.getAllSalas().get(i).getJogadores().get(0).getMao().size() == 0) {
								maoFim = true;
							}
						}
					}
				}

				//

				for (Session s : salas.getSessionsBySala(room)) {
					s.getBasicRemote().sendText(email + " jogou " + carta.getNaipe() + " " + carta.getValor());
					if (forte != null) {
						for (int i = 0; i < salas.getAllSalas().size(); ++i) {
							if (salas.getAllSalas().get(i).getNome().equals(room)) {
								for (int j = 0; j < salas.getAllSalas().get(i).getJogadores().size(); ++j) {
									if (salas.getAllSalas().get(i).getJogadores().get(j).getNick()
											.equals(forte.getEmail())) {
										int fez = salas.getAllSalas().get(i).getJogadores().get(j).getRodFeitas();
										salas.getAllSalas().get(i).getJogadores().get(j).setRodFeitas(fez + 1);
									}
								}
							}
						}
						s.getBasicRemote().sendText(forte.getEmail() + " fez");
					}
					if (maoFim == false) {
						s.getBasicRemote().sendText("%vez " + vez);
					}

				}

				if (maoFim == true) {
					for (int i = 0; i < salas.getAllSalas().size(); ++i) {
						for (Session s : salas.getSessionsBySala(room)) {
							s.getBasicRemote().sendText("limpa vidas");
						}
						if (salas.getAllSalas().get(i).getNome().equals(room)) {
							for (int j = 0; j < salas.getAllSalas().get(i).getJogadores().size(); ++j) {
								if (salas.getAllSalas().get(i).getJogadores().get(j).perderVida() == true) {
									for (Session s : salas.getSessionsBySala(room)) {
										s.getBasicRemote()
												.sendText(salas.getAllSalas().get(i).getJogadores().get(j).getNick()
														+ " perdeu uma vida.");

										if (salas.getAllSalas().get(i).getJogadores().get(j).getVida() == 0) {
											salas.removeJogador(room,
													salas.getAllSalas().get(i).getJogadores().get(j).getNick());
											s.getBasicRemote()
													.sendText(salas.getAllSalas().get(i).getJogadores().get(j).getNick()
															+ " esta fora.");
										}

									}
								}

								for (Session s : salas.getSessionsBySala(room)) {
									s.getBasicRemote()
											.sendText(salas.getAllSalas().get(i).getJogadores().get(j).getNick() + " - "
													+ salas.getAllSalas().get(i).getJogadores().get(j).getVida() + "-"
													+ salas.getAllSalas().get(i).getJogadores().get(j).getAposta() + "-"
													+ salas.getAllSalas().get(i).getJogadores().get(j).getRodFeitas()
													+ "-" + salas.getAllSalas().get(i).getJogadores().size());

								}

								salas.getAllSalas().get(i).getJogadores().get(j).setAposta(null);
							}

							if (salas.getAllSalas().get(i).getJogadores().size() > 1) {

								salas.getAllSalas().get(i).somaRodada();

								salas.getAllSalas().get(i).setComeca();
								salas.getAllSalas().get(i).setPrimeiraVez();

								salas.getAllSalas().get(i).resetaBaralho();
								salas.getAllSalas().get(i).setManilha();
								salas.getAllSalas().get(i).darCartas();

								vez = salas.getAllSalas().get(i).getVez();

								Carta m = salas.getAllSalas().get(i).getManilha();

								for (Session s : salas.getSessionsBySala(room)) {
									s.getBasicRemote().sendText("Turno de apostas!");
									s.getBasicRemote().sendText("pe " + salas.getAllSalas().get(i).getPe());
									s.getBasicRemote().sendText("manilha " + m.getNaipe() + " " + m.getValor());
									s.getBasicRemote().sendText("%vez " + vez);
								}
                               
							  //------------------------------------------
								int indicepe = 0;
								
								for (int j = 0; j < salas.getAllSalas().get(i).getJogadores().size(); j++) {
									if(salas.getAllSalas().get(i).getJogadores().get(j).getNick().equals(salas.getAllSalas().get(i).getPe())){
										indicepe = j;
									}
								}
								
								
								for (int j = 0; j < salas.getAllSalas().get(i).getJogadores().size(); j++) {
									if(j < indicepe){
										salas.getAllSalas().get(i).getJogadores().get(j).setAteTurno(j);
									}else if(j == indicepe){
										int listjogsize = salas.getAllSalas().get(i).getJogadores().size();
										salas.getAllSalas().get(i).getJogadores().get(j).setAteTurno(listjogsize-1);
									}else{
										salas.getAllSalas().get(i).getJogadores().get(j).setAteTurno(j-1);
									}
								}
								for (Session s : salas.getSessionsBySala(room)) {

									for (int j = 0; j < salas.getAllSalas().get(i).getJogadores().size(); j++) {
										s.getBasicRemote().sendText("%Turnoteste "
												+ salas.getAllSalas().get(i).getJogadores().get(j).getNick() + " "
												+ salas.getAllSalas().get(i).getJogadores().get(j).getAteTurno());
									}

								}
                               //----------------------------------------
								mandaCartas(room);
								for (int j = 0; j < salas.getAllSalas().get(i).getJogadores().size(); ++j) {
									salas.getAllSalas().get(i).getJogadores().get(j).setRodFeitas(0);
								}

							}
						}
					}
				}
			}
		}

	}

	@OnClose
	public void onClose(@PathParam("room") String room, Session session) throws IOException {

		String email = salas.getEmailById(session.getId());
		salas.removeJogador(room, email);
		salas.removeById(session.getId());

		if (salas.getSala(room).getJogadores().size() == 0) {
			salas.removeSala(room);
		}

		for (Session s : salas.getSessionsBySala(room)) {
			s.getBasicRemote().sendText(email + " saiu");
		}

		for (int i = 0; i < salas.getAllSalas().size(); ++i) {
			if (salas.getAllSalas().get(i).getNome().equals(room)) {
				if (salas.getAllSalas().get(i).getJogadores().size() == 1
						&& salas.getAllSalas().get(i).getStatus().equals("comecou")) {

					for (Session s : salas.getSessionsBySala(room)) {
						UsuarioDAO userDAO = new UsuarioDAO();
						userDAO.somaVitoria(salas.getAllSalas().get(i).getJogadores().get(0).getNick());
						s.getBasicRemote()
								.sendText(salas.getAllSalas().get(i).getJogadores().get(0).getNick() + " ganhou");
						// System.out.println(salas.getAllSalas().get(i).getJogadores().get(0).getNick()
						// + " ganhou");
					}

				}

			}
		}

	}

	public void mandaCartas(String room) throws IOException {
		for (int i = 0; i < salas.getAllSalas().size(); ++i) {
			if (salas.getAllSalas().get(i).getNome().equals(room)) {
				for (Jogador j : salas.getAllSalas().get(i).getJogadores()) {
					ArrayList<Carta> mao = j.getMao();
					Session s = salas.getSessionByEmail(j.getNick());
					for (Carta c : mao) {
						s.getBasicRemote().sendText("recebeu a carta " + c.getNaipe() + " " + c.getValor());
					}
				}
			}
		}
	}

}