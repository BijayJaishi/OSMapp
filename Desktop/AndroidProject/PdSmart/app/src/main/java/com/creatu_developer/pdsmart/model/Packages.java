package com.creatu_developer.pdsmart.model;

public class Packages
{
    private String summary;

    private String pslug;

    private String pdescription;

    private String auto_renew;

    private String image;

    private String pds_type;

    private String category_id;

    private String pamount;

    private String id;

    private String updated_at;

    private String pname;

    private String created_at;

    private String ptype_id;

    private String pactive;

    public String getSummary ()
    {
        return summary;
    }

    public void setSummary (String summary)
    {
        this.summary = summary;
    }

    public String getPslug ()
    {
        return pslug;
    }

    public void setPslug (String pslug)
    {
        this.pslug = pslug;
    }

    public String getPdescription ()
    {
        return pdescription;
    }

    public void setPdescription (String pdescription)
    {
        this.pdescription = pdescription;
    }

    public String getAuto_renew ()
    {
        return auto_renew;
    }

    public void setAuto_renew (String auto_renew)
    {
        this.auto_renew = auto_renew;
    }


    public String getImage ()
    {
        return image;
    }

    public void setImage (String image)
    {
        this.image = image;
    }

    public String getPds_type ()
    {
        return pds_type;
    }

    public void setPds_type (String pds_type)
    {
        this.pds_type = pds_type;
    }

    public String getCategory_id ()
    {
        return category_id;
    }

    public void setCategory_id (String category_id)
    {
        this.category_id = category_id;
    }

    public String getPamount ()
    {
        return pamount;
    }

    public void setPamount (String pamount)
    {
        this.pamount = pamount;
    }

    public String getId ()
    {
        return id;
    }

    public void setId (String id)
    {
        this.id = id;
    }

    public String getUpdated_at ()
    {
        return updated_at;
    }

    public void setUpdated_at (String updated_at)
    {
        this.updated_at = updated_at;
    }



    public String getPname ()
    {
        return pname;
    }

    public void setPname (String pname)
    {
        this.pname = pname;
    }

    public String getCreated_at ()
    {
        return created_at;
    }

    public void setCreated_at (String created_at)
    {
        this.created_at = created_at;
    }

    public String getPtype_id ()
    {
        return ptype_id;
    }

    public void setPtype_id (String ptype_id)
    {
        this.ptype_id = ptype_id;
    }

    public String getPactive ()
    {
        return pactive;
    }

    public void setPactive (String pactive)
    {
        this.pactive = pactive;
    }

    @Override
    public String toString()
    {
        return "ClassPojo [summary = "+summary+", pslug = "+pslug+", pdescription = "+pdescription+", auto_renew = "+auto_renew+", image = "+image+", pds_type = "+pds_type+", category_id = "+category_id+", pamount = "+pamount+", id = "+id+", updated_at = "+updated_at+", pname = "+pname+", created_at = "+created_at+", ptype_id = "+ptype_id+", pactive = "+pactive+"]";
    }
}
