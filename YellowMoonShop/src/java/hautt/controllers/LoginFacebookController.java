/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.controllers;

import hautt.dtos.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.restfb.types.User;
import hautt.daos.UserDAO;
import hautt.facebook.RestFB;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author SE130205
 */
public class LoginFacebookController extends HttpServlet {

    private static final String ERROR = "loginPage.jsp";
    private static final String SUCCESS = "SearchAllCakesController";
    private static final Logger LOGGER = Logger.getLogger(LoginFacebookController.class);

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        String code = request.getParameter("code");
        try {
            String accessToken = RestFB.getToken(code);
            User fbUser = RestFB.getUserInfo(accessToken);
            UserDTO dto = new UserDTO();
            dto.setFacebookID(fbUser.getId());
            dto.setName(fbUser.getName());
            UserDAO dao = new UserDAO();
            UserDTO user = dao.checkLogin(fbUser.getId());
            if (user == null) {
                dao.registerFacebook(dto);
                user = dao.checkLogin(fbUser.getId());
            }
            HttpSession session = request.getSession();
            session.setAttribute("USER", user);
            url = SUCCESS;
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            LOGGER.fatal("Error at LoginFacebookController: ", e);
        } finally {
            response.sendRedirect(url);
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
