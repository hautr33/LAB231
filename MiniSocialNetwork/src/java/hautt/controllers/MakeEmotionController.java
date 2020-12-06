/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.controllers;

import hautt.daos.ArticleDAO;
import hautt.daos.EmotionDAO;
import hautt.dtos.ArticleDTO;
import hautt.dtos.EmotionDTO;
import java.io.IOException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author SE130205
 */
public class MakeEmotionController extends HttpServlet {

    private static final String ERROR = "invalid.jsp";
    private static final String SUCCESS = "MainController?btnAction=ViewDetail&txtID=";
    private static final Logger LOGGER = Logger.getLogger(MakeEmotionController.class);

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
            String status = request.getParameter("txtStatus");
            String articleID = request.getParameter("txtArticleID");
            String email = request.getParameter("txtEmail");
            EmotionDAO emotionDAO = new EmotionDAO();
            ArticleDAO articleDAO = new ArticleDAO();
            String tmpStatus = emotionDAO.checkEmotion(articleID, email);
            if (tmpStatus != null && !tmpStatus.isEmpty()) {
                if (tmpStatus.equals(status)) {
                    emotionDAO.updateEmotion(new EmotionDTO(articleID, email, "None"));
                    if (status.equals("Like")) {
                        status = "UnLike";
                    } else {
                        status = "UnDislike";
                    }
                } else {
                    emotionDAO.updateEmotion(new EmotionDTO(articleID, email, status));
                    if (status.equals("Like") && !tmpStatus.equals("None")) {
                        status = "DislikeToLike";
                    } else if (status.equals("Dislike") && !tmpStatus.equals("None")) {
                        status = "LikeToDislike";
                    }
                }
            } else {
                emotionDAO.addEmotion(new EmotionDTO(articleID, email, status));
            }
            ArticleDTO articleDTO = articleDAO.getAnArticle(articleID);
            articleDAO.updateArticleEmotion(articleDTO, status);
            url = SUCCESS + articleID;
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            LOGGER.fatal("Error at MakeEmotionController: ", e);
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
