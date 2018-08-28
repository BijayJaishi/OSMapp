package com.creatu_developer.pdsmart.academic;


import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.Html;
import android.util.AndroidRuntimeException;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;


import com.creatu_developer.pdsmart.R;
import com.creatu_developer.pdsmart.academic.bachelor.BachelorActivity;
import com.creatu_developer.pdsmart.academic.plus_two.PlusTwoScienceActivity;
import com.creatu_developer.pdsmart.model.academic_model.AcademicModelClass;
import com.creatu_developer.pdsmart.model.academic_model.AcademicResults;
import com.creatu_developer.pdsmart.model.academic_model.AcademicSubCategories;
import com.creatu_developer.pdsmart.retrofit_api_client.RetrofitClient;
import com.creatu_developer.pdsmart.retrofit_api_interface.ApiInterface;

import java.util.ArrayList;
import java.util.List;

import io.github.luizgrp.sectionedrecyclerviewadapter.SectionParameters;
import io.github.luizgrp.sectionedrecyclerviewadapter.SectionedRecyclerViewAdapter;
import io.github.luizgrp.sectionedrecyclerviewadapter.StatelessSection;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;


public class BachelorFragment extends Fragment {
    View view;
    private SectionedRecyclerViewAdapter sectionAdapter;
    String title;
    ProgressBar progressBar;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        view = inflater.inflate(R.layout.recycler_view, container, false);
        sectionAdapter = new SectionedRecyclerViewAdapter();

        getPlusTwo("16");
        progressBar = view.findViewById(R.id.progress_bar);


        return view;
    }


    public void getPlusTwo(String category_id){
        ApiInterface apiInterface = RetrofitClient.getFormData().create(ApiInterface.class);
        Call<AcademicModelClass> academicModelClassCall = apiInterface.getAcademic(category_id);

        academicModelClassCall.enqueue(new Callback<AcademicModelClass>() {
            @Override
            public void onResponse(Call<AcademicModelClass> call, Response<AcademicModelClass> response) {
                if(response.isSuccessful()){

                    List<AcademicResults> academicResults = response.body().getAcademicResultsList();
                    List<AcademicSubCategories> subCategories;
                    for(AcademicResults body:academicResults){
                        title = body.getDescription();
                        subCategories = body.getSub_categories();

                        sectionAdapter.addSection(new ExpandableContactsSection(title,subCategories));
                    }


                    RecyclerView recyclerView = (RecyclerView) view.findViewById(R.id.recycler_view);
                    recyclerView.setLayoutManager(new LinearLayoutManager(getContext()));
                    recyclerView.setAdapter(sectionAdapter);
                    sectionAdapter.notifyDataSetChanged();
                    progressBar.setVisibility(View.GONE);

                }

            }

            @Override
            public void onFailure(Call<AcademicModelClass> call, Throwable t) {

            }
        });
    }


    private class ExpandableContactsSection extends StatelessSection {

        String title;
        List<AcademicSubCategories> list;
        boolean expanded = false;

        ExpandableContactsSection(String title, List<AcademicSubCategories> list) {
            super(SectionParameters.builder()
                    .itemResourceId(R.layout.ex1_item)
                    .headerResourceId(R.layout.ex1_header)
                    .build());

            this.title = title;
            this.list = list;
        }

        @Override
        public int getContentItemsTotal() {
            return expanded ? list.size() : 0;
        }

        @Override
        public RecyclerView.ViewHolder getItemViewHolder(View view) {
            return new ItemViewHolder(view);
        }

        @Override
        public void onBindItemViewHolder(RecyclerView.ViewHolder holder, int position) {
            final ItemViewHolder itemHolder = (ItemViewHolder) holder;

            final AcademicSubCategories subCategories = list.get(position);

            itemHolder.tvItem.setText(Html.fromHtml(subCategories.getName()).toString().trim());

            itemHolder.rootView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    try{

                        Intent intent = new Intent(getActivity(), PlusTwoScienceActivity.class);
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

                        intent.putExtra("category_title",subCategories.getName());
                        intent.putExtra("category_id",subCategories.getId());

                        getActivity().startActivity(intent);
                    }catch (AndroidRuntimeException e){
                        e.printStackTrace();
                    }
                }
            });
        }

        @Override
        public RecyclerView.ViewHolder getHeaderViewHolder(View view) {
            return new HeaderViewHolder(view);
        }

        @Override
        public void onBindHeaderViewHolder(RecyclerView.ViewHolder holder) {
            final HeaderViewHolder headerHolder = (HeaderViewHolder) holder;

            headerHolder.tvTitle.setText(Html.fromHtml(title).toString().trim());
            headerHolder.rootView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    expanded = !expanded;
                    headerHolder.imgArrow.setImageResource(
                            expanded ? R.drawable.ic_keyboard_arrow_up_black_24dp : R.drawable.ic_keyboard_arrow_down_black_24dp
                    );
                    sectionAdapter.notifyDataSetChanged();
                }
            });
        }
    }

    private class HeaderViewHolder extends RecyclerView.ViewHolder {

        private final View rootView;
        private final TextView tvTitle;
        private final ImageView imgArrow;

        HeaderViewHolder(View view) {
            super(view);

            rootView = view;
            tvTitle = (TextView) view.findViewById(R.id.tvTitle);
            imgArrow = (ImageView) view.findViewById(R.id.imgArrow);
        }
    }

    private class ItemViewHolder extends RecyclerView.ViewHolder {

        private final View rootView;

        private final TextView tvItem;

        ItemViewHolder(View view) {
            super(view);

            rootView = view;

            tvItem = (TextView) view.findViewById(R.id.tvItem);
        }
    }

}
