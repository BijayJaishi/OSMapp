package com.creatu_developer.pdsmart.model.package_model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.List;

public class PackageModelClass {

    private String response_time;

    @SerializedName("results")
    @Expose
    private List<PackageData> packageDataList;

    public List<PackageData> getPackageDataList() {
        return packageDataList;
    }

    public void setPackageDataList(List<PackageData> packageDataList) {
        this.packageDataList = packageDataList;
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

    @Override
    public String toString()
    {
        return "ClassPojo [response_time = "+response_time+", results = "+packageDataList+", status = "+status+"]";
    }

}
