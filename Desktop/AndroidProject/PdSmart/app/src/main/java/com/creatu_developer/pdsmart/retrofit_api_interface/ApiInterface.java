package com.creatu_developer.pdsmart.retrofit_api_interface;


import com.creatu_developer.pdsmart.model.HomeModelClass;
import com.creatu_developer.pdsmart.model.academic_model.AcademicModelClass;
import com.creatu_developer.pdsmart.model.college_model.CollegeModelClass;
import com.creatu_developer.pdsmart.model.notes_videos_model.NotesVideoModelClass;
import com.creatu_developer.pdsmart.model.package_model.PackageModelClass;

import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.Path;

/**
 * Created by lokesh on 6/1/18.
 */

public interface ApiInterface {

    @GET("home")
    Call<HomeModelClass> getHome();

    @GET("colleges")
    Call<CollegeModelClass> getCollegeList();

    @GET("subcategory/{categoryId}")
    Call<AcademicModelClass> getAcademic(@Path("categoryId") String categoryId);

    @GET("package/{categoryId}")
    Call<PackageModelClass> getPackage(@Path("categoryId") String categoryId);

    @GET("package/{packageId}/{userId}")
    Call<NotesVideoModelClass> getDetailsPage(@Path("packageId") String packageId, @Path("userId") String userId);

    @POST("register")
    Call<ResponseBody> postUserData(@Body RequestBody body);

    @POST("login")
    Call<ResponseBody> loginData(@Body RequestBody body);

    @POST("unlockPackage")
    Call<ResponseBody> unlockPackage(@Body RequestBody body);

}
