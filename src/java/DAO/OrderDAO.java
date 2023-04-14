/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import connection.connectDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Order;
import models.Product;

/**
 *
 * @author LENOVO
 */
public class OrderDAO {
    public boolean insertOrder(Order model) {
        boolean result = false;
        String sql = "INSERT INTO orders (p_id, u_id ,o_quantity, o_date) VALUES (?,?,?,?);";
        connectDB db = connectDB.getInstance();
        Connection con;
        try {
            con = db.openConnection();
            try (PreparedStatement statement = con.prepareStatement(sql)) {
                statement.setInt(1, model.getId());
                statement.setInt(2, model.getUid());
                statement.setInt(3, model.getQuantity());
                statement.setString(4, model.getDate());
                statement.execute();
            }
            con.close();
            result = true;
        } catch (Exception e) {
        }
        return result;
    }

    public List<Order> userOrders(int id) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders where u_id=?";
        connectDB db = connectDB.getInstance();
        Connection con;
        try{
            con = db.openConnection();
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                ProductDAO productDAO = new ProductDAO();
                int pId = rs.getInt("p_id");

                Product product = productDAO.getSingleProduct(pId);
                order.setOrderId(rs.getInt("id"));
                order.setId(pId);
                order.setName(product.getName());
                order.setCategory(product.getCategory());
                order.setPrice(product.getPrice() * rs.getInt("o_quantity"));
                order.setQuantity(rs.getInt("o_quantity"));
                order.setDate(rs.getString("o_date"));
                list.add(order);  
            }
            rs.close();
            statement.close();
            con.close();

        } catch (Exception e) {
        }

        return list;
    }
    
    public void cancelOrder(int id){
        String sql = "delete orders where id=?";
        connectDB db = connectDB.getInstance();
        Connection con;
        try {
            con = db.openConnection();
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            rs.close();
            statement.close();
            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
