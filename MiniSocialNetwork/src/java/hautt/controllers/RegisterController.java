/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.controllers;

import hautt.daos.UserDAO;
import hautt.dtos.UserDTO;
import java.io.IOException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.log4j.Logger;

/**
 *
 * @author SE130205
 */
public class RegisterController extends HttpServlet {

    private static final String ERROR = "invalid.jsp";
    private static final String SUCCESS = "registerPage.jsp";
    private static final Logger LOGGER = Logger.getLogger(RegisterController.class);

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
        try {
            String email = request.getParameter("txtEmail").trim();
            String name = request.getParameter("txtName").trim();
            String password = request.getParameter("txtPassword").replaceAll(" ", "");
            String confirmPassword = request.getParameter("txtConfirmPassword").replaceAll(" ", "");
            if (password.equals(confirmPassword)) {
                password = DigestUtils.sha256Hex(password);
                UserDTO dto = new UserDTO(email, name, password, "MB", "New");
                UserDAO dao = new UserDAO();
                boolean isRegister = dao.registerAccount(dto);
                if (isRegister) {
                    request.setAttribute("REGISTER_SUCCESS", "Your account has been successfully registered!!");
                }
            } else {
                request.setAttribute("REGISTER_ERROR", "Confirm Password must match Password!!");
            }
            url = SUCCESS;
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            if (e.getMessage().contains("Cannot insert duplicate")) {
                request.setAttribute("REGISTER_ERROR", "This email already exists!!");
                url = SUCCESS;
            }
            LOGGER.fatal("Error at RegisterController: ", e);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
