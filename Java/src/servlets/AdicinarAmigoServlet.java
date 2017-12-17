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
import model.Amigos;
import model.Usuario;

@WebServlet(name="AdicinarAmigoServlet", urlPatterns="/AdicinarAmigoServlet")
public class AdicinarAmigoServlet extends HttpServlet{
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession s =  req.getSession();
		Usuario amigo = new Usuario();
		UsuarioDAO usuarioDAO = new UsuarioDAO();
		NotificacoesDAO notDAO = new NotificacoesDAO();
		
		String destinatario = new String();
		destinatario = req.getParameter("nomeAceita");
		amigo = usuarioDAO.populaUser(destinatario);
		
		String remetente;
		remetente = (String) s.getAttribute("email");
		
		AmigoDAO amigoDAO= new AmigoDAO();
		Amigos a = new Amigos();
		
		a.setAmigo(remetente);
		a.setUsuario(destinatario);
		
		if(amigoDAO.verificaExistencia(remetente, destinatario) == false && amigoDAO.verificaExistencia(destinatario, remetente) == false ){
			try {
				amigoDAO.mandaConvite(a);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			notDAO.excluiNotificacoes(destinatario, remetente);
		}
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/login");
		dispatcher.forward(req, resp);
		
		
	}
}
