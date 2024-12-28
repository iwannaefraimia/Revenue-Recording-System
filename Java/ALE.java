package omadiki5;




public class ALE {


    //Variables
    private String aleNum;
    private String aleDescr;
    private String aleOldKAE;
    



    // Constructors
    public ALE(String aleNum, String aleDescr, String aleOldKAE) {
        this.aleNum = aleNum;
        this.aleDescr = aleDescr;
        this.aleOldKAE = aleOldKAE;
    }

    




    // Getters & Setters

    public String getALENum() {
        return aleNum;
    }

    public void setALENum(String aleNum) {
        this.aleNum = aleNum;
    }

    public String getALEDescr() {
        return aleDescr;
    }

    public void setALEDescr(String aleDescr) {
        this.aleDescr = aleDescr;
    }

    public String getALEOldKAE() {
        return aleOldKAE;
    }

    public void setALEOldKAE(String aleOldKAE) {
        this.aleOldKAE = aleOldKAE;
    }

}
