package omadiki5;




public class AssetCat {


    //Variables
    private int assetCatID;
    private String assetCatName;
    



    // Constructors
    public AssetCat(int assetCatID, String assetCatName) {
        this.assetCatID = assetCatID;
        this.assetCatName = assetCatName;
    }

    public AssetCat(String assetCatName) {
        this.assetCatName = assetCatName;
    }




    // Getters & Setters

    public int getAssetCatID() {
        return assetCatID;
    }

    public void setAssetCatID(int assetCatID) {
        this.assetCatID = assetCatID;
    }

    public String getAssetCatName() {
        return assetCatName;
    }

    public void setAssetCatName(String assetCatName) {
        this.assetCatName = assetCatName;
    }
}
