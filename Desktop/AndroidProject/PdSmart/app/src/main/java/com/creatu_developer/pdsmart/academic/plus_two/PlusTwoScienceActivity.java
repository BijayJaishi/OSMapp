package com.creatu_developer.pdsmart.academic.plus_two;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.text.Html;
import android.util.AndroidRuntimeException;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.engine.DiskCacheStrategy;
import com.bumptech.glide.load.resource.drawable.GlideDrawable;
import com.bumptech.glide.request.RequestListener;
import com.bumptech.glide.request.target.Target;

import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.adapter.CompetitiveCourseAdapter;
import com.creatu_developer.pdsmart.adapter.PlusTwoCommerceAdapter;
import com.creatu_developer.pdsmart.adapter.PlusTwoScienceAdapter;
import com.creatu_developer.pdsmart.authentications.LoginActivity;
import com.creatu_developer.pdsmart.dark_statusbar.DarkStatusBar;
import com.creatu_developer.pdsmart.innerpage.InnerActivity;
import com.creatu_developer.pdsmart.model.CompetitiveCourseModelClass;
import com.creatu_developer.pdsmart.model.notes_videos_model.NotesVideoModelClass;
import com.creatu_developer.pdsmart.model.package_model.PackageData;
import com.creatu_developer.pdsmart.model.package_model.PackageModelClass;
import com.creatu_developer.pdsmart.retrofit_api_client.RetrofitClient;
import com.creatu_developer.pdsmart.retrofit_api_interface.ApiInterface;
import com.creatu_developer.pdsmart.side_menu.CompetitiveCourse;
import com.esewa.android.sdk.payment.ESewaConfiguration;
import com.esewa.android.sdk.payment.ESewaPayment;
import com.esewa.android.sdk.payment.ESewaPaymentActivity;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class PlusTwoScienceActivity extends AppCompatActivity {

    RecyclerView recyclerView;
    List<PackageData> packageDataList;
    Toolbar toolbar;
    TextView txt_toolbar_title;
    ProgressBar progressBar;
    private int REQUEST_CODE_PAYMENT = 1001;
    String id,pkg_id;
    ESewaConfiguration eSewaConfiguration;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_plus_two);

        toolbar = findViewById(R.id.tool_bar);
        txt_toolbar_title = toolbar.findViewById(R.id.toolbar_title);

        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        recyclerView = findViewById(R.id.recyclerView);
        progressBar =  findViewById(R.id.progress_bar);

        // Dark Status Bar for Marshmallow

        Window window = getWindow();
        View view = window.getDecorView();
        DarkStatusBar.setLightStatusBar(view,this);

        packageDataList = new ArrayList<>();

        String category_id,category;

        try{
            category_id = getIntent().getExtras().getString("category_id");
            category = getIntent().getExtras().getString("category_title");
            System.out.println("Category : "+category_id);
            getSupportActionBar().setTitle(category);
            getPackages(category_id);
        }catch (NullPointerException e){
            e.printStackTrace();
        }

    }

    public void getPackages(String category_id){
            ApiInterface apiInterface = RetrofitClient.getFormData().create(ApiInterface.class);
            Call<PackageModelClass> packageModelClassCall = apiInterface.getPackage(category_id);

            packageModelClassCall.enqueue(new Callback<PackageModelClass>() {
                @Override
                public void onResponse(Call<PackageModelClass> call, Response<PackageModelClass> response) {
                    if (response.isSuccessful()){
                        List<PackageData> packageData = response.body().getPackageDataList();

                        PlusTwoCommerceAdapter adapter = new PlusTwoCommerceAdapter(getApplicationContext(),packageData);
                        RecyclerView.LayoutManager layoutManager = new GridLayoutManager(getApplicationContext(),2);
                        recyclerView.setLayoutManager(layoutManager);
                        recyclerView.setAdapter(adapter);
                        adapter.notifyDataSetChanged();
                        progressBar.setVisibility(View.GONE);
                    }
                }

                @Override
                public void onFailure(Call<PackageModelClass> call, Throwable t) {

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

    public class PlusTwoCommerceAdapter extends RecyclerView.Adapter<PlusTwoCommerceAdapter.MyViewHolder> {

        Context context;
        List<PackageData> packageList;

        public PlusTwoCommerceAdapter(Context context, List<PackageData> packageList) {
            this.context = context;
            this.packageList = packageList;
        }

        @NonNull
        @Override
        public MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.fragment_competitive_course, parent, false);
            return new MyViewHolder(view);
        }

        @Override
        public void onBindViewHolder(@NonNull final MyViewHolder holder, int position) {

            eSewaConfiguration = new ESewaConfiguration()
                    .clientId("KBYXFAkSBRFZMRYWA1sHDhYNCBYXFAkSBRE=")
                    .secretKey("BhwIWQdCGAofEV0ABAQECg==")
                    .environment(ESewaConfiguration.ENVIRONMENT_TEST);

            final PackageData modelClass = packageList.get(position);



            if(modelClass.getPamount().equals("0")){
                holder.btn_paid.setText("Free");
                holder.txt_price.setText("Free");
            }else {
                holder.btn_paid.setText("Buy");
                holder.txt_price.setText("Rs."+ Html.fromHtml(modelClass.getPamount()).toString().trim());
            }

            Random r = new Random();
            int i1 = r.nextInt(800 - 605) + 605;
            final String  productId = modelClass.getPname().substring(0,3)+"_"+i1;



            holder.txt_Category.setText("Category : "+Html.fromHtml(modelClass.getSummary()).toString().trim());
            holder.txt_bank.setText(Html.fromHtml(modelClass.getPdescription()).toString().trim());

            Glide.with(context).load("http://pdsmarteducation.com/uploads/images/"+modelClass.getImage()).listener(new RequestListener<String, GlideDrawable>() {
                @Override
                public boolean onException(Exception e, String model, Target<GlideDrawable> target, boolean isFirstResource) {
                    holder.progressBar.setVisibility(View.GONE);
                    return false;
                }

                @Override
                public boolean onResourceReady(GlideDrawable resource, String model, Target<GlideDrawable> target, boolean isFromMemoryCache, boolean isFirstResource) {
                    holder.progressBar.setVisibility(View.GONE);
                    return false;
                }
            }).thumbnail(0.5f)
                    .diskCacheStrategy(DiskCacheStrategy.ALL)
                    .placeholder(R.drawable.ic_camera_alt_black_24dp)
                    .error(R.drawable.ic_camera_alt_black_24dp)
                    .into(holder.pkg_Image);


            holder.itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    try{
                        pkg_id = modelClass.getId();
                        ///// stored json data into shared preferences /////
                        SharedPreferences sharedPreferences = context.getSharedPreferences("UserProfile", Context.MODE_PRIVATE);
                        String  email = sharedPreferences.getString("email",null);
                        String  password = sharedPreferences.getString("password",null);
                        id = sharedPreferences.getString("id",null);

                        if (email != null && id != null){

                            ApiInterface apiInterface  = RetrofitClient.getFormData().create(ApiInterface.class);
                            Call<NotesVideoModelClass> notesVideoModelClassCall = apiInterface.getDetailsPage(modelClass.getId(),id);

                            notesVideoModelClassCall.enqueue(new Callback<NotesVideoModelClass>() {
                                @Override
                                public void onResponse(Call<NotesVideoModelClass> call, Response<NotesVideoModelClass> response) {
                                    if (response.isSuccessful()){
                                        int buy = response.body().getNotesVideoResults().getBuy();
                                        if (buy == 1){

                                            ESewaPayment eSewaPayment = new ESewaPayment(modelClass.getPamount(),modelClass.getPname(), productId, "https://ir-user.esewa.com.np/epay/main");

                                            Intent intent = new Intent(getApplicationContext(), ESewaPaymentActivity.class);
                                            intent.putExtra(ESewaConfiguration.ESEWA_CONFIGURATION, eSewaConfiguration);
                                            intent.putExtra(ESewaPayment.ESEWA_PAYMENT, eSewaPayment);
                                            startActivityForResult(intent, REQUEST_CODE_PAYMENT);
                                        }else {
                                            try{

                                                SharedPreferences sharedPreferences1 = getSharedPreferences("PackageId",Context.MODE_PRIVATE);
                                                SharedPreferences.Editor editor = sharedPreferences1.edit();
                                                editor.putString("package_id",modelClass.getId());
                                                editor.putString("id",id);
                                                editor.apply();

                                                Intent intent = new Intent(context, InnerActivity.class);
                                                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

                                                intent.putExtra("title",modelClass.getPname());
                                                intent.putExtra("package_id",modelClass.getId());
                                                intent.putExtra("id",id);



                                                context.startActivity(intent);
                                            }catch (AndroidRuntimeException e){
                                                e.printStackTrace();
                                            }
                                        }
                                    }
                                }

                                @Override
                                public void onFailure(Call<NotesVideoModelClass> call, Throwable t) {

                                }
                            });

                        }else {
                            AlertDialog alertDialog = new AlertDialog.Builder(PlusTwoScienceActivity.this,AlertDialog.THEME_HOLO_LIGHT).create();

                            alertDialog.setTitle("PdSmart Education");
                            alertDialog.setMessage(Html.fromHtml("Please Login to app!!!"));

                            alertDialog.setButton(AlertDialog.BUTTON_NEUTRAL, "No",
                                    new DialogInterface.OnClickListener() {
                                        public void onClick(DialogInterface dialog, int which) {
                                            dialog.dismiss();
                                        }
                                    });

                            alertDialog.setButton(AlertDialog.BUTTON_POSITIVE, "Yes",
                                    new DialogInterface.OnClickListener() {
                                        public void onClick(DialogInterface dialog, int which) {
                                            context.startActivity(new Intent(context, LoginActivity.class));
                                            dialog.dismiss();
                                        }
                                    });

                            alertDialog.show();
                            final Button neutralButton = alertDialog.getButton(AlertDialog.BUTTON_NEUTRAL);
                            final Button positveButton = alertDialog.getButton(AlertDialog.BUTTON_POSITIVE);
                            neutralButton.setTextColor(context.getResources().getColor(R.color.black));
                            positveButton.setTextColor(context.getResources().getColor(R.color.black));
                        }

                    }catch (NullPointerException e){
                        e.printStackTrace();
                    }

                }
            });
        }

        @Override
        public int getItemCount() {
            return packageList.size();
        }

        class MyViewHolder extends RecyclerView.ViewHolder {

            TextView txt_bank, txt_Category, txt_price;
            Button btn_paid;
            ProgressBar progressBar;
            ImageView pkg_Image;

            public MyViewHolder(View itemView) {
                super(itemView);

                txt_bank = itemView.findViewById(R.id.txt_bank);
                txt_Category = itemView.findViewById(R.id.txt_category);
                txt_price = itemView.findViewById(R.id.txt_price);
                btn_paid = itemView.findViewById(R.id.btn_paid);
                progressBar = itemView.findViewById(R.id.progress_bar);
                pkg_Image = itemView.findViewById(R.id.pkg_image);
            }
        }


    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == REQUEST_CODE_PAYMENT){

            System.out.println("Hello");

            if(resultCode == Activity.RESULT_OK && data!=null){
                String message = data.getStringExtra(ESewaPayment.EXTRA_RESULT_MESSAGE);

                System.out.println("Hello1");

                if (message != null)
                    try {
                        JSONObject jObj = new JSONObject(message);
                        String productId =  jObj.optString("productId");
                        String totalAmount = jObj.optString("totalAmount");
                        String refID = jObj.optJSONObject("transactionDetails").optString("referenceId");
                        message = jObj.getJSONObject("message").optString("successMessage");
                        System.out.println("Pid : "+productId);
                        System.out.println("refid : "+refID);
                        System.out.println("amount : "+totalAmount);
                        System.out.println("message : "+message);
                        Toast.makeText(getApplicationContext(), "Payment Successful", Toast.LENGTH_SHORT).show();
                        CompetitiveCourse competitiveCourse = new CompetitiveCourse();
                        competitiveCourse.packageUnlock(productId,productId,refID,id,totalAmount,pkg_id);
                    } catch (JSONException e) {
                        e.printStackTrace();
                        Toast.makeText(getApplicationContext(), "Oops ! something went wrong", Toast.LENGTH_SHORT).show();
                    }

            }else if (resultCode == Activity.RESULT_CANCELED){
                Toast.makeText(getApplicationContext(), "Cancel By User", Toast.LENGTH_SHORT).show();
            }else if (resultCode == ESewaPayment.RESULT_EXTRAS_INVALID){
                String s = data.getStringExtra(ESewaPayment.EXTRA_RESULT_MESSAGE);
                System.out.println("Proof of payment1 : "+s);
            }
        }
    }

}
