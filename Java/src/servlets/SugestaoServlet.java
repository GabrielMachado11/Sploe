package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.EmailException;

import dao.SugestaoDAO;
import model.Sugestao;


@WebServlet(name = "Sugestao Servlet", urlPatterns = "/sugestao")

public class SugestaoServlet extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String assunto;
		String mensagem;

		assunto = req.getParameter("assunto");
		mensagem = req.getParameter("mensagem");
		RequestDispatcher r;

		
			//SugestaoDAO sDAO = new SugestaoDAO();
			//Sugestao s = new Sugestao();
			//s.setTipo(assunto);
			//s.setConteudo(mensagem);
			//try {
				//sDAO.envia(s);
				r = req.getRequestDispatcher("emailEnviado.html");
				r.forward( req, resp );
			//} catch (SQLException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				//r = req.getRequestDispatcher("index.jsp");
				//r.forward( req, resp );
			//}
			
			

		

	}
}
