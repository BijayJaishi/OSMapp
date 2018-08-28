package com.creatu_developer.pdsmart.model.notes_videos_model;

public class VideosModelClass {

    private String video;
    private String videodescription;

    @Override
    public String toString() {
        return "VideosModelClass{" +
                "video='" + video + '\'' +
                ", videodescription='" + videodescription + '\'' +
                '}';
    }

    public String getVideodescription() {
        return videodescription;
    }

    public void setVideodescription(String videodescription) {
        this.videodescription = videodescription;
    }

    public String getVideo() {
        return video;
    }

    public void setVideo(String video) {
        this.video = video;
    }
}
