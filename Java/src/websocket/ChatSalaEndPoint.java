package websocket;

import java.io.IOException;


import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;






@ServerEndpoint(value = "/chat/{room}")
public class ChatSalaEndPoint {
	private HashMap<Session, String> clientsMap = new HashMap<Session, String>();
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	@OnOpen
	public void onOpen(@PathParam("room") String room, Session session) throws SQLException, IOException {
		clientsMap.put(session, room);
		clients.add(session);
	}

	
	
	@OnMessage
	public void onMessage(@PathParam("room") String room, String text, Session currentSession) throws IOException {
		for(Session client : clients) {
			String sala = clientsMap.get(currentSession);
			if(sala.equals(room)) {
				client.getBasicRemote().sendText(text);
			}
		}
	}
	
	

	@OnClose
	
	public void onClose(@PathParam("room") String room, Session session) {
		clients.remove(session);
	}
}
