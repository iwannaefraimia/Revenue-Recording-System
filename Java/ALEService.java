package omadiki5;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;



public class ALEService {


    // Method to return all the available ALEs.
    public List<ALE> getALEs() throws Exception {

        List<ALE> ales = new ArrayList<ALE>();

        DB db = new DB();
        Connection con = null;
        String query = "SELECT * FROM ale;";

        try {

            con = db.getConnection();

            PreparedStatement stmt = con.prepareStatement(query);
            
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                ales.add( new ALE(
                                   rs.getString("ale_Num"), 
                                   rs.getString("ale_Descr"), 
                                   rs.getString("ale_OldKAE")));
            }

            rs.close();
            stmt.close();
            db.close();

            return ales;

        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();    
            } catch (Exception e) {
                
            }
        }
    } // End of getALEs method




    // Method to return a specific ALE in given aleNum.
    public ALE findALE(String aleNum) throws Exception {
       
        DB db = new DB();
        Connection con = null;
        String query = "SELECT * FROM ale WHERE ale_Num=?;";

        try {

            con = db.getConnection();

            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, aleNum);
            
            ResultSet rs = stmt.executeQuery();
            
            if (!rs.next()) {
               
                rs.close();
                stmt.close();
                return null;               
            }
            
            return new ALE(
                            rs.getString("ale_Num"), 
                            rs.getString("ale_Descr"), 
                            rs.getString("ale_OldKAE"));

        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();    
            } catch (Exception e) {
                
            }
        }   
    } // End of findALE method





    // Method to delete an ALE    
    public void deleteALE(String ALENum) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "DELETE FROM ale where ale_Num=?;";

        try {
            
            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

            smt.setString(1, ALENum);            
            
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
    }  // end of deleteALE method






    // Method to update/edit an ALE
    public void updateALE(ALE ale) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "UPDATE ale SET ale_Descr=?, ale_OldKAE=? WHERE ale_Num=?;";

        try {
            
            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

            smt.setString(1, ale.getALEDescr());
            smt.setString(2, ale.getALEOldKAE());
            smt.setString(3, ale.getALENum());

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
    }  // end of update/edit ALE method





    // Method to create a new ALE
    public void insertALE(ALE ale) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "INSERT INTO ale (ale_Num, ale_Descr, ale_OldKAE) VALUES (?,?,?);";

        try {

            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

            smt.setString(1, ale.getALENum());
            smt.setString(2, ale.getALEDescr());
            smt.setString(3, ale.getALEOldKAE());


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
    } // End of insert new ALE method


}
