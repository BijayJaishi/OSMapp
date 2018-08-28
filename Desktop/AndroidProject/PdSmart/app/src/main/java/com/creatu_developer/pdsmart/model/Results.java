package com.creatu_developer.pdsmart.model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.List;

public class Results
{
    @SerializedName("body")
    @Expose
    private List<Body> body;

    public List<Body> getBody() {
        return body;
    }

    public void setBody(List<Body> body) {
        this.body = body;
    }

    @SerializedName("carousels")
    @Expose
    private List<Carousels> carousels;

    public List<Carousels> getCarousels() {
        return carousels;
    }

    public void setCarousels(List<Carousels> carousels) {
        this.carousels = carousels;
    }

    @Override
    public String toString()
    {
        return "ClassPojo [body = "+body+", carousels = "+carousels+"]";
    }
}
