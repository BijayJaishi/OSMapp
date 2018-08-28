package com.creatu_developer.pdsmart.side_menu;


import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.Html;
import android.util.AndroidRuntimeException;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.engine.DiskCacheStrategy;
import com.bumptech.glide.load.resource.drawable.GlideDrawable;
import com.bumptech.glide.request.RequestListener;
import com.bumptech.glide.request.target.Target;

import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.authentications.LoginActivity;
import com.creatu_developer.pdsmart.innerpage.InnerActivity;
import com.creatu_developer.pdsmart.model.Body;
import com.creatu_developer.pdsmart.model.HomeModelClass;
import com.creatu_developer.pdsmart.model.Packages;
import com.creatu_developer.pdsmart.model.notes_videos_model.NotesVideoModelClass;
import com.creatu_developer.pdsmart.retrofit_api_client.RetrofitClient;
import com.creatu_developer.pdsmart.retrofit_api_interface.ApiInterface;
import com.esewa.android.sdk.payment.ESewaConfiguration;
import com.esewa.android.sdk.payment.ESewaPayment;
import com.esewa.android.sdk.payment.ESewaPaymentActivity;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.List;
import java.util.Random;

import io.github.luizgrp.sectionedrecyclerviewadapter.SectionParameters;
import io.github.luizgrp.sectionedrecyclerviewadapter.SectionedRecyclerViewAdapter;
import io.github.luizgrp.sectionedrecyclerviewadapter.StatelessSection;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * A simple {@link Fragment} subclass.
 */
public class Home extends Fragment {

    View view;
    private SectionedRecyclerViewAdapter sectionAdapter;
    List<Packages> packagesList;
    List<Body> bodies;
    String title;
    RecyclerView recyclerView;
    ProgressBar progressBar;
    private int REQUEST_CODE_PAYMENT = 1001;
    String id,pkg_id;
    ESewaConfiguration eSewaConfiguration;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        view = inflater.inflate(R.layout.fragment_home, container, false);
        sectionAdapter = new SectionedRecyclerViewAdapter();
        recyclerView = view.findViewById(R.id.recyclerView);
        progressBar = view.findViewById(R.id.progress_bar);

        getPackages();
        return view;
    }

    public void getPackages(){
        ApiInterface apiInterface = RetrofitClient.getFormData().create(ApiInterface.class);
        Call<HomeModelClass> homeModelClassCall = apiInterface.getHome();

        homeModelClassCall.enqueue(new Callback<HomeModelClass>() {
            @Override
            public void onResponse(Call<HomeModelClass> call, Response<HomeModelClass> response) {
                if(response.isSuccessful()){
                    bodies = response.body().getResults().getBody();
                    for(Body body:bodies){
                        title = body.getTitle();
                        packagesList = body.getPackages();
                        System.out.println("Title : "+title);
                        System.out.println("List : "+packagesList);
                        sectionAdapter.addSection(new RecyclerViewAdapter(getActivity(),title,packagesList));
                    }

                    RecyclerView.LayoutManager layoutManager = new LinearLayoutManager(getActivity());
                    recyclerView.setLayoutManager(layoutManager);
                    recyclerView.setAdapter(sectionAdapter);
                    sectionAdapter.notifyDataSetChanged();
                    progressBar.setVisibility(View.GONE);
                }

            }

            @Override
            public void onFailure(Call<HomeModelClass> call, Throwable t) {

            }
        });
    }

    ///////// dynamic recycler view with headers
    public class RecyclerViewAdapter extends StatelessSection {

        Context context;
        String title;
        List<Packages> list;

        public RecyclerViewAdapter(Context context, String title, List<Packages> list) {
            super(SectionParameters.builder()
                    .itemResourceId(R.layout.package_item)
                    .headerResourceId(R.layout.header)
                    .build());

            this.title = title;
            this.list = list;
            this.context = context;


        }

        @Override
        public int getContentItemsTotal() {

            return list.size();

        }


        @Override
        public RecyclerView.ViewHolder getItemViewHolder(View view) {
            //////// return a custom instance of ViewHolder for the items of this section

            return new ItemViewHolder(view);
        }

        @Override
        public void onBindItemViewHolder(final RecyclerView.ViewHolder holder, final int position) {


            // bind your view here
            final ItemViewHolder itemHolder = (ItemViewHolder) holder;

            eSewaConfiguration = new ESewaConfiguration()
                    .clientId("NTdFJCwyOTFZIBcQFAAHAgoXXz01WiQgRjU9Nj4kJTU=")
                    .secretKey("BhwIWREXGAgYFwc=")
                    .environment(ESewaConfiguration.ENVIRONMENT_PRODUCTION);

            final Packages products = list.get(position);

            if (products.getPamount().equals("0")) {

                ((ItemViewHolder) holder).txt_pkg_price.setText("Free");
            } else {

                ((ItemViewHolder) holder).txt_pkg_price.setText("Rs." + Html.fromHtml(products.getPamount()).toString().trim());
            }

            Random r = new Random();
            int i1 = r.nextInt(800 - 605) + 605;
            final String  productId = products.getPname().substring(0,3)+"_"+i1;

            itemHolder.txt_pkg_name.setText(Html.fromHtml(products.getPname()).toString().trim());
            itemHolder.txt_pkg_price.setText(Html.fromHtml(products.getPamount()).toString().trim());
            itemHolder.txt_pkg_desc.setText(Html.fromHtml(products.getPdescription()).toString().trim());


            Glide.with(context).load("http://pdsmarteducation.com/uploads/images/"+products.getImage()).listener(new RequestListener<String, GlideDrawable>() {
                @Override
                public boolean onException(Exception e, String model, Target<GlideDrawable> target, boolean isFirstResource) {
                    itemHolder.progressBar.setVisibility(View.GONE);
                    return false;
                }

                @Override
                public boolean onResourceReady(GlideDrawable resource, String model, Target<GlideDrawable> target, boolean isFromMemoryCache, boolean isFirstResource) {
                    itemHolder.progressBar.setVisibility(View.GONE);
                    return false;
                }
            }).thumbnail(0.5f)
                    .diskCacheStrategy(DiskCacheStrategy.ALL)
                    .placeholder(R.drawable.ic_camera_alt_black_24dp)
                    .error(R.drawable.ic_camera_alt_black_24dp)
                    .into(itemHolder.pkg_image);

            itemHolder.itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    try {
                        pkg_id = products.getId();
                        ///// stored json data into shared preferences /////
                        SharedPreferences sharedPreferences = context.getSharedPreferences("UserProfile", Context.MODE_PRIVATE);
                        String email = sharedPreferences.getString("email", null);
                        String password = sharedPreferences.getString("password", null);
                        id = sharedPreferences.getString("id", null);

                        if (email != null && id != null) {

                            System.out.println("Email : "+email+" "+id);

                            ApiInterface apiInterface = RetrofitClient.getFormData().create(ApiInterface.class);

//                            Call<NotesVideoModelClass> notesVideoModelClassCall = apiInterface.getDetailsPage(modelClass.getId(), id);

                            Call<NotesVideoModelClass> notesVideoModelClassCall = apiInterface.getDetailsPage(products.getId(), id);


                            notesVideoModelClassCall.enqueue(new Callback<NotesVideoModelClass>() {
                                @Override
                                public void onResponse(Call<NotesVideoModelClass> call, Response<NotesVideoModelClass> response) {


                                    if (response.isSuccessful()) {
                                        int buy = response.body().getNotesVideoResults().getBuy();
                                        if (buy == 1) {

                                            ESewaPayment eSewaPayment = new ESewaPayment(products.getPamount(),products.getPname(), productId, "https://ir-user.esewa.com.np/epay/main");

                                            Intent intent = new Intent(getActivity(), ESewaPaymentActivity.class);
                                            intent.putExtra(ESewaConfiguration.ESEWA_CONFIGURATION, eSewaConfiguration);
                                            intent.putExtra(ESewaPayment.ESEWA_PAYMENT, eSewaPayment);
                                            startActivityForResult(intent, REQUEST_CODE_PAYMENT);
                                            System.out.println("REQUEST : "+REQUEST_CODE_PAYMENT);
                                            // dialog.dismiss();
//                                            AlertDialog alertDialog = new AlertDialog.Builder(context, AlertDialog.THEME_HOLO_LIGHT).create();
//
//                                            alertDialog.setTitle("OrderLy");
//                                            alertDialog.setMessage(Html.fromHtml("Please buy first!!!!"));
//
//                                            alertDialog.setButton(AlertDialog.BUTTON_NEUTRAL, "No",
//                                                    new DialogInterface.OnClickListener() {
//                                                        public void onClick(DialogInterface dialog, int which) {
//                                                            dialog.dismiss();
//                                                        }
//                                                    });
//
//                                            alertDialog.setButton(AlertDialog.BUTTON_POSITIVE, "Yes",
//                                                    new DialogInterface.OnClickListener() {
//                                                        public void onClick(DialogInterface dialog, int which) {
//
//
//
//                                                        }
//                                                    });
//
//                                            alertDialog.show();
//                                            final Button neutralButton = alertDialog.getButton(AlertDialog.BUTTON_NEUTRAL);
//                                            final Button positveButton = alertDialog.getButton(AlertDialog.BUTTON_POSITIVE);
//                                            neutralButton.setTextColor(context.getResources().getColor(R.color.black));
//                                            positveButton.setTextColor(context.getResources().getColor(R.color.black));
                                        } else {
                                            try{

                                                SharedPreferences sharedPreferences1 = getActivity().getSharedPreferences("PackageId",Context.MODE_PRIVATE);
                                                SharedPreferences.Editor editor = sharedPreferences1.edit();
                                                editor.putString("package_id",products.getId());
                                                editor.putString("id",id);
                                                editor.apply();

                                                Intent intent = new Intent(context, InnerActivity.class);
                                                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

                                                intent.putExtra("title",products.getPname());
                                                intent.putExtra("package_id",products.getId());
                                                intent.putExtra("id",id);



                                                context.startActivity(intent);
                                            }catch (AndroidRuntimeException e){
                                                e.printStackTrace();
                                            }
                                        }
                                    }else {
                                        System.out.println("Response : "+response.errorBody());
                                    }
                                }

                                @Override
                                public void onFailure(Call<NotesVideoModelClass> call, Throwable t) {

                                }
                            });

                        } else {
                            AlertDialog alertDialog = new AlertDialog.Builder(context, AlertDialog.THEME_HOLO_LIGHT).create();

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

                    } catch (NullPointerException e) {
                        e.printStackTrace();
                    }


                }
            });
        }

        @Override
        public RecyclerView.ViewHolder getHeaderViewHolder(View view) {
            //////// return a custom instance of ViewHolder for the header of this section
            return new HeaderViewHolder(view);
        }


        @Override
        public void onBindHeaderViewHolder(RecyclerView.ViewHolder holder) {


            final HeaderViewHolder headerHolder = (HeaderViewHolder) holder;

            headerHolder.tvTitle.setText(Html.fromHtml(title).toString().trim());

        }

        ///// creating class for Items

        class ItemViewHolder extends RecyclerView.ViewHolder{

            private final View rootView;

            private ImageView pkg_image;
            private TextView txt_pkg_name,txt_pkg_desc,txt_pkg_price;
            ProgressBar progressBar;

            ItemViewHolder(View view) {
                super(view);

                rootView = view;
                txt_pkg_desc = view.findViewById(R.id.pkg_desc);
                txt_pkg_name = view.findViewById(R.id.pkg_name);
                txt_pkg_price = view.findViewById(R.id.pkg_price);
                pkg_image = view.findViewById(R.id.pkg_img);
                progressBar = view.findViewById(R.id.progress_bar);

            }
        }

        ///// creating class for header
        class HeaderViewHolder extends RecyclerView.ViewHolder{

            private final View rootView;
            private final TextView tvTitle;

            HeaderViewHolder(View view) {
                super(view);

                rootView = view;
                tvTitle = (TextView) view.findViewById(R.id.txt_header);
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
                        Toast.makeText(getActivity(), "Payment Successful", Toast.LENGTH_SHORT).show();
                        packageUnlock(productId,productId,refID,id,totalAmount,pkg_id);
                    } catch (JSONException e) {
                        e.printStackTrace();
                        Toast.makeText(getActivity(), "Oops ! something went wrong", Toast.LENGTH_SHORT).show();
                    }

            }else if (resultCode == Activity.RESULT_CANCELED){
                Toast.makeText(getActivity(), "Cancel By User", Toast.LENGTH_SHORT).show();
            }else if (resultCode == ESewaPayment.RESULT_EXTRAS_INVALID){
                String s = data.getStringExtra(ESewaPayment.EXTRA_RESULT_MESSAGE);
                System.out.println("Proof of payment1 : "+s);
            }
        }
    }

    public void packageUnlock(String oid,String pid,String refid,String uid,String amt,String pkgId){

        ApiInterface apiInterface = RetrofitClient.getFormData().create(ApiInterface.class);

        RequestBody requestBody = new MultipartBody.Builder()
                .setType(MultipartBody.FORM)
                .addFormDataPart("oid",oid)
                .addFormDataPart("productId",pid)
                .addFormDataPart("refId",refid)
                .addFormDataPart("userId",uid)
                .addFormDataPart("amt",amt)
                .addFormDataPart("packageId",pkgId)
                .build();

        apiInterface.unlockPackage(requestBody).enqueue(new Callback<ResponseBody>() {
            @Override
            public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                if (response.isSuccessful()){
                    String response_body_string = null;
                    try {
                        response_body_string = response.body().string();
                        JSONObject jsonObject = new JSONObject(response_body_string);
                        int status = jsonObject.optInt("status");
                        JSONObject results = jsonObject.getJSONObject("results");
                        String message = results.optString("message");

                        if (status == 400){
                            Toast.makeText(getActivity(), message, Toast.LENGTH_SHORT).show();
                        }else if (status == 200){
                            Toast.makeText(getActivity(), message, Toast.LENGTH_SHORT).show();
                        }

                    } catch (IOException e) {
                        e.printStackTrace();
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }


                }else{
                    Toast.makeText(getActivity(), "Response : "+response.errorBody(), Toast.LENGTH_SHORT).show();
                }
            }

            @Override
            public void onFailure(Call<ResponseBody> call, Throwable t) {

            }
        });

    }

}
