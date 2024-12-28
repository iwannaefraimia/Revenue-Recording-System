package omadiki5;


import java.math.BigDecimal;



public class Asset {


    // Variables 
    private int assetID;
    private String assetName;
    private String assetDescr;
    private BigDecimal assetTotalTimima;
    private int assetCatID;
    



    // Constructors
    public Asset(int assetID, String assetName, String assetDescr, BigDecimal assetTotalTimima, int assetCatID) {
        this.assetID = assetID;
        this.assetName = assetName;
        this.assetDescr = assetDescr;
        this.assetTotalTimima = assetTotalTimima;
        this.assetCatID = assetCatID;
    }

    public Asset(String assetName, String assetDescr, BigDecimal assetTotalTimima, int assetCatID) {
        this.assetName = assetName;
        this.assetDescr = assetDescr;
        this.assetTotalTimima = assetTotalTimima;
        this.assetCatID = assetCatID;
    }

    public Asset(int assetID, String assetName) {
        this.assetID = assetID;
        this.assetName = assetName;
    }

    public Asset(int assetID, int assetCatID) {
        this.assetID = assetID;
        this.assetCatID = assetCatID;
    }






    // Getters & Setters
    public int getAssetID() {
        return assetID;
    }

    public void setAssetID(int assetID) {
        this.assetID = assetID;
    }

    public String getAssetName() {
        return assetName;
    }

    public void setAssetName(String assetName) {
        this.assetName = assetName;
    }

    public String getAssetDescr() {
        return assetDescr;
    }

    public void setAssetDescr(String assetDescr) {
        this.assetDescr = assetDescr;
    }

    public BigDecimal getAssetTotalTimima() {
        return assetTotalTimima;
    }

    public void setAssetTotalTimima(BigDecimal assetTotalTimima) {
        this.assetTotalTimima = assetTotalTimima;
    }

    public int getAssetCatID() {
        return assetCatID;
    }

    public void setAssetCatID(int assetCatID) {
        this.assetCatID = assetCatID;
    }

}
