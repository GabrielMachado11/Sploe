package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UsuarioDAO;
import dbcon.Conexao;
import model.Usuario;

@WebServlet(name="LogOut Servlet", urlPatterns="/logout")
public class LogOutServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession s =  req.getSession();
		s.invalidate();
		resp.sendRedirect("index.jsp");
		
	}
}
