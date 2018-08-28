package com.creatu_developer.pdsmart.model.unlock_package;

public class UnlockPackageModelClass {

    private String response_time;

    private UnlockMessageClass unlockMessageClass;

    @Override
    public String toString() {
        return "UnlockPackageModelClass{" +
                "response_time='" + response_time + '\'' +
                ", unlockMessageClass=" + unlockMessageClass +
                ", status='" + status + '\'' +
                '}';
    }

    public UnlockMessageClass getUnlockMessageClass() {
        return unlockMessageClass;
    }

    public void setUnlockMessageClass(UnlockMessageClass unlockMessageClass) {
        this.unlockMessageClass = unlockMessageClass;
    }

    private String status;

    public String getResponse_time ()
    {
        return response_time;
    }

    public void setResponse_time (String response_time)
    {
        this.response_time = response_time;
    }


    public String getStatus ()
    {
        return status;
    }

    public void setStatus (String status)
    {
        this.status = status;
    }

}
