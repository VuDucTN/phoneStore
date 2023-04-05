/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import connection.connectDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Cart;
import models.Product;

/**
 *
 * @author LENOVO
 */
public class ProductDAO {

    public List<Product> getAllProducts() {
        List<Product> pd = new ArrayList<>();
        connectDB db = connectDB.getInstance();
        String sql = "Select * from products";
        try {
            Connection con = db.openConnection();
            PreparedStatement statement = con.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(2);
                int price = rs.getInt(3);
                String image = rs.getString(4);
                String category = rs.getString(5);
                Product product = new Product(id, name, price, image, category);
                pd.add(product);
            }
            rs.close();
            statement.close();
            con.close();
        } catch (Exception ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE,
                    null, ex);
        }
        return pd;
    }

    public boolean addProduct(Product product) {
        boolean f = false;
        // create sql for insert
        String sql = "INSERT INTO products (name, price, image, category)\n" + "VALUES (?,?,?,?);";
        connectDB db = connectDB.getInstance();

        Connection con;

        try {
            con = db.openConnection();
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, product.getName());
            statement.setInt(2, product.getPrice());
            statement.setString(3, product.getImage());
            statement.setString(4, product.getCategory());
            statement.execute();
            statement.close();
            con.close();
            f = true;

        } catch (Exception ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return f;
    }

    public Product getProduct(String idd) {
        int id = Integer.parseInt(idd);
        connectDB db = connectDB.getInstance();
        String sql = "Select * from products where id=?";
        Product product = null;

        try {
            Connection con = db.openConnection();
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                String name = rs.getString(2);
                int price = rs.getInt(3);
                String category = rs.getString(4);;
                product = new Product(id, name, price, category);
            }
            rs.close();
            statement.close();
            con.close();
        } catch (Exception ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE,
                    null, ex);
        }
        return product;
    }

    public List<Cart> getCarts(ArrayList<Cart> carts) {
        List<Cart> products = new ArrayList<>();
        connectDB db = connectDB.getInstance();
        String sql = "Select * from products where id=?";
        try {
            if (carts.size() > 0) {
                for (Cart item : carts) {
                    Connection con = db.openConnection();
                    PreparedStatement statement = con.prepareStatement(sql);
                    statement.setInt(1, item.getId());
                    ResultSet rs = statement.executeQuery();
                    while (rs.next()) {
                        Cart row = new Cart();
                        row.setId(rs.getInt("id"));
                        row.setName(rs.getString("name"));
                        row.setPrice(rs.getInt("price") * item.getQuantity());
                        row.setCategory(rs.getString("category"));
                        row.setQuantity(item.getQuantity());
                        products.add(row);
                    }
                }
            }
        } catch (Exception e) {
        }
        return products;
    }

    public int getTotalCartPrice(ArrayList<Cart> cartList) {
        int sum = 0;
        connectDB db = connectDB.getInstance();
        String sql = "Select price from products where id=?";
        
        try {
            if (cartList.size() > 0) {
                for (Cart itemCart : cartList) {
                    Connection con = db.openConnection();
                    PreparedStatement statement = con.prepareStatement(sql);
                    statement.setInt(1, itemCart.getId());
                    ResultSet rs = statement.executeQuery();
                    while(rs.next()){
                        sum += rs.getInt("price") * itemCart.getQuantity();
                    }
                }
            }
        } catch (Exception e) {
        }

        return sum;
    }
}
