package omadiki5;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;




public class IncomeTypeService {

    // Method to return all the available income types.
    public List<IncomeType> getIncomeTypes() throws Exception {

        List<IncomeType> incomeTypes = new ArrayList<IncomeType>();

        DB db = new DB();
        Connection con = null;
        String query = "SELECT * FROM incometypes;";

        try {

            con = db.getConnection();

            PreparedStatement stmt = con.prepareStatement(query);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                incomeTypes.add(new IncomeType(
                                            rs.getInt("incometype_ID"),
                                            rs.getString("incometype_Name"),
                                            rs.getString("incometype_ALE")));
            }

            rs.close();
            stmt.close();
            db.close();

            return incomeTypes;

        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {

            }
        }
    } // End of getIncomeTypes




    // Method to return a specific income type in given incometype ID.
    public IncomeType findIncomeType(String incomeTypeIDStr) throws Exception {
        
        DB db = new DB();
        Connection con = null;
        String query = "SELECT * FROM incometypes WHERE incometype_ID=?;";

        try {

            con = db.getConnection();

            PreparedStatement stmt = con.prepareStatement(query);
            int incomeTypeID = Integer.parseInt(incomeTypeIDStr);
            stmt.setInt(1, incomeTypeID);
            
            ResultSet rs = stmt.executeQuery();
            
            if (!rs.next()) {
            
                rs.close();
                stmt.close();
                return null;               
            }
            
            return new IncomeType(
                                rs.getInt("incometype_ID"),
                                rs.getString("incometype_Name"),
                                rs.getString("incometype_ALE"));

        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();    
            } catch (Exception e) {
                
            }
        }   
    } // End of findIncomeType method




    // Method to delete an income type
    public void deleteIncomeType(int incomeTypeID) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "DELETE FROM incometypes WHERE incometype_ID=?;";

        try {

            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

            smt.setInt(1, incomeTypeID);

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
    } // end of delete income types method





    // Method to update/edit an income type
    public void updateIncomeType(IncomeType incometype) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "UPDATE incometypes SET incometype_Name=?, incometype_ALE=? WHERE incometype_ID=?;";

        try {

            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

            smt.setString(1, incometype.getIncomeTypeName());
            smt.setString(2, incometype.getIncomeTypeALE());
            smt.setInt(3, incometype.getIncomeTypeID());
            
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
    }  // end of update/edit income type method




    // Method to create a new income type record
    public void insertIncomeType(IncomeType incomeType) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "INSERT INTO incometypes (incometype_Name, incometype_ALE) VALUES (?,?);";

        try {

            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

            smt.setString(1, incomeType.getIncomeTypeName());
            smt.setString(2, incomeType.getIncomeTypeALE());

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
    } // End of new income type method

}
