package com.creatu_developer.pdsmart.adapter;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.text.Html;
import android.util.AndroidRuntimeException;
import android.view.LayoutInflater;
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
import com.creatu_developer.pdsmart.DetailActivity;
import com.creatu_developer.pdsmart.MainActivity;

import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.authentications.LoginActivity;
import com.creatu_developer.pdsmart.innerpage.InnerActivity;
import com.creatu_developer.pdsmart.innerpage.innerpage_fragments.Notes;
import com.creatu_developer.pdsmart.model.CompetitiveCourseModelClass;
import com.creatu_developer.pdsmart.model.notes_videos_model.NotesVideoModelClass;
import com.creatu_developer.pdsmart.model.package_model.PackageData;
import com.creatu_developer.pdsmart.retrofit_api_client.RetrofitClient;
import com.creatu_developer.pdsmart.retrofit_api_interface.ApiInterface;
import com.esewa.android.sdk.payment.ESewaConfiguration;
import com.esewa.android.sdk.payment.ESewaPayment;
import com.esewa.android.sdk.payment.ESewaPaymentActivity;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

import static android.app.Activity.RESULT_OK;

public class PlusTwoCommerceAdapter extends RecyclerView.Adapter<PlusTwoCommerceAdapter.MyViewHolder> {

    Context context;
    List<PackageData> packageList;
    int REQUEST_CODE_PAYMENT = 999;

    public PlusTwoCommerceAdapter(Context context, List<PackageData> packageList) {
        this.context = context;
        this.packageList = packageList;
    }

    @NonNull
    @Override
    public PlusTwoCommerceAdapter.MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.fragment_competitive_course, parent, false);
        return new MyViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull final PlusTwoCommerceAdapter.MyViewHolder holder, int position) {
        final PackageData modelClass = packageList.get(position);

        if(modelClass.getPamount().equals("0")){
            holder.btn_paid.setText("Free");
            holder.txt_price.setText("Free");
        }else {
            holder.btn_paid.setText("Buy");
            holder.txt_price.setText("Rs."+Html.fromHtml(modelClass.getPamount()).toString().trim());
        }


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
                    ///// stored json data into shared preferences /////
                   SharedPreferences sharedPreferences = context.getSharedPreferences("UserProfile", Context.MODE_PRIVATE);
                   String  email = sharedPreferences.getString("email",null);
                   String  password = sharedPreferences.getString("password",null);
                   String id = sharedPreferences.getString("id",null);

                    if (email != null && password != null){

                        ApiInterface apiInterface  = RetrofitClient.getFormData().create(ApiInterface.class);
                        Call<NotesVideoModelClass> notesVideoModelClassCall = apiInterface.getDetailsPage(modelClass.getId(),id);

                        notesVideoModelClassCall.enqueue(new Callback<NotesVideoModelClass>() {
                            @Override
                            public void onResponse(Call<NotesVideoModelClass> call, Response<NotesVideoModelClass> response) {
                                if (response.isSuccessful()){
                                    int buy = response.body().getNotesVideoResults().getBuy();
                                    if (buy == 1){
                                        final ESewaConfiguration eSewaConfiguration = new ESewaConfiguration()
                                                .clientId("NTdFJCwyOTFZIBcQFAAHAgoXXz01WiQgRjU9Nj4kJTU=")
                                                .secretKey("BhwIWREXGAgYFwc=")
                                                .environment(ESewaConfiguration.ENVIRONMENT_PRODUCTION);

                                        ESewaPayment eSewaPayment = new ESewaPayment("1","Book","sa0910","https://ir-user.esewa.com.np/epay/main");
                                        System.out.println("Esewa : "+eSewaPayment);
                                        Intent intent = new Intent(context, ESewaPaymentActivity.class);
                                        intent.putExtra(ESewaConfiguration.ESEWA_CONFIGURATION,eSewaConfiguration);
                                        intent.putExtra(ESewaPayment.ESEWA_PAYMENT,eSewaPayment);
                                        ((Activity) context).startActivityForResult(intent,REQUEST_CODE_PAYMENT);
                                    }else {
                                        context.startActivity(new Intent(context,InnerActivity.class));
                                    }
                                }
                            }

                            @Override
                            public void onFailure(Call<NotesVideoModelClass> call, Throwable t) {

                            }
                        });

                    }else {
                        AlertDialog alertDialog = new AlertDialog.Builder(context,AlertDialog.THEME_HOLO_LIGHT).create();

                        alertDialog.setTitle("OrderLy");
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

//                try{
//                    Intent intent = new Intent(context, InnerActivity.class);
//                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//
//                    intent.putExtra("title",Html.fromHtml(modelClass.getPname()));
//                    intent.putExtra("id",Html.fromHtml(modelClass.getCategory_id()));
//
//                    context.startActivity(intent);
//                }catch (AndroidRuntimeException e){
//                    e.printStackTrace();
//                }
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
