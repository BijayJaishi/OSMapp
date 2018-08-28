package com.creatu_developer.pdsmart.innerpage.innerpage_fragments;


import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ProgressBar;


import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.adapter.CompetitiveCourseAdapter;
import com.creatu_developer.pdsmart.adapter.NotesAdapter;
import com.creatu_developer.pdsmart.model.CompetitiveCourseModelClass;
import com.creatu_developer.pdsmart.model.notes_videos_model.NotesModelClass;
import com.creatu_developer.pdsmart.model.notes_videos_model.NotesVideoModelClass;
import com.creatu_developer.pdsmart.retrofit_api_client.RetrofitClient;
import com.creatu_developer.pdsmart.retrofit_api_interface.ApiInterface;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * A simple {@link Fragment} subclass.
 */
public class Notes extends Fragment {

    View view;
    RecyclerView recyclerView;
    ProgressBar progress_bar;



    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        // Inflate the layout for this fragment //
        view = inflater.inflate(R.layout.recycler_view, container, false);
        recyclerView = view.findViewById(R.id.recycler_view);
        progress_bar = view.findViewById(R.id.progress_bar);

        try{
            SharedPreferences sharedPreferences1 = getActivity().getSharedPreferences("PackageId", Context.MODE_PRIVATE);
            String package_id = sharedPreferences1.getString("package_id",null);
            String id = sharedPreferences1.getString("id",null);

            if (package_id != null && id != null){
                getNotes(package_id,id);
            }

        }catch (NullPointerException e){
            e.printStackTrace();
        }




        return view;
    }

    public void getNotes(String packageId,String id){
        ApiInterface apiInterface = RetrofitClient.getFormData().create(ApiInterface.class);
        Call<NotesVideoModelClass> notesVideoModelClassCall = apiInterface.getDetailsPage(packageId,id);
        notesVideoModelClassCall.enqueue(new Callback<NotesVideoModelClass>() {
            @Override
            public void onResponse(Call<NotesVideoModelClass> call, Response<NotesVideoModelClass> response) {

                List<NotesModelClass> notesModelClassList = response.body().getNotesVideoResults().getNotesModelClassList();

                NotesAdapter adapter = new NotesAdapter(getActivity(),notesModelClassList);
                RecyclerView.LayoutManager layoutManager = new GridLayoutManager(getActivity(),2);
                recyclerView.setLayoutManager(layoutManager);
                recyclerView.setAdapter(adapter);
                adapter.notifyDataSetChanged();

                progress_bar.setVisibility(View.GONE);
            }

            @Override
            public void onFailure(Call<NotesVideoModelClass> call, Throwable t) {

            }
        });
    }

}
