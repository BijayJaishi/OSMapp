package com.creatu_developer.pdsmart.model.notes_videos_model;

public class NotesModelClass {
    private String id;
    private String summary;
    private String notedescription;
    private String notetitle;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getNotedescription() {
        return notedescription;
    }

    public void setNotedescription(String notedescription) {
        this.notedescription = notedescription;
    }

    public String getNotetitle() {
        return notetitle;
    }

    public void setNotetitle(String notetitle) {
        this.notetitle = notetitle;
    }

    @Override
    public String toString() {
        return "NotesModelClass{" +
                "id='" + id + '\'' +
                ", summary='" + summary + '\'' +
                ", notedescription='" + notedescription + '\'' +
                ", notetitle='" + notetitle + '\'' +
                '}';
    }

    public NotesModelClass(String id, String summary, String notedescription, String notetitle) {
        this.id = id;
        this.summary = summary;
        this.notedescription = notedescription;
        this.notetitle = notetitle;
    }
}
