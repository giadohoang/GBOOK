/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.*;
import model.Profile;

/**
 *
 * @author Gia
 */
public class UserDAO {
    public static Connection openConnection(){
        Connection conn = null;
        try{
            Class.forName(DBConfig.driver);
            conn = DriverManager.getConnection(DBConfig.url,
                    DBConfig.user, DBConfig.password);
            System.out.println("connected to MYSQL server");
        } catch (Exception e){
            e.printStackTrace();
        }
        
        return conn;
    }
    
    public static boolean isDuplicateEmailOrPhone(String emailOrPhone){
        
        try(Connection c = openConnection()){
            String select="select id from tbl_profile where email_mobile = ?";
            PreparedStatement ps = c.prepareStatement(select);
            ps.setString(1, emailOrPhone);
            return ps.executeQuery().next();
        } catch(Exception e){
            
        }
        return false;
    }
    
    public static boolean addNewUser(Profile profile){
        try(Connection c = openConnection()){
            String insert = "Insert into tbl_profile Values(null,?,?,?,?,?,?,null)";
            PreparedStatement ps = c.prepareStatement(insert);
            ps.setString(1, profile.getFirstName());
            ps.setString(2, profile.getLastName());
            ps.setString(3, profile.getEmailOrPhone());
            ps.setString(4, profile.getPassword());
            ps.setString(5, profile.getBirthday());
            ps.setString(6, profile.getSex());
            
            ps.executeUpdate();
            ps.close();
            return true;
        } catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }
}
