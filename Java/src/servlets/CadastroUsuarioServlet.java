package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.Properties;
import java.security.*;
import java.math.*;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UsuarioDAO;
import dbcon.Conexao;
import model.Token;
import model.Usuario;

@WebServlet(name="Cadastro Servlet Usuario", urlPatterns="/cadastro")

public class CadastroUsuarioServlet extends HttpServlet{
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Usuario user = new Usuario();
		
		user.setNome(req.getParameter("nome"));
		user.setNick(req.getParameter("nick"));
		user.setEmail(req.getParameter("email"));
		user.setDataNascimento(req.getParameter("data"));
		user.setSenha(md5(req.getParameter("senha")));
		user.setGenero(req.getParameter("genderr"));
		user.setPergunta(req.getParameter("pergunta"));
		user.setResposta(req.getParameter("resp"));
		user.setConfirmSenha(md5(req.getParameter("confirma")));
		//pupula um objeto usuario pegando as informaçoes digitadas nos campos que contem os nomes fornecidos do html
		
		UsuarioDAO usuarioDAO = new UsuarioDAO();
		
		int verifica[] = usuarioDAO.confirmarExistenciaUsuarioCadastrado(user);
		//essa matriz é responsavel por verificar qual erro está persistindo, se é de nick ou de email, no caso
		
		String redirecionamento = null;
	
		
		if(verifica[0] == 0 && verifica[1] == 0 && user.getSenha().equals(user.getConfirmSenha())){
			if (isValidName(user.getEmail())==true){
				try {
					usuarioDAO.inserirUsuario(user);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				redirecionamento = "cadastroSucesso.html";
				
				String redirecionamentoToken = enviaToken(user.getEmail());
				if(!redirecionamentoToken.equals("")) {
					redirecionamento = redirecionamentoToken;
				}
			}
			else {
				
				redirecionamento = "cadastro.jsp";
			}
		}else{
			if(verifica[0] == 1){
				redirecionamento = "email-cadastroERROR.jsp";
			}else if(verifica[1] == 1){
				redirecionamento = "nick-cadastradoERROR.jsp";
			}else{
				redirecionamento = "cadastro.jsp";
			}
		}
		
		//testes para saber qual erro esta acontecendo
		RequestDispatcher r = req.getRequestDispatcher( redirecionamento );
		r.forward( req, resp );
		//apos efetuar o cadastro, o usuario sera levado ate a pagina correspondente da string redirecionamento
	}
	private static boolean isValidName(String name){
		return name.matches("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
				+ "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
	}
	private static String md5(String senha){
		String sen = "";
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		BigInteger hash = new BigInteger(1, md.digest(senha.getBytes()));
		sen = hash.toString(16);			
		return sen;
	}
	
	private String enviaToken(String email) {
		UsuarioDAO usuarioDAO = new UsuarioDAO();
		Usuario user = usuarioDAO.populaUser(email);
		Token token = new Token();
		boolean criouToken = token.criarToken(String.valueOf(user.getIdUsuario()), "cadastro");
		
		if(!criouToken) {
			return "aguardeAcao.html";
		}else {
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
	               message.setSubject("Confirmação de cadastro");//Assunto
	               message.setText("Olá! Para confirmar seu cadastro, acesse o link: sploegame.azurewebsites.net/confirma?t=" + token.getToken());
	               //Método para enviar a mensagem criada
	               Transport.send(message);
	          } catch (MessagingException e) {
	               throw new RuntimeException(e);
	         }
		}
		return "";
		
	}
}
