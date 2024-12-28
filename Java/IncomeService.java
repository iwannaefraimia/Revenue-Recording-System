package omadiki5;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;


public class IncomeService {


    // method to find all incomes based on given criteria
    public List<Income> findIncomes(Date dateFrom, Date dateTo, BigDecimal amountMin, String account, String assetcat, String asset, String incometype, String sap) throws Exception {
        List<Income> incomesFound = new ArrayList<>();

        DB db = new DB();
        Connection con = null;
        
        try {
            // the expression 1=1 means (since it is always true) to show all the available records! 
            String sql = "SELECT * FROM incomes " + 
                        "LEFT JOIN accounts on incomes.income_AccID=accounts.acc_Num " + 
                        "LEFT JOIN assets on incomes.income_AssetID=assets.asset_ID " + 
                        "LEFT JOIN incometypes on incomes.income_IncomeType=incometypes.incometype_ID " + 
                        "WHERE 1=1";
            

                // conditional parameters in the sql query
                if (dateFrom == null) {
                }else{
                    sql += " AND income_DateKatath >= ?";
                }
                
                if (dateTo == null) {
                }else{
                    sql += " AND income_DateKatath <= ?";
                }
                
                if (amountMin == null) {
                }else{
                    sql += " AND income_AmountDeposit >= ?";
                }

                if (account.equals("") || account == null || account.isEmpty()) {
                    }else{
                    sql += " AND income_AccID = ?";
                }

                if (incometype.equals("") || incometype == null || incometype.isEmpty()) {
                    }else{
                    sql += " AND income_IncomeType = ?";
                }

                if (sap.equals("") || sap == null || sap.isEmpty()) {
                    }else{
                    sql += " AND income_SAP = ?";
                }

                // Asset & AssetCat handling! 
                // Both Asset & AssetCat are empty. 
                if (assetcat.equals("") && asset.equals("")) {
                // AssetCat has value, but Asset is empty. 
                } else if (!assetcat.equals("") && asset.equals("")) {
                    sql += " AND assets.asset_CatID = ?";
                // Both Asset & AssetCat have values   OR   Asset has value, but AssetCat is empty.
                } else if ((!asset.equals("") && !assetcat.equals("")) || (!asset.equals("") && assetcat.equals(""))) {
                    sql += " AND incomes.income_AssetID = ?";
                }




            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

                int parameterIndex = 1;

                // conditional parameters in prepearedstatement smt
                if (dateFrom == null) {
                }else{
                    smt.setDate(parameterIndex++, dateFrom);
                }
                
                if (dateTo == null) {
                }else{
                    smt.setDate(parameterIndex++, dateTo);
                }
                
                if (amountMin == null) {
                }else{
                    smt.setBigDecimal(parameterIndex++, amountMin);
                }

                if (account.equals("") || account == null || account.isEmpty()) {
                    }else{
                    smt.setString(parameterIndex++, account);
                    }

                if (incometype.equals("") || incometype == null || incometype.isEmpty()) {
                    }else{
                    int incometypeID = Integer.parseInt(incometype);
                    smt.setInt(parameterIndex++, incometypeID);
                    }

                if (sap.equals("") || sap == null || sap.isEmpty()) {
                    }else{
                    smt.setString(parameterIndex++, sap);
                    }


                // Asset & AssetCat handling! 
                // Both Asset & AssetCat are empty. 
                if (assetcat.equals("") && asset.equals("")) {
                // AssetCat has value, but Asset is empty. 
                } else if (!assetcat.equals("") && asset.equals("")) {
                    int assetcatID = Integer.parseInt(assetcat);
                    smt.setInt(parameterIndex++, assetcatID);
                // Both Asset & AssetCat have values   OR   Asset has value, but AssetCat is empty.
                } else if ((!asset.equals("") && !assetcat.equals("")) || (!asset.equals("") && assetcat.equals(""))) {
                    int assetID = Integer.parseInt(asset);
                    smt.setInt(parameterIndex++, assetID);
                }





            ResultSet rs = smt.executeQuery();


            while (rs.next()) {
                Asset assetFound = new Asset(-1, 0);
                
                assetFound.setAssetID(rs.getInt("assets.asset_ID"));
                assetFound.setAssetCatID(rs.getInt("assets.asset_CatID"));


                Income incomeFound = new Income(-1, null, null, BigDecimal.ZERO, "", "", "", "", 0, 0, 0);
                
                incomeFound.setIncomeID(rs.getInt("incomes.income_ID"));
                incomeFound.setIncomeDateKatath(rs.getDate("incomes.income_DateKatath"));
                incomeFound.setIncomeDateTaiped(rs.getDate("incomes.income_DateTaiped"));
                incomeFound.setIncomeAmount(rs.getBigDecimal("incomes.income_AmountDeposit"));
                incomeFound.setIncomeDosi(rs.getString("incomes.income_Dosi_Etos"));
                incomeFound.setIncomeDescr(rs.getString("incomes.income_Descr"));
                incomeFound.setIncomeSAP(rs.getString("incomes.income_SAP"));
                incomeFound.setIncomeAccount(rs.getString("incomes.income_AccID"));
                incomeFound.setIncomeAssetCat(rs.getInt("assets.asset_CatID"));
                incomeFound.setIncomeAsset(rs.getInt("incomes.income_AssetID"));
                incomeFound.setIncomeIncomeType(rs.getInt("incomes.income_IncomeType"));

                incomesFound.add(incomeFound);
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
        return incomesFound;
    } // end of findIncomes






    // Method to return a specific income in given incomeID.
    public Income findIncome(int incomeID) throws Exception {
       
        DB db = new DB();
        Connection con = null;
        String query = "SELECT * FROM incomes WHERE income_ID=?;";

        try {

            con = db.getConnection();

            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setInt(1, incomeID);
            
            ResultSet rs = stmt.executeQuery();
            
            if (!rs.next()) {
               
                rs.close();
                stmt.close();
                return null;               
            }
            
            return new Income(
                            rs.getInt("incomes.income_ID"),
                            rs.getDate("incomes.income_DateKatath"),
                            rs.getDate("incomes.income_DateTaiped"),
                            rs.getBigDecimal("incomes.income_AmountDeposit"),
                            rs.getString("incomes.income_Dosi_Etos"),
                            rs.getString("incomes.income_Descr"),
                            rs.getString("incomes.income_SAP"),
                            rs.getString("incomes.income_AccID"),
                            rs.getInt("incomes.income_AssetID"),
                            rs.getInt("incomes.income_IncomeType"));
            
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();    
            } catch (Exception e) {
            
            }
        }   
    } // End of findIncome







    // method to insert new income records
    public void insertIncome(Income income) throws Exception {
        DB db = new DB();
        Connection con = null;
        String sql = "INSERT INTO incomes (income_DateKatath, income_DateTaiped, income_AmountDeposit, income_Dosi_Etos, income_Descr, income_SAP, income_AccID, income_AssetID, income_IncomeType) VALUES (?,?,?,?,?,?,?,?,?);";

        try {

            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

            smt.setDate(1, income.getIncomeDateKatath());
            smt.setDate(2, income.getIncomeDateTaiped());
            smt.setBigDecimal(3, income.getIncomeAmount());
            smt.setString(4, income.getIncomeDosi());
            smt.setString(5, income.getIncomeDescr());
            smt.setString(6, income.getIncomeSAP());
            smt.setString(7, income.getIncomeAccount());
            smt.setInt(8, income.getIncomeAsset());
            smt.setInt(9, income.getIncomeIncomeType());

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
    }



    private int getAssetIDFromRS(ResultSet rs) throws SQLException {
        return rs.getInt("assets.asset_ID");
    }



    public List<Income> findIncomesByAsset(int assetID) throws Exception {

        List<Income> incomes = new ArrayList<>();
        DB db = new DB();
        Connection con = null;
        String query = "SELECT * FROM incomes LEFT JOIN assets ON incomes.income_AssetID = assets.asset_ID LEFT JOIN incometypes ON incomes.income_IncomeType = incometypes.incometype_ID WHERE incomes.income_AssetID=?";

        try {

            con = db.getConnection();

            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setInt(1, assetID);
            
            ResultSet rs = stmt.executeQuery();
            

            while (rs.next()) {
                int assetIDFromRS = getAssetIDFromRS(rs);
                String assetNameFromRS = rs.getString("assets.asset_Name");
                Asset assetFound = new Asset(assetIDFromRS, assetNameFromRS);
                int assetIDForIncome = getAssetIDFromRS(rs);
    
                Income income = new Income(
                                        rs.getDate("incomes.income_DateKatath"),
                                        rs.getDate("incomes.income_DateTaiped"),
                                        rs.getBigDecimal("incomes.income_AmountDeposit"),
                                        rs.getString("incomes.income_Dosi_Etos"),
                                        rs.getString("incomes.income_Descr"),
                                        rs.getString("incomes.income_SAP"),
                                        rs.getString("incomes.income_AccID"),
                                        rs.getInt("incomes.income_IncomeType"),
                                        assetIDForIncome);
    
                // Set the income type name from the join
                income.setIncomeTypeName(rs.getString("incometypes.incometype_Name"));

                incomes.add(income);
            }
                
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        } finally {
            try {
                db.close();    
            } catch (Exception e) {
                
            }
            
        }   
        return incomes;
    }





    // method to update an income's record infos 
    public void updateIncome(Income income) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "UPDATE incomes SET income_DateKatath=?, income_DateTaiped=?, income_AmountDeposit=?, income_Dosi_Etos=?, income_Descr=?, income_SAP=?, income_AccID=?, income_AssetID=?, income_IncomeType=? WHERE income_ID=?";

        try {
            
            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);
            
            smt.setDate(1, income.getIncomeDateKatath());
            smt.setDate(2, income.getIncomeDateTaiped());
            smt.setBigDecimal(3, income.getIncomeAmount());
            smt.setString(4, income.getIncomeDosi());
            smt.setString(5, income.getIncomeDescr());
            smt.setString(6, income.getIncomeSAP());
            smt.setString(7, income.getIncomeAccount());
            smt.setInt(8, income.getIncomeAsset());
            smt.setInt(9, income.getIncomeIncomeType());
            smt.setInt(10, income.getIncomeID());
            
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
    } // End of updateIncome






    // Method to delete a specific income record
    public void deleteIncome(int incomeID) throws Exception {

        DB db = new DB();
        Connection con = null;
        String sql = "DELETE FROM incomes WHERE income_ID=?;";

        try {
            
            con = db.getConnection();
            PreparedStatement smt = con.prepareStatement(sql);

            // setting parameters
            smt.setInt(1, incomeID);
            
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
    } // End of delete method


}
