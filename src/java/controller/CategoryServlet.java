package controller;

import dal.CategoryDAO2;
import model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class CategoryServlet extends HttpServlet {

    private CategoryDAO2 categoryDAO = new CategoryDAO2();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "edit":
                showEditForm(request, response);
                break;
            case "insert":
                showAddForm(request, response);
                break;
            case "getSubCategories":
                getSubCategories(request, response);
                break;
            default:
                listCategories(request, response);
                break;
        }
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();

        // Thêm danh sách danh mục con cho từng danh mục
        for (Category category : categories) {
            List<Category> subCategories = categoryDAO.getCategoriesByParentId(category.getCategoryID());
            category.setSubCategories(subCategories); // Bạn cần đảm bảo class Category có phương thức setSubCategories
        }

        request.setAttribute("categories", categories);
        request.getRequestDispatcher("category-list.jsp").forward(request, response);
    }

    private void getSubCategories(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parentId = request.getParameter("parentId");
        List<Category> subCategories = categoryDAO.getCategoriesByParentId(parentId);
        request.setAttribute("subCategories", subCategories);
        request.setAttribute("parentId", parentId); // Lưu parentId để có thể hiển thị tiêu đề
        request.getRequestDispatcher("category-sub-list.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        Category categoryToEdit = categoryDAO.getCategoryById(id);
        List<Category> categories = categoryDAO.getAllCategories();

        // Lưu category vào request để sử dụng trong JSP
        request.setAttribute("category", categoryToEdit);

        // Tính số chữ cái trong ID của category hiện tại
        String currentCategoryID = categoryToEdit.getCategoryID();
        int letterCount = currentCategoryID.replaceAll("[^A-Za-z]", "").length();
        int length =  currentCategoryID.length();

        // Tính số chữ cái cho danh mục cha
        int parentLetterCount = letterCount - 1; // Số chữ cái bình thường
        
        if (length >= 4) {
            parentLetterCount = 3; // Nếu có 4 chữ cái, cha có thể có 2 chữ cái
        }

        // Lọc danh mục cha chỉ cho phép chọn theo số chữ cái
        List<Category> filteredCategories = new ArrayList<>();
        if (length < 4){
            for (Category parentCategory : categories) {
            int parentCategoryLetterCount = parentCategory.getCategoryID().replaceAll("[^A-Za-z]", "").length();

            // Kiểm tra điều kiện cho danh mục cha
            if (parentCategoryLetterCount == parentLetterCount) {
                filteredCategories.add(parentCategory);
            }
        }
        } else {
            for (Category parentCategory : categories) {
            int parentCategoryLetterCount = parentCategory.getCategoryID().length();

            // Kiểm tra điều kiện cho danh mục cha
            if (parentCategoryLetterCount == parentLetterCount) {
                filteredCategories.add(parentCategory);
            }
        }
        }

        // Lưu danh sách danh mục cha đã lọc vào request
        request.setAttribute("filteredCategories", filteredCategories);

        // Chuyển đến JSP
        request.getRequestDispatcher("category-edit.jsp").forward(request, response);
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        Category categoryToEdit = categoryDAO.getCategoryById(id);
        // Chuyển đến JSP
        request.setAttribute("category", categoryToEdit);
        request.getRequestDispatcher("category-add.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("insert".equalsIgnoreCase(action)) {
            insertCategory(request, response);
        } else if ("update".equalsIgnoreCase(action)) {
            updateCategory(request, response);
        }
    }

    private void insertCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String PCategoryID = request.getParameter("categoryID");
        String categoryID = categoryDAO.generateCategoryID(PCategoryID);
        String icon = "iconDisable";
        String categoryName = request.getParameter("categoryName");
        String parentCategoryID = request.getParameter("ParentCategoryID");
        int status = Integer.parseInt(request.getParameter("status"));
        String description = request.getParameter("description");

        Category category = new Category(categoryID, icon, categoryName, parentCategoryID, description, status);
        categoryDAO.insertCategory(category);
        response.sendRedirect("CategoryServlet");
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String categoryID = request.getParameter("categoryID");
        String icon = "iconDisable";
        String categoryName = request.getParameter("categoryName");
        String parentCategoryID = request.getParameter("parentCategoryID");
        int status = Integer.parseInt(request.getParameter("status"));
        String description = request.getParameter("description");

        Category category = new Category(categoryID, icon, categoryName, parentCategoryID, description, status);
        categoryDAO.updateCategory(category);
        response.sendRedirect("CategoryServlet");
    }
}
