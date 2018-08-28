package com.crystalinfosys.restroapp.authentication;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Build;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.text.Html;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.crystalinfosys.restroapp.MainActivity;
import com.crystalinfosys.restroapp.R;
import com.crystalinfosys.restroapp.dark_statusbar.DarkStatusBar;
import com.crystalinfosys.restroapp.retrofit_api_client.RetrofitClient;
import com.crystalinfosys.restroapp.retrofit_api_interface.LoginApiInterface;
import com.crystalinfosys.restroapp.view_margin.MarginClass;
import android.view.ContextThemeWrapper;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;

import okhttp3.MultipartBody;
import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class LoginActivity extends AppCompatActivity {

    TextView txt_signUp;
    EditText edit_phone,edit_password;
    Button btn_forget_password,btn_facebook_login,btn_gmail_login,btn_login;
    Toolbar toolbar;
    String phone,password;
    SharedPreferences sharedPreferences;
    ProgressBar progressBar;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {

            getWindow().setFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
                    WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS);
        }

        setContentView(R.layout.activity_login);

//

        // Dark Status Bar for Marshmallow

        Window window = getWindow();
        View view = window.getDecorView();
        DarkStatusBar.setLightStatusBar(view,this);



        ////// retrive data from shared preference //////

        try{
            sharedPreferences = getSharedPreferences("UserDetail",Context.MODE_PRIVATE);
            phone = sharedPreferences.getString("phone",null);
            password = sharedPreferences.getString("password","");

            //check if string is null or not

            if (!phone.equals("") && !password.equals("")){
//                startActivity(new Intent(getApplicationContext(),MainActivity.class));
            }

        }catch (NullPointerException e){
            e.printStackTrace();
        }


        toolbar = findViewById(R.id.toolbar);
        txt_signUp = findViewById(R.id.txt_SignUp);
        btn_login = findViewById(R.id.btn_sign_in);
        edit_password = findViewById(R.id.edit_password);
        edit_phone = findViewById(R.id.edit_phone);
        btn_forget_password = findViewById(R.id.btn_forgetPassword);
        txt_signUp = findViewById(R.id.txt_SignUp);
        progressBar = findViewById(R.id.progressbar);


        //button forget click listener

        btn_forget_password.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(getApplicationContext(),ForgotPasswordActivity.class));
            }
        });


        //button lgoin click listener

        btn_login.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                LoggedIn();

            }
        });


        // Sign Up click listener

        txt_signUp.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(getApplicationContext(),RegisterActivity.class));
            }
        });

        ////// different format text in single textview //////

        String first = "New Here ? ";
        String next = "<font color='#69c730'>Sign Up</font>";
        txt_signUp.setText(Html.fromHtml(first + next));

        //toolbar_height

        int statusBar = 0;
        int resourceId = getResources().getIdentifier("status_bar_height", "dimen", "android");
        if (resourceId > 0) {
            statusBar = getResources().getDimensionPixelSize(resourceId);
        }

        //calling margin class

        MarginClass marginClass = new MarginClass();
        marginClass.setMargins(toolbar,0,statusBar - 18,0,0);

    }

    public void LoggedIn(){

        //assigning the edit_phone_text to phone string
        phone = edit_phone.getText().toString();

        //assigning the edit_password_text to password string
        password = edit_password.getText().toString();

        ///// validating the string if it is empty or not

        if (phone.equals("")){
            Toast.makeText(this, "Enter Phone number", Toast.LENGTH_SHORT).show();
        }else if (phone.length() != 10){
            Toast.makeText(this, "The phone number must be of 10 characters.", Toast.LENGTH_SHORT).show();
        }else if (password.equals("")){
            Toast.makeText(this, "Enter Password", Toast.LENGTH_SHORT).show();
        }else if (password.length() < 6){
            Toast.makeText(this, "The password must be at least 6 characters", Toast.LENGTH_SHORT).show();
        }else {

            //// calling the UserLogIn function with parameter phone and password

            UserLogIn(phone,password);

        }

    }


    /////// pass the parameter for login to app ///////

    public void UserLogIn(final String phone, final String password){

        LoginApiInterface loginApiInterface = RetrofitClient.getFormData().create(LoginApiInterface.class);


        //// Passing the form field using MultiPartBody

        RequestBody requestBody = new MultipartBody.Builder()
                .setType(MultipartBody.FORM)
                .addFormDataPart("phone", phone)
                .addFormDataPart("password", password)
                .build();

        // Progress Bar Showing

//        progressBar.setIndeterminate(true);
//        progressBar.setVisibility(View.VISIBLE);

        final ProgressDialog pDialog = ProgressDialog.show(new ContextThemeWrapper(this, R.style.NewDialog), "", "Please Wait...", true);

        pDialog.show();

        loginApiInterface.postLoginData(requestBody).enqueue(new Callback<ResponseBody>() {
            @Override
            public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {

                if(response.isSuccessful()) {

                    //the response-body is already parseable to your ResponseBody object

                    ResponseBody responseBody =response.body();

                    //you can do whatever with the response body now...

                    String responseBodyString= null;
                    try {
                        responseBodyString = responseBody.string();
                        Log.d("Response body", responseBodyString);

                        try {
                            JSONObject jsonObjet = new JSONObject(responseBodyString);
                            String code = jsonObjet.getString("status");
                            String message = jsonObjet.getString("message");

                            if (code.equals("0")){

//                                if (progressBar.isShown()){
//                                    progressBar.setVisibility(View.GONE);
//                                }
                                if (pDialog.isShowing()){
                                    pDialog.dismiss();
                                }
                             ////  avi.hide();

                                Toast.makeText(LoginActivity.this, message, Toast.LENGTH_SHORT).show();
                            }
                            else if (code.equals("1")) {

                                //////// save data to shared preferences //////

                                SharedPreferences.Editor editor = sharedPreferences.edit();
                                editor.putString("password",password);
                                editor.putString("phone",phone);
                                editor.apply();

                                if (pDialog.isShowing()){
                                    pDialog.dismiss();
                                }

//                                if (progressBar.isShown()){
//                                    progressBar.setVisibility(View.GONE);
//                                }

                                Toast.makeText(LoginActivity.this, message, Toast.LENGTH_SHORT).show();

                                startActivity(new Intent(LoginActivity.this, MainActivity.class));
                            }

                        } catch (JSONException e){
                            e.printStackTrace();
                        } catch (NullPointerException ex) {
                            ex.printStackTrace();
                        }

                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                }
                else  {
                    Log.d("Response errorBody", String.valueOf(response.errorBody()));
                }

            }

            @Override
            public void onFailure(Call<ResponseBody> call, Throwable t) {
                Log.d("Error ",t.getMessage());
            }
        });

    }

}
