package com.crystalinfosys.restroapp.authentication;

import android.content.Intent;
import android.os.Build;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.text.Html;
import android.view.View;
import android.view.WindowManager;
import android.widget.TextView;

import com.crystalinfosys.restroapp.MainActivity;
import com.crystalinfosys.restroapp.R;
import com.crystalinfosys.restroapp.view_margin.MarginClass;

public class PasscodeActivity extends AppCompatActivity {

    TextView txt_send_again;
    Toolbar toolbar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {

            getWindow().setFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
                    WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS);
        }


        setContentView(R.layout.activity_passcode);

        int statusBar = 0;
        int resourceId = getResources().getIdentifier("status_bar_height", "dimen", "android");
        if (resourceId > 0) {
            statusBar = getResources().getDimensionPixelSize(resourceId);
        }

        toolbar = findViewById(R.id.toolbar);
        MarginClass marginClass = new MarginClass();
        marginClass.setMargins(toolbar,0,statusBar - 18,0,0);


        txt_send_again = findViewById(R.id.txt_send_again);

        String first = "Do not receive sms ? ";
        String next = "<font color='#69c730'>Send Again</font>";
        txt_send_again.setText(Html.fromHtml(first + next));
    }

    public void Done(View view) {
        startActivity(new Intent(getApplicationContext(), MainActivity.class));
    }
}
