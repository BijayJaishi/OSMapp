package com.creatu_developer.pdsmart.retrofit_api_client;

import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

/**
 * Created by lokesh on 5/20/18.
 */

public class RetrofitClient {

    public static Retrofit retrofit = null;

   // public static String url = "http://192.168.10.68:81/api/";
    public static String url = "http://pdsmarteducation.com/api/";

    public static Retrofit getFormData(){

        if (retrofit ==null){
            retrofit = new Retrofit.Builder()
                    .baseUrl(url)
                    .addConverterFactory(GsonConverterFactory.create())
                    .build();
        }

        return retrofit;
    }
}
