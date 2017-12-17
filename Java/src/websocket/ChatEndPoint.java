package websocket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

/*
 * classe que eh responsavel peelas mensagens
 */
@ServerEndpoint("/websocket")
public class ChatEndPoint {
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	//lista de sessoes dos usuarios
	
	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		synchronized (clients) {
			for (Session client : clients) {
				client.getBasicRemote().sendText(message);
				//envia as mensagens para todo mundo, o que vai definir quem vai receber a mensagem está na jsp, vê lá
			}
		}

	}

	//metodos inuteis, precisa de @OnOpen e @OnClose, mas na realidade nao ta fazendo nada
	@OnOpen
	public void onOpen(Session session) {
		clients.add(session);
	}

	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
	}

}