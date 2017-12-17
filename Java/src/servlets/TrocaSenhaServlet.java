package servlets;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.TokenDAO;
import dao.UsuarioDAO;
import model.Usuario;
import model.Token;

@WebServlet(name="Troca Senha Servlet", urlPatterns="/troca")
public class TrocaSenhaServlet extends HttpServlet{
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String senha = req.getParameter("NSenha");
		String csenha = req.getParameter("CSenha");
		String token = req.getParameter("token");

		UsuarioDAO usuarioDAO = new UsuarioDAO();
		
		if(!senha.equals(csenha)){
			resp.sendRedirect("trocaSenhaError.jsp");
		}else{
			
			TokenDAO tokenDao = new TokenDAO();
			String idusuario = tokenDao.verificaToken(token, "senha");
			
			if(!idusuario.equals("")) {
				Usuario user = usuarioDAO.getUserById(idusuario);
		    	try {
		    		MessageDigest md = null;
		    		try {
		    			md = MessageDigest.getInstance("MD5");
		    		} catch (NoSuchAlgorithmException e) {
		    			e.printStackTrace();
		    		}
		    		BigInteger hash = new BigInteger(1, md.digest(senha.getBytes()));
		    		String novaSenha = hash.toString(16);
		    		
					usuarioDAO.atualizarSenha(novaSenha, user.getEmail());
					tokenDao.expirarTokenByHash(token);
					resp.sendRedirect("sucesso.html");
				} catch (SQLException e) {
					resp.sendRedirect("trocaSenhaError.jsp");
				}
		    }else {
		    	resp.sendRedirect("trocaSenhaError.jsp");
		    }
			
			
//			String email = token.split("_")[0];
//			String id = token.split("_")[1];
//			String tempo = token.split("_")[2];
//			Usuario usuario = usuarioDAO.getUserById(id);
//			
//			String comparacao = usuario.getEmail() + "|sploe";
//			
//			MessageDigest m = null;
//			try {
//				m = MessageDigest.getInstance("MD5");
//			} catch (NoSuchAlgorithmException e1) {
//				e1.printStackTrace();
//			}
//			
//		    m.update(comparacao.getBytes(),0,comparacao.length());
//		    String comparacaoMD5 = new BigInteger(1,m.digest()).toString(16);
//		    
//		    Date dataToken = new Date(Long.parseLong(tempo) + 360000);
//		    Date atual = new Date();
//		    
//		    boolean tokenExpirado = atual.before(dataToken);
//		    
//		    if(comparacaoMD5.equals(email) && !tokenExpirado) {
//		    	try {
//		    		MessageDigest md = null;
//		    		try {
//		    			md = MessageDigest.getInstance("MD5");
//		    		} catch (NoSuchAlgorithmException e) {
//		    			e.printStackTrace();
//		    		}
//		    		BigInteger hash = new BigInteger(1, md.digest(senha.getBytes()));
//		    		String novaSenha = hash.toString(16);
//		    		
//					usuarioDAO.atualizarSenha(novaSenha, usuario.getEmail());
//					resp.sendRedirect("sucesso.html");
//				} catch (SQLException e) {
//					resp.sendRedirect("trocaSenhaError.jsp");
//				}
//		    }else {
//		    	resp.sendRedirect("trocaSenhaError.jsp");
//		    }
		}
	}
}
