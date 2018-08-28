package com.creatu_developer.pdsmart.model.academic_model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.List;

public class AcademicResults {
    private String id;

    @SerializedName("sub_categories")
    @Expose
    private List<AcademicSubCategories> sub_categories;

    public List<AcademicSubCategories> getSub_categories() {
        return sub_categories;
    }

    public void setSub_categories(List<AcademicSubCategories> sub_categories) {
        this.sub_categories = sub_categories;
    }

    private String description;

    private String name;

    private String slug;

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }



    public String getDescription ()
    {
        return description;
    }

    public void setDescription (String description)
    {
        this.description = description;
    }

    public String getName ()
    {
        return name;
    }

    public void setName (String name)
    {
        this.name = name;
    }

    public String getSlug ()
    {
        return slug;
    }

    public void setSlug (String slug)
    {
        this.slug = slug;
    }

    @Override
    public String toString()
    {
        return "ClassPojo [id = "+id+", sub_categories = "+sub_categories+", description = "+description+", name = "+name+", slug = "+slug+"]";
    }
}
