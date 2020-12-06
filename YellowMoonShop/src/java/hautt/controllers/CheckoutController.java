/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.controllers;

import hautt.daos.CakeDAO;
import hautt.daos.OrderDAO;
import hautt.daos.OrderDetailDAO;
import hautt.daos.UserDAO;
import hautt.dtos.CakeDTO;
import hautt.dtos.CartDTO;
import hautt.dtos.OrderDTO;
import hautt.dtos.OrderDetailDTO;
import hautt.dtos.UserDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
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
public class CheckoutController extends HttpServlet {

    private static final String ERROR = "viewCart.jsp";
    private static final String SUCCESS = "checkout.jsp";
    private static final Logger LOGGER = Logger.getLogger(CheckoutController.class);

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
            String userID = request.getParameter("txtUserID");
            String name = request.getParameter("txtName");
            String address = request.getParameter("txtAddress");
            String phone = request.getParameter("txtPhone");
            String note = request.getParameter("txtNote");
            String saveInfo = request.getParameter("chkInfo");
            HttpSession session = request.getSession();
            if (saveInfo != null && saveInfo.equals("Save")) {
                UserDTO dto = new UserDTO(userID, name, phone, address, "");
                UserDAO dao = new UserDAO();
                dao.updateInfo(dto);
                dto = dao.getUser(userID);
                session.setAttribute("USER", dto);
            }
            UserDTO user = (UserDTO) session.getAttribute("USER");
            if (user == null) {
                UserDAO dao = new UserDAO();
                UserDTO dto = new UserDTO("", name, phone, address, "MB");
                userID = dao.getGuestID(dto);
                if (user == null) {
                    dao.register(dto);
                    userID = dao.getGuestID(dto);
                }
            }
            String outOfStockString = "";
            String notEnoughCakeString = "";
            CartDTO cart = (CartDTO) session.getAttribute("CART");
            if (cart != null && !cart.getCart().values().isEmpty()) {
                CakeDAO dao = new CakeDAO();
                for (CakeDTO dto : cart.getCart().values()) {
                    int cakeQuantity = dao.getCakeQuantity(dto.getCakeID());
                    if (cakeQuantity == 0) {
                        if (!outOfStockString.isEmpty()) {
                            outOfStockString += ", ";
                        }
                        outOfStockString += dto.getCakeName();
                    } else if (cakeQuantity < dto.getQuantity()) {
                        if (!notEnoughCakeString.isEmpty()) {
                            notEnoughCakeString += ", ";
                        }
                        notEnoughCakeString += dto.getCakeName() + "(Max: " + cakeQuantity + ")";
                    }
                }
            }
            if (!outOfStockString.isEmpty() || !notEnoughCakeString.isEmpty()) {
                if (!outOfStockString.isEmpty()) {
                    request.setAttribute("OUT_OF_STOCK", outOfStockString);
                }
                if (!notEnoughCakeString.isEmpty()) {
                    request.setAttribute("NOT_ENOUGH_CAKE", notEnoughCakeString);
                }
            } else {
                Timestamp orderDate = new Timestamp(System.currentTimeMillis());
                orderDate.setNanos(0);
                Calendar calendar = Calendar.getInstance();
                calendar.add(Calendar.DAY_OF_YEAR, 7);
                Date date = calendar.getTime();
                Timestamp arrivalDate = new Timestamp(date.getTime());
                OrderDTO orderDTO = new OrderDTO("", userID, name, address, phone, note, orderDate, arrivalDate, "COD", cart.getTotalAmount(), "Shipping");
                OrderDAO orderDAO = new OrderDAO();
                orderDAO.insert(orderDTO);
                String orderID = orderDAO.getOrderID(userID, orderDate);
                OrderDetailDAO detailDAO = new OrderDetailDAO();
                for (CakeDTO cake : cart.getCart().values()) {
                    OrderDetailDTO dto = new OrderDetailDTO(orderID, cake.getCakeID(), cake.getQuantity(), cake.getPrice(), cake.getTotal());
                    detailDAO.insert(dto);
                    CakeDAO cakeDAO = new CakeDAO();
                    int quantity = cakeDAO.getCakeQuantity(cake.getCakeID());
                    quantity -= cake.getQuantity();
                    cakeDAO.updateQuantity(cake.getCakeID(), quantity);
                    request.setAttribute("ORDER_ID", orderID);
                    session.setAttribute("CART", null);
                }
                url = SUCCESS;
            }

        } catch (ClassNotFoundException | SQLException | NamingException e) {
            LOGGER.fatal("Error at CheckoutController: ", e);
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
