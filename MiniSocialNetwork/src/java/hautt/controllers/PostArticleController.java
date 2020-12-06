/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.controllers;

import hautt.daos.ArticleDAO;
import hautt.dtos.ArticleDTO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.log4j.Logger;

/**
 *
 * @author SE130205
 */
@MultipartConfig
public class PostArticleController extends HttpServlet {

    private static final String ERROR = "invalid.jsp";
    private static final String SUCCESS = "postArticlePage.jsp";
    private static final Logger LOGGER = Logger.getLogger(PostArticleController.class);

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
            String title = request.getParameter("txtTitle");
            String description = request.getParameter("txtDescription");
            String email = request.getParameter("txtEmail");

            Calendar calendar = Calendar.getInstance();
            Date dateTime = calendar.getTime();
            Timestamp date = new Timestamp(dateTime.getTime());

            String id = email + "_" + date.toString().replaceAll("-", "").replaceAll(":", "").replace(" ", "_");

            String imageURL = "";
            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();
            if (!imageName.isEmpty()) {
                Path path = Paths.get(request.getServletContext().getRealPath(""));
                path = path.getParent().getParent();
                String fullSavePath = path.toString().replace("\\", "/") + "/web/images/articles/";
                File fileSaveDir = new File(fullSavePath);
                if (!fileSaveDir.exists()) {
                    Files.createDirectories(Paths.get(fullSavePath));
                }
                String extensionName = imageName.split("\\.")[imageName.split("\\.").length - 1];
                String filePath = fullSavePath + id + "." + extensionName;
                part.write(filePath);
                File source = new File(path.toString().replace("\\", "/") + "/web/images/articles/" + id + "." + extensionName);
                File dest = new File(path.toString().replace("\\", "/") + "/build/web/images/articles/" + id + "." + extensionName);
                if (!dest.exists()) {
                    Files.createDirectories(Paths.get(path.toString().replace("\\", "/") + "/build/web/images/articles/"));
                }
                Files.copy(source.toPath(), dest.toPath(), StandardCopyOption.REPLACE_EXISTING);
                imageURL = "images/articles/" + id + "." + extensionName;
            }
            ArticleDTO dto = new ArticleDTO(id, email, title, description, imageURL, date, "Active");
            ArticleDAO dao = new ArticleDAO();
            dao.postArticle(dto);
            request.setAttribute("POST_ARTICLE_SUCCESS", "Your article has been posted successfully!!");
            url = SUCCESS;
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            LOGGER.fatal("Error at PostArticleController: ", e);
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
