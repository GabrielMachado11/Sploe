package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.UsuarioDAO;
import dbcon.Conexao;
import model.Usuario;
@WebServlet(name="Login Servlet Usuario", urlPatterns="/login")
public class LoginUsuarioServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Usuario user = new Usuario();
		HttpSession s =  req.getSession();
		
		user.setEmail(req.getParameter("email"));
		user.setSenha(md5(req.getParameter("senha")));
		//pupula um objeto usuario pegando as informaçoes digitadas nos campos que contem os nomes fornecidos
		String redirecionamento = "loginERROR.html";
		UsuarioDAO usuarioDAO = new UsuarioDAO();
		
		if(usuarioDAO.consultarLogin(user) == true){
			s.setAttribute("email", user.getEmail());
			s.setAttribute("senha", user.getSenha());
			//req.setAttribute("email", user.getEmail());
			redirecionamento = "minhaConta.jsp";
			//caso exista algum usuario com o nome e a senha do carinha ele fara com que se logue na sessao, ainda nao é possivel fazer com que ele permaneça conectado apos fechar o broswer, pelo que eu pesquisei é necessario o uso de cookies
		}else{
			user.setEmail((String) s.getAttribute("email"));
			user.setSenha((String) s.getAttribute("senha"));
			if(usuarioDAO.consultarLogin(user) == true){
				s.setAttribute("email", user.getEmail());
				s.setAttribute("senha", user.getSenha());
				redirecionamento = "minhaConta.jsp";
			}
		} 
		 
		//req.getRequestDispatcher(redirecionamento).forward(req, resp);
		resp.sendRedirect(redirecionamento);
	}
	
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
				
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
}
