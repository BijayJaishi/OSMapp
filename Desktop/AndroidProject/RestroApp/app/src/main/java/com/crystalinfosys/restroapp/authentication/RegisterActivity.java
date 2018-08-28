package com.crystalinfosys.restroapp.authentication;


import android.Manifest;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Build;
import android.provider.MediaStore;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.AppCompatCheckBox;
import android.support.v7.widget.Toolbar;
import android.text.Html;
import android.util.Log;
import android.view.ContextThemeWrapper;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.crystalinfosys.restroapp.MainActivity;
import com.crystalinfosys.restroapp.R;
import com.crystalinfosys.restroapp.retrofit_api_client.RetrofitClient;
import com.crystalinfosys.restroapp.retrofit_api_interface.RegisterApiInterface;
import com.crystalinfosys.restroapp.validation_class.ValidationClass;
import com.crystalinfosys.restroapp.view_margin.MarginClass;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class RegisterActivity extends AppCompatActivity {

    TextView txt_already_have_account;
    EditText edit_Name, edit_Phone,edit_email,edit_password,edit_address;
    Button btn_Sign_Up;
    AppCompatCheckBox checkBox;
    Toolbar toolbar;
    ImageView userImage;

    SharedPreferences sharedPreferences;

    String name,email,password,phone,address;

    final int RQS_IMAGE1 = 1;
    Uri source1;
    Bitmap bm1;
    File file;

    private static final int MY_PERMISSIONS_REQUEST_STORAGE = 0;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {

            getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
                    WindowManager.LayoutParams.FLAG_FULLSCREEN);
        }

        setContentView(R.layout.activity_register);

        txt_already_have_account = findViewById(R.id.txt_already_have_account);
        checkBox = findViewById(R.id.agree_terms);
        edit_address = findViewById(R.id.edit_address);
        edit_email = findViewById(R.id.edit_email);
        edit_Name = findViewById(R.id.edit_name);
        edit_password = findViewById(R.id.edit_password);
        edit_Phone = findViewById(R.id.edit_phone);
        toolbar = findViewById(R.id.toolbar);
        userImage = findViewById(R.id.user_image);

        try{
            sharedPreferences = getSharedPreferences("UserDetail", Context.MODE_PRIVATE);
            phone = sharedPreferences.getString("phone",null);
            password = sharedPreferences.getString("password","");

            //check if string is null or not

            if (!phone.equals("") && !password.equals("")){
//                startActivity(new Intent(getApplicationContext(),MainActivity.class));
            }

        }catch (NullPointerException e){
            e.printStackTrace();
        }

        ///// toolbar height

        int statusBar = 0;
        int resourceId = getResources().getIdentifier("status_bar_height", "dimen", "android");
        if (resourceId > 0) {
            statusBar = getResources().getDimensionPixelSize(resourceId);
        }

        //calling margin class

        MarginClass marginClass = new MarginClass();
        marginClass.setMargins(toolbar,0,statusBar - 18,0,0);


        //// different type of text in single text view

        String first = "Already have an Account ? ";
        String next = "<font color='#69c730'>Sign In</font>";
        txt_already_have_account.setText(Html.fromHtml(first + next));

        String first1 = "I agree with ";
        String next1 = "<font color='#69c730'>Terms & Conditions</font>";
        checkBox.setText(Html.fromHtml(first1 + next1));



        ///// load image from gallery


        userImage.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(Intent.ACTION_PICK,
                        android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
                startActivityForResult(intent, RQS_IMAGE1);

            }
        });


        //// asking for permission to read the gallery

        if (ContextCompat.checkSelfPermission(this,
                Manifest.permission.READ_EXTERNAL_STORAGE)
                != PackageManager.PERMISSION_GRANTED) {

            if (ActivityCompat.shouldShowRequestPermissionRationale(this,
                    Manifest.permission.READ_EXTERNAL_STORAGE)) {

            } else {

                ActivityCompat.requestPermissions(this,
                        new String[]{Manifest.permission.READ_EXTERNAL_STORAGE},
                        MY_PERMISSIONS_REQUEST_STORAGE);
            }
        }

    }


    @Override
    public void onRequestPermissionsResult(int requestCode,
                                           @NonNull String permissions[], @NonNull int[] grantResults) {
        switch (requestCode) {
            case MY_PERMISSIONS_REQUEST_STORAGE: {
                // If request is cancelled, the result arrays are empty.
                if (grantResults.length > 0
                        && grantResults[0] == PackageManager.PERMISSION_GRANTED) {

                } else {

                }
                return;
            }

        }
    }

    public void SignUp(View view) {

        inputData();

    }


    public void inputData(){

        name = edit_Name.getText().toString();
        email = edit_email.getText().toString();
        phone = edit_Phone.getText().toString();
        address = edit_address.getText().toString();
        password = edit_password.getText().toString();

        ///// validating the string if it is empty or not

        if (name.equals("")){
            Toast.makeText(this, "Enter name", Toast.LENGTH_SHORT).show();
        }else if (email.equals("")){
            Toast.makeText(this, "Enter email", Toast.LENGTH_SHORT).show();
        }else if(!email.matches(ValidationClass.emailPattern)){
            Toast.makeText(this, "Enter valid email", Toast.LENGTH_SHORT).show();
        }else if (password.equals("")){
            Toast.makeText(this, "Enter Password", Toast.LENGTH_SHORT).show();
        }else if (password.length() < 6){
            Toast.makeText(this, "The password must be at least 6 characters", Toast.LENGTH_SHORT).show();
        }else if (phone.length() != 10){
            Toast.makeText(this, "The phone number must be of 10 characters.", Toast.LENGTH_SHORT).show();
        }else if (address.equals("")){
            Toast.makeText(this, "Enter address", Toast.LENGTH_SHORT).show();
        }else if (file == null){
            Toast.makeText(this, "Insert image", Toast.LENGTH_SHORT).show();
        }
        else {
            RegisterData(name,email,password,phone,address,file);
        }

    }


    public void RegisterData(String name, String email, final String password, final String phone, String address, File image){

        RegisterApiInterface registerApiInterface = RetrofitClient.getFormData().create(RegisterApiInterface.class);

        //// Passing the form field using MultiPartBody

        RequestBody requestBody = new MultipartBody.Builder()
                .setType(MultipartBody.FORM)
                .addFormDataPart("name",name)
                .addFormDataPart("email",email)
                .addFormDataPart("password",password)
                .addFormDataPart("phone",phone)
                .addFormDataPart("address",address)
                .addFormDataPart("image", image.getName(),
                        RequestBody.create(MediaType.parse("image/png"), image))
                .build();

        final ProgressDialog pDialog =ProgressDialog.show(new ContextThemeWrapper(this,R.style.NewDialog),"","Please wait..",true);

        pDialog.show();

        registerApiInterface.submitData(requestBody).enqueue(new Callback<ResponseBody>() {
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

                                Toast.makeText(RegisterActivity.this, message, Toast.LENGTH_SHORT).show();
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

                                Toast.makeText(RegisterActivity.this, message, Toast.LENGTH_SHORT).show();

                                startActivity(new Intent(RegisterActivity.this, MainActivity.class));
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


    ////// compressing the image in bitmap and providing the file path

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(resultCode == RESULT_OK){
            switch (requestCode){
                case RQS_IMAGE1:
                    source1 = data.getData();
                    try {
                        System.out.println("Bitmap path = "+source1.getPath());
                        bm1 = BitmapFactory.decodeStream(
                                getContentResolver().openInputStream(source1));
                        userImage.setImageBitmap(bm1);

                        String[] filePathColumn = { MediaStore.Images.Media.DATA };
                        Cursor cursor = getContentResolver().query(source1, filePathColumn, null, null, null);
                        cursor.moveToFirst();
                        int columnIndex = cursor.getColumnIndex(filePathColumn[0]);
                        String filePath = cursor.getString(columnIndex);
                        cursor.close();

                        file = new File(filePath);

                        System.out.println("Image :"+bm1);
                    } catch (NullPointerException e) {
                        e.printStackTrace();
                    } catch (FileNotFoundException e) {
                        e.printStackTrace();
                    }

                    break;
            }
        }
    }
}
