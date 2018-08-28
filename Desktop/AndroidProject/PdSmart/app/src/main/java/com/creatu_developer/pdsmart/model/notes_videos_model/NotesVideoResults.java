package com.creatu_developer.pdsmart.model.notes_videos_model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.List;

public class NotesVideoResults {
    private int buy;


    @SerializedName("videos")
    @Expose
    public List<VideosModelClass> videosModelClassList;

    @SerializedName("notes")
    @Expose
    public List<NotesModelClass> notesModelClassList;


    @SerializedName("questions")
    @Expose
    public List<QandAModelClass> QandModelClassList;

    @Override
    public String toString() {
        return "NotesVideoResults{" +
                "buy=" + buy +
                ", videosModelClassList=" + videosModelClassList +
                ", notesModelClassList=" + notesModelClassList +
                ", QandModelClassList=" + QandModelClassList +
                '}';
    }

    public List<VideosModelClass> getVideosModelClassList() {
        return videosModelClassList;
    }

    public void setVideosModelClassList(List<VideosModelClass> videosModelClassList) {
        this.videosModelClassList = videosModelClassList;
    }

    public List<NotesModelClass> getNotesModelClassList() {
        return notesModelClassList;
    }

    public void setNotesModelClassList(List<NotesModelClass> notesModelClassList) {
        this.notesModelClassList = notesModelClassList;
    }

    public List<QandAModelClass> getQandModelClassList() {
        return QandModelClassList;
    }

    public void setQandModelClassList(List<QandAModelClass> qandModelClassList) {
        QandModelClassList = qandModelClassList;
    }




    public int getBuy ()
    {
        return buy;
    }

    public void setBuy (int buy)
    {
        this.buy = buy;
    }

}
