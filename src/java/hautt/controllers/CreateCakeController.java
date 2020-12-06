/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.controllers;

import hautt.daos.CakeDAO;
import hautt.dtos.CakeDTO;
import hautt.dtos.UserDTO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.sql.Date;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.log4j.Logger;

/**
 *
 * @author SE130205
 */
@MultipartConfig
public class CreateCakeController extends HttpServlet {

    private static final String ERROR = "invalid.jsp";
    private static final String SUCCESS = "createCakePage.jsp";
    private static final Logger LOGGER = Logger.getLogger(CreateCakeController.class);

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
            String cakeName = request.getParameter("txtCakeName");
            String description = request.getParameter("txtDescription");
            String categoryID = request.getParameter("txtCategoryID");
            String priceString = request.getParameter("txtPrice");
            String quantityString = request.getParameter("txtQuantity");
            int quantity = Integer.parseInt(quantityString);

            String createDateString = request.getParameter("txtCreateDate");
            String expirationDateString = request.getParameter("txtExpirationDate");
            Date createDate = Date.valueOf(createDateString);
            Date expirationDate = Date.valueOf(expirationDateString);
            Timestamp date = new Timestamp(System.currentTimeMillis());

            HttpSession session = request.getSession();
            String lastUpdateUser = ((UserDTO) session.getAttribute("USER")).getUserID();

            String imageURL = "";
            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();
            if (!imageName.isEmpty()) {
                Path path = Paths.get(request.getServletContext().getRealPath(""));
                path = path.getParent().getParent();
                String fullSavePath = path.toString().replace("\\", "/") + "/web/images/cakes/";
                File fileSaveDir = new File(fullSavePath);
                if (!fileSaveDir.exists()) {
                    Files.createDirectories(Paths.get(fullSavePath));
                }
                String fileName = date.toString().replaceAll("-", "").replaceAll(":", "").replace(" ", "_");
                String extensionName = imageName.split("\\.")[imageName.split("\\.").length - 1];
                String filePath = fullSavePath + fileName + "." + extensionName;
                part.write(filePath);
                File source = new File(path.toString().replace("\\", "/") + "/web/images/cakes/" + fileName + "." + extensionName);
                File dest = new File(path.toString().replace("\\", "/") + "/build/web/images/cakes/" + fileName + "." + extensionName);
                if (!dest.exists()) {
                    Files.createDirectories(Paths.get(path.toString().replace("\\", "/") + "/build/web/images/cakes/"));
                }
                Files.copy(source.toPath(), dest.toPath(), StandardCopyOption.REPLACE_EXISTING);
                imageURL = "images/cakes/" + fileName + "." + extensionName;
            }

            CakeDTO dto = new CakeDTO(cakeName, imageURL, description, categoryID, priceString, quantity, createDate, expirationDate, date, lastUpdateUser);
            CakeDAO dao = new CakeDAO();
            dao.createCake(dto);
            request.setAttribute("CREATE_CAKE_SUCCESS", "Your cake has been created successfully!!");
            url = SUCCESS;
        } catch (IOException | ClassNotFoundException | NumberFormatException | SQLException | NamingException | ServletException e) {
            LOGGER.fatal("Error at CreateCakeController: ", e);
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
