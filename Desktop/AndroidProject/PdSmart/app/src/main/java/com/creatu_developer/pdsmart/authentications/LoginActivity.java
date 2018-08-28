package com.creatu_developer.pdsmart.authentications;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.ContextThemeWrapper;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.creatu_developer.pdsmart.MainActivity;
import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.dark_statusbar.DarkStatusBar;
import com.creatu_developer.pdsmart.retrofit_api_client.RetrofitClient;
import com.creatu_developer.pdsmart.retrofit_api_interface.ApiInterface;
import com.creatu_developer.pdsmart.validation_class.ValidationClass;

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

    TextView txt_register;
    Toolbar toolbar;

    EditText edit_email,edit_password;
    String email,password;
    SharedPreferences sharedPreferences;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        txt_register  = findViewById(R.id.register);
        edit_email = findViewById(R.id.edit_email);
        edit_password = findViewById(R.id.edit_password);
        toolbar = findViewById(R.id.tool_bar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        txt_register.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(getApplicationContext(),RegisterActivity.class));
            }
        });

        sharedPreferences = getSharedPreferences("UserProfile", Context.MODE_PRIVATE);

        // Dark Status Bar for Marshmallow

        Window window = getWindow();
        View view = window.getDecorView();
        DarkStatusBar.setLightStatusBar(view,this);

//        try{
//            ///// stored json data into shared preferences /////
//            sharedPreferences = getSharedPreferences("UserProfile", Context.MODE_PRIVATE);
//            email = sharedPreferences.getString("email",null);
//            password = sharedPreferences.getString("password",null);
//
//            if (email != null && password != null){
//                startActivity(new Intent(getApplicationContext(),MainActivity.class));
//            }
//
//        }catch (NullPointerException e){
//            e.printStackTrace();
//        }


    }

    public void Login(View view) {
        getUserData();
    }


    public void getUserData(){

        email = edit_email.getText().toString();
        password = edit_password.getText().toString();


         if (email.equals("")){
            Toast.makeText(this, "Please Enter Email", Toast.LENGTH_SHORT).show();
        }else if(!email.matches(ValidationClass.emailPattern)){
            Toast.makeText(this, "Please Enter valid email", Toast.LENGTH_SHORT).show();
        }else if (password.equals("")){
             Toast.makeText(this, "Please Enter Password", Toast.LENGTH_SHORT).show();
         }else {

            postLogin(email,password);
        }

    }

    public void postLogin(String email, String password){
        ApiInterface loginInterface = RetrofitClient.getFormData().create(ApiInterface.class);

        RequestBody requestBody = new MultipartBody.Builder()
                .setType(MultipartBody.FORM)
                .addFormDataPart("email",email)
                .addFormDataPart("password",password)
                .build();

        ////// show progress dialog /////
        final ProgressDialog pDialog =ProgressDialog.show(new ContextThemeWrapper(this,R.style.NewDialog),"","Please wait..",true);

        pDialog.show();

        loginInterface.loginData(requestBody).enqueue(new Callback<ResponseBody>() {
            @Override
            public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {

                if (response.isSuccessful()){

                    try {
                        ///// get json response if response is successful ////
                        String response_body_string = response.body().string();


                        JSONObject jsonObject = new JSONObject(response_body_string);

                        int status = jsonObject.optInt("status");

                        System.out.println("Status : "+status);

                        if (status==400){

                            if (pDialog.isShowing()){
                                pDialog.dismiss();
                            }

                            Toast.makeText(LoginActivity.this, "Failed to login", Toast.LENGTH_SHORT).show();

                        }else if (status==200){

                            ///// get json response after successfully register ////
                            JSONObject dataJsonObject = jsonObject.getJSONObject("results");

                            String id = dataJsonObject.optString("id");
                            String name = dataJsonObject.optString("name");
                            String email = dataJsonObject.optString("email");
                            String phone = dataJsonObject.optString("contact");
                            String college = dataJsonObject.optString("college");
                            String password = dataJsonObject.optString("password");

                            ///// stored json data into shared preferences /////

                            SharedPreferences.Editor editor = sharedPreferences.edit();

                            editor.putString("id",id);
                            editor.putString("name",name);
                            editor.putString("email",email);
                            editor.putString("phone",phone);
                            editor.putString("college",college);
                            editor.putString("password",password);

                            editor.apply();

                            if (pDialog.isShowing()){
                                pDialog.dismiss();
                            }

                            System.out.println("Id : "+id);

                            Toast.makeText(LoginActivity.this, "Successfully Login", Toast.LENGTH_SHORT).show();
                            ////// start main activity class //////
                           finish();

                        }


                    } catch (IOException e) {
                        e.printStackTrace();
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }

                }else {
                    System.out.println(response.errorBody());
                }
            }

            @Override
            public void onFailure(Call<ResponseBody> call, Throwable t) {

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

    public void Register(View view) {
        startActivity(new Intent(getApplicationContext(),RegisterActivity.class));
    }


}
