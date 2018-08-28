package com.crystalinfosys.restroapp.authentication;

import android.content.Intent;
import android.os.Build;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.WindowManager;

import com.crystalinfosys.restroapp.MainActivity;
import com.crystalinfosys.restroapp.R;
import com.crystalinfosys.restroapp.view_margin.MarginClass;

public class ForgotPasswordActivity extends AppCompatActivity {
    Toolbar toolbar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {

            getWindow().setFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
                    WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS);
        }

        setContentView(R.layout.activity_forgot_password);

        int statusBar = 0;
        int resourceId = getResources().getIdentifier("status_bar_height", "dimen", "android");
        if (resourceId > 0) {
            statusBar = getResources().getDimensionPixelSize(resourceId);
        }

        toolbar = findViewById(R.id.toolbar);
        MarginClass marginClass = new MarginClass();
        marginClass.setMargins(toolbar,0,statusBar - 18,0,0);
    }

    public void Done(View view) {
            startActivity(new Intent(getApplicationContext(), MainActivity.class));
    }
}
