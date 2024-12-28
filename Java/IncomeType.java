package omadiki5;


import java.sql.*;

public class IncomeType {


    // Variables 
    private int incomeTypeID;
    private String incomeTypeName;
    private String incomeTypeALE;
    



    // Constructors 
    public IncomeType(int incomeTypeID, String incomeTypeName, String incomeTypeALE) {
        this.incomeTypeID = incomeTypeID;
        this.incomeTypeName = incomeTypeName;
        this.incomeTypeALE = incomeTypeALE;
    }

    public IncomeType(String incomeTypeName, String incomeTypeALE) {
        this.incomeTypeName = incomeTypeName;
        this.incomeTypeALE = incomeTypeALE;
    }



    // Getters & Setters
    public int getIncomeTypeID() {
        return incomeTypeID;
    }

    public void setIncomeTypeID(int incomeTypeID) {
        this.incomeTypeID = incomeTypeID;
    }

    public String getIncomeTypeName() {
        return incomeTypeName;
    }

    public void setIncomeTypeName(String incomeTypeName) {
        this.incomeTypeName = incomeTypeName;
    }

    public String getIncomeTypeALE() {
        return incomeTypeALE;
    }

    public void setIncomeTypeALE(String incomeTypeALE) {
        this.incomeTypeALE = incomeTypeALE;
    }

}