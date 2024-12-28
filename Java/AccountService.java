package omadiki5;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;



public class AccountService {


    // Method to return all the available accounts.
    public List<Account> getAccounts() throws Exception {

        List<Account> accounts = new ArrayList<Account>();

        DB db = new DB();
        Connection con = null;
        String query = "SELECT * FROM accounts;";

        try {

            con = db.getConnection();

            PreparedStatement stmt = con.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                accounts.add( new Account(
                                        rs.getString("acc_Num"), 
                                        rs.getString("acc_Name"), 
                                        rs.getString("acc_IBAN"), 
                                        rs.getString("acc_Descr")));
            }

            rs.close();
            stmt.close();
            db.close();

            return accounts;

        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();    
            } catch (Exception e) {
                
            }
        }
    } // End of getAccounts method





    // Method to return a specific account in given accNum.
    public Account findAccount(String accNum) throws Exception {
       
        DB db = new DB();
        Connection con = null;
        String query = "SELECT * FROM accounts WHERE acc_Num=?;";

        try {

            con = db.getConnection();

            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, accNum);
            
            ResultSet rs = stmt.executeQuery();
            
            if (!rs.next()) {
               
                rs.close();
                stmt.close();
                return null;               
            }
            
            return new Account(rs.getString("accounts.acc_Num"),
                                rs.getString("accounts.acc_Name"),
                                rs.getString("accounts.acc_IBAN"),
                                rs.getString("accounts.acc_Descr"));
            
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();    
            } catch (Exception e) {
                
            }
        }   
    } // End of findAccount method







    // Method to delete an account
    public void deleteAccount(String accNum) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "DELETE FROM accounts WHERE acc_Num=?;";

        try {
            
            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

            smt.setString(1, accNum);
            
            smt.executeUpdate();

            smt.close();
            db.close();

        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
             db.close();   
            } catch (Exception e) {
                
            }           
        }
    } // end of delete Account method






    // Method to update/edit an account
    public void updateAccount(Account account) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "UPDATE accounts SET acc_Name=?, acc_IBAN=?, acc_Descr=? WHERE acc_Num=?";

        try {
            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

            smt.setString(1, account.getAccName());
            smt.setString(2, account.getAccIBAN());
            smt.setString(3, account.getAccDescr());
            smt.setString(4, account.getAccNum());

            smt.executeUpdate();

            smt.close();
            db.close();

        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
             db.close();   
            } catch (Exception e) {
                
            }           
        }
    } // end of update/edit account method





    // Method to create a new account
    public void insertAccount(Account account) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "INSERT INTO accounts (acc_Num, acc_Name, acc_IBAN, acc_Descr) VALUES (?,?,?,?);";

        try {

            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

            smt.setString(1, account.getAccNum());
            smt.setString(2, account.getAccName());
            smt.setString(3, account.getAccIBAN());
            smt.setString(4, account.getAccDescr());

            smt.executeUpdate();

            smt.close();
            db.close();

        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {

            }
        }
    } // End of insert new account method

    
}
