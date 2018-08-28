package com.creatu_developer.pdsmart.authentications;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.AppCompatSpinner;
import android.support.v7.widget.Toolbar;
import android.view.ContextThemeWrapper;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.creatu_developer.pdsmart.MainActivity;
import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.model.college_model.College;
import com.creatu_developer.pdsmart.model.college_model.CollegeModelClass;
import com.creatu_developer.pdsmart.retrofit_api_client.RetrofitClient;
import com.creatu_developer.pdsmart.retrofit_api_interface.ApiInterface;
import com.creatu_developer.pdsmart.validation_class.ValidationClass;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import okhttp3.MultipartBody;
import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class RegisterActivity extends AppCompatActivity {

    Toolbar toolbar;

    EditText edit_user_name,edit_password,edit_confirm_password,edit_email,edit_contact;

    AppCompatSpinner collegeSpinner;

    String name,password,confirm_pass,email,contact,college_id;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        toolbar = findViewById(R.id.tool_bar);

        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        edit_user_name = findViewById(R.id.edit_name);
        edit_confirm_password = findViewById(R.id.edit_confirm_pass);
        edit_contact = findViewById(R.id.edit_phone);
        edit_email = findViewById(R.id.edit_email);
        edit_password = findViewById(R.id.edit_password);
        collegeSpinner = findViewById(R.id.college_spinner);

        getCollege();


    }

    public void signUp(View view) {
        getUserData();
    }

    public void getCollege(){

        ApiInterface collegeInterface = RetrofitClient.getFormData().create(ApiInterface.class);
        Call<CollegeModelClass> collegeModelClassCall = collegeInterface.getCollegeList();

        collegeModelClassCall.enqueue(new Callback<CollegeModelClass>() {
            @Override
            public void onResponse(Call<CollegeModelClass> call, Response<CollegeModelClass> response) {
                if (response.isSuccessful()){
                    List<College> collegeList = response.body().getCollegeList();


                    final List<String> college_id_value = new ArrayList<String>();
                    final List<String> college_name = new ArrayList<>();


                    for(int i=0;i<collegeList.size();i++)
                    {
                        college_name.add(collegeList.get(i).getName());
                        college_id_value.add(collegeList.get(i).getId());

                        try {
                            ArrayAdapter a = new ArrayAdapter(RegisterActivity.this, android.R.layout.simple_spinner_item, college_name);
                            a.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
                            // Setting the ArrayAdapter data on the Spinner
                            collegeSpinner.setAdapter(a);
                        }catch (NullPointerException e){
                            e.printStackTrace();
                        }

                    }

                    collegeSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                        @Override
                        public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {

                            college_id = college_id_value.get(i);

                        }

                        @Override
                        public void onNothingSelected(AdapterView<?> adapterView) {

                        }
                    });

                }else {
                    Toast.makeText(getApplicationContext(), "Error : "+response.errorBody(), Toast.LENGTH_SHORT).show();
                }

            }

            @Override
            public void onFailure(Call<CollegeModelClass> call, Throwable t) {

            }
        });

    }

    public void getUserData(){

        name = edit_user_name.getText().toString();
        password = edit_password.getText().toString();
        confirm_pass = edit_confirm_password.getText().toString();
        email = edit_email.getText().toString();
        contact = edit_contact.getText().toString();

        System.out.println("College : "+college_id);

        if(name.equals("")){
            Toast.makeText(this, "Please Enter Name", Toast.LENGTH_SHORT).show();
        }else if (email.equals("")){
            Toast.makeText(this, "Please Enter Email", Toast.LENGTH_SHORT).show();
        }else if(!email.matches(ValidationClass.emailPattern)){
            Toast.makeText(this, "Please Enter valid email", Toast.LENGTH_SHORT).show();
        }else if (contact.equals("")){
            Toast.makeText(this, "Please Enter Contact", Toast.LENGTH_SHORT).show();
        }else if (contact.length()>10){
            Toast.makeText(this, "Please Enter valid contact number", Toast.LENGTH_SHORT).show();
        }else if (password.equals("")){
            Toast.makeText(this, "Please Enter Password", Toast.LENGTH_SHORT).show();
        }else if (confirm_pass.equals("")){
            Toast.makeText(this, "Please Re - Enter Password", Toast.LENGTH_SHORT).show();
        }else if (!password.equals(confirm_pass)){
            Toast.makeText(this, "Password doesn't match", Toast.LENGTH_SHORT).show();
        }else {
            registerData(name,email,password,contact,"student",college_id);
        }

    }

    public void registerData(String name,String email,String password,String contact,String user_type,String college){

        ApiInterface registerInterface = RetrofitClient.getFormData().create(ApiInterface.class);

        RequestBody requestBody = new MultipartBody.Builder()
                .setType(MultipartBody.FORM)
                .addFormDataPart("name",name)
                .addFormDataPart("email",email)
                .addFormDataPart("password",password)
                .addFormDataPart("contact",contact)
                .addFormDataPart("user_type",user_type)
                .addFormDataPart("college",college)
                .build();

        ////// show progress dialog /////
        final ProgressDialog pDialog =ProgressDialog.show(new ContextThemeWrapper(this,R.style.NewDialog),"","Please wait..",true);

        pDialog.show();

        registerInterface.postUserData(requestBody).enqueue(new Callback<ResponseBody>() {
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

                            Toast.makeText(RegisterActivity.this, "Failed to register", Toast.LENGTH_SHORT).show();

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
                            SharedPreferences sharedPreferences = getSharedPreferences("UserProfile", Context.MODE_PRIVATE);
                            SharedPreferences.Editor editor = sharedPreferences.edit();

                            editor.putString("id",id);
                            editor.putString("name",name);
                            editor.putString("email",email);
                            editor.putString("password",password);
                            editor.putString("phone",phone);
                            editor.putString("college",college);
                            editor.apply();

                            if (pDialog.isShowing()){
                                pDialog.dismiss();
                            }

                            Toast.makeText(RegisterActivity.this, "Successfully Register", Toast.LENGTH_SHORT).show();
                            ////// start main activity class //////
                            startActivity(new Intent(getApplicationContext(), MainActivity.class));

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

    public void loginPage(View view) {
        finish();
    }


}
