package servlets;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AmigoDAO;
import dao.NotificacoesDAO;
import dao.TokenDAO;
import dao.UsuarioDAO;
import model.Amigos;
import model.Usuario;

@WebServlet(name="ConfirmaCadastro", urlPatterns="/confirma")
public class ConfirmaCadastro extends HttpServlet{
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String token = req.getParameter("t");

		UsuarioDAO usuarioDAO = new UsuarioDAO();
		TokenDAO tokenDao = new TokenDAO();
		String idusuario = tokenDao.verificaToken(token, "cadastro");
		
		if(!idusuario.equals("")) {
	    	try {
	    		usuarioDAO.confirmaCadastro("1", idusuario);
	    		tokenDao.expirarTokenByHash(token);
				resp.sendRedirect("sucesso.html");
			} catch (SQLException e) {
				resp.sendRedirect("trocaSenhaError.jsp");
			}
	    }else {
	    	resp.sendRedirect("trocaSenhaError.jsp");
	    }
		
		
//		String comparacao = usuario.getEmail() + "|sploe";
//		
//		MessageDigest m = null;
//		try {
//			m = MessageDigest.getInstance("MD5");
//		} catch (NoSuchAlgorithmException e1) {
//			e1.printStackTrace();
//		}
//		
//	    m.update(comparacao.getBytes(),0,comparacao.length());
//	    String comparacaoMD5 = new BigInteger(1,m.digest()).toString(16);
//	    
//	    Date dataToken = new Date(Long.parseLong(tempo) + 360000);
//	    Date atual = new Date();
//	    
//	    boolean tokenExpirado = atual.before(dataToken);
//	    
//	    if(comparacaoMD5.equals(email) && !tokenExpirado) {
//	    	try {
//				usuarioDAO.confirmaCadastro("1", id);
//				resp.sendRedirect("sucesso.html");
//			} catch (Exception e) {
//				resp.sendRedirect("trocaSenhaError.jsp");
//			}
//	    }else {
//	    	resp.sendRedirect("trocaSenhaError.jsp");
//	    }
		
	}
}
