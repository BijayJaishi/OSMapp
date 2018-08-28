package com.creatu_developer.pdsmart.model.unlock_package;

public class UnlockMessageClass {
    private String message;

    private String pamount;

    private String esewaAmount;

    public String getMessage ()
    {
        return message;
    }

    public void setMessage (String message)
    {
        this.message = message;
    }

    public String getPamount ()
    {
        return pamount;
    }

    public void setPamount (String pamount)
    {
        this.pamount = pamount;
    }


    public String getEsewaAmount ()
    {
        return esewaAmount;
    }

    public void setEsewaAmount (String esewaAmount)
    {
        this.esewaAmount = esewaAmount;
    }

    @Override
    public String toString()
    {
        return "ClassPojo [message = "+message+", pamount = "+pamount+", esewaAmount = "+esewaAmount+"]";
    }
}
