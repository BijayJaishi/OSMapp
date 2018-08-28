package com.creatu_developer.pdsmart.model.college_model;

 public class College
    {
        private String id;

        private String logo;

        private String updated_at;

        private String color_code;

        private String name;

        private String created_at;

        public String getId ()
        {
            return id;
        }

        public void setId (String id)
        {
            this.id = id;
        }

        public String getLogo ()
        {
            return logo;
        }

        public void setLogo (String logo)
        {
            this.logo = logo;
        }

        public String getUpdated_at ()
        {
            return updated_at;
        }

        public void setUpdated_at (String updated_at)
        {
            this.updated_at = updated_at;
        }

        public String getColor_code ()
        {
            return color_code;
        }

        public void setColor_code (String color_code)
        {
            this.color_code = color_code;
        }

        public String getName ()
        {
            return name;
        }

        public void setName (String name)
        {
            this.name = name;
        }

        public String getCreated_at ()
        {
            return created_at;
        }

        public void setCreated_at (String created_at)
        {
            this.created_at = created_at;
        }

        @Override
        public String toString()
        {
            return "ClassPojo [id = "+id+", logo = "+logo+", updated_at = "+updated_at+", color_code = "+color_code+", name = "+name+", created_at = "+created_at+"]";
        }
    }
