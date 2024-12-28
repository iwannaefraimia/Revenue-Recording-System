package omadiki5;




public class Account {


    // Variables
    private String accNum;
    private String accName;
    private String accIBAN;
    private String accDescr;
    



    // Constructors
    public Account(String accNum, String accName, String accIBAN, String accDescr) {
        this.accNum = accNum;
        this.accName = accName;
        this.accIBAN = accIBAN;
        this.accDescr = accDescr;
    }




    // Getters & Setters

    public String getAccNum() {
        return accNum;
    }

    public void setAccNum(String accNum) {
        this.accNum = accNum;
    }

    public String getAccName() {
        return accName;
    }

    public void setAccName(String accName) {
        this.accName = accName;
    }

    public String getAccIBAN() {
        return accIBAN;
    }

    public void setAccIBAN(String accIBAN) {
        this.accIBAN = accIBAN;
    }

    public String getAccDescr() {
        return accDescr;
    }

    public void setAccDescr(String accDescr) {
        this.accDescr = accDescr;
    }
}
