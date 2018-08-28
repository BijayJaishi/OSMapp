package com.creatu_developer.pdsmart;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.text.Html;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.creatu_developer.pdsmart.R;

import com.creatu_developer.pdsmart.dark_statusbar.DarkStatusBar;

public class DetailActivity extends AppCompatActivity {

    Toolbar toolbar;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);
        toolbar = findViewById(R.id.tool_bar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        WebView webview = findViewById(R.id.pkg_desc);
        final ProgressBar progressBar = findViewById(R.id.progressBar);
        String title = getIntent().getExtras().getString("title");
        String desc = getIntent().getExtras().getString("desc");

        getSupportActionBar().setTitle(Html.fromHtml(title).toString().trim());


        // Dark Status Bar for Marshmallow

        Window window = getWindow();
        View view = window.getDecorView();
        DarkStatusBar.setLightStatusBar(view,this);


        webview.getSettings().setJavaScriptEnabled(true);
        webview.getSettings().setBuiltInZoomControls(true);
        webview.getSettings().setDisplayZoomControls(false);

        webview.loadUrl("http://docs.google.com/gview?embedded=true&url=" + "http://pdsmarteducation.com/uploads/notes/"+Html.fromHtml(desc).toString().trim());

        webview.setScrollbarFadingEnabled(true); // Explicitly, however it's a default, I think.
        webview.setScrollBarStyle(WebView.SCROLLBARS_INSIDE_OVERLAY);

        webview.setWebViewClient(new WebViewClient() {

            public void onPageFinished(WebView view, String url){
                // do your stuff here
                progressBar.setVisibility(View.GONE);
            }
        });




    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()){
            case android.R.id.home:
                finish();
                break;
        }
        return super.onOptionsItemSelected(item);
    }
}
