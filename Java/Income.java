package omadiki5;

import java.sql.Date;
import java.math.BigDecimal;



public class Income {


    //Variables 
    private int incomeID;
    private Date incomeDateKatath;
    private Date incomeDateTaiped;
    private BigDecimal incomeAmount;
    private String incomeDosi;
    private String incomeDescr;
    private String incomeSAP;
    private String incomeAccount;
    private int incomeAssetCat;
    private int incomeAsset;
    private int incomeIncomeType;
    private String incomeIncomeTypeName;




    // Constructors
    
    // full constructor
    public Income(
                int incomeID,
                Date incomeDateKatath, 
                Date incomeDateTaiped, 
                BigDecimal incomeAmount,
                String incomeDosi, 
                String incomeDescr, 
                String incomeSAP, 
                String incomeAccount, 
                int incomeAsset, 
                int incomeIncomeType) {

        this.incomeID = incomeID;
        this.incomeDateKatath = incomeDateKatath;
        this.incomeDateTaiped = incomeDateTaiped;
        this.incomeAmount = incomeAmount;
        this.incomeDosi = incomeDosi;
        this.incomeDescr = incomeDescr;
        this.incomeSAP = incomeSAP;
        this.incomeAccount = incomeAccount;
        this.incomeAsset = incomeAsset;
        this.incomeIncomeType = incomeIncomeType;
    }

    // default constructor (no ID, as it is auto-increment)
    public Income(
                Date incomeDateKatath, 
                Date incomeDateTaiped, 
                BigDecimal incomeAmount,
                String incomeDosi, 
                String incomeDescr, 
                String incomeSAP, 
                String incomeAccount, 
                int incomeAsset, 
                int incomeIncomeType) {
        
        this.incomeDateKatath = incomeDateKatath;
        this.incomeDateTaiped = incomeDateTaiped;
        this.incomeAmount = incomeAmount;
        this.incomeDosi = incomeDosi;
        this.incomeDescr = incomeDescr;
        this.incomeSAP = incomeSAP;
        this.incomeAccount = incomeAccount;
        this.incomeAsset = incomeAsset;
        this.incomeIncomeType = incomeIncomeType;
    }

    // search constructor (+ assetcatID for search form use)
    public Income(
                int incomeID,
                Date incomeDateKatath, 
                Date incomeDateTaiped, 
                BigDecimal incomeAmount,
                String incomeDosi, 
                String incomeDescr, 
                String incomeSAP, 
                String incomeAccount, 
                int incomeAssetCat, 
                int incomeAsset, 
                int incomeIncomeType) {

        this.incomeID = incomeID;
        this.incomeDateKatath = incomeDateKatath;
        this.incomeDateTaiped = incomeDateTaiped;
        this.incomeAmount = incomeAmount;
        this.incomeDosi = incomeDosi;
        this.incomeDescr = incomeDescr;
        this.incomeSAP = incomeSAP;
        this.incomeAccount = incomeAccount;
        this.incomeAssetCat = incomeAssetCat;
        this.incomeAsset = incomeAsset;
        this.incomeIncomeType = incomeIncomeType;
        }







    // Getters & setters 
    public int getIncomeID() {
        return incomeID;
    }

    public void setIncomeID(int incomeID) {
        this.incomeID = incomeID;
    }

    public Date getIncomeDateKatath() {
        return incomeDateKatath;
    }

    public void setIncomeDateKatath(Date incomeDateKatath) {
        this.incomeDateKatath = incomeDateKatath;
    }

    public Date getIncomeDateTaiped() {
        return incomeDateTaiped;
    }

    public void setIncomeDateTaiped(Date incomeDateTaiped) {
        this.incomeDateTaiped = incomeDateTaiped;
    }

    public BigDecimal getIncomeAmount() {
        return incomeAmount;
    }

    public void setIncomeAmount(BigDecimal incomeAmount) {
        this.incomeAmount = incomeAmount;
    }

    public String getIncomeDosi() {
        return incomeDosi;
    }

    public void setIncomeDosi(String incomeDosi) {
        this.incomeDosi = incomeDosi;
    }

    public String getIncomeDescr() {
        return incomeDescr;
    }

    public void setIncomeDescr(String incomeDescr) {
        this.incomeDescr = incomeDescr;
    }

    public String getIncomeSAP() {
        return incomeSAP;
    }

    public void setIncomeSAP(String incomeSAP) {
        this.incomeSAP = incomeSAP;
    }

    public String getIncomeAccount() {
        return incomeAccount;
    }

    public void setIncomeAccount(String incomeAccount) {
        this.incomeAccount = incomeAccount;
    }

    public int getIncomeAssetCat() {
        return incomeAssetCat;
    }

    public void setIncomeAssetCat(int incomeAssetCat) {
        this.incomeAssetCat = incomeAssetCat;
    }

    public int getIncomeAsset() {
        return incomeAsset;
    }

    public void setIncomeAsset(int incomeAsset) {
        this.incomeAsset = incomeAsset;
    }
    
    public int getIncomeIncomeType() {
        return incomeIncomeType;
    }

    public void setIncomeIncomeType(int incomeIncomeType) {
        this.incomeIncomeType = incomeIncomeType;
    }

    public String getIncomeTypeName() {
        return incomeIncomeTypeName;
    }

    public void setIncomeTypeName(String incomeIncomeTypeName) {
        this.incomeIncomeTypeName = incomeIncomeTypeName;
    }

}