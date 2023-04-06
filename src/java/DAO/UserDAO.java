/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import connection.connectDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.User;

/**
 *
 * @author LENOVO
 */
public class UserDAO {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public UserDAO(Connection con) {
        this.con = con;
    }
    
    public User userLogin(String email, String password){
        User user = null;
        try{
            query = "select * from account_user where email=? and password=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            rs = pst.executeQuery();
            
            if(rs.next()){
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getInt("role"));
            }
        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        
        return user;
    }
    
    public void Register(User user) {
        // create sql for insert
        String sql = "INSERT INTO account_user (name, password ,email, role, phone)\n" + "VALUES (?,?,?,?,?);";
        connectDB db = connectDB.getInstance();

        Connection con;

        try {
            con = db.openConnection();
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, user.getName());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getEmail());
            statement.setInt(4, user.getRole());
            statement.setString(5, user.getPhone());

            statement.execute();

            statement.close();
            con.close();

        } catch (Exception ex) {
            
        }

    }
    
    public User userGetPass(String email, String phone){
        User user = null;
        try{
            query = "select * from account_user where email=? and phone=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, phone);
            rs = pst.executeQuery();
            
            if(rs.next()){
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getInt("role"));
            }
        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        
        return user;
    }
}
