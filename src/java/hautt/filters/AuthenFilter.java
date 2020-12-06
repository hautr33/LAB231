/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.filters;

import hautt.dtos.UserDTO;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author SE130205
 */
public class AuthenFilter implements Filter {

    private static final boolean debug = true;
    private static List<String> guest;
    private static List<String> member;
    private static List<String> admin;
    private static String ERROR = "invalid.jsp";

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public AuthenFilter() {
        //Guest
        guest = new ArrayList<>();
        guest.add("loginPage.jsp");
        guest.add("invalid.jsp");
        guest.add("viewCart.jsp");
        guest.add("paymentInfo.jsp");
        guest.add("LoginController");
        guest.add("LoginFacebookController");
        guest.add("SearchAllCakesController");
        guest.add("SearchCakeController");
        guest.add("AddToCartController");
        guest.add("RemoveFromCartController");
        guest.add("UpdateCartController");
        guest.add("CheckoutController");

        //Member
        member = new ArrayList<>();
        member.add("invalid.jsp");
        member.add("viewCart.jsp");
        member.add("paymentInfo.jsp");
        member.add("LogoutController");
        member.add("SearchAllCakesController");
        member.add("SearchCakeController");
        member.add("AddToCartController");
        member.add("RemoveFromCartController");
        member.add("UpdateCartController");
        member.add("CheckoutController");

        //Admin
        admin = new ArrayList<>();
        admin.add("invalid.jsp");
        admin.add("createCakePage.jsp");
        admin.add("updateCakePage.jsp");
        admin.add("LogoutController");
        admin.add("SearchAllCakesController");
        admin.add("SearchCakeController");
        admin.add("UpdateCakeController");
        admin.add("CreateCakeController");
        admin.add("FowardUpdatePageController");
        admin.add("UpdateCakeController");
        admin.add("ViewAllUsersController");
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthenFilter:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthenFilter:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        try {
            HttpServletRequest rq = (HttpServletRequest) request;
            HttpServletResponse rs = (HttpServletResponse) response;
            String uri = rq.getRequestURI();
            if ((uri.contains(".js") || uri.contains(".jpg") || uri.contains(".png") || uri.contains(".jpeg") || uri.contains(".jfif")) && !uri.contains(".jsp")) {
                chain.doFilter(request, response);
            } else {
                int index = uri.lastIndexOf("/");
                String resource = uri.substring(index + 1);
                if (resource.isEmpty()) {
                    rq.getRequestDispatcher("SearchAllCakesController").forward(request, response);
                } else {
                    HttpSession session = rq.getSession(false);
                    if (session != null && session.getAttribute("USER") != null) {
                        UserDTO dto = (UserDTO) session.getAttribute("USER");
                        String roleID = dto.getRoleID();
                        if (roleID.equals("AD") && admin.contains(resource)) {
                            chain.doFilter(request, response);
                        } else if (roleID.equals("MB") && member.contains(resource)) {
                            chain.doFilter(request, response);
                        } else {
                            rs.sendRedirect(ERROR);
                        }
                    } else if (guest.contains(resource)) {
                        chain.doFilter(request, response);
                    } else {
                        rs.sendRedirect(ERROR);
                    }
                }
            }
        } catch (IOException | ServletException e) {
            log("Error at Filter: " + e);
        }
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("AuthenFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("AuthenFilter()");
        }
        StringBuffer sb = new StringBuffer("AuthenFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
