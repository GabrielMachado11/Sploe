package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AmigoDAO;
import dao.NotificacoesDAO;
import dao.UsuarioDAO;
import dbcon.Conexao;
import model.Usuario;

@WebServlet(name = "Manda Convite Amigo", urlPatterns = "/addAmigo")
public class MandaConviteAmigoServlet extends HttpServlet {
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession s =  req.getSession();
		Usuario amigo = new Usuario();
		UsuarioDAO usuarioDAO = new UsuarioDAO();
		NotificacoesDAO notDAO = new NotificacoesDAO();
		
		String destinatario = new String();
		destinatario = req.getParameter("nomeAmigo");
		amigo = usuarioDAO.populaUser(destinatario);
		
		String remetente;
		remetente = (String) s.getAttribute("email");
		AmigoDAO a = new AmigoDAO();
		
		if(a.verificaExistencia(remetente, amigo.getEmail()) == false && a.verificaExistencia(amigo.getEmail(), remetente) == false && notDAO.verificaExistencia(amigo.getEmail(), remetente) == false && notDAO.verificaExistencia(remetente, amigo.getEmail()) == false){
			notDAO.mandaConvite(amigo.getEmail(), remetente);
		}
		
		
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/login");
		dispatcher.forward(req, resp);
		
	}
}
