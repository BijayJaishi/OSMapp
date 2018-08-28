package com.creatu_developer.pdsmart.model.academic_model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.List;

public class AcademicModelClass {

    private String response_time;

    @SerializedName("results")
    @Expose
    private List<AcademicResults> academicResultsList;

    public List<AcademicResults> getAcademicResultsList() {
        return academicResultsList;
    }

    public void setAcademicResultsList(List<AcademicResults> academicResultsList) {
        this.academicResultsList = academicResultsList;
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
        return "ClassPojo [response_time = "+response_time+", results = "+academicResultsList+", status = "+status+"]";
    }

}
