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
    
    public static Profile getProfile(String emailOrPhone, String password){
    Profile profile = null;
    String select = "select * from tbl_profile " + 
            "where email_mobile = ? and password = ?";
        try (Connection c = openConnection()) {
            PreparedStatement ps = c.prepareStatement(select);
            ps.setString(1, emailOrPhone);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                profile = new Profile(rs.getString("first_name"), rs.getString("last_name"), rs.getString("email_mobile"), rs.getString("password"), rs.getString("birthday"), rs.getString("sex"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    return profile;
    }
    
    //return profile result the same way as getProfile above
    public static Profile checkLogin(String emailOrPhone, String password){
        return getProfile(emailOrPhone, password);
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
    
    //We need both profile and emailOrPhone String in case user wish to change current emailOrPhone value
    //Then emailOrPhone will be used to find data
    //and profile.emailOrPhone string will be new (if so) value for emailOrPhone
    public static boolean updateIser(Profile profile, String emailOrPhone){
        try (Connection c = openConnection()) {
            String update = "upadte tbl_profile set first_name = ?, last_name = ?, "
                    + "email_mobile = ?, password = ?, birthday = ?, "
                    + "sex = ? where email_mobile = ?";
            PreparedStatement ps = c.prepareStatement(update);
            ps.setString(1, profile.getFirstName());
            ps.setString(2, profile.getLastName());
            ps.setString(3, profile.getEmailOrPhone());
            ps.setString(4, profile.getPassword());
            ps.setString(5, profile.getBirthday());
            ps.setString(6, profile.getSex());
            ps.setString(7, emailOrPhone);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
