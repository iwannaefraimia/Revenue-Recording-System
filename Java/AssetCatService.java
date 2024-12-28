package omadiki5;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;



public class AssetCatService {


    // Method to return all the available asset categories.
        public List<AssetCat> getAssetCats() throws Exception {

        List<AssetCat> assetCats = new ArrayList<AssetCat>();

        DB db = new DB();
        Connection con = null;
        String query = "SELECT * FROM assetcats;";

        try {

            con = db.getConnection();

            PreparedStatement stmt = con.prepareStatement(query);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                assetCats.add( new AssetCat(
                                            rs.getInt("assetCat_ID"), 
                                            rs.getString("assetCat_Name")));
            }

            rs.close();
            stmt.close();
            db.close();

            return assetCats;

            
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();    
            } catch (Exception e) {
                
            }
        }
    } // End of getAssetCats




    // Method to return a specific asset category in given assetCatID.
    public AssetCat findAssetCat(String assetCatIDStr) throws Exception {
        
        DB db = new DB();
        Connection con = null;
        String query = "SELECT * FROM assetcats WHERE assetcat_ID=?;";

        try {

            con = db.getConnection();

            PreparedStatement stmt = con.prepareStatement(query);
            int assetCatID = Integer.parseInt(assetCatIDStr);
            stmt.setInt(1, assetCatID);
            
            ResultSet rs = stmt.executeQuery();
            
            if (!rs.next()) {
            
                rs.close();
                stmt.close();
                return null;               
            }
            
            return new AssetCat(
                                rs.getInt("assetcat_ID"), 
                                rs.getString("assetcat_Name"));
            
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();    
            } catch (Exception e) {
                
            }
        }   
    } // End of findAssetCat method







    // Method to delete an asset category
    public void deleteAssetCat(int assetCatID) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "DELETE FROM assetcats WHERE assetcat_ID=?;";

        try {
            
            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);
            
            smt.setInt(1, assetCatID);

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
    }  // end of delete asset category method






    // Method to update/edit an asset category
    public void updateAssetCat(AssetCat assetcat) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "UPDATE assetcats SET assetcat_Name=? WHERE assetcat_ID=?";

        try {
            
            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

            smt.setString(1, assetcat.getAssetCatName());
            smt.setInt(2, assetcat.getAssetCatID());

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
    }  // end of update/edit asset category method





    // Method to create a new asset category
    public void insertAssetCat(AssetCat assetCat) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "INSERT INTO assetcats (assetcat_Name) VALUES (?);";

        try {

            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

            smt.setString(1, assetCat.getAssetCatName());

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
    } // End of new asset category method


}
