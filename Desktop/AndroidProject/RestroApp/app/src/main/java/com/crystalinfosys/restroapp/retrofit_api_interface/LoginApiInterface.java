package com.crystalinfosys.restroapp.retrofit_api_interface;

import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;

/**
 * Created by lokesh on 5/20/18.
 */

public interface LoginApiInterface {
    @POST("index")
    Call<ResponseBody> postLoginData(@Body RequestBody body);
}
