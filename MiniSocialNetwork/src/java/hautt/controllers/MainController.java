/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author SE130205
 */
@MultipartConfig
public class MainController extends HttpServlet {

    private static final String ERROR = "invalid.jsp";
    private static final String REGISTER = "RegisterController";
    private static final String LOGIN = "LoginController";
    private static final String LOGOUT = "LogoutController";
    private static final String VERIFY_ACCOUNT = "VerifyAccountController";
    private static final String POST_ARTICLE = "PostArticleController";
    private static final String SEARCH_ALL = "SearchAllArticleController";
    private static final String SEARCH = "SearchArticleController";
    private static final String VIEW_DETAIL = "ViewArticleDetailController";
    private static final String DELETE_ARTICLE = "DeleteArticleController";
    private static final String MAKE_EMOTION = "MakeEmotionController";
    private static final Logger LOGGER = Logger.getLogger(MainController.class);

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
            String action = request.getParameter("btnAction");
            switch (action) {
                case "Register":
                    url = REGISTER;
                    break;
                case "Login":
                    url = LOGIN;
                    break;
                case "Logout":
                    url = LOGOUT;
                    break;
                case "VerifyAccount":
                    url = VERIFY_ACCOUNT;
                    break;
                case "Post":
                    url = POST_ARTICLE;
                    break;
                case "SearchAll":
                    url = SEARCH_ALL;
                    break;
                case "Search":
                    url = SEARCH;
                    break;
                case "ViewDetail":
                    url = VIEW_DETAIL;
                    break;
                case "DeleteArticle":
                    url = DELETE_ARTICLE;
                    break;
                case "MakeEmotion":
                    url = MAKE_EMOTION;
                    break;
            }
        } catch (Exception e) {
            LOGGER.fatal("Error at MainController: ", e);
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
