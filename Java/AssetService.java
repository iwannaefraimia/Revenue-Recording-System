package omadiki5;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;



public class AssetService {


    // Returns all available assets.
    public List<Asset> getAssets() throws Exception {

        List<Asset> assets = new ArrayList<Asset>();

        DB db = new DB();
        Connection con = null;
        String query = "SELECT * FROM assets;";

        try {

            con = db.getConnection();

            PreparedStatement stmt = con.prepareStatement(query);
            // skipping setting parameters (do not need)
            
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                assets.add( new Asset(
                                    rs.getInt("asset_ID"), 
                                    rs.getString("asset_Name"), 
                                    rs.getString("asset_Descr"),
                                    rs.getBigDecimal("asset_TotalTimima"),
                                    rs.getInt("asset_CatID")) );
            }

            rs.close();
            stmt.close();
            db.close();

            return assets;

            
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();    
            } catch (Exception e) {
                
            }
        }
    } // End of getAssets




    // Returns the asset name for the specified asset ID.
    public String getAssetNameById(int assetID) throws Exception {
        
        DB db = new DB();
        Connection con = null;
        String query = "SELECT asset_Name FROM assets WHERE asset_ID = ?;";

        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setInt(1, assetID);
            
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getString("asset_Name");
            } else {
                throw new Exception("Asset not found for ID: " + assetID);
            }
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();
            } catch (Exception e) {
                // handle close exception
            }
        }
    } // End of getAssetNameById




    // Method to delete a specific asset
    public void deleteAsset(int assetID) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "DELETE FROM assets WHERE asset_ID=?;";

        try {
            
            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

            // setting parameters
            smt.setInt(1, assetID);
            
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
    } // End of deleteAsset




    // method to update an asset's infos 
    public void updateAsset(Asset asset) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "UPDATE assets SET asset_Name=?, asset_Descr=?, asset_TotalTimima=?, asset_CatID=? WHERE asset_ID=?";

        try {
            
            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

            // setting parameters            
            smt.setString(1, asset.getAssetName());
            smt.setString(2, asset.getAssetDescr());
            smt.setBigDecimal(3, asset.getAssetTotalTimima());
            smt.setInt(4, asset.getAssetCatID());
            smt.setInt(5, asset.getAssetID());
            
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
    } // End of updateAsset 




    



    // method to find all assets based on given criteria
    public List<Asset> findAssets(String assetCatID, BigDecimal timimaMin, BigDecimal timimaMax) throws Exception {
        List<Asset> assetsFound = new ArrayList<>();

        DB db = new DB();
        Connection con = null;
        
        try {
            // the expression 1=1 means (since it is always true) to show all the available records! 
            String sql = "SELECT * FROM assets LEFT JOIN assetcats on assets.asset_CatID=assetcats.assetcat_ID WHERE 1=1";
            
                // conditional parameters in the sql query
                int parameterIndex = 1;
                
                if (assetCatID == null || assetCatID.isEmpty()) {
                    }else{
                    sql += " AND assets.asset_CatID = ?";
                    }

                if (timimaMin != null) {
                    sql += " AND assets.asset_TotalTimima >= ?";
                }

                if (timimaMax != null) {
                    sql += " AND assets.asset_TotalTimima <= ?";
                }

            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

                // conditional parameters in prepearedstatement smt
                if (assetCatID == null || assetCatID.isEmpty()) {
                    }else{
                    smt.setString(parameterIndex++, assetCatID);
                    }

                if (timimaMin != null) {
                    smt.setBigDecimal(parameterIndex++, timimaMin);
                }

                if (timimaMax != null) {
                    smt.setBigDecimal(parameterIndex++, timimaMax);
                }


            ResultSet rs = smt.executeQuery();


            while (rs.next()) {
                Asset asset = new Asset(0, "", "", BigDecimal.ZERO, 0);
    
                asset.setAssetID(rs.getInt("assets.asset_ID"));
                asset.setAssetName(rs.getString("assets.asset_Name"));
                asset.setAssetDescr(rs.getString("assets.asset_Descr"));
                asset.setAssetTotalTimima(rs.getBigDecimal("assets.asset_TotalTimima"));
                asset.setAssetCatID(rs.getInt("assets.asset_CatID"));
    
                assetsFound.add(asset);
            }
    
            rs.close();
            smt.close();
            db.close();

        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
             db.close();   
            } catch (Exception e) {
                e.printStackTrace();
            }           
            
        }
        return assetsFound;
    } // end of findAssets



    // Method to return a specific asset in given assetID.
    public Asset findAsset(int assetID) throws Exception {
       
        DB db = new DB();
        Connection con = null;
        String query = "SELECT * FROM assets WHERE asset_ID=?;";

        try {

            con = db.getConnection();

            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setInt(1, assetID);
            
            ResultSet rs = stmt.executeQuery();
            
            if (!rs.next()) {
               
                rs.close();
                stmt.close();
                return null;               
            }
            
            return new Asset(
                            rs.getInt("assets.asset_ID"),
                            rs.getString("assets.asset_Name"),
                            rs.getString("assets.asset_Descr"),
                            rs.getBigDecimal("assets.asset_TotalTimima"),
                            rs.getInt("assets.asset_CatID"));

        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();    
            } catch (Exception e) {
            
            }
            
        }   

    } // End of findAsset





    // Method to create a new asset
    public void insertAsset(Asset asset) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "INSERT INTO assets (asset_Name, asset_Descr, asset_TotalTimima, asset_CatID) VALUES (?,?,?,?);";

        try {

            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

            smt.setString(1, asset.getAssetName());
            smt.setString(2, asset.getAssetDescr());
            smt.setBigDecimal(3, asset.getAssetTotalTimima());
            smt.setInt(4, asset.getAssetCatID());

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
    } // End of insert new asset method

}
