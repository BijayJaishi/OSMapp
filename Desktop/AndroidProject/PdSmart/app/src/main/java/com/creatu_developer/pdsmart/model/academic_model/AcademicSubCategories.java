package com.creatu_developer.pdsmart.model.academic_model;

public class AcademicSubCategories {

    private String id;



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
        return "ClassPojo [id = "+id+", description = "+description+", name = "+name+", slug = "+slug+"]";
    }

}
