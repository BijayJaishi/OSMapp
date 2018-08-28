package com.crystalinfosys.restroapp.first_page;

import android.content.Intent;
import android.os.Build;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;

import com.crystalinfosys.restroapp.R;
import com.crystalinfosys.restroapp.authentication.LoginActivity;
import com.crystalinfosys.restroapp.authentication.RegisterActivity;

public class FirstPageActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {

            getWindow().setFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
                    WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS);
        }

        setContentView(R.layout.activity_first_page);
    }

    public void SignUp(View view) {
        startActivity(new Intent(getApplicationContext(), RegisterActivity.class));
    }

    public void SignIn(View view) {
        startActivity(new Intent(getApplicationContext(), LoginActivity.class));
    }
}
