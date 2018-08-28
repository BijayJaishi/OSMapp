package com.crystalinfosys.restroapp.retrofit_api_client;

import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

/**
 * Created by lokesh on 5/20/18.
 */

public class RetrofitClient {

    public static Retrofit retrofit = null;

    public static Retrofit getFormData(){

        if (retrofit ==null){
            retrofit = new Retrofit.Builder()
                    .baseUrl("http://clients.crystalinfosys.com/restroApp/public/api/")
                    .addConverterFactory(GsonConverterFactory.create())
                    .build();
        }

        return retrofit;
    }
}
