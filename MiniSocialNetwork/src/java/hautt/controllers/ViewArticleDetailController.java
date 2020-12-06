/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.controllers;

import hautt.daos.ArticleDAO;
import hautt.daos.EmotionDAO;
import hautt.daos.UserDAO;
import hautt.dtos.ArticleDTO;
import hautt.dtos.UserDTO;
import java.io.IOException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author SE130205
 */
public class ViewArticleDetailController extends HttpServlet {

    private static final String ERROR = "invalid.jsp";
    private static final String SUCCESS = "articleDetailPage.jsp";
    private static final Logger LOGGER = Logger.getLogger(ViewArticleDetailController.class);

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
            String id = request.getParameter("txtID");
            HttpSession session = request.getSession();
            UserDTO userDTO = (UserDTO) session.getAttribute("USER");
            ArticleDAO articleDAO = new ArticleDAO();
            ArticleDTO articleDTO = articleDAO.getAnArticle(id);
            UserDAO userDAO = new UserDAO();
            if (articleDTO != null) {
                UserDTO authorDTO = userDAO.getUser(articleDTO.getEmail());
                EmotionDAO emotionDAO = new EmotionDAO();
                String emotion = emotionDAO.checkEmotion(articleDTO.getId(), userDTO.getEmail());
                request.setAttribute("AUTHOR_NAME", authorDTO.getName());
                request.setAttribute("ARTICLE", articleDTO);
                request.setAttribute("EMOTION", emotion);
                url = SUCCESS;
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            LOGGER.fatal("Error at ViewArticleDetailController: ", e);
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
