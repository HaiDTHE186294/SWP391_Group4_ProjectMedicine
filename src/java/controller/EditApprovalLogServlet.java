package controller;

import dal.ProductDAO;
import dal.stockDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.AdminApprovalLog;
import model.User;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class EditApprovalLogServlet extends HttpServlet {
    
    private ProductDAO pDAO = new ProductDAO();
    private stockDAO sDao = new stockDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String approvalID = request.getParameter("approvalID");
        
        // Fetch the approval log based on approvalID
        AdminApprovalLog log = pDAO.getAdminApprovalLogByID(approvalID);
        
        if (log != null) {
            List<User> users = sDao.getAllUser();
            Map<Integer, String> statusMap = pDAO.getAllStatuses();

            // Set the retrieved log, users, and status map into the request scope
            request.setAttribute("log", log);
            request.setAttribute("userMap", users);
            request.setAttribute("statusMap", statusMap);

            // Forward to the edit JSP
            request.getRequestDispatcher("/editApprovalLog.jsp").forward(request, response);
        } else {
            // Handle the case where the log is not found (optional)
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Approval Log Not Found");
        }
    }
}
