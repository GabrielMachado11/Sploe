package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import dao.TokenDAO;
import dao.UsuarioDAO;
import model.Token;
import model.Usuario;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.Properties;

@WebServlet(name="Gera Token Servlet", urlPatterns="/token")
public class GeraToken extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UsuarioDAO usuarioDAO = new UsuarioDAO();
		Usuario user = usuarioDAO.populaUser(request.getParameter("email"));
		
		String email = request.getParameter("email");
		
		if(email.equals("")){
			response.sendRedirect("email-encontradoError.jsp");
		}
		
//		MessageDigest m = null;
//		try {
//			m = MessageDigest.getInstance("MD5");
//		} catch (NoSuchAlgorithmException e1) {
//			e1.printStackTrace();
//		}
//		
//		String emailCriptografado = user.getEmail() + "|sploe";
//	    m.update(emailCriptografado.getBytes(),0,emailCriptografado.length());
//	    String token = new BigInteger(1,m.digest()).toString(16);
//	    
//	    String dataGeracao = String.valueOf(new Date().getTime());
//	    token = token + "_" + user.getIdUsuario() + "_" + dataGeracao;
//		
		Token token = new Token();
		boolean criouToken = token.criarToken(String.valueOf(user.getIdUsuario()), "senha");
		
		if(criouToken) {
			Properties props = new Properties();
		    // Parâmetros de conexão com servidor Gmail 
		    props.put("mail.smtp.host", "smtp.gmail.com");
		    props.put("mail.smtp.socketFactory.port", "465");
		    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		    props.put("mail.smtp.auth", "true");
		    props.put("mail.smtp.port", "465");

	        Session session2 = Session.getDefaultInstance(props,
	        		new javax.mail.Authenticator() {
	        			protected PasswordAuthentication getPasswordAuthentication() 
	        			{
	                        return new PasswordAuthentication("projetosploe@gmail.com", "pds2017info");
	        			}
	             	});
	         // Ativa Debug para sessão 
	         session2.setDebug(true);
	         try {
	               Message message = new MimeMessage(session2);
	               message.setFrom(new InternetAddress("projetosploe@gmail.com")); //Remetente

	               Address[] toUser = InternetAddress //Destinatário(s)
	                          .parse(email);  
	               message.setRecipients(Message.RecipientType.TO, toUser);
	               message.setSubject("Alteração de senha");//Assunto
	               message.setText("Olá! Para alterar sua senha, acesse o link: sploegame.azurewebsites.net/novaSenha.jsp?t=" + token.getToken());
	               //Método para enviar a mensagem criada
	               Transport.send(message);
	          } catch (MessagingException e) {
	               throw new RuntimeException(e);
	         }
	         
	         response.sendRedirect("enviandoEmailConfirmacao.jsp");
		}else {
			response.sendRedirect("aguardeAcao.html");
		}
		
		
	}
}