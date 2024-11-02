package controller;

import dal.ProductDAO;
import dal.stockDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.AdminApprovalLog;
import model.Import;
import model.User;

public class AdminApprovalLogServlet extends HttpServlet {

    private ProductDAO pDAO = new ProductDAO();
    private stockDAO sDao = new stockDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<AdminApprovalLog> logList = pDAO.getAdminApprovalLogs();
        List<User> users = sDao.getAllUser();

        // Tạo map để ánh xạ userId (int) với username (String)
        Map<Integer, String> userMap = new HashMap<>();
        for (User user : users) {
            userMap.put(user.getUserId(), user.getUsername());
        }

        // Fetch the map of statuses
        Map<Integer, String> statusMap = pDAO.getAllStatuses();

        // Set the lists in the request scope
        request.setAttribute("logList", logList);
        request.setAttribute("statusMap", statusMap);
        request.setAttribute("userMap", userMap);

        // Forward to JSP
        request.getRequestDispatcher("/adminApprovalLogs.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String approvalID = request.getParameter("approvalID");
        String pid = request.getParameter("pid");
        String action = request.getParameter("action");
        String status = request.getParameter("status");
        String detail = request.getParameter("detail");
        String decider = request.getParameter("decider");

        // Create an AdminApprovalLog object to hold the updated data
        AdminApprovalLog log = new AdminApprovalLog();
        log.setApprovalID(approvalID);
        log.setPid(pid);
        log.setAction(action);
        log.setStatus(Integer.parseInt(status)); // Assuming status is an integer
        log.setDetail(detail);
        log.setDecider(Integer.parseInt(decider)); // Assuming decider is an integer

        // Call DAO to update the log
        pDAO.updateApprovalLog(log);
        pDAO.updateProductStatus(pid, Integer.parseInt(status));
        response.sendRedirect("AdminApprovalLogServlet");
        

    }

}
