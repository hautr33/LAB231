/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.controllers;

import hautt.daos.CategoryDAO;
import hautt.daos.CakeDAO;
import hautt.dtos.CategoryDTO;
import hautt.dtos.CakeDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
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
public class SearchAllCakesController extends HttpServlet {

    private static final String ERROR = "invalid.jsp";
    private static final String SUCCESS = "homePage.jsp";
    private static final Logger LOGGER = Logger.getLogger(SearchAllCakesController.class);

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
            String curPageString = request.getParameter("txtCurPage");
            int curPage;
            if (curPageString == null || curPageString.isEmpty()) {
                curPage = 1;
            } else {
                curPage = Integer.parseInt(curPageString);
            }
            CakeDAO cakeDAO = new CakeDAO();
            cakeDAO.updateStatus();
            List<CakeDTO> listCake = cakeDAO.getAllCakes(curPage);
            
            CategoryDAO categoryDAO = new CategoryDAO();
            List<CategoryDTO> listCategory = categoryDAO.getCategories();
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime now = LocalDateTime.now();
            HttpSession session = request.getSession();
            session.setAttribute("LIST_CATEGORY", listCategory);
            session.setAttribute("TODAY", dtf.format(now));
            session.setAttribute("TOMORROW", dtf.format(now.plusDays(1)));
            request.setAttribute("LIST_CAKE", listCake);
            request.setAttribute("CUR_PAGE", curPage);
            url = SUCCESS;
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            LOGGER.fatal("Error at SearchAllCakesController: ", e);
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
