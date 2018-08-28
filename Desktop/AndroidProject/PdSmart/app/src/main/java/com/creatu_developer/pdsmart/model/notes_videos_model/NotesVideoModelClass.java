package com.creatu_developer.pdsmart.model.notes_videos_model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class NotesVideoModelClass {
    private String response_time;

    @SerializedName("results")
    @Expose
    private NotesVideoResults notesVideoResults;

    public NotesVideoResults getNotesVideoResults() {
        return notesVideoResults;
    }

    public void setNotesVideoResults(NotesVideoResults notesVideoResults) {
        this.notesVideoResults = notesVideoResults;
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
        return "ClassPojo [response_time = "+response_time+", results = "+notesVideoResults+", status = "+status+"]";
    }
}
