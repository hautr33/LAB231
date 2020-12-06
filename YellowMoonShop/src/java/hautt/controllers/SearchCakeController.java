/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.controllers;

import hautt.daos.CategoryDAO;
import hautt.daos.CakeDAO;
import hautt.dtos.CakeDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
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
public class SearchCakeController extends HttpServlet {

    private static final String ERROR = "invalid.jsp";
    private static final String SUCCESS = "homePage.jsp";
    private static final Logger LOGGER = Logger.getLogger(SearchCakeController.class);

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
            String searchType = request.getParameter("txtSearchType");
            String curPageString = request.getParameter("txtCurPage");
            int curPage;
            if (curPageString == null || curPageString.isEmpty()) {
                curPage = 1;
            } else {
                curPage = Integer.parseInt(curPageString);
            }
            CakeDAO dao = new CakeDAO();
            dao.updateStatus();
            List<CakeDTO> list = null;
            String error = "";
            String title = "Yellow Moon Shop";
            if (searchType == null) {
                error = "Please choose search type!!";
            } else {
                if (searchType.equals("name")) {
                    String search = request.getParameter("txtSearch").trim();
                    if (search.isEmpty()) {
                        error = "Cake name can not blank!!";
                    } else {
                        list = dao.searchCakeName(search, curPage);
                        title = "Search by Name: " + search;
                    }
                } else if (searchType.equals("price")) {
                    String txtFromPrice = request.getParameter("txtFromPrice");
                    String txtToPrice = request.getParameter("txtToPrice");
                    if (txtFromPrice.isEmpty() || txtToPrice.isEmpty()) {
                        error = "Frome Price or To Price can not blank!!";
                    } else {
                        float fromPrice = Float.parseFloat(txtFromPrice);
                        float toPrice = Float.parseFloat(txtToPrice);
                        if (fromPrice > toPrice) {
                            error = "Frome Price must be less than To Price please!!";
                        } else {
                            list = dao.searchCakePrice(fromPrice, toPrice, curPage);
                            title = "Search by Price: " + fromPrice + " ~ " + toPrice;
                        }

                    }
                } else if (searchType.equals("category")) {
                    String categoryID = request.getParameter("txtCategoryID");
                    if (categoryID.isEmpty()) {
                        error = "Please choose a category to search!!";
                    } else {
                        list = dao.searchCakeCategory(categoryID, curPage);
                        CategoryDAO categoryDAO = new CategoryDAO();
                        title = "Search by Category: " + categoryDAO.getCategoryName(categoryID);
                    }
                }

            }
            request.setAttribute("SEARCH_TITLE", title);
            request.setAttribute("SEARCH_TYPE", searchType);
            request.setAttribute("SEARCH_ERROR", error);
            request.setAttribute("LIST_CAKE", list);
            request.setAttribute("CUR_PAGE", curPage);
            url = SUCCESS;
        } catch (ClassNotFoundException | NumberFormatException | SQLException | NamingException e) {
            LOGGER.fatal("Error at SearchCakeController: ", e);
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
