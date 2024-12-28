package omadiki5;




public class Dosi {


    //Variables
    private int dosiID;
    private int dosiAsset;
    private double dosiAmount;
    private String dosiDescr;



    // Constructors
    public Dosi(int dosiID, int dosiAsset, double dosiAmount, String dosiDescr) {
        this.dosiID = dosiID;
        this.dosiAsset = dosiAsset;
        this.dosiAmount = dosiAmount;
        this.dosiDescr = dosiDescr;
    }

    


    // Getters & Setters

    public int getDosiID() {
        return dosiID;
    }

    public void setDosiID(int dosiID) {
        this.dosiID = dosiID;
    }

    public int getDosiAsset() {
        return dosiAsset;
    }

    public void setDosiAsset(int dosiAsset) {
        this.dosiAsset = dosiAsset;
    }

    public double getDosiAmount() {
        return dosiAmount;
    }

    public void setDosiAmount(double dosiAmount) {
        this.dosiAmount = dosiAmount;
    }

    public String getDosiDescr() {
        return dosiDescr;
    }

    public void setDosiDescr(String dosiDescr) {
        this.dosiDescr = dosiDescr;
    }

}
