/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Sevlet;

import DAO.ProductDAO;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import models.Cart;
import models.Product;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "ProductSevlet", urlPatterns = {"/ProductSevlet"})
@MultipartConfig(
        location = "C:\\Users\\LENOVO\\Documents\\NetBeansProjects\\MyPhoneStore\\web\\images",
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 11
)

public class ProductSevlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductSevlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductSevlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        try {
            String theCommand = request.getParameter("command");
            if (theCommand == null) {
                theCommand = "LIST";
            }
            switch (theCommand) {
                case "LIST":
                    listProducts(request, response);
                    break;
                case "LOAD":
                    loadProduct(request, response);
                    break;
                case "LOAD_UPDATE":
                    loadProductUpdate(request, response);
                    break;
                case "UPDATE":
                    updateProduct(request, response);
                    break;
                case "DELETE":
                    deleteProduct(request, response);
                    break;
                default:
                    listProducts(request, response);
            }

        } catch (Exception ex) {

            Logger.getLogger(ProductSevlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            String name = request.getParameter("name");
            String price = request.getParameter("price");
            String category = request.getParameter("category");
//        String image = request.getParameter("image");
            Part part = request.getPart("image");
            String fileName = part.getSubmittedFileName();

            Product product = new Product(name, Integer.parseInt(price), fileName, category);

            ProductDAO productDAO = new ProductDAO();
            HttpSession session = request.getSession();
            boolean f = productDAO.addProduct(product);

            if (f) {
                String path = getServletContext().getRealPath("") + "images";
                File file = new File(path);
                part.write(path + File.separator + fileName);
                session.setAttribute("succMsg", "Sucessfully");
                response.sendRedirect("create_product.jsp");
            } else {
                session.setAttribute("failMsg", "Fail Upload");
                response.sendRedirect("create_product.jsp");
            }
//        listProducts(request, response);

        } catch (Exception e) {
        }

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

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("productlist", products);
        //read student info from the form
        request.getRequestDispatcher("index.jsp").forward(request, response);

    }

    private void loadProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //read student id from the form data
        String theProductId = request.getParameter("productId");

        //get student from the database
        Product product = new ProductDAO().getProduct(theProductId);
        //place student in the request attribute
        Product pd = (Product) product;
        request.setAttribute("THE_PRODUCT", product);

        //send to jsp page: update-student-form.jsp
        RequestDispatcher dispatcher
                = request.getRequestDispatcher("viewsproduct.jsp");
        dispatcher.forward(request, response);
    }

    private void loadProductUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //read student id from the form data
        String theProductId = request.getParameter("productId");

        //get student from the database
        Product product = new ProductDAO().getProduct(theProductId);
        //place student in the request attribute
        Product pd = (Product) product;
        request.setAttribute("THE_PRODUCT_UPDATE", product);

        //send to jsp page: update-student-form.jsp
        RequestDispatcher dispatcher
                = request.getRequestDispatcher("edit.jsp");
        dispatcher.forward(request, response);
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("productId"));
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String category = request.getParameter("category");
        //create a new student object
        Product product = new Product(id, name, Integer.parseInt(price), category);

        //perform update on database
        new ProductDAO().updateProduct(product);
        //send them back to the "list student" page
        response.sendRedirect("managerProduct.jsp");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String theProductId = request.getParameter("productId");

        // delete student from the database
        new ProductDAO().deleteProduct(theProductId);
        // send them back to the "list student" pages
        response.sendRedirect("managerProduct.jsp");// Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
