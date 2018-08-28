package com.creatu_developer.pdsmart.innerpage;

import android.media.MediaPlayer;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.text.Html;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.widget.MediaController;
import android.widget.ProgressBar;
import android.widget.VideoView;


import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.dark_statusbar.DarkStatusBar;

public class VideoActivity extends AppCompatActivity {

    private VideoView player;
    ProgressBar progressBar;
    MediaController mediaController;

    String title,videoUrl;
    Toolbar toolbar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_video);
        player = findViewById(R.id.videoView);
        progressBar = findViewById(R.id.progressBar);

        toolbar = findViewById(R.id.tool_bar);

        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);


        // Dark Status Bar for Marshmallow

        Window window = getWindow();
        View view = window.getDecorView();
        DarkStatusBar.setLightStatusBar(view,this);

        mediaController= new MediaController(this);

        title = getIntent().getExtras().getString("title");
        videoUrl = getIntent().getExtras().getString("video");

        getSupportActionBar().setTitle(Html.fromHtml(title).toString().trim());



        play();
    }

    public void play(){
        Uri uri = Uri.parse("http://pdsmarteducation.com/uploads/videos/"+Html.fromHtml(videoUrl).toString().trim());

        player.setVideoURI(uri);

        player.setMediaController(mediaController);

        mediaController.setAnchorView(player);

        player.start();

        progressBar.setVisibility(View.VISIBLE);

        player.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
            @Override
            public void onPrepared(MediaPlayer mp) {
                mp.start();

                mp.setOnInfoListener(new MediaPlayer.OnInfoListener() {
                    @Override
                    public boolean onInfo(MediaPlayer mp, int what, int extra) {
                        switch (what) {
                            case MediaPlayer.MEDIA_INFO_VIDEO_RENDERING_START: {
                                progressBar.setVisibility(View.GONE);
                                return true;
                            }
                            case MediaPlayer.MEDIA_INFO_BUFFERING_START: {
                                progressBar.setVisibility(View.VISIBLE);
                                return true;
                            }
                            case MediaPlayer.MEDIA_INFO_BUFFERING_END: {
                                progressBar.setVisibility(View.GONE);
                                return true;
                            }
                        }
                        return false;
                    }
                });
//                mediaPlayer.setOnVideoSizeChangedListener(new MediaPlayer.OnVideoSizeChangedListener() {
//                    @Override
//                    public void onVideoSizeChanged(MediaPlayer mediaPlayer, int i, int i1) {
//                        progressBar.setVisibility(View.GONE);
//                        mediaPlayer.start();
//                    }
//                });
            }
        });


    }

    @Override
    protected void onPause() {
        super.onPause();
        player.pause();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        player.stopPlayback();
    }

    @Override
    protected void onResume() {
        super.onResume();
        player.resume();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        switch (item.getItemId()){
            case android.R.id.home:
                finish();
                player.pause();
                break;
        }
        return super.onOptionsItemSelected(item);
    }

}
